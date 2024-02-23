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

#ifndef INC_GUARD_CSLOm_RANGEs_h
#define INC_GUARD_CSLOm_RANGEs_h

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
// CSLOmBaseRange class
// ********************************************************************************
/**
 * The Base Range class is the base class for all bit range objects
 * Simple Bit Range, Multi Dimensional Bit Range, Field, Isa Field, Isa Element
 * 
 * This is an abstract class - you cannot instantiate it.
 * It doesn't do anything except being the base class for bit ranges
 */
class CSLOmBaseRange : public CSLOmBase {
  public:
    enum ECSLOmBitRangeType {
      BR_UNDEFINED,
      BR_SIMPLE,
      BR_MULTI_DIM,
      BR_MAX
    };
  protected:
    ECSLOmBitRangeType m_brType;

    /**
     * The constructor that calls the constructor of the base class
     */
    CSLOmBaseRange(TLineNumberType lineNumber,RefString fileName, ECSLOmBitRangeType brType);

    /**
     * Method to replace the this pointer with a this smart pointer
     */
    RefCSLOmBaseRange getThis() const { return boost::static_pointer_cast<CSLOmBaseRange>(m_weakRef.lock()); }
  public:
    virtual ~CSLOmBaseRange() {}
    /**
     * API function to cast an object
     */
    static RefCSLOmBaseRange cast(RefCSLOmBase object);

    /**
     * API function the get the ID of the bit range
     */
    RefCSLOmIdentifier getID() const { return boost::static_pointer_cast<CSLOmIdentifier>(getChild(ID)); }
    RefString getName() const { return boost::static_pointer_cast<CSLOmIdentifier>(getChild(ID))->getName(); }

    /**
     * return an expr link to the current object
     */
    RefCSLOmExprLink getBitRangeLink() const;

    /**
     * API function that returns if the bit range is multi dimensional or simple
     */
    ECSLOmBitRangeType getBrType() const { return m_brType; }
};

// ********************************************************************************
// CSLOmSimpleBitRange class
// ********************************************************************************
/**
 * Class that holds a single dimension bit range
 * Base class for field class
 * This is a class for csl_bitrange object
 * 
 * Children:
 * m_children[0] = ID     - RefCSLOmIdentifier
 * m_children[1] = offset - RefCSLOmNumber
 * m_children[2] = lower  - RefCSLOmNumber
 * m_children[3] = upper  - RefCSLOmNumber
 */
class CSLOmSimpleBitRange : public CSLOmBaseRange {
  protected:
    friend class CSLOmMultiDimBitRange;
    TBool m_isDefault;  
    TBool m_isField;    
    TBool m_isAnonymous;
    TBool m_hasSetWidth;

    static TULong m_anonymousCounter;

    RefString m_className;

    /**
     * Constructor of the class
     */
    CSLOmSimpleBitRange(TLineNumberType lineNumber,RefString fileName, TBool isDefault, TBool isField = FALSE);

  private:

    /**
     * Method to replace the this pointer with a this smart pointer
     */
    RefCSLOmSimpleBitRange getThis() const { return boost::static_pointer_cast<CSLOmSimpleBitRange>(m_weakRef.lock()); }

    /**
     * API function to allocate a smart pointer of this type, create the identifierm and add the new object in the OM tree
     */
    static RefCSLOmSimpleBitRange allocate(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name);

