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

#ifndef INC_GUARD_CSLOm_MISC_h
#define INC_GUARD_CSLOm_MISC_h

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
// CSLOmDesign class
// ********************************************************************************
/**
 * This CSLOm class represents the "design" concept. All units, commands, declarations, asserts, etc.
 * in a design are attached to only one design object. However, an application can create multiple 
 * design objects, each of them holding unrelated units, commands, etc. <br/>
 * In CSLOm therms, a design is a scope and models the absolute root concept. It is the scope
 * parent of all top level instances units, register files, etc.
 */
class CSLOmDesign : public CSLOmBase {
  public:
    static RefCSLOmDesign cast(RefCSLOmBase object);
  private:
    RefCSLOmDesign getThis() const { return boost::static_pointer_cast<CSLOmDesign>(m_weakRef.lock()); }
    RefCSLOmScope m_scope; // attached scope

    CSLOmDesign();

  public:
    static RefCSLOmDesign build();

    RefCSLOmScope getAttachedScope() const;
    
    const RefTVec_RefCSLOmBase getTops() const;
    
    const RefTVec_RefCSLOmUnitDecl getUnitDeclarations() const;
    const RefTVec_RefCSLOmBase getUnitDeclarationsAsBase() const;
    const RefTVec_RefCSLOmBase getVerifCompsAsBase() const;
    const RefTVec_RefCSLOmBase getTBsAsBase() const;
    const RefTVec_RefCSLOmBase getEnumDeclarationsAsBase() const;
    const RefTVec_RefCSLOmBase getMemoryMapsAsBase() const;
    const RefTVec_RefCSLOmBase getMemoryMapPagesAsBase() const;
    const RefTVec_RefCSLOmBase getISAAsBase() const;
    const RefTVec_RefCSLOmBase getFieldsAsBase() const;
    
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmInclude class
// ********************************************************************************
class CSLOmInclude : public CSLOmBase {
  private:
    RefCSLOmInclude getThis() const { return boost::static_pointer_cast<CSLOmInclude>(m_weakRef.lock()); }
    EIncludeFileType m_fileType;
    RefString m_incFileName;
    CSLOmInclude(TLineNumberType, RefString, EIncludeFileType, RefString);
  public:
    static RefCSLOmInclude build(TLineNumberType, RefString, EIncludeFileType, const RefString&);
    const RefString getIncFileName() const;
    const EIncludeFileType getFileType() const;
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmList class
// ********************************************************************************
class CSLOmList: public CSLOmBase {
  public:
    static RefCSLOmList cast(RefCSLOmBase object);
    RefCSLOmIdentifier getID() const { ASSERT(getChild(ID).get(), "Identifier non existent"); return CSLOmIdentifier::cast(getChild(ID)); }
    RefCSLOmBase getIDAsBase() const { ASSERT(getChild(ID).get(), "Identifier non existent"); return getChild(ID); }
    RefString getName() const { return getID()->getName(); }
    RefTVec_RefCSLOmExprLink getLinks() const { return getChildren<CSLOmExprLink>(TYPE_EXPR); }
    RefTVec_RefCSLOmBase getLinksAsBase() const { return getChildrenAsBase(TYPE_EXPR); }
  private:
    RefCSLOmList getThis() const { return boost::static_pointer_cast<CSLOmList>(m_weakRef.lock()); }
    static TULong m_anonymousCounter;
    ECSLOmType m_listType;

  protected:
    CSLOmList(TLineNumberType lineNumber, RefString fileName);

    /**
     * Verifies that the exprLink points to a object of the same type with the rest of the 
     * objects in the class
     * If there aren't any objects in the list then the list takes the type of the object
     * If the object doesn't exist the type of the list will be TYPE_ALL_TYPES for creating list of 
     * names.
     */
    TBool verifyObjectType(RefCSLOmExprLink object);
    
  public:
    /**
     * The build method for CSLOmList
     *
     * @param lineNumber - type TLineNumberType - the lineNumber where the number appears
     * @param parent - type RefCSLOmBase - the parent of the port
     * @param objects - type RefTVec_RefCSLOmExprLink - vector of ExprLinks to the objects inside the list
     * @param name - type RefString - the list name(implicit param for anonymous list, then the name will be generated like this (*CSLList_index))
     *
     * @return RefCSLOmList - the list object that has been built
     */
    static RefCSLOmList build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name = RefString(new std::string("")));

    void addItemToList(RefCSLOmExprLink);
    void removeItemFromList(RefCSLOmExprLink);

    /**
     * This function evaluates all the links in the list and returns a Ref to a vector of
     * objects of type RefCSLOmBase
     */
    RefTVec_RefCSLOmBase getObjects();

    /**
     * Returns the type of the objects in the list
     */
    ECSLOmType getListType();
    TBool isSignalList();
    TBool isPortList();
    TBool isGroupList();
    TBool isInterfaceList();

    /**
     * Returns an ExprLink to the current object
     * Used by TW for anonymous lists
     */
    RefCSLOmExprLink getListLink();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmEnum class
// ********************************************************************************

class CSLOmEnum : public CSLOmBase {
    // ATTENTION: according to the c++ enum csl_enum can have to items with same value
  private:
    //    RefTMap_RefString_RefCSLOmNumber m_enum;
    RefCSLOmEnum getThis() const { return boost::static_pointer_cast<CSLOmEnum>(m_weakRef.lock()); }
    TInt m_currentMaxValue;
    TUInt m_width;

