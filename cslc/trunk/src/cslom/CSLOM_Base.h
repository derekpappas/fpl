//----------------------------------------------------------------------
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
#ifndef INC_GUARD_CSLOm_BASE_h
#define INC_GUARD_CSLOm_BASE_h

//#include <QObject>

#include "Base.h"
#include "../support/CommonSupport.h"
//#include "VeriNum.h"
#include "CSLOM_Declarations.h"

namespace NSCSLOmVisitor {
  class CVisitor;
}

namespace NSCSLOm {

  // ********************************************************************************
  // CSLOmBase class
  // ********************************************************************************
  /**
   * This is the base class for all CSLOm classes (except CSLOmScope).
   * It is used to hold the raw type (ECSLOmType) of a class, the parent and the children objects.
   * It provides core mechanisms for self registration, automatic parent scope lookup, caching
   * and performance optimization.
   * Once a child is set the reverse link, from child to parent, is automaticaly updated
   * so you can navigate each way you want. This is like a double link relation.
   */
  class CSLOmBase{ //: public QObject {
  //Q_OBJECT

  private:
    RefCSLOmBase getThis() const { return m_weakRef.lock(); }
    mutable boost::weak_ptr<CSLOmScope> m_cachedParentScope; // cached parent scope

    void addChild  (const RefCSLOmBase child);
    void addChildAt(const RefCSLOmBase child, TUInt position);

  protected:
    TInt m_mandatoryCounter;
    boost::weak_ptr<CSLOmBase> m_weakRef; // self weak reference
    ECSLOmType m_type;
    boost::weak_ptr<CSLOmBase> m_parent; 
    RefTVec_RefCSLOmBase m_children;
    TLineNumberType m_lineNumber; 
    TLineNumberType m_colNumber; 
    RefString m_fileName;

    TBool m_addToMemoryMap;
    TBool m_isDefined;

    CSLOmBase(ECSLOmType type, TLineNumberType lineNumber, RefString fileName);

    friend class CSLOmScopeBlock; // class needs getAttachedScope for setting the current scope;

  public:
    void defineObject() { m_isDefined = TRUE; }
    TBool isDefined() { return m_isDefined; }
    TInt getMandatoryCount(){return m_mandatoryCounter;}

    void setFileName(RefString fn) { ASSERT(!m_fileName.get(), "filename allready set"); m_fileName = fn; }
    void setColumnNumber(TLineNumberType col) { m_colNumber = col; }

    RefString getFileName() const { return m_fileName; } // the name of the file that this construct was generated from
    TLineNumberType setColumnNumber() { return m_colNumber; }  // the linecolumn number in the file that this construct was generated from

    RefTVec_RefCSLOmBase getChildrenVec() const { return m_children; } // the children of this node
    TBool getAddToMemMapBit() const { return m_addToMemoryMap; } // related to memory mapped objects-investigate
    static RefCSLOmScope getAttachedScope(const CSLOmBase* base); // 
    virtual ~CSLOmBase();


    
    // returns the child of the current object from the specified index
    const RefCSLOmBase getChild(TUInt index) const { 
#ifdef RELEASE
      if (getChildrenSize() > index) {
        return m_children[index];
      }
      else {
        return RefCSLOmBase();
      }
#else
      if (getChildrenSize() > index) {
        return m_children->at(index); // use the STL function to check ??? instead of array access
      }
      else {
        return RefCSLOmBase();
      }
#endif
    }



    const TVec_RefCSLOmBase::size_type getChildrenSize() const {
      TVec_RefCSLOmBase::size_type size;
      if (!m_children.get()) { // no child list yet so return zero
        size = ZERO;
      }
      else {
        size = m_children->size();
      }
      return size;
    }
    const RefCSLOmBase getChild(ECSLOmType type, TUInt index) const;

    void setChild(TUInt index, RefCSLOmBase object);

