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
#ifndef __INC_GUARD_SYMBOL_TABLE
#define __INC_GUARD_SYMBOL_TABLE

#include "Def.hpp"
#include "../../support/CommonSupport.h"
#include "../../csl_xml_warn_error/CSLC_Errors.h"

namespace NSSymbolTable {
//-------------------------------------------------------------------------//
//---------typedefs and various declarations for Symbol Tree --------------//
//-------------------------------------------------------------------------//
class CSymNode;
class CSymTree;

typedef boost::shared_ptr<CSymNode>                                   RefCSymNode;
typedef boost::shared_ptr<CSymTree>                                   RefCSymTree;

struct less_RefString {
    TBool operator() (const RefString& s1, const RefString& s2) const;
};

  // DEP moved to support/TypeDefs.h typedef std::vector<RefString>                                           TVec_RefString;
typedef std::map<RefString, RefCSymNode, less_RefString>                 TMap_RefString_RefCSymNode;

  // DEP moved to support/TypeDefs.h typedef boost::shared_ptr<TVec_RefString>                                RefTVec_RefString;
typedef boost::shared_ptr<TMap_RefString_RefCSymNode>                    RefTMap_RefString_RefCSymNode;

typedef TMap_RefString_RefCSymNode::iterator                             TMap_RefString_RefCSymNode_iter;
  // DEP moved to support/TypeDefs.h typedef TVec_RefString::iterator                                         TVec_RefString_iter;

enum EObjType {
  TUNDEF                                = 0x00000000,
  TDESIGN                               = 0x00000001,
  TUSER_DEFINED                         = 0x00000002,
  TUNIT_DECL                            = 0x00000004,
  TIFC_DECL                             = 0x00000008,
  TSIGNAL_DECL                          = 0x00000010,
  TPORT_DECL                            = 0x00000020,
  TFIELD_DECL                           = 0x00000040,
  TRF_DECL                              = 0x00000080,
  TFIFO_DECL                            = 0x00000100,
  TMEMMAP_DECL                          = 0x00000200,
  TSIGNALGR_DECL                        = 0x00000400,
  TBITRANGE_DECL                        = 0x00000800,
  TCELL_DECL                            = 0x00001000,
  TLIST_DECL                            = 0x00002000,
  TTB_DECL                              = 0x00004000,
  TEVENT_DECL                           = 0x00008000,
//  TTBVEC_DECL                           = 0x00010000,
//  TISA_DECL                             = 0x00020000,
//  TISAI_DECL                            = 0x00040000,
//  TISAIF_DECL                           = 0x00080000,
  TISAF_DECL                            = 0x00010000,
  TISAE_DECL                            = 0x00020000,
  TENUM_DECL                            = 0x00040000,
  TENUMIT_DECL                          = 0x00080000,
  TMEMMAPP_DECL                         = 0x00100000,
  TREG_DECL                             = 0x00200000,
  TSTATED_DECL                          = 0x00400000,
  TVEC_DECL                             = 0x00800000,
  TSIGPATG_DECL                         = 0x01000000,
  TMEM_DECL                             = 0x02000000,
  TMDB_DECL                             = 0x04000000,
  TPIPELINE_DECL                        = 0x08000000,
  TPIPESTG_DECL                         = 0x10000000,
  TCONSTINT_DECL                        = 0x20000000,
  TPARAM_DECL                           = 0x40000000,
  TMAX                                  = 0x80000000
};                

void assertName(RefString name);
TBool hasOneBitSet(TInt Type);
TBool isType(EObjType type);

const TInt maskScopeHolder   = 
  TUNIT_DECL 
  | TIFC_DECL 
  | TDESIGN 
  | TFIELD_DECL 
  | TRF_DECL 
  | TFIFO_DECL 
  | TMEMMAP_DECL /*
                   | TISAIF_DECL 
                   | TISA_DECL 
                   | TISAI_DECL */
  
  | TMEMMAPP_DECL 
  | TREG_DECL 
  | TSIGNALGR_DECL 
  | TTB_DECL 
  | TMEM_DECL 
  | TSIGPATG_DECL 
  | TISAF_DECL 
  | TISAE_DECL 
  | TVEC_DECL 
  | TSTATED_DECL;

const TInt maskInstantiable  = 
  TUNIT_DECL 
  | TIFC_DECL 
  | TFIELD_DECL 
  | TRF_DECL 
  | TFIFO_DECL 
  | TMEMMAP_DECL 
  | TSIGNALGR_DECL 
  | TBITRANGE_DECL 
  | TSIGNAL_DECL
  | TPORT_DECL 
  | TCELL_DECL    
  | TLIST_DECL 
  | TTB_DECL 
  | TEVENT_DECL /*
                  | TTBVEC_DECL 
                  | TISA_DECL 
                  | TISAI_DECL 
                  | TISAIF_DECL*/ 
  | TENUM_DECL 
  | TENUMIT_DECL 
  | TMEMMAPP_DECL
  | TREG_DECL 
  | TSTATED_DECL 
  | TVEC_DECL 
  | TSIGPATG_DECL 
  | TMEM_DECL 
  | TMDB_DECL 
  | TISAF_DECL 
  | TISAE_DECL 
  | TPIPELINE_DECL;

//function that does the checks for the param name

/**
   The node of the symbol tree.
**/
//-------------------------------------------------------------------------//
// CSymNode class
//-------------------------------------------------------------------------//
class CSymNode {
  private:
    boost::weak_ptr<CSymNode> m_parent;                        //the parent of this object
    RefTMap_RefString_RefCSymNode m_children;    //the map with children. The key of the map is the name of the child. The other member is the ref pointer to the child.
    EObjType m_type;                             //the type of this object.
    boost::weak_ptr<CSymNode> m_userDef;                       //if m_type == TUSER_DEFINED then m_userDef should point to the user defined type for this object.
    TBool m_isDefined;                             //this TBool shows if this object was defined. Only the objects in the maskScopeHolder can be defined.
    TBool m_isUsed;                                //this TBool is true if this object was used in an expression different than a declaration.
    TBool m_isFieldScopeHolder;                         //this TBool is true if this object is scope holder(used for field and isa_field, which can be scope holder or non scope 
                                                        //holder)
    RefString m_name;