  protected:
    CSLOmEnum(TLineNumberType lineNumber, RefString fileName);
    static RefCSLOmEnum allocate(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name );
  public:
    static RefCSLOmEnum cast(RefCSLOmBase object);
    static RefCSLOmEnum build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name);
    void addPair(RefString itemName, RefCSLOmNumber itemValue = RefCSLOmNumber());
    RefCSLOmNumber getValue(RefString itemName);
    RefString getName(RefCSLOmNumber itemValue);
    //API methods (usefull in(for) other classes):
    TBool hasItem(RefCSLOmNumber itemValue);
    TBool hasItem(RefString itemName);
    TBool isEmpty();

    TUInt getWidth();

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmContainer class
// ********************************************************************************
// this class is for internal use (it does not have language representation)
// so for that purpose every class that needs access for this object has to be declared as friend
class CSLOmContainer : public CSLOmBase {
  private:
    friend class CSLOmField;
    friend class CSLOmIsaField;
    friend class CSLOmIsaElement;
    friend class CSLOmMemoryMapPage;
    friend class CSLOmFifoInfo;
    //to be removed
    friend class CSLOmIsa;

    ECSLOmType m_containedType;
    RefCSLOmContainer getThis() const { return boost::static_pointer_cast<CSLOmContainer>(m_weakRef.lock());  }

    static RefCSLOmContainer allocate(TLineNumberType lineNumber, RefString fileName, ECSLOmType type);
    static RefCSLOmContainer build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, ECSLOmType type);
    static RefCSLOmContainer build(TLineNumberType lineNumber, RefString fileName, ECSLOmType type);
    
    void addItem(RefCSLOmBase item);
    ECSLOmType getContainedType() const;
  protected:
    CSLOmContainer(TLineNumberType lineNumber, RefString fileName, ECSLOmType type);

  public:
    static RefCSLOmContainer cast(RefCSLOmBase object);

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmEvent class
// ********************************************************************************
class CSLOmEvent {     //??? need specs
  public:
  private:
};

// ********************************************************************************
// CSLOmMux class
// ********************************************************************************
class CSLOmMux : public CSLOmBase {
  public:
    enum ESelectorType {
      SEL_UNDEFINED,
      SEL_ENCODED,
      SEL_ONE_HOT,
      SEL_ONE_COLD,
      SEL_MAX
    };

  private:
    RefCSLOmMux getThis() const { return boost::static_pointer_cast<CSLOmMux>(m_weakRef.lock()); }
    

    ESelectorType m_selectorType;
    TBool m_generatesUnit;
  protected:
    CSLOmMux(TLineNumberType, RefString);
  public:
    static RefCSLOmMux cast(RefCSLOmBase);
    static RefCSLOmMux build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExprLink output, RefCSLOmExprLink selector, RefCSLOmList inputs);

    const TBool generatesUnit() const;
    void generatesUnit(TBool);
};

// ********************************************************************************
// CSLOmParameter class
// ********************************************************************************
// author - eugennc

class CSLOmParameter : public CSLOmBase {

  private:
    TBool m_isOveriden;
    enum ECSLOmParameterType {
      PARAMETER_TYPE_UNDEFINED,
      PARAMETER_TYPE_DECL     ,
      PARAMETER_TYPE_OVR      ,
      PARAMETER_TYPE_MAX
    };

    //    RefTVec_RefCSLOmInstance m_parent;
    //RefCSLOmExprLink                            m_declName              ;
    //RefCSLOmNumber                              m_value                 ;
    RefTVec_WeakCSLOmUnitInstance               m_instanceLinks         ; //weak_ref
    ECSLOmParameterType                         m_parameterType    ;
    TUInt                                       m_width;

    RefCSLOmParameter getThis() const { return boost::static_pointer_cast<CSLOmParameter>(m_weakRef.lock());}
        
  protected:
    CSLOmParameter(TLineNumberType lineNumber, RefString fileName, ECSLOmParameterType type);

  public:
    
    static RefCSLOmParameter cast(RefCSLOmBase object);
    static RefCSLOmParameter build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmParameter oldParam, RefCSLOmNumber value = RefCSLOmNumber());
    static RefCSLOmParameter build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink declName, RefCSLOmNumber value = RefCSLOmNumber());
    static RefCSLOmParameter build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString &name, RefCSLOmExpr value, RefCSLOmExpr width = RefCSLOmExpr());
    TBool isDecl() const { return (PARAMETER_TYPE_DECL == m_parameterType); }
    TBool isOvr()  const { return (PARAMETER_TYPE_OVR  == m_parameterType); }
    TBool isOveriden()  const { return m_isOveriden; }
    void override (RefCSLOmNumber value); 
    RefCSLOmIdentifier getID() const ;
    RefCSLOmBase getIDAsBase() const ;
    RefString getName() const ;
    RefCSLOmNumber getValue() const;
    RefCSLOmExpr getValueAsExpr() const;
    RefCSLOmBase getValueAsBase() const;
    RefCSLOmExprLink getParamAsLink() const;
    void registerUnitInstance(RefCSLOmUnitInstance);
    RefTVec_WeakCSLOmUnitInstance getUnitInstances() const;
    TUInt getWidth() const;
    void acceptVisitor(NSCSLOmVisitor::CVisitor&) const;
};

}

#endif