    /**
     * Returns the raw type of this object.
     *
     * @return the raw type of this object
     * @see ECSLOmType
     */
    ECSLOmType getType() const;

    /**
     * Returns true if the object can be removed from the tree
     * The possible removable objects are:
     * - CSLOmPortDecl if the parent of it is a CSLOmInterface, if the parent of the CSLOmInterface is CSLOmDesign
     */
    TBool isRemovable() const;

    /**
     * Returns true if the declaration can be added to the memory map
     */
    TBool isAddressableDecl() const;

    /**
     * Returns true if the object can be added to the memory map
     */
    TBool isAddressable() const;

    //Vector or StateData

    /**
     * Returns true if the object is of StateData type
     */
    TBool isStateData() const;
    
    /**
     * Returns true if the object is of VerifComp type
     */
    TBool isVerifComp() const;

    /**
     * Returns true if the object is of Testbench type
     */
    TBool isTestBench() const;


    /**
     * Returns true if the object is of Vector type
     */
    TBool isVector() const;


    void addToMemoryMap();    

    /**
     * Returns true if the object can be inserted from the tree
     * The possible insertable objects are:
     * - CSLOmField
     */
    TBool isInsertable() const;

    /**
     * Returns true if this object is a top level object, that is his raw type is one of: <br/>
     *   - TYPE_DECL_UNIT <br/>
     *   - TYPE_DESIGN <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the top level status of this object
     * @see ECSLOmType
     * @see getType()
     */
    TBool isTopLevel() const;

    /**
     * Returns true if this object is a scope holder object, that is his raw type is one of: <br/>
     *   - TYPE_DESIGN <br/>
     *   - TYPE_DECL_UNIT <br/>
     *   - TYPE_INST_UNIT <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the scope status of this object
     * @see ECSLOmType
     * @see getType()
     */
    TBool isScopeHolder() const;

    /**
     * Returns true if this object is an identifier that points directly or indirectly to a scope object,
     * that is the raw type is one of: <br/>
     *   - TYPE_ID_SCOPE_DIRECT <br/>
     *   - TYPE_ID_SCOPE_INDIRECT <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the to scope status of this object
     * @see ECSLOmType
     * @see getType()
     */
    TBool isToScopeID() const;

    /**
     * Returns true if this object is an identifier, that is his raw type is one of: <br/>
     *   - TYPE_ID_SIMPLE <br/>
     *   - TYPE_ID_SCOPE_DIRECT <br/>
     *   - TYPE_ID_SCOPE_INDIRECT <br/>
     * or false otherwhise.
     *
     * @return true or false, depending on the identifier status of this object
     * @see ECSLOmType
     * @see getType()
     */
    TBool isID() const;
    TBool isFifo() const;
    TBool isRegisterFile() const;
    TBool isMemory() const;
    TBool isRegister() const;
    /**
     * Predicate for signal
     * @return true or false, depending on the type of object
     */
    TBool isSignal() const;

    /**
     * Predicate for Port
     * @return true or false, depending on the type of object
     */
    TBool isPort() const;

    /**
     * Predicate for Group
     * @return true or false, depending on the type of object
     */
    TBool isGroup() const;

    /**
     * Predicate for SignalGroup
     * @return true or false, depending on the type of object
     */
    TBool isSignalGroup() const;

    /**
     * Predicate for Interface
     * @return true or false, depending on the type of object
     */
    TBool isInterface() const;

    /**
     * Predicate for Field
     * @return true or false, depending on the type of object
     */
    TBool isField() const;

    /**
     * Predicate for Field
     * @return true or false, depending on the type of object
     */
    TBool isIsaField() const;
    TBool isIsaElement() const;

    /**
     * Predicate for Design
     * @return true or false, depending on the type of object
     */
    TBool isDesign() const { return m_type == TYPE_DESIGN; }

    /**
     * Predicate for UnitDecl
     * @return true or false, depending on the type of object
     */
    TBool isUnitDecl() const { return m_type == TYPE_DECL_UNIT; }