    friend class CSLOmExprLink;
    static RefCSLOmSimpleBitRange build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, RefCSLOmSimpleBitRange simpleBitRange, TBool dontChange = FALSE);

  public:
    virtual ~CSLOmSimpleBitRange() {}

    /**
     * API function to cast an object
     */
    static RefCSLOmSimpleBitRange cast(RefCSLOmBase object);

    /**
     * Build functions to allocate a smart pointer of this type
     * Different parameters for each csl constructor
     *
     * @see Documentation
     */
    static RefCSLOmSimpleBitRange build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr widthOrBitRange = RefCSLOmExpr());
    static RefCSLOmSimpleBitRange build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmSimpleBitRange simpleBitRange);
    static RefCSLOmSimpleBitRange build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr up, RefCSLOmExpr low);

    /**
     * set methods for offset
     */
    void setOffset(RefCSLOmExpr offset);

    /**
     * sets the lower to zero and upper to width - 1
     */
    void setWidth(RefCSLOmExpr width);

    /**
     * sets the lower and upper of the range
     */ 
    void setRange(RefCSLOmExpr low, RefCSLOmExpr up);

    /**
     * swaps upper and lower //SHOULD ONLY BE CALLED FROM CHECKER
     * DON'T CALL IT FROM ANYWHERE ELSE
     */ 
    void swapUpLow(){ m_isDefault=TRUE; setRange(getUpper(),getLower()); }

    /**
     * evaluates the expr and if the evaluation is a simple bitrange it calls the other setBitRange function
     */
    void setBitRange(RefCSLOmExpr br);

    /**
     * copies the values of the upper and lower to the current object
     */
    void setBitRange(RefCSLOmSimpleBitRange br);

    RefCSLOmSimpleBitRange getBitRange() const { return CSLOmSimpleBitRange::cast(getThis()); }

    /**
     * get methods for every child
     * the getID is inherited from BaseRange class
     */
    RefCSLOmExpr getOffset() const;
    RefCSLOmExpr getLower() const;
    RefCSLOmExpr getUpper() const;

    /**
     * calculates the width of the range
     */
    RefCSLOmExpr getWidth() const;

    /**
     * return flag
     */
    TBool hasSetWidth() {return m_hasSetWidth;}

    /**
     * returns if the object is a field or just a simple bit range
     */
    TBool brIsField    () const { return m_isField;     }

    /**
     * returns if the bitrange is anonymous
     * for instance if the bitrange is a dimension of a multi dim bit range
     */
    TBool isAnonymous() const { return m_isAnonymous; }

    /** 
     * if the lower and upper values have not been set
     * they default to 0
     */
    TBool isDefault  () const { return m_isDefault;   }

    /** 
     * if the lower and upper values have not been set
     * they default to 0
     */
    TBool isDimension() const { return getParent()->isMultiDimBitRange();   }

    const RefString getSimpleBitRangeClassName() const;
    void setSimpleBitRangeClassName(RefString name);

    /**
     * calls the visit function for this object
     */
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmMultiDimBitRange class
// ********************************************************************************
/**
 * Class that holds a n dimensions bit range
 * This is a class for csl_multi_dim_bitrange object
 * 
 * Children:
 * m_children[0]         = ID                - RefCSLOmIdentifier
 * m_children[1]         = no of dimenstions - RefCSLOmNumber
 * m_children[2 <-> n+2] = dimensions        - RefCSLOmSimpleBitRange
 */
class CSLOmMultiDimBitRange : public CSLOmBaseRange {
  private:
    TBool m_isAnonymous;
    static TULong m_anonymousCounter;

    /**
     * Method to replace the this pointer with a this smart pointer
     */
    RefCSLOmMultiDimBitRange getThis() const { return boost::static_pointer_cast<CSLOmMultiDimBitRange>(m_weakRef.lock()); }

    /**
     * class constructor
     */
    CSLOmMultiDimBitRange(TLineNumberType lineNumber,RefString fileName);
  public:    

    /**
     * API function to cast an object
     */
    static RefCSLOmMultiDimBitRange cast(RefCSLOmBase object);

