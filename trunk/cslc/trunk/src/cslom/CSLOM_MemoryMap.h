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

#ifndef INC_GUARD_CSLOm_MEM_MAP_h
#define INC_GUARD_CSLOm_MEM_MAP_h

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
// CSLOmMemoryMapLocation class
// ********************************************************************************
/**
 * Children list:
 * identifier - localAddr - globalAddr - accessRightsEnum
 * Data members:
 * m_addressableObject
 * m_accessRightsMask
 *
 * The identifier of a mem map location is the symbol set by the user for that address
 * This identifier gets registered into the scope of the mem map location list
 * @see CSLOmMemoryMapPage
 */

class CSLOmMemoryMapLocation : public CSLOmBase {
  private:
    RefCSLOmMemoryMapLocation getThis() const { return boost::static_pointer_cast<CSLOmMemoryMapLocation>(m_weakRef.lock()); }
    RefCSLOmBase m_addressableObject;
    TBool m_hasWidthOne;
  protected:
    CSLOmMemoryMapLocation(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase addressableObject);
  public:
    TBool hasWidthOne() const { return m_hasWidthOne; }
    static RefCSLOmMemoryMapLocation cast(RefCSLOmBase object);
    static RefCSLOmMemoryMapLocation build(TLineNumberType               lineNumber       , 
                                           RefString                     fileName         ,
                                           RefCSLOmMemoryMapPage         parent           , 
                                           const RefString&              symbol           , 
                                           RefCSLOmBase                  addressableObject, 
                                           RefCSLOmAddressRange          localAddr        , 
                                           RefCSLOmAddressRange          globalAddr       );

    //APIs
    const RefCSLOmBase getSymbolAsBase() const { ASSERT(getChild(ID).get(), "id does not exist"); return getChild(ID); }
    const RefCSLOmBase getGlobalAddrAsBase() const { ASSERT(getChild(MEM_MAP_LOC_GLOBAL_ADDR).get(), "global address non existent"); return getChild(MEM_MAP_LOC_GLOBAL_ADDR); } 
    const RefCSLOmBase getLocalAddrAsBase() const { ASSERT(getChild(MEM_MAP_LOC_LOCAL_ADDR).get(), "local address non existent"); return getChild(MEM_MAP_LOC_LOCAL_ADDR); } 

    const RefCSLOmIdentifier getSymbol() const;
    const RefCSLOmBase getAddressableObject() const { ASSERT(m_addressableObject.get(), "state element non existent"); return m_addressableObject; } 
    const RefCSLOmAddressRange getGlobalAddress() const;
    const RefCSLOmAddressRange getLocalAddress() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmMemoryMapPage class
// ********************************************************************************

class CSLOmMemoryMapPage : public CSLOmBase {
  public:
    enum Endianess {
      ENDIAN_UNDEFINED,
      ENDIAN_LITTLE   ,
      ENDIAN_BIG      ,
      ENDIAN_MAX
    };

  private:
    friend class CSLOmMemoryMapPageInstance;
    RefTMap_TUInt_RefCSLOmMemoryMapLocation m_map;

    TLong m_incAmount      ;
    TLong m_currentAddress ;
    TLong m_nextAddress    ;
    TLong m_dataWordWidth  ;
    TLong m_alignment      ;
    TULong m_symbolLength   ;
    TLong m_lowerBound     ;
    TLong m_upperBound     ;

    EMemoryMapType m_pageType;

    RefCSLOmScope m_scope;

    RefCSLOmExpr m_unitName;

    RefString m_prefix;
    RefString m_suffix;

    Endianess m_endianess;
    
    //for design checker
    TBool m_addAddressRangePresent;

    // RefTVec_RefCSLOmAddressRange m_range;
    // RefTVec_RefCSLOmAddressRange m_reserved;
    // RefTMap_TUInt_RefCSLOmMemoryMapLocation m_map;
    // RefTMap_RefCSLOmNumber_RefCSLOmNumber m_free;
    // 
    // TUInt m_incAmount;
    