    /**
     * Predicate for TestbenchDecl
     * @return true or false, depending on the type of object
     */
    TBool isAddressRange() const { return m_type == TYPE_ADDRESS_RANGE; }

    /**
     * Predicate for Connectable
     * @return true or false, depending on the type of object
     */
    TBool isConnectable() const { return m_type == TYPE_CONNECTABLE; }

    /**
     * Predicate for Instance
     * @return true or false, depending on the type of object
     */
    TBool isInstance() const { return m_type == TYPE_INST_UNIT; }

    /**
     * Predicate for Instantiation
     * @return true or false, depending on the type of object
     */
    TBool isInstantiation() const { return m_type == TYPE_UNIT_INSTANTIATION; }

    /**
     * Predicate for BitRange
     * @return true or false, depending on the type of object
     */
    TBool isBitRange() const { return m_type == TYPE_BIT_RANGE; }
    TBool isSimpleBitRange() const;
    TBool isMultiDimBitRange() const;

    /**
     * Predicate for Expr
     * @return true or false, depending on the type of object
     */
    TBool isExpr() const { return m_type == TYPE_EXPR; }

    /**
     * Predicate for Expr
     * @return true or false, depending on the type of object
     */
    TBool isNumber() const;
    TBool isString() const;
    TBool isExprLink() const;

    /**
     * Predicate for Enum
     * @return true or false, depending on the type of object
     */
    TBool isEnum() const { return m_type == TYPE_ENUM; }

    /**
     * Predicate for EnumItem
     * @return true or false, depending on the type of object
     */
    TBool isEnumItem() const;

    /**
     * Predicate for ListExpr
     * @return true or false, depending on the type of object
     */
    TBool isListExpr() const { return m_type == TYPE_LIST_EXPR; }

    /**
     * Predicate for UnitInstantiation
     * @return true or false, depending on the type of object
     */
    TBool isUnitInstantiation() const { return m_type == TYPE_UNIT_INSTANTIATION; }

    /**
     * Predicate for List
     * @return true or false, depending on the type of object
     */
    TBool isList() const { return m_type == TYPE_LIST; }

    /**
     * Predicate for Parameter
     * @return true or false, depending on the type of object
     */
    TBool isParameter() const { return m_type == TYPE_PARAMETER; }

    /**
     * Predicate for ParameterOverride
     * @return true or false, depending on the type of object
     */
    
    // TBool isParameterOverride() const { return m_type == TYPE_PARAMETER_OVERRIDE; }
    

    /**
     * Predicate for Command
     * @return true or false, depending on the type of object
     */
    TBool isCommand() const { return m_type == TYPE_COMMAND; }

    /**
     * Predicate for Memorymap
     * @return true or false, depending on the type of object
     */
    TBool isMemoryMap() const { return m_type == TYPE_MEMORY_MAP; }

    /**
     * Predicate for MemoryMapLocation
     * @return true or false, depending on the type of object
     */
    TBool isMemoryMapLocation() const { return m_type == TYPE_MEMORY_MAP_LOCATION; }

    /**
     * Predicate for MemoryMapLocationPage
     * @return true or false, depending on the type of object
     */
    TBool isMemoryMapLocationPage() const { return m_type == TYPE_MEMORY_MAP_PAGE; }

    /**
     * Predicate for MemoryMapLocationPage
     * @return true or false, depending on the type of object
     */
    TBool isMemoryMapLocationPageInstance() const { return m_type == TYPE_MEMORY_MAP_PAGE_INST; }
    /**
     * Predicate for Mux
     * @return true or false, depending on the type of object
     */
    TBool isMux() const { return m_type == TYPE_MUX; }

    /**
     * Predicate for Vector
     * @return true or false, depending on the type of object
     */
    TBool isStmt() const { return m_type == TYPE_STMT; }

