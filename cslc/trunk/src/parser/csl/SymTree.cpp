//----------------------------------------------------------------------
// Copyright (c) 2007 Fastpathlogic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of Fastpathlogic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------
#include <sstream>
#include "CslParser.hpp"

#include "SymTree.h"


TBool cslParserHasErrors = FALSE;

using namespace std;
namespace NSSymbolTable {
//ANTLR_USING_NAMESPACE(antlr);

inline TBool less_RefString::operator() (const RefString& s1, const RefString& s2) const {
  ASSERT(s1.get(), "null string 1");
  ASSERT(s2.get(), "null string 2");

  return s1->compare(*s2) < ZERO;
}
 
inline void assertName(RefString name) {
  ASSERT(name.get(),"null name");
  ASSERT(!(name->empty()), "empty name");
}

TBool hasOneBitSet(TInt type) {
  TUInt count = ZERO;
  while (type > ZERO) {
    if (type & ONE == ONE) {
      count++;
    }
    type = type >> ONE;
  }
  return count == ONE;
}

inline TBool isType(EObjType type) {
  return (type > TUNDEF && type < TMAX && hasOneBitSet(type));
}

//-------------------------------------------------------------------------//
// CSymNode class
//-------------------------------------------------------------------------//
CSymNode::CSymNode() :
  m_parent     ()           ,
  m_children   ()           ,
  m_type       (TDESIGN)    ,
  m_userDef    ()           ,
  m_isDefined  (FALSE)      , 
  m_isUsed     (TRUE)       ,
  m_isFieldScopeHolder(TRUE),
  m_name       ()           ,
  m_declLine   (ZERO)       , 
  m_declCol    (ZERO)       , 
  m_defLine    (ZERO)       , 
  m_defCol     (ZERO)       ,
  m_fileName   ()           {}

CSymNode::CSymNode(RefString name      ,
                   EObjType type       , 
                   TULong declLine     ,     
                   TULong declCol      , 
                   RefString fileName) :
  m_parent     ()            ,
  m_children   ()            ,
  m_type       (type)        ,
  m_userDef    ()            ,
  m_isDefined  (FALSE)       , 
  m_isUsed     (FALSE)       ,
  m_isFieldScopeHolder(TRUE) ,
  m_name       (name)        ,
  m_declLine   (declLine)    , 
  m_declCol    (declCol)     , 
  m_defLine    (ZERO)        , 
  m_defCol     (ZERO)        ,
  m_fileName   (fileName)     {
  
  assertName(name);
  assertName(fileName);
  ASSERT(isType(type), "Invalid type");
}

void CSymNode::addChild(RefString name, RefCSymNode child) {
  assertName(name);
  ASSERT(child.get(),"null child given");
  //TODO use the m_weakRef trick from BZ with the child variable
  ASSERT(child != getThis(),"can't add as child the same node as this");
  ASSERT(isScopeHolder(), "can't add a child to an object that can't have children. Use a different insemination protocol");

  if(!m_children.get()) {
    m_children = RefTMap_RefString_RefCSymNode(new TMap_RefString_RefCSymNode());
  }
  ASSERT(m_children->find(name) == m_children->end() ,"name already exists in scope(this should be an error)");
  m_children->insert( make_pair(name, child));
}

void CSymNode::setParent(RefCSymNode parent) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(parent != getThis(),"parent is the same with the child");
  ASSERT(!getParent().get(), "parent already set");

  parent->addChild(m_name, getThis());
  m_parent =boost::weak_ptr<CSymNode>( parent);
}

RefCSymNode CSymNode::buildRoot() {
  CSymNode* node;
  try {
    node = new CSymNode();
  }
  catch(std::exception& e) {
    ASSERT(FAIL,"no memory");
  }

  RefCSymNode refNode = RefCSymNode(node);
  node->m_weakRef =boost::weak_ptr<CSymNode>( refNode);

  return refNode;
}


RefCSymNode CSymNode::build(RefString        fileName   , 
                            TULong                   line       , 
                            TULong           column     , 
                            RefCSymNode      parent     , 
                            const RefString& name       , 
                            EObjType         type       , 
                            RefCSymNode      userDefType) {
  assertName(fileName);
  assertName(name);


  CSymNode* node;
  try {
    node = new CSymNode(name, type, line, column, fileName);
  }
  catch(std::exception& e) {
    ASSERT(FAIL,"no memory");
  }

  RefCSymNode refNode = RefCSymNode(node);
  node->m_weakRef =boost::weak_ptr<CSymNode>( refNode);
  node->m_declLine = line;
  node->m_declCol = column;
  node->m_fileName = fileName;
  node->m_name = name;
  node->m_type = type;

  if (parent.get()) {
    node->setParent(parent);
  }

  if(type == TUSER_DEFINED) {
    ASSERT(userDefType.get(), "this should not be null if it is a user defined type");
    node->m_userDef = boost::weak_ptr<CSymNode>(userDefType);
  }
  else {
    ASSERT(!userDefType.get(), "if it is not a user defined type this parameter should be null");
  }
  return refNode;
}

RefCSymNode CSymNode::getChild(RefString name) {
  assertName(name);
  if(!m_children.get()) {
    return RefCSymNode();
  } else {
    
    TMap_RefString_RefCSymNode_iter it = m_children->find(name);
    if( it != m_children->end() ) {
      return it->second;
    } else {
      return RefCSymNode();
    }
  }
}