    RefCSLOmMemoryMapPage getThis() const { return boost::static_pointer_cast<CSLOmMemoryMapPage>(m_weakRef.lock());  }
    CSLOmMemoryMapPage(TLineNumberType lineNumber, RefString fileName/*, TUInt incAmount*/);
    static RefCSLOmMemoryMapPage allocate(TLineNumberType      lineNumber, 
                                          RefString            fileName  ,
                                          RefCSLOmDesign       parent    ,
                                          const RefString&     name      );
  public:
    //for design checker again
    TBool isSetAddressRange(){return m_addAddressRangePresent;}
    TBool hasFree(TInt width) const;
  public:
    TBool isFree(RefCSLOmAddressRange range) const;
    TBool isIllegal(RefCSLOmAddressRange range) const;
    TBool isReserved(RefCSLOmAddressRange range) const;
    
    TBool isUnitNameSet() const { return m_unitName.get(); }
    RefCSLOmUnitDecl getUnitName() const { return CSLOmUnitDecl::cast(m_unitName->doEval()); }
    
  private:
    void allocLocation(RefCSLOmAddressRange range);
    /**
     * increments the current and next address by inc amount
     * if the range between the next address and next_addr+incAmount is illegal or reserved
     * then next address jumps to the first free range with width == incAmount
     * if there isn't another free range then next_range is assigned to -1
     * if current range is -1 inc returns false
     */
    TBool inc(TInt incAmount = 0);
  public:
    static RefCSLOmMemoryMapPage cast(RefCSLOmBase object);
    static RefCSLOmMemoryMapPage build(TLineNumberType      lineNumber,
                                       RefString            fileName  ,
                                       RefCSLOmDesign       parent    ,
                                       const RefString&     name      );

    static RefCSLOmMemoryMapPage build(TLineNumberType               lineNumber, 
                                       RefString                     fileName  ,
                                       RefCSLOmDesign                parent    ,
                                       const RefString&              name      ,
                                       RefCSLOmMemoryMapPage sourcePage);
    //API's
    RefCSLOmNumber getLowerBound() const { return CSLOmNum32::build(m_lineNumber, m_fileName, m_lowerBound); }
    RefCSLOmNumber getUpperBound() const { return CSLOmNum32::build(m_lineNumber, m_fileName, m_upperBound); }

    RefCSLOmScope getAttachedScope() const;

    void setUnitName(RefCSLOmExpr unitName);
    void addAddressRange(RefCSLOmNumber lower, RefCSLOmNumber upper);
    void setAddressIncrement(RefCSLOmNumber incAmount);
    void setNextAddress(RefCSLOmNumber address);
    void addReservedRange(RefCSLOmNumber lower, RefCSLOmNumber upper);
    void add(RefCSLOmBase addrObj, const RefString& name, RefCSLOmNumber baseAddress = RefCSLOmNumber());
    void add(RefCSLOmMemoryMapPage sourcePage);
    void setDataWordWidth(RefCSLOmNumber wordWidth);
    void setAlignment(RefCSLOmNumber align);
    void setEndianess(Endianess endian);
    void setSymbolMaxLength(RefCSLOmNumber length);
    void setPrefix(RefString prefix);
    void setSuffix(RefString suffix);
    void setAccessRights(RefCSLOmNumber low, RefCSLOmNumber up, RefCSLOmExprLink group, CSLOmAddressRange::EAccessRights accessRights);

    RefCSLOmNumber getAddressIncrement() const;
    RefCSLOmNumber getNextAddress()      const;
    RefCSLOmNumber getDataWordWidth()    const;
    RefCSLOmNumber getAlignment()        const;
    Endianess getEndianess()             const;
    RefCSLOmNumber getSymbolMaxLength()  const;
    RefString getPrefix()                const;
    RefString getSuffix()                const;