    /**
     * Predicate for Vector
     * @return true or false, depending on the type of object
     */
    TBool isStmtAssign() const;

    /**
     * Method returns the scope of the current object if the object is a design
     * Method asserts if the object is not a design
     *
     * @return RefCSLOmScope - scope of design object
     */
    RefCSLOmScope getDesignScope() const;

    /**
     * Method returns the scope of the current object if the object is a Unit Declaration
     * Method asserts if the object is not a UnitDeclaration
     *
     * @return RefCSLOmScope - scope of unitDecl object
     */
    RefCSLOmScope getUnitScope() const;

    /**
     * Method returns the scope of the current object if the object is a Unit Declaration
     * Method asserts if the object is not a UnitDeclaration
     *
     * @return RefCSLOmScope - scope of unitDecl object
     */
    RefCSLOmScope getMemMapPageScope() const;

    /**
     * Method returns the scope of the current object if the object is a Unit Declaration
     * Method asserts if the object is not a UnitDeclaration
     *
     * @return RefCSLOmScope - scope of unitDecl object
     */
    RefCSLOmScope getMemMapScope() const;

    /**
     * Method returns the scope of the current object if the object is a Unit Declaration
     * Method asserts if the object is not a UnitDeclaration
     *
     * @return RefCSLOmScope - scope of unitDecl object
     */
    RefCSLOmScope getFieldScope() const;

    /**
     * Method returns the scope of the current object if the object is a design
     * Method asserts if the object is not a design
     *
     * @return RefCSLOmScope - scope of design object
     */
    RefCSLOmScope getInstanceScope() const;
    RefCSLOmScope getIsaElementScope() const;

    /**
     * Method returns the scope of the current object if the object is a interface
     * Method asserts if the object is not a interface
     *
     * @return RefCSLOmScope - scope of interface object
     */
    RefCSLOmScope getInterfaceScope() const;

    /**
     * Method returns the scope of the current object if the object is a signal group
     * Method asserts if the object is not a signal group
     *
     * @return RefCSLOmScope - scope of signal group object
     */
    RefCSLOmScope getSignalGroupScope() const;

    /**
     * Sets the parent of current object, and adds the current object to </br>
     * the m_children of parent
     *
     * @param RefCSLOmBase parent - the parent object
     */
    void setParent(RefCSLOmBase parent);

    /**
     * Sets the parent of current object, and adds the current object to </br>
     * the m_children of parent
     *
     * @param RefCSLOmBase parent - the parent object
     */
    void setParentAt(RefCSLOmBase parent, TUInt position);

    /**
     * Sets the parent of current object, and adds the current object to </br>
     * the m_children of parent
     *
     * @param RefCSLOmBase parent - the parent object
     */
    void setParentOnly(RefCSLOmBase parent);

    /**
     * Method that removes the parameter child from the m_children of the current node if
     * the child arguments exist in the m_children vector
     * Method asserts if parameter:
     *   - is not a child of current node 
     *   - is not removable
     *
     * @param RefCSLOmBase child - child to be removed
     * @see isRemovable()
     */
    void removeChild(RefCSLOmBase child);

    /**
     * Method that replaces the child from the m_children of the current node if
     * the child arguments exist in the m_children vector
     * Method asserts if parameter:
     *   - is not a child of current node 
     *   - is not removable
     *
     * @param RefCSLOmBase child - child to be removed
     * @see isRemovable()
     */
    void replaceChild(RefCSLOmBase oldChild, RefCSLOmBase newChild);

    /**
     * Returns the nearest parent scope up in the scope hierarchy.
     * If there is no upper scope this method returns null, that is calling get() on returned object returns 0. <br/>
     * <b>NOTE: </b>for performance reasons, this method also triggers the update of m_cachedParentScope member
     * on all m_parents up in the hierarchy.
     *
     * @return the parent scope
     */
    RefCSLOmScope getParentScope() const;

    RefCSLOmBase getParent() const;