    boost::weak_ptr<CSymNode> m_weakRef;
    //these TULong variables store debugging information for the user like:
    //declaration and definition line and column for this object, as well as the name of the source file
    //from where the objects were created.
    TULong m_declLine, m_declCol, m_defLine, m_defCol;
    RefString m_fileName;

    CSymNode();
    CSymNode(RefString name      ,
             EObjType type       , 
             TULong declLine     ,     
             TULong declCol      , 
             RefString fileName  );
    
    //adds a child to the object. Returns a pair between the node added/present in the map and the TBoolean value
    //of the insertion into the map. If by any reason the element was not added to the map then the first member
    //of the pair is a null ref.
    //The return value depends on the implementation of the insert method of map, which is:
    //  pair<iterator,TBool> insert( const TYPE& pair );
    //  inserts pair<key,val>, but only if no element with key key already exists. The return value is an iterator
    //  to the element inserted (or an existing pair with key key), and a TBoolean which is true if an insertion took place.
    //So, after analysing the above 3 lines the output should be like:
    //If TBool == true then the node returned should be the same as the one given as a param. The insert was successfull.
    //Else if RefCSymNode != null then this is the node that already is in the map (same result as find).
    // Else, when TBool == false and RefCSymNode == null then the insert failed.
    //Check: http://www.cppreference.com/cppmap/insert.html
    void addChild(RefString name, RefCSymNode child);
    void setParent(RefCSymNode);
  public:
    RefCSymNode getThis()  { return m_weakRef.lock();  }
    TBool isScopeHolder()  { return ((m_type & maskScopeHolder) && m_isFieldScopeHolder);  }
    TBool isInstantiable() { return m_type & maskInstantiable; }
    TBool isUserDefined()  { return m_type == TUSER_DEFINED;   }

    static RefCSymNode buildRoot();
    static RefCSymNode build(RefString        fileName    , 
                             TULong           line        , 
                             TULong           column      , 
                             RefCSymNode      parent      , 
                             const RefString& name        , 
                             EObjType         type        , 
                             RefCSymNode      userDefType = RefCSymNode());

    RefCSymNode getParent() const { return m_parent.lock(); }
    RefString getName()     const { return m_name; }
    EObjType getType()      const { return m_type; }
    TULong getDeclLine() const { return m_declLine; }
    TULong getDeclCol() const { return m_declCol; }
    TULong getDefLine() const { return m_defLine; }
    TULong getDefCol() const { return m_defCol; }
    RefString getFilename() const { return m_fileName; }

    void setDefLine(TULong line) { m_defLine = line; } 
    void setDefCol(TULong col) { m_defCol = col; }

    //defining the object and setting it's line and column definition information
    void setIsDefined(TULong defLine, TULong defCol);
    void setIsScopeHolder(TBool isFieldScopeHolder); //used for field and isa_field

    //returns true if the object was defined, else false.
    TBool isDefined() const { return m_isDefined; }

    RefCSymNode getUserDefinedType() const { return m_userDef.lock(); }

    //searches for name in the children map.
    //Returns RefCSymNode() if name is not found
    //or the node with that name if name is found.
    RefCSymNode getChild(RefString name);

    //Returns the map with the children
    RefTMap_RefString_RefCSymNode getChildren() const {
      return m_children;
    }
};

/**
 *  Class that has the functionality of a tree.
 */
//-------------------------------------------------------------------------//
// CSymTree class
//-------------------------------------------------------------------------//
class CSymTree {
  private:
    //the root of the tree. Has an empty string as a name, it's type is TUNDEF and it's parent is RefCSymNode().
    RefCSymNode m_root;
    //stores the current scope.
    //At first it is the root.
    RefCSymNode m_currentScope;

  public:
    CSymTree();
    //declares an object with name name and type type. declLine, declCol and fileName are the line, column and filename for
    //the current declaration and are used for creating the error message.
    //The showWarning TBoolean flag inhibits the print of the warning message, when the object is already declared, but only
    //if it is set to false.
    RefCSymNode declare(RefString       name        , 
                        EObjType        type        ,
                        RefString       fileName    , 
                        TULong          declLine    , 
                        TULong          declCol     , 
                        RefString       userType    = RefString());
    //searches for node with name name and type type in the current scope. If not found creates it and adds it to the current scope.
    //Sets the defined bit to 1 so that when we try to define it again it will fail with an error message.
    RefCSymNode define(RefString name, EObjType type, TULong defLine, TULong defCol, TBool isFieldScopeHolder = TRUE);

    //switches to the new scope
    void enterScope(RefString);

    void exitScope();
    
    RefCSymNode getCurrentScope() const { return m_currentScope; }

    RefCSymNode lookup(RefString);
    RefCSymNode lookup(std::vector<RefString>);

    //recursive nice print of the tree
    void printTree(RefCSymNode currentNode = RefCSymNode(), TInt depth = 0);
};

}

#endif
