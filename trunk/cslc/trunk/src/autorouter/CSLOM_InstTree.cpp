//---------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 FastPath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of FastPath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of FastPath Logic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/**
 * Author: Zamfir Bogdan <bogdanz@fplsrl.com>
 */

#include "CSLOM_InstTree.h"
#include "CSLOM_InstTreeVisitor.h"

using namespace NSCInstTreeVisitor;
using namespace NSCSLOm;
using namespace std;

TBool instTreeHasErrors;
RefString cslTopUnitName;


namespace NSCInstTree {

string getIntanceHidAsString(RefCSLOmExprLink expr) {
  string output("");

  RefTVec_RefString names = expr->getHidNames();
  ASSERT(names.get(),"vector of ids is null ... this is bad");
  ASSERT(names->size() > 0, "names has no names.. please try again ");
  TVec_RefString::iterator it;

  for (it = names->begin(); it < names->end(); ++it) {
    output.append(*(*it));
  }
  ASSERT(!output.empty(), "HID is empty... this is not good");
  return output;
}

string getEndPointHidAsString(RefCSLOmExprLink expr) {
  string output("");

  ASSERT(expr->doEval().get(),"expression cannot be evaled");
  RefTVec_RefString names = expr->getHidNames();
  RefTVec_RefCSLOmIdentifier ids = expr->getIDs();
  ASSERT(names.get(),"vector of ids is null ... this is bad");
  ASSERT(names->size() > 0, "names has no names.. please try again ");
  TVec_RefString::iterator it;
  TVec_RefCSLOmIdentifier::iterator iter;

  for (it = names->begin(), iter = ids->begin(); 
       it < names->end()-1, iter < ids->end()-1; 
       ++it, ++iter) {
    output.append(*(*it));
  }
  ASSERT(!output.empty(), "HID is empty... this is not good");
  return output;
}

//********************************************************************
// CInstTreeNode class
//********************************************************************
boost::weak_ptr<CInstTreeNode> CInstTreeNode::m_root = boost::weak_ptr<CInstTreeNode>();
RefTVec_RefCInstTreeNode CInstTreeNode::m_nodeMap = RefTVec_RefCInstTreeNode(new TVec_RefCInstTreeNode);

CInstTreeNode::CInstTreeNode(TInt id, TInt level) :
  m_parent(),
  m_weakRef(),
  m_children(),
  m_unitDecl(),
  m_unitInstance(),
  m_level(level),
  m_id(id) {}

RefCInstTreeNode CInstTreeNode::build(TInt id, TInt level, RefCInstTreeNode parent, RefCSLOmUnitDecl unit, RefCSLOmUnitInstance inst) {
  ASSERT(unit.get(), "null received");

  CInstTreeNode* node;
  try {
    node = new CInstTreeNode(id, level);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCInstTreeNode refNode = RefCInstTreeNode(node);
  node->m_weakRef = boost::weak_ptr<CInstTreeNode>(refNode);

  if(!inst.get()) {
    node->m_name = CSLOmIdentifier::cast(unit->getChild(ID))->getName();
  }
  else {
    node->m_name = CSLOmIdentifier::cast(inst->getChild(ID))->getName();
  }

  if (parent.get()) {
    node->setParent(parent);
  }
  else {
    m_root = boost::weak_ptr<CInstTreeNode>(refNode);
  }
  node->m_unitDecl = boost::weak_ptr<CSLOmUnitDecl>(unit);
  node->m_unitInstance = boost::weak_ptr<CSLOmUnitInstance>(inst);

  m_nodeMap->push_back(refNode);

  return refNode;
}

void CInstTreeNode::setParent(RefCInstTreeNode parent) {
  ASSERT(!m_parent.lock().get(), "parent already set");
  ASSERT(parent.get(), "null received");  

  m_parent = boost::weak_ptr<CInstTreeNode>(parent);
  parent->addChild(getThis());
}

void CInstTreeNode::addChild(RefCInstTreeNode child) {
  ASSERT(child.get(), "null received");
  
  RefString name = child->getName();
  if(!m_children.get()) {
    m_children = RefTMap_RefString_RefCInstTreeNode (new TMap_RefString_RefCInstTreeNode);
  }
  m_children->insert(std::make_pair(name, child));
}

void CInstTreeNode::acceptVisitor(NSCInstTreeVisitor::CInstTreeVisitor& visitor) const {
  visitor.visit(getThis());
}

//********************************************************************
// CInstTreeCreator class
//********************************************************************
CInstTreeCreator::CInstTreeCreator() : 
  m_level(0),
  m_id(0),
  m_noOfUnitsTraversed(0),
  m_topUnit(new std::string("")),
  m_currentParent(),
  m_root(),
  m_hasTop(FALSE) {

  initMaskValueDisableAll();

  enableUnitJump();
  enableOnlyTop();
  enableNoTestObjects();

  enableDesignTraversal();                 
  enableDesignBeforeTraversal();           
  enableDesignInTraversal();               
  enableDesignAfterTraversal();            
                                                    
  enableUnitDeclTraversal();               
  enableUnitDeclBeforeTraversal();         
  enableUnitDeclInTraversal();             
  enableUnitDeclAfterTraversal();          
                                                    
  enableUnitInstanceTraversal();           
  enableUnitInstanceBeforeTraversal();     
  enableUnitInstanceInTraversal();         
  enableUnitInstanceAfterTraversal();      
                                                    
  enableUnitInstantiationTraversal();      
  enableUnitInstantiationBeforeTraversal();
  enableUnitInstantiationInTraversal();    
  enableUnitInstantiationAfterTraversal(); 
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmDesign                          & design                          ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmUnitDecl                        & unitDecl                        ) {
  ASSERT(unitDecl.get(), "null received");
  unitDecl->visitUnit();
    
  if (!m_hasTop && unitDecl->isTopUnit() && !unitDecl->isTestBench() && !unitDecl->isVerifComp()) {
    m_currentParent = CInstTreeNode::build(m_id++, m_level++, RefCInstTreeNode(), unitDecl);
    m_topUnit->append(*(CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName()));
    cslTopUnitName = CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName();
    m_root = m_currentParent;
    m_hasTop = TRUE;
  }
  else if (!unitDecl->isTopUnit() && !unitDecl->isTestBench() && !unitDecl->isVerifComp() ) {
    m_level++;
  }
  else if (!unitDecl->isTestBench() && !unitDecl->isVerifComp()) {
    m_topUnit->append(std::string(", "));
    m_topUnit->append(*(CSLOmIdentifier::cast(unitDecl->getChild(ID))->getName()));

    args.push_back(*m_topUnit);

    addErr(NSWarningErr::DEE_CSB_MOD_MULTIPLE_TOP_UNIT, args, 0, RefString(), FALSE, TRUE);
    instTreeHasErrors = TRUE;
  }
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmUnitInstance                    & unitInst                        ) {

  m_currentParent = CInstTreeNode::build(m_id++, m_level, m_currentParent, unitInst->getUnitDecl(), unitInst);

  RefCInstTreeNode temp = m_currentParent->getParent();

  RefString cycle(new std::string(""));
  cycle->append(*(CSLOmIdentifier::cast(m_currentParent->getUnitDecl()->getChild(ID))->getName()));

  while (temp.get()) {
    if (temp->getUnitInst().get() == unitInst.get()) {
      args.push_back(*cycle);

      addErr(NSWarningErr::DEE_CSB_MOD_CYCLE_FOUND, args, 0, RefString(), FALSE, TRUE);
      instTreeHasErrors = TRUE;

      disableUnitJump();
      disableOnlyTop();
      disableNoTestObjects();

      disableUnitDeclTraversal();               
      disableUnitDeclBeforeTraversal();         
      disableUnitDeclInTraversal();             
      disableUnitDeclAfterTraversal();          

      disableUnitInstanceTraversal();           
      disableUnitInstanceBeforeTraversal();     
      disableUnitInstanceInTraversal();         
      disableUnitInstanceAfterTraversal();      

      disableUnitInstantiationTraversal();      
      disableUnitInstantiationBeforeTraversal();
      disableUnitInstantiationInTraversal();    
      disableUnitInstantiationAfterTraversal();

      break;
    }
    else {
      cycle->append(", ");
      cycle->append(*(CSLOmIdentifier::cast(temp->getUnitDecl()->getChild(ID))->getName()));

      temp = temp->getParent();
    }
  }
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmInclude                         & fileInclude                     ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmUnitInstantiation               & unitInstantiation               ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmIdentifier                      & id                              ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmExprLink                        & exprLink                        ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmSignal                          & signal                          ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmGroup                           & group                           ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmGroupSignal                     & groupSignal                     ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmNum32                           & number                          ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmInterface                       & interface                       ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmPortDecl                        & portDecl                        ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmExprOp                          & exprOp                          ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmExprConcat                      & exprConcat                      ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmList                            & list                            ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmParameter                       & parameter                       ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmListExpr                        & listExpr                        ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {
}

void CInstTreeCreator::beforeTraversal(const RefCSLOmExprFuncSignature               & exprFuncSignature               ) {
}

// void CInstTreeCreator::beforeTraversal(const RefCSLOmParameterOverride               & parameterOverride               ) {
// }

void CInstTreeCreator::inTraversal(const RefCSLOmDesign                          & design                          ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmInclude                        & fileInclude                     ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmIdentifier                      & id                              ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmExprLink                        & exprLink                        ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmUnitDecl                        & unitDecl                        ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmSignal                          & signal                          ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmUnitInstance                    & unitInst                        ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmGroup                           & group                           ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmGroupSignal                     & groupSignal                     ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmNum32                           & number                          ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmInterface                       & interface                       ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmUnitInstantiation               & unitInstantiation               ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmPortDecl                        & portDecl                        ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmExprOp                          & exprOp                          ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmExprConcat                      & exprConcat                      ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmList                            & list                            ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmParameter                       & parameter                       ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmListExpr                        & listExpr                        ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {
}

void CInstTreeCreator::inTraversal(const RefCSLOmExprFuncSignature               & exprFuncSignature               ) {
}

// void CInstTreeCreator::inTraversal(const RefCSLOmParameterOverride               & parameterOverride               ) {
// }

void CInstTreeCreator::afterTraversal(const RefCSLOmIdentifier                      & id                              ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmExprLink                        & exprLink                        ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmDesign                          & design                          ) {

  RefTVec_RefCSLOmBase units = design->getChildrenAsBase(TYPE_DECL_UNIT);
  if (units.get()) {
    for (TVec_RefCSLOmBase::iterator it = units->begin(); it < units->end(); ++it) {
      if (!(*it)->isTestBench() && !(*it)->isVerifComp()) {
        if (!CSLOmUnitDecl::cast(*it)->isVisited()) {
          (*it)->acceptVisitor(*this);
        }
      }
    }
  }


//   else if (!m_hasTop && hasUnits) {

//     addErr(NSWarningErr::DEE_CSB_MOD_CYCLE_FOUND, args, 0, FALSE, TRUE);
//     instTreeHasErrors = TRUE;
//   }
}

void CInstTreeCreator::afterTraversal(const RefCSLOmUnitDecl                        & unitDecl                        ) {
  m_level--;
}

void CInstTreeCreator::afterTraversal(const RefCSLOmUnitInstance                    & unitInst                        ) {
  m_currentParent = m_currentParent->getParent();
}

void CInstTreeCreator::afterTraversal(const RefCSLOmInclude                         & fileInclude                     ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmUnitInstantiation               & unitInstantiation               ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmSignal                          & signal                          ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmSimpleBitRange                  & simpleBitRange                  ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmMultiDimBitRange                & multiDimBitRange                ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmGroup                           & group                           ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmGroupSignal                     & groupSignal                     ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmNum32                           & number                          ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmInterface                       & interface                       ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmPortDecl                        & portDecl                        ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmExprOp                          & exprOp                          ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmExprConcat                      & exprConcat                      ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmExprMultiConcat                 & exprMultiConcat                 ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmList                            & list                            ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmParameter                       & parameter                       ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmListExpr                        & listExpr                        ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmExprHybridOrFuncCall            & exprHybridOrFuncCall            ) {
}

void CInstTreeCreator::afterTraversal(const RefCSLOmExprFuncSignature               & exprFuncSignature               ) {
}

// void CInstTreeCreator::afterTraversal(const RefCSLOmParameterOverride               & parameterOverride               ) {
// }

} // end namespace NSCSLOmInstanceTree