    /**
     * Build functions to allocate a smart pointer of this type
     * Different parameters for each csl constructor
     *
     * @see Documentation
     */
    static RefCSLOmMultiDimBitRange build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr noOfDimsOrBr);

    /**
     * Build functions to allocate a smart pointer of this type
     * Different parameters for each csl constructor
     *
     * @see Documentation
     */
    static RefCSLOmMultiDimBitRange build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmMultiDimBitRange noOfDimsOrBr);

    /**
     * copies the param object inside the current object
     * all the dimensions are copied also
     */
    void copy(RefCSLOmMultiDimBitRange br);

    /**
     * API function to set the no of dimensions
     * it also creates the dimensions with default values
     */
    void setNoOfDims(RefCSLOmExpr noOfDims);

    /**
     * sets the offset of a dimension
     */
    void setDimOffset(RefCSLOmExpr dim, RefCSLOmExpr offset);

    /**
     * sets the width of a dimension
     */
    void setDimWidth(RefCSLOmExpr dim, RefCSLOmExpr width);

    /**
     * sets the lower and upper of a dimension
     */
    void setDimRange(RefCSLOmExpr dim, RefCSLOmExpr low, RefCSLOmExpr up);

    /**
     * evaluates the second expr and calls the other setDimBitRange function
     */
    void setDimBitRange(RefCSLOmExpr dim, RefCSLOmExpr br);

    /**
     * sets the lower and upper of a dimension to the values from the simple bitrange lower and upper
     */
    void setDimBitRange(RefCSLOmExpr dim, RefCSLOmSimpleBitRange br);

    /**
     * get the no of dimensions
     */
    RefCSLOmExpr getNoOfDims() const;

    /**
     * gets the offset of the dimension
     */
    RefCSLOmExpr getDimOffset(RefCSLOmExpr dim) const;

    /**
     * calculates the width of the dimension
     */
    RefCSLOmExpr getDimWidth(RefCSLOmExpr dim) const;

    /**
     * gets the lower of the dimension
     */
    RefCSLOmExpr getDimLower(RefCSLOmExpr dim) const;

    /**
     * gets the upper of the dimension
     */
    RefCSLOmExpr getDimUpper(RefCSLOmExpr dim) const;

    /**
     * gets the bitrange of the dimension
     */
    RefCSLOmSimpleBitRange getDimBitRange(RefCSLOmExpr dim) const;

    /**
     * gets the first dimension
     */
    RefCSLOmSimpleBitRange getDimZero() const { return CSLOmSimpleBitRange::cast(getChild(FIRST_DIM));}

    /**
     * API function that states if the multi dim bit range is anonymous
     */ 
    TBool isAnonymous() const { return m_isAnonymous; }

    /**
     * API function that states if the dim has the width set or not
     */ 
    TBool dimIsDefault(TUInt dimNo) const { return CSLOmSimpleBitRange::cast(getChild(dimNo+FIRST_DIM))->isDefault(); }

    /**
     * function that calls the visit function for this object
     */
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

// ********************************************************************************
// CSLOmField class
// ********************************************************************************
/**
 * Class that holds a field
 * Base class for isa_field and isa_element claasses
 * This is a class for csl_bitrange object
 * Field is a scopeHolder object
 * 
 * Children:
 * m_children[0] = ID     - RefCSLOmIdentifier
 * m_children[1] = offset - RefCSLOmNumber
 * m_children[2] = lower  - RefCSLOmNumber
 * m_children[3] = upper  - RefCSLOmNumber
 * m_children[4] = allowed Ranges - RefCSLOmContainer
 * m_children[5] = value | expr link to enumItem | expr link to enum - RefCSLOmExpr
 * if field is hierarchical then m_children[5] represents the first field
 * m_children[5 <-> n] = children fields - RefCSLOmField
 */
class CSLOmField : public CSLOmSimpleBitRange {
  public:
    enum ECSLOmFieldType {
      FIELD_UNDEFINED    ,
      FIELD_VALUE        ,
      FIELD_ENUM         ,
      FIELD_ENUM_ITEM    ,
      FIELD_HIERARCHICAL
    };

    enum ECSLOmFieldIsaType {
      FIELD_ISA_UNDEFINED ,
      FIELD_ISA_FIELD     ,
      FIELD_ISA_ELEMENT   ,
      FIELD_ISA_MAX
    };

    /**
     * Method to get the scope of the field
     */
    RefCSLOmScope getAttachedScope() const;

    /**
     * API function to cast an object to a field
     */
    static RefCSLOmField cast(RefCSLOmBase object);

  private:

    /**
     * API function to get a smart pointer to this ptr
     */
    RefCSLOmField getThis() const { return boost::static_pointer_cast<CSLOmField>(m_weakRef.lock());  }

    /**
     * function to allocate a smart pointer to the field class
     */
    static RefCSLOmField allocate( TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name); 

  protected:
    RefCSLOmScope m_scope;
    ECSLOmFieldType m_fieldType;
    RefTVec_RefCSLOmField m_fieldPositions;
    TBool m_hasPositionsSet;
    ECSLOmFieldIsaType m_fieldIsaType;

    TBool m_isDecoder;
    TBool m_isInstance;
    TBool m_isUpdated;
    friend class CSLOmSimpleBitRange;
    void updateHierWidth();
    