    /**
     * This is a template function that returns a vector of specified template type;
     * this vector contains all children that meet the specified type filter criterion.
     *
     * @param typeFilter [=TYPE_ALL_TYPES] the type filter that any child has to met in
     * order to be included in the returned vector
     *
     * @return a vector of children filtered by the specified type filter criterion
     * @see ECSLOmType
     */
    template<class T> 
    boost::shared_ptr<std::vector<boost::shared_ptr<T> > >
    getChildren(ECSLOmType typeFilter) const {

      typedef boost::shared_ptr<T>              RefCSLOmT;
      typedef std::vector<RefCSLOmT>               TVec_RefCSLOmT;
      typedef boost::shared_ptr<TVec_RefCSLOmT> RefTVec_RefCSLOmT;

      if(!m_children.get()) {
        return RefTVec_RefCSLOmT();
      }
      TVec_RefCSLOmT* filteredChildren = 0;
      for(TVec_RefCSLOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
        if( typeFilter ==         TYPE_ALL_TYPES                                 ||
           (typeFilter ==    TYPE_ALL_TOP_LEVELS && (*iter)->isTopLevel())       ||
           (typeFilter == TYPE_ALL_SCOPE_HOLDERS && (*iter)->isScopeHolder())    ||
           (typeFilter ==           TYPE_ALL_IDS && (*iter)->isID())             ||
           (typeFilter ==       TYPE_ALL_SIGNALS && (*iter)->isSignal())         ||
           (typeFilter ==    TYPE_ALL_INTERFACES && (*iter)->isInterface())      ||
           (typeFilter ==         TYPE_ALL_PORTS && (*iter)->isPort())           ||
           (typeFilter ==        TYPE_ALL_GROUPS && (*iter)->isGroup())          ||
           (typeFilter ==        TYPE_ALL_FIELDS && (*iter)->isField())          ||
           (typeFilter ==           TYPE_ALL_ISA && ((*iter)->isIsaField()       || (*iter)->isIsaElement())) ||
           (typeFilter ==     TYPE_ALL_SIMPLE_BR && (*iter)->isSimpleBitRange()) ||
           (typeFilter ==         TYPE_DECL_UNIT && (*iter)->isUnitDecl() && !(*iter)->isVerifComp() && !(*iter)->isTestBench()) ||
           (typeFilter ==   TYPE_ALL_VERIF_COMPS && (*iter)->isVerifComp())      ||
           (typeFilter ==           TYPE_ALL_TBS && (*iter)->isTestBench())      ||

           (*iter)->getType() == typeFilter && typeFilter != TYPE_DECL_UNIT) {
          if(!filteredChildren) {
            filteredChildren = new TVec_RefCSLOmT();
          }
          filteredChildren->push_back(boost::static_pointer_cast<T>(*iter));
        }
      }
      return RefTVec_RefCSLOmT(filteredChildren);
    }

    /**
     * Returns a vector of type base pointers of all children that meet the specified
     * type filter criterion.
     *
     * @param typeFilter [=TYPE_ALL_TYPES] the type filter that any child has to met in
     * order to be included in the returned vector
     *
     * @return a vector of children filtered by the specified type filter criterion
     * @see ECSLOmType
     */
    const RefTVec_RefCSLOmBase getChildrenAsBase(ECSLOmType typeFilter = TYPE_ALL_TYPES) const;

    /**
     * Returns all CSLOmIdentifier instances from this subTree that don't have other
     * CSLOmIdentifier instances as children in the scope tree
     */
    void getIdsFromSubTree(TBackInsertIterator_TVec_RefCSLOmIdentifier inserter) const;

    /**
     * This function returns the number of the line the class was mapped on
     */
    TLineNumberType getLineNumber() const;

    /**
     * Visitor pattern function.
     *
     * @param visitor the visitor to visit this object
     */
    virtual void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const = 0;
  };

}

#endif