void CSymNode::setIsDefined(TULong defLine, TULong defCol) {
  if (m_isDefined) {
    args.push_back(*(m_fileName));
    args.push_back(intToString(defLine));
    args.push_back(*m_name);
    if (getParent()->getName().get()) {
      args.push_back(*(getParent()->getName()));
    }
    else {
      args.push_back(std::string("global scope"));
    }
    addErr(NSWarningErr::CSE_CSC_SCOP_CSE_CSC_SCOP_ID_ALREADY_DEFINED, args);
    cslParserHasErrors = TRUE;
  }
  m_defLine = defLine;
  m_defCol = defCol;
  m_isDefined = TRUE; 
}

void CSymNode::setIsScopeHolder(TBool isScopeHolder) {
  ASSERT(TFIELD_DECL == m_type || TISAF_DECL == m_type, "this should only be called on fields or isa_fields ");
  ASSERT(!isScopeHolder, "this should be false ");
  m_isFieldScopeHolder = isScopeHolder;
}

//-------------------------------------------------------------------------//
// CSymTree class
//-------------------------------------------------------------------------//
CSymTree::CSymTree() {
  try{
    m_root = CSymNode::buildRoot();
    m_currentScope = m_root;
  } catch (std::bad_alloc) {
    addErr(NSWarningErr::SEE_ALL_MEM_BAD_ALLOC, args, 0, RefString(), TRUE);
  }
}

RefCSymNode CSymTree::lookup(RefString type) {
  assertName(type);
  
  RefCSymNode node = m_currentScope;
  while (node.get()) {
    if (node->getChild(type).get()) {
      return node->getChild(type);
    }
    else {
      node = node->getParent();
    }
  }
  return RefCSymNode();
}

RefCSymNode CSymTree::lookup(std::vector<RefString> type) {
  RefCSymNode node = m_currentScope;
  TBool found = FALSE;
  while (node.get()) {
    if (node->getChild(type[0]).get()) {
      found = TRUE;
    }
    else {
      node = node->getParent();
    }
    if (found == TRUE) {
      RefCSymNode temp = node;
      std::vector<RefString>::iterator it;
      for (it = type.begin(); it < type.end(); it++) {
        if (temp->getChild(*it).get()) {
          temp = temp->getChild(*it);
          if (!temp.get()) {
            return RefCSymNode();
          }
        }
        else if (temp->getType() == TUSER_DEFINED) {
          temp = temp->getUserDefinedType()->getChild(*it);
          if (!temp.get()) {
            return RefCSymNode();
          }
        }
        else {
          found = FALSE;
          node = node->getParent();
          break;
        }
      }
      if (found == TRUE) {
        return temp;
      }
    }
  }
  return RefCSymNode();
}

//explanation of the algorithm:
//1. Create a node.
//2. Add it to the map (see addChild comments).
//3. Check if the node was added to the map.
// If It was not added check why.
//4. Object was already there (already declared). Highest probability warning.
//5. Object was declared but with a different type than the one it is declared now. Medium to high probability error.
//6. The object was not inserted into the map by an unspecified error. Has an extremely low probability of happening.
RefCSymNode CSymTree::declare(RefString name, EObjType type, RefString fileName, TULong declLine, TULong declCol, RefString userType) {
  assertName(name);
  ASSERT(isType(type) , "invalid type");

  // call build function
  RefCSymNode node = RefCSymNode();
  RefCSymNode userDefType = RefCSymNode();
  if (userType.get()) {
    ASSERT(type == TUSER_DEFINED,"this should only happen when there is a user defined type")
      userDefType = lookup(userType);
    if (!userDefType.get()) {
      //error .. type does not exist
    }
  }
  RefCSymNode found = m_currentScope->getChild(name);
  if (!found.get()) {
    node = CSymNode::build(fileName, declLine, declCol, m_currentScope, name, type, userDefType);//1
  }
//  else {
//    args.push_back(*(fileName));
//    args.push_back(*name);
//    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, declLine);
//  }
  return node;
}

RefCSymNode CSymTree::define(RefString name, EObjType type, TULong defLine, TULong defCol, TBool isFieldScopeHolder){
  assertName(name);
  ASSERT(isType(type) && type != TUSER_DEFINED, "invalid type");
  
  RefCSymNode node = m_currentScope->getChild(name);
  if (node.get()) {
    if (node->getType() == type) {
      node->setIsDefined(defLine, defCol);
      if (!isFieldScopeHolder) {
        node->setIsScopeHolder(isFieldScopeHolder);
      }
    }
    else {
      //error : cannot define with a type different from the declaration type
    }
  }
  else {
    ASSERT(FAIL, "you must first declare it, and after that define it");
  }

  return node;
}

//Because addDeclaration(), addDefinition return the node added then
//when entering the scope pass the newly created node to the function
//so that there wouldn't be a reason to search for the name. Saves
//some time.
void CSymTree::enterScope(RefString name) {
  assertName(name);
  
  RefCSymNode newScope = m_currentScope->getChild(name);
  if (newScope.get()) {
    m_currentScope = newScope;
  }
  else {
    ASSERT(FAIL,"this should not happen");
  }
}

void CSymTree::exitScope() {
  ASSERT(m_currentScope.get(), "null current scope");
  ASSERT(m_currentScope != m_root, "null current scope");
  if( m_currentScope != m_root )
    m_currentScope = m_currentScope->getParent();
}

void CSymTree::printTree(RefCSymNode currentNode, TInt depth) {
  if (!currentNode.get()) {
    currentNode = m_root;
  }
  ASSERT(currentNode.get(), "null node given");
  RefTMap_RefString_RefCSymNode map = currentNode->getChildren();

  if (map.get()) {
    stringstream s;
    for(TInt bars = 0; bars < depth; ++bars) {
      s << "|";
    }

    for(TMap_RefString_RefCSymNode_iter it = map->begin(); it != map->end(); ++it) {
      cout << s.str() << *(it->first) << endl;
      printTree(it->second, depth+1);
    }
  }
}


}

