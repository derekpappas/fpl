// Copyright (c) 2005, 2006, 2007, 2008 Fastpathlogic
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

// Author BogdanZ

#ifndef INC_GUARD_CSLOm_ISA_h
#define INC_GUARD_CSLOm_ISA_h

#include "Base.h"
#include "../support/CommonSupport.h"
#include "VeriNum.h"
#include "CSLOM_Declarations.h"
#include "CSLOM_Base.h"
#include "CSLOM_Scoping.h"

namespace NSCSLOmVisitor {
class CVisitor;
}

namespace NSCSLOm {

// ********************************************************************************
// CSLOmIsaField class
// ********************************************************************************
/**
 * class that holds information about an isaField
 * all range methods are inherited from simpleBitRange
 * all hierarchical positioning methods are inherited from field
 */
class CSLOmIsaField : public CSLOmField {
  public:
    enum ECSLOmIsaFieldType {
      ISA_FIELD_UNDEFINED,
      ISA_FIELD_OPCODE,
      ISA_FIELD_SUBOPCODE,
      ISA_FIELD_RF_ADDR,
      ISA_FIELD_MEM_ADDR,
      ISA_FIELD_BRANCH_ADDRESS,
      ISA_FIELD_IM,
      ISA_FIELD_SELECTOR,
      ISA_FIELD_RESERVED,
      ISA_FIELD_UNUSED,
      ISA_FIELD_CONSTANT,
      ISA_FIELD_MAX
    };
  private:

    /**
     * constructor
     */
    CSLOmIsaField(TLineNumberType, RefString, CSLOmField::ECSLOmFieldType);

    /**
     * members needed by Isa Checker for special and mofo check
     */
    

    /**
     * API function to return a shared_ptr to this object
     */
    RefCSLOmIsaField getThis() const { return boost::static_pointer_cast<CSLOmIsaField>(m_weakRef.lock());  }   
    RefString m_mnemonic;
    RefString m_name;
    ECSLOmIsaFieldType m_isaFieldType;

    /**
     * method that allocates a generic isa field
     */
    static RefCSLOmIsaField allocate( TLineNumberType    lineNumber,
                                      RefString          fileName,
                                      RefCSLOmBase       parent    ,
                                      const RefString&   name      );

  public:

    /**
     * API function to cast a base object to an isa field object
     */
    static RefCSLOmIsaField cast(RefCSLOmBase object);

    /**
     * build methods to create a isa field object
     * parameters are set according the csl_constructors
     * 
     * @see Documentation
     */
    static RefCSLOmIsaField build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExprLink enumItemOrEnum = RefCSLOmExprLink()); 
    static RefCSLOmIsaField build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr widthOrBr, RefCSLOmExprLink enumItemOrEnum = RefCSLOmExprLink()); 
    static RefCSLOmIsaField build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr low, RefCSLOmExpr up, RefCSLOmExprLink enumItemOrEnum = RefCSLOmExprLink()); 
    static RefCSLOmIsaField build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmIsaField field); 

    /**
     * sets the name of the isa field
     * attention: it does not change the identifier
     */
    void setName(RefString);

    /**
     * sets the mnemonic of the isa field
     */
    void setMnemonic(RefString);

    /**
     * sets the isa field type: selector, constant etc.
     */
    void setIsaFieldType(ECSLOmIsaFieldType);
    
    /**
     * get functions for name, mnemonic and type
     */
    RefString getName();
    RefString getMnemonic();
    ECSLOmIsaFieldType getIsaFieldType();

    /**
     * method that calls visit for the current object
     */
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmIsaElement class
// ********************************************************************************
class CSLOmIsaElement : public CSLOmField {
  public:
    enum EIsaElementType {
      ISA_ELEM_UNDEFINED,
      ISA_ELEM_ROOT,
      ISA_ELEM_FORMAT,
      ISA_ELEM_INSTR,
      ISA_ELEM_MAX
    };

    /**
     * API function to cast a base object to an isa field object
     */
    static RefCSLOmIsaElement cast(RefCSLOmBase object);

  private:
    RefCSLOmIsaElement getThis() const { return boost::static_pointer_cast<CSLOmIsaElement>(m_weakRef.lock()); }   

    RefTVec_RefCSLOmBase m_registeredEnums;    
    RefTVec_RefCSLOmIdentifier m_registeredEnumItems;
    EIsaElementType m_isaElemType;
    EIsaElementType m_sourceType;

    TBool m_shouldBeRoot;
    TBool m_cannotBeInstr;

    WeakRefCSLOmIsaElement m_isaParent;
    RefTVec_WeakRefCSLOmIsaElement m_isaChildren;
    
    void setIsaParent(RefCSLOmIsaElement);
    void addIsaChild(RefCSLOmIsaElement);

    CSLOmIsaElement(TLineNumberType, RefString);

  public:

    /**
     * build method for isa element object
     * @param lineNumber - type TLineNumberType - linenumber - line number in the csl code
     * @param parent - type RefCSLOmIsaElement - parent scope
     * @param name - type RefString - name of the isa element
     * @param source - type RefCSLOmIsaElement - the isa element from which is inherited the current isa element - if exists
     */
    static RefCSLOmIsaElement build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmIsaElement source = RefCSLOmIsaElement());

    RefCSLOmIsaElement getIsaParent() { return m_isaParent.lock(); }
    RefTVec_WeakRefCSLOmIsaElement getIsaChildren() { return m_isaChildren; }

    /**
     * sets type of isa element: root, format or instruction
     */
    void setIsaType(EIsaElementType type);

    /**
     * API function to return the isa element type
     */
    EIsaElementType getIsaType() const { return m_isaElemType; } 
    TBool getShouldBeRoot(){ return m_shouldBeRoot;}
    TBool getCannotBeInstr(){ return m_cannotBeInstr;}


    void registeredEnum(RefCSLOmEnum);
    void registeredEnumItem(RefCSLOmIdentifier);

    TBool ancestorHasRegisteredEnum(RefCSLOmBase en);
    TBool hasRegisteredEnum(RefCSLOmBase en);
    RefTVec_RefCSLOmIdentifier getRegisteredEnums();
    RefTVec_RefCSLOmIdentifier getRegisteredEnumItems() { return m_registeredEnumItems; }

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

}

#endif