    RefTVec_RefCSLOmBase getPageInstances() { return getChildrenAsBase(TYPE_MEMORY_MAP_PAGE_INST); }

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmMemoryMapPageInstance class
// ********************************************************************************
class CSLOmMemoryMapPageInstance : public CSLOmBase {
  private:
    CSLOmMemoryMapPageInstance(TLineNumberType lineNumber, RefString fileName);
    RefCSLOmMemoryMapPageInstance getThis() const { return boost::static_pointer_cast<CSLOmMemoryMapPageInstance>(m_weakRef.lock()); }
  public: 
    static RefCSLOmMemoryMapPageInstance cast(RefCSLOmBase object);
    static RefCSLOmMemoryMapPageInstance build(TLineNumberType  lineNumber ,
                                               RefString        fileName   ,
                                               RefCSLOmBase     parent     , 
                                               RefCSLOmExprLink type       , 
                                               const RefString& name       , 
                                               RefCSLOmExprLink unitInst   = RefCSLOmExprLink());

    TBool hasUnitInstance() const { return getChildrenSize() == MEM_MAP_PAGE_UNIT_INST + ONE; }

    RefCSLOmIdentifier getID() const { return boost::static_pointer_cast<CSLOmIdentifier>(getChild(ID)); }
    RefCSLOmExprLink getPageExpr() const { return boost::static_pointer_cast<CSLOmExprLink>(getChild(MEM_MAP_PAGE_EXPR)); } 
    RefCSLOmExprLink getUnitInstanceExpr() const { 
      ASSERT(hasUnitInstance(), "should be tested by the caller"); 
      return boost::static_pointer_cast<CSLOmExprLink>(getChild(MEM_MAP_PAGE_UNIT_INST)); 
    } 

    RefCSLOmMemoryMapPage getPage() const { 
      ASSERT(getPageExpr()->isResolved(), "should be resolved by now"); 
      return boost::static_pointer_cast<CSLOmMemoryMapPage>(getPageExpr()->getValue()); 
    } 

    RefCSLOmUnitInstance getUnitInstance() const { 
      ASSERT(getUnitInstanceExpr()->isResolved(), "should be resolved by now"); 
      return boost::static_pointer_cast<CSLOmUnitInstance>(getUnitInstanceExpr()->getValue()); 
    }

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmMemoryMap class
// ********************************************************************************
class CSLOmMemoryMap : public CSLOmBase {
  public:
    RefCSLOmMemoryMap getThis() const { return boost::static_pointer_cast<CSLOmMemoryMap>(m_weakRef.lock()); }
  private:
    friend class CSLOmMemoryMapPageInstance;
    static TBool m_designHasMemoryMap;

    TBool m_autoGen;
    RefCSLOmUnitDecl m_topUnit;

    RefCSLOmScope m_scope;
    
    EMemoryMapType m_mapType;
    
    RefString m_prefix;
    RefString m_suffix;
    CSLOmMemoryMap(TLineNumberType lineNumber, RefString fileName);
  public:
    static RefCSLOmMemoryMap cast(RefCSLOmBase object);
    static RefCSLOmMemoryMap build(TLineNumberType, RefString, RefCSLOmDesign, const RefString&);

    RefCSLOmScope getAttachedScope() const;

    void autoGenMemoryMap() { m_autoGen = TRUE; }
    TBool getAutoGenBit() const { return m_autoGen; }

    void setTopUnit(RefCSLOmUnitDecl top);
    RefCSLOmUnitDecl getTopUnit() const;

    void setMemMapType(EMemoryMapType type);
    EMemoryMapType getMemMapType() const;

    void setAccessRightsEnum(RefCSLOmEnum group);
    RefCSLOmEnum getAccessRightsEnum();

    void setPrefix(RefString prefix) { ASSERT(prefix.get() && !prefix->empty(), "null or empty prefix"); m_prefix = prefix; }
    RefString getPrefix() const { return m_prefix; }
    void setSuffix(RefString suffix) { ASSERT(suffix.get() && !suffix->empty(), "null or empty prefix"); m_suffix = suffix; }
    RefString getSuffix() const { return m_suffix; }

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

}

#endif