    /**
     * constructor
     */
    CSLOmField(TLineNumberType lineNumber,RefString fileName, ECSLOmFieldType type, ECSLOmFieldIsaType isIsa = FIELD_ISA_UNDEFINED); 
  public:

    virtual ~CSLOmField() {}

    TBool hasPositionsSet() { return m_hasPositionsSet; }

    TBool isEnumFieldInstance() { return m_isInstance; }
    /**
     * API function to state if a decoder is to be generated out of this field
     */
    TBool isDecoder() const { return m_isDecoder; }

    /**
     * set function that sets the gen decoder bit to TRUE
     * asserts if the bit is already set
     */
    void setAsDecoder() { ASSERT(!m_isDecoder, "already a decoder"); m_isDecoder = TRUE; }

    /**
     * build functions to build a field object width different params
     */
    static RefCSLOmField build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name); 
    static RefCSLOmField build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr widthOrBr, RefCSLOmExprLink enumItemOrEnum = RefCSLOmExprLink()); 
    static RefCSLOmField build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr low, RefCSLOmExpr up, RefCSLOmExprLink enumItemOrEnum = RefCSLOmExprLink()); 
    static RefCSLOmField build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmField field); 

    /**
     * API functions to state the type of the field
     */
    TBool isWithValue()    const { return m_fieldType == FIELD_VALUE; }
    TBool isWithEnum()     const { return m_fieldType == FIELD_ENUM; }
    TBool isWithEnumItem() const { return m_fieldType == FIELD_ENUM_ITEM; }
    TBool isHierarchical() const { return m_fieldType == FIELD_HIERARCHICAL; }    

    /**
     * returns the type of the field
     */
    ECSLOmFieldType getFieldType() const { return m_fieldType; }


    /**
     * API function to return if the current object is an isaField or not
     */
    TBool fIsIsaField() const { return m_fieldIsaType == FIELD_ISA_FIELD; }

    /**
     * API function to return if the current object is an isaElement or not
     */
    TBool fIsIsaElement() const { return m_fieldIsaType == FIELD_ISA_ELEMENT; }

    /**
     * API function to return the isa type of the field
     */
    ECSLOmFieldIsaType getFieldIsaType() const { return m_fieldIsaType; }

    /**
     * returns true if the value is within the allowed ranges or no allowed range has been set
     */
    TBool isAllowed(RefCSLOmNumber value);

    /**
     * adds a allowed range to the field
     */
    void addAllowedRange(RefCSLOmExpr low, RefCSLOmExpr up);

    /**
     * adds a allowed range to the field
     */
    RefCSLOmContainer getAllowedRange() { return CSLOmContainer::cast(getChild(FIELD_POS_RANGES)); }

    /**
     * set functions to associate a value, enum or enumItem to the field
     * this method are mutualy exclusive
     * if one is called the other to cannot be called anymore on that field
     */
    void setValue(RefCSLOmExpr value);
    void setEnum(RefCSLOmEnum enum_);
    void setEnumItem(RefCSLOmIdentifier enumItem);

    /**
     * get methods for the value
     * asserts if the type is incorrect
     * check the type before calling this functions
     */
    RefCSLOmBase getValue() const { 
      if(m_fieldType == FIELD_VALUE) {
        return getChild(FIELD_POS_VALUE); 
      }
      else {
        return RefCSLOmBase();
      }
    }
    RefCSLOmBase getEnum() const { 
      if(m_fieldType == FIELD_ENUM) {
        return CSLOmExprLink::cast(getChild(FIELD_POS_ENUM))->doEval(); 
      }
      else {
        return RefCSLOmBase();
      }
    }
    RefCSLOmBase getEnumItem() const { 
      if(m_fieldType == FIELD_ENUM_ITEM) {
        return CSLOmExprLink::cast(getChild(FIELD_POS_ENUM_ITEM))->doEval(); 
      }
      else {
        return RefCSLOmBase();
      }
    }

    /**
     * returns the children of the current hierarchical field
     * asserts if the field is not hierarchical
     * check before calling this method that the field isHierarchical
     */
    RefTVec_RefCSLOmBase getFields() const {ASSERT(m_fieldType == FIELD_HIERARCHICAL, "test the fieldType first"); return getChildrenAsBase(TYPE_ALL_FIELDS); }

    TBool prevOverlap(RefCSLOmField, RefCSLOmField);
    TBool nextOverlap(RefCSLOmField, RefCSLOmField);
    TBool posOverlap(RefCSLOmField, RefCSLOmNumber);

    /**
     * return if the position of the field is already set
     */
    TBool isSetPosition(RefCSLOmField field);

    TInt getFieldPosition(RefCSLOmField field);
    RefTVec_RefCSLOmField getFieldPositions(){return m_fieldPositions;}

    /**
     * methods to set the children field possitions relative to the bits or relative to other children fields
     */
    void setFieldPosition(RefCSLOmField, RefCSLOmExpr);
    void setNextField(RefCSLOmField, RefCSLOmField);
    void setPreviousField(RefCSLOmField, RefCSLOmField);
    
    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;    
};

// ********************************************************************************
// CSLOmAddressRange class
// ********************************************************************************
class CSLOmAddressRange : public CSLOmBase {
  public:
    enum EAddressRangeType {
      ADDR_UNDEFINED ,
      ADDR_RESERVED  ,
      ADDR_VALID     ,
      ADDR_ILLEGAL   ,
      ADDR_MAX
    };

    enum EAccessRights {
      ACC_NONE  = 0,
      ACC_RD    = 1,
      ACC_WR    = 2,
      ACC_RD_WR = 3
    };

  private:
    EAddressRangeType m_rangeType;
    TBool m_isAnonymous;
    TULong m_accessRightsMask;
    static TULong m_anonymousCounter;

    friend class CSLOmMemoryMapPage;
    /**
     * builds a temporary range out of two expressions
     * only to be used internaly and in checking purposes
     */
  public:
    TBool isAnonymous() { return m_isAnonymous; }
    static RefCSLOmAddressRange build(TLineNumberType   lineNumber ,
                                      RefString         fileName,
                                      TInt              lower      , 
                                      TInt              upper      );
  private:
    RefCSLOmAddressRange getThis() const { return boost::static_pointer_cast<CSLOmAddressRange>(m_weakRef.lock()); }
    static RefCSLOmAddressRange allocate(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, EAddressRangeType type, const RefString& name = RefString());
    void addWidthAsRange(RefCSLOmExpr width);

  public:
    EAddressRangeType getAddressRangeType() const { return m_rangeType; }
    const TBool hasWidthOrRange() const;

  protected:  
    CSLOmAddressRange(TLineNumberType lineNumber,RefString fileName, EAddressRangeType type);

  public:
    static RefCSLOmAddressRange cast(RefCSLOmBase object);
    static RefCSLOmAddressRange build(TLineNumberType   lineNumber ,
                                      RefString         fileName,
                                      RefCSLOmBase      parent     , 
                                      RefCSLOmExpr      width      ,
                                      EAddressRangeType type       ,  
                                      const RefString&  name       = RefString());
    static RefCSLOmAddressRange build(TLineNumberType   lineNumber ,
                                      RefString         fileName,
                                      RefCSLOmBase      parent     , 
                                      RefCSLOmExpr      lower      , 
                                      RefCSLOmExpr      upper      ,
                                      EAddressRangeType type       ,  
                                      const RefString&  name       = RefString());

    void setWidth(RefCSLOmExpr width);
    void setRange(RefCSLOmExpr lower, RefCSLOmExpr upper);
    void setOffset(RefCSLOmExpr offset);
    void setType(EAddressRangeType type);

    void setAccessRights(RefCSLOmIdentifier group, EAccessRights access);
    EAccessRights getAccessRights(RefCSLOmIdentifier group) const;

    RefCSLOmExpr getLower() const;
    RefCSLOmExpr getUpper() const;
    RefCSLOmExpr getWidth() const;
    RefCSLOmExpr getOffset() const;

    TBool includes(RefCSLOmAddressRange range) const;
    TBool overlaps(RefCSLOmAddressRange range) const;
    TBool equals(RefCSLOmAddressRange range) const;

    TPair_RefCSLOmAddressRange_RefCSLOmAddressRange remove(RefCSLOmAddressRange);

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};


}

#endif
