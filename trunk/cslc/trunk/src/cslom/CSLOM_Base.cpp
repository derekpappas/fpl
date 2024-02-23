//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007, 2008 Fastpath Logic
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

#include "CSLOM.h"
#include "CSLOM_Visitor.h"
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include <algorithm>
#include <iterator>
#include <sstream>
#include <cstdlib>
#include <cmath>
#include "../support/CommonSupport.h"

/**
 * Bit that tells the cslc if errors appeared in the CSLOM
 */
extern TBool cslomHasErrors;

namespace NSCSLOm {

// ********************************************************************************
// CSLOmBase class
// ********************************************************************************
CSLOmBase::CSLOmBase(ECSLOmType type, TLineNumberType lineNumber, RefString fileName) : 
  m_cachedParentScope(), 
  m_mandatoryCounter(0),
  m_weakRef(), 
  m_type(type), 
  m_parent(), 
  m_children(), 
  m_lineNumber(lineNumber),
  m_colNumber(0),
  m_fileName(fileName),
  m_addToMemoryMap(FALSE),
  m_isDefined(TRUE) {

}


const RefCSLOmBase CSLOmBase::getChild(ECSLOmType type, TUInt index) const{ 
  RefTVec_RefCSLOmBase children = getChildrenAsBase(type);
  ASSERT(children.get() && children->size() > index, "index does not exist in children vector of the type required");
  return children->at(index);
}

void CSLOmBase::setChild(TUInt index, RefCSLOmBase object) { 
  ASSERT(getChildrenVec().get() && getChildrenVec()->size() > index, "index does not exist in children vector"); 
  ASSERT(object.get(), "object does not exist"); 
  object->setParentOnly(getThis());
  m_children->at(index) = object;
}

RefCSLOmScope CSLOmBase::getAttachedScope(const CSLOmBase* base) {
  //  ASSERT(base->isScopeHolder(), "param is not a scope holder");

  switch(base->m_type) {
    case TYPE_DESIGN:          return base->getDesignScope();      break;
    case TYPE_DECL_UNIT:       return base->getUnitScope();        break;
    case TYPE_MEMORY_MAP_PAGE: return base->getMemMapPageScope();  break;
    case TYPE_MEMORY_MAP:      return base->getMemMapScope();      break;
    case TYPE_INST_UNIT:       return base->getInstanceScope();    break;
    case TYPE_ISA_ELEMENT:     return base->getIsaElementScope();  break;
    case TYPE_BIT_RANGE:       
      if (base->isField()) {
        return base->getFieldScope();
      }
      else {
        ASSERT(FAIL, "bitrange is not a field");
      }
      break;
    case TYPE_CONNECTABLE:
      if (base->isInterface()) {
        return base->getInterfaceScope();
      }
      else if (base->isGroup()) {
        return base->getSignalGroupScope();
      }
      else {
        ASSERT(FAIL,"[CSLOmBase::getAttachedScope()] bug detected...object is not a scope holder");
      }
      break;
    default:
      ASSERT(FAIL,"[CSLOmBase::getAttachedScope()] bug detected...object is not a scope holder");
  }
}

void CSLOmBase::addChild(const RefCSLOmBase child) {
  ASSERT(child.get(), "null child received");

  //if not allocated, allocate children vector
  if(!getChildrenVec().get()) {
    m_children = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  }
  m_children->push_back(child);
}

void CSLOmBase::addChildAt(const RefCSLOmBase child, TUInt position) {
  ASSERT(child.get(), "null child received");
  if(isInsertable()) {

    //if not allocated, allocate children vector
    if(!getChildrenVec().get()) {
      m_children = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
    }

    TUInt counter = 0;
    TVec_RefCSLOmBase::iterator it;
    for( it = m_children->begin(); it < m_children->end(); ++it) {
      ++counter;
      if(counter == position) {
        m_children->insert(it,child);
      }
    }
  }
}

CSLOmBase::~CSLOmBase() {}

ECSLOmType CSLOmBase::getType() const {
  return m_type;
}

TBool CSLOmBase::isAddressableDecl() const {
  return isRegisterFile() || 
         isFifo()         ||
         isRegister()     ||
         isMemory();
}

TBool CSLOmBase::isAddressable() const {
  return isAddressableDecl() ||
         (isInstance() && CSLOmUnitInstance::cast(getThis())->getUnitDecl()->isAddressableDecl());
}

void CSLOmBase::addToMemoryMap() {
  ASSERT(isAddressable(), "object is not addressable");
  
  m_addToMemoryMap = TRUE;
}

TBool CSLOmBase::isRemovable() const {
  return (isAddressRange()
          || isInstance()
          || isInstantiation()
          || isParameter()
          || (isField()
              && m_parent.lock().get())
          || (isSignal()
              && m_parent.lock().get())
          || (isBitRange()
              && m_parent.lock().get())
          || (isPort()
              && m_parent.lock().get()
              && m_parent.lock()->isInterface()));
}

TBool CSLOmBase::isInsertable() const {
  return isField();
}

TBool CSLOmBase::isTopLevel() const {
  return 
    isDesign() && 
    isUnitDecl();
}

TBool CSLOmBase::isScopeHolder() const {
  return isDesign()  
    || isInterface()
    || isUnitDecl()
    || isTestBench()
    || isVector()
    || isField()
    || isMemoryMap()
    || isMemoryMapLocationPage()
    || isSignalGroup()
    || isIsaElement();
}

TBool CSLOmBase::isToScopeID() const {
  return
    m_type == TYPE_ID_SCOPE_DIRECT ||
    m_type == TYPE_ID_SCOPE_INDIRECT;
}
TBool CSLOmBase::isNumber() const {
  return (m_type == TYPE_EXPR) && (CSLOmExpr::cast(getThis())->getExprType() == CSLOmExpr::EXPR_NUMBER); 
}

TBool CSLOmBase::isString() const {
  return (m_type == TYPE_EXPR) && (CSLOmExpr::cast(getThis())->getExprType() == CSLOmExpr::EXPR_STRING); 
}

TBool CSLOmBase::isExprLink() const {
  return (m_type == TYPE_EXPR) && (CSLOmExpr::cast(getThis())->getExprType() == CSLOmExpr::EXPR_HID); 
}

TBool CSLOmBase::isStmtAssign() const {
  return (isStmt() && (CSLOmStmt::cast(getThis())->getStmtType() == CSLOmStmt::STMT_ASSIGN));
}

TBool CSLOmBase::isSimpleBitRange() const {
  return (isBitRange() && (CSLOmBaseRange::cast(getThis())->getBrType() == CSLOmBaseRange::BR_SIMPLE));
}

TBool CSLOmBase::isMultiDimBitRange() const {
  return (isBitRange() && (CSLOmBaseRange::cast(getThis())->getBrType() == CSLOmBaseRange::BR_MULTI_DIM));
}

TBool CSLOmBase::isFifo() const {
  return (isUnitDecl() && (CSLOmUnitDecl::cast(getThis())->getUnitType() == CSLOmUnitDecl::CSL_FIFO_DECL));
}

TBool CSLOmBase::isVector() const {
  return (isUnitDecl() && (CSLOmUnitDecl::cast(getThis())->getUnitType() == CSLOmUnitDecl::CSL_VECTOR));
}

TBool CSLOmBase::isStateData() const {
  return (isUnitDecl() && (CSLOmUnitDecl::cast(getThis())->getUnitType() == CSLOmUnitDecl::CSL_STATE_DATA));
}

TBool CSLOmBase::isVerifComp() const {
  return (isVector() || isStateData());
}

TBool CSLOmBase::isTestBench() const {
  return (isUnitDecl() && (CSLOmUnitDecl::cast(getThis())->getUnitType() == CSLOmUnitDecl::CSL_TESTBENCH_DECL));
}

TBool CSLOmBase::isRegisterFile() const {
  return (isUnitDecl() && (CSLOmUnitDecl::cast(getThis())->getUnitType() == CSLOmUnitDecl::CSL_REGISTER_FILE_DECL));
}

TBool CSLOmBase::isMemory() const {
  return (isUnitDecl() && (CSLOmUnitDecl::cast(getThis())->getUnitType() == CSLOmUnitDecl::CSL_MEMORY_DECL));
}

TBool CSLOmBase::isRegister() const {
  return (isUnitDecl() && (CSLOmUnitDecl::cast(getThis())->getUnitType() == CSLOmUnitDecl::CSL_REGISTER_DECL));
}

TBool CSLOmBase::isEnumItem() const { 
  return (m_type == TYPE_ID_SIMPLE) && (CSLOmIdentifier::cast(getThis())->getIdType() == CSLOmIdentifier::ID_ENUM_ITEM); 
}

TBool CSLOmBase::isID() const {
  return
    m_type == TYPE_ID_SIMPLE ||
    m_type == TYPE_ID_SCOPE_DIRECT ||
    m_type == TYPE_ID_SCOPE_INDIRECT;
}

TBool CSLOmBase::isSignal() const {
  return 
    isConnectable() && 
    CSLOmConnectable::cast(getThis())->cIsSignal();
}

TBool CSLOmBase::isPort() const {
  return 
    isConnectable() && 
    CSLOmConnectable::cast(getThis())->cIsPort();
}

TBool CSLOmBase::isGroup() const {
  return 
    isConnectable() && 
    CSLOmConnectable::cast(getThis())->cIsSignalGroup();
}

TBool CSLOmBase::isSignalGroup() const {
  return 
    isConnectable() && 
    CSLOmConnectable::cast(getThis())->cIsSignalGroup();
}

TBool CSLOmBase::isInterface() const {
  return 
    isConnectable() && 
    CSLOmConnectable::cast(getThis())->cIsInterface();
}

TBool CSLOmBase::isField() const {
  return isSimpleBitRange() && CSLOmSimpleBitRange::cast(getThis())->brIsField();
}

TBool CSLOmBase::isIsaField() const {
  return isField() && CSLOmField::cast(getThis())->fIsIsaField();
}

TBool CSLOmBase::isIsaElement() const {
  return isField() && CSLOmField::cast(getThis())->fIsIsaElement();
}

RefCSLOmScope CSLOmBase::getDesignScope() const {
  ASSERT(isDesign(),"type of the object is not design; current type is "+m_type);
  return static_cast<const CSLOmDesign*>(getThis().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getUnitScope() const {
  ASSERT(isUnitDecl(),"type of the object is not unit declaration; current type is "+m_type);
  return static_cast<const CSLOmUnitDecl*>(getThis().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getMemMapPageScope() const {
  ASSERT(isMemoryMapLocationPage(),"type of the object is not unit declaration; current type is "+m_type);
  return static_cast<const CSLOmMemoryMapPage*>(getThis().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getMemMapScope() const {
  ASSERT(isMemoryMap(),"type of the object is not unit declaration; current type is "+m_type);
  return static_cast<const CSLOmMemoryMap*>(getThis().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getFieldScope() const {
  ASSERT(isField(),"type of the object is not unit declaration; current type is "+m_type);
  return static_cast<const CSLOmField*>(getThis().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getInstanceScope() const {
  ASSERT(isInstance(),"type of the object is not unit declaration; current type is "+m_type);
  return static_cast<const CSLOmUnitDecl*>(CSLOmUnitInstance::cast(getThis())->getUnitDecl().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getIsaElementScope() const {
  ASSERT(isIsaElement(),"type of the object is not unit declaration; current type is "+m_type);
  return static_cast<const CSLOmIsaElement*>(getThis().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getInterfaceScope() const {
  ASSERT(isInterface(),"type of the object is not interface; current type is "+m_type);
  return static_cast<const CSLOmInterface*>(getThis().get())->getAttachedScope();
}

RefCSLOmScope CSLOmBase::getSignalGroupScope() const {
  ASSERT(isSignalGroup(),"type of the object is not signal group; current type is "+m_type);
  return static_cast<const CSLOmGroupSignal*>(getThis().get())->getAttachedScope();
}

void CSLOmBase::setParent(RefCSLOmBase parent) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(!m_parent.lock().get(), "parent already set");// {
//     addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_HAS_PARENT, args, this->getLineNumber(), m_fileName);
//     cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmBase::setParent()] parent already set.", m_lineNumber);
  //  }

  parent->addChild(getThis());
  m_parent = boost::weak_ptr<CSLOmBase>( parent);

  // added to improve scope lookup performance
  if(parent->isScopeHolder() && m_type != TYPE_ID_SCOPE_DIRECT) {
    m_cachedParentScope = boost::weak_ptr<CSLOmScope>( getAttachedScope(parent.get()));
  }
  else if(parent->m_cachedParentScope.lock().get()) {
    m_cachedParentScope = parent->m_cachedParentScope;
  }
}

void CSLOmBase::setParentAt(RefCSLOmBase parent, TUInt position) {
  ASSERT(parent.get(), "null parent received");
  if(m_parent.lock().get()) {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_HAS_PARENT, args, this->getLineNumber(), m_fileName);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmBase::setParent()] parent already set.", m_lineNumber);
  }

  parent->addChildAt(getThis(), position);
  m_parent = boost::weak_ptr<CSLOmBase>( parent);

  // added to improve scope lookup performance
  if(parent->isScopeHolder() && m_type != TYPE_ID_SCOPE_DIRECT) {
    m_cachedParentScope = boost::weak_ptr<CSLOmScope>( getAttachedScope(parent.get()));
  }
  else if(parent->m_cachedParentScope.lock().get()) {
    m_cachedParentScope = parent->m_cachedParentScope;
  }
}

void CSLOmBase::setParentOnly(RefCSLOmBase parent) {
  ASSERT(parent.get(), "null parent received");
  if(m_parent.lock().get()) {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_HAS_PARENT, args, this->getLineNumber(),m_fileName);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmBase::setParent()] parent already set.", m_lineNumber);
  }

  m_parent = boost::weak_ptr<CSLOmBase>( parent);
}

void CSLOmBase::removeChild(RefCSLOmBase child) {
  TRACE_ME(1, "CSLOmBase::removeChild(RefCSLOmBase child)");
  ASSERT(child.get(), "Null child to remove");

  ASSERT(child->getParent() == getThis(), "This child does not belong to this parent");
  ASSERT(child->isRemovable(), "This type of child can't be removed" << child->getType());

  RefTVec_RefCSLOmIdentifier ids = RefTVec_RefCSLOmIdentifier(new TVec_RefCSLOmIdentifier());
  child->getIdsFromSubTree(std::back_inserter(*ids));
  if(!child->isAddressRange()  || (child->isAddressRange() && child->getChild(ID)->isID())) {
    if(ids.get() && ids->size()) {
      RefCSLOmScope scope;
      if (child->isPort() && m_parent.lock()->isUnitDecl()) {
        scope = CSLOmUnitDecl::cast(m_parent.lock())->getAttachedScope();
      }
      else {
        scope = child->getParentScope();
      }
    
      ASSERT(scope.get(),"Parent scope of child is NULL");
      for(TVec_RefCSLOmIdentifier_const_iter it = ids->begin(); it<ids->end(); ++it) {
        scope->removeID((*it)->getName());
      }
      if(m_cachedParentScope.lock().get()) {
        //flushing the cached scope
        if(isScopeHolder()) {
          m_cachedParentScope = boost::weak_ptr<CSLOmScope>();
        }
        else {
          RefCSLOmBase parent = m_parent.lock();
          if(parent.get())
            do {
              parent->m_cachedParentScope = boost::weak_ptr<CSLOmScope>();
            } while(parent.get() && !parent->isScopeHolder());
        }
      }
    }
  }
  TVec_RefCSLOmBase::iterator it;
  for(it = m_children->begin(); it < m_children->end() && *it != child; ++it);
  m_children->erase(it);
}

void CSLOmBase::replaceChild(RefCSLOmBase oldChild, RefCSLOmBase newChild) {
  TRACE_ME(1, "CSLOmBase::replaceChild(RefCSLOmBase oldChild, RefCSLOmBase newChield)");
  ASSERT(oldChild.get(), "Null oldChild to remove");

  ASSERT(oldChild->getParent() == getThis(), "This child does not belong to this parent");
  ASSERT(oldChild->isRemovable(), "This type of child can't be removed" + oldChild->getType());
  RefTVec_RefCSLOmIdentifier ids = RefTVec_RefCSLOmIdentifier(new TVec_RefCSLOmIdentifier());
  oldChild->getIdsFromSubTree(std::back_inserter(*ids));
  if(ids.get() && ids->size()) {
    RefCSLOmScope scope = oldChild->getParentScope();
    ASSERT(scope.get(),"Parent scope of oldChild is NULL");
    for(TVec_RefCSLOmIdentifier_const_iter it = ids->begin(); it<ids->end(); ++it) {
      scope->removeID((*it)->getName());
    }
    if(m_cachedParentScope.lock().get()) {
      //flushing the cached scope
      if(isScopeHolder()) {
        m_cachedParentScope = boost::weak_ptr<CSLOmScope>();
      }
      else {
        RefCSLOmBase parent = m_parent.lock();
        if(parent.get())
          do {
            parent->m_cachedParentScope = boost::weak_ptr<CSLOmScope>();
          } while(parent.get() && !parent->isScopeHolder());
      }
    }
  }
  TVec_RefCSLOmBase::iterator it;
  for(it = m_children->begin(); it < m_children->end() && *it != oldChild; ++it);
  m_children->erase(it);
  ++it;
  m_children->insert(it,newChild);
}

// Returns the nearest parent scope up in the scope hierarchy
// If there is no upper scope this method returns null, that is, calling get() on returned object returns 0
// NOTE: for performance reasons, this method also triggers the update of m_cachedParentScope member
// on all m_parents up in the hierarchy
RefCSLOmScope CSLOmBase::getParentScope() const {
  if(m_cachedParentScope.lock().get()) {
    // m_cachedParentScope already exists; no need for updating it
    return m_cachedParentScope.lock();
  }
  else if(m_type != TYPE_ID_SCOPE_DIRECT && m_parent.lock().get() && m_parent.lock()->isScopeHolder()) {
    // if m_parent is a scope holder, and the object is not the id 
    // the m_cachedParentScope is set to the scope of the parent
    // **update m_cachedParentScope
    m_cachedParentScope = boost::weak_ptr<CSLOmScope>( getAttachedScope(getParent().get()));
    return m_cachedParentScope.lock();
  }
  else if(!m_parent.lock().get()) {
    // if parent does not exist we return m_cachedParentScope whose value is 0
    // because we are on the else branch of the first if
    return m_cachedParentScope.lock(); // **whose get() method returns 0
  }
  else {
    // if parent exists and is not a scope holder, we set the m_cachedParentScope to the parent scope of the m_parent
    // **update m_cachedParentScope
    m_cachedParentScope = boost::weak_ptr<CSLOmScope>( m_parent.lock()->getParentScope());
    return m_cachedParentScope.lock();
  }
}

RefCSLOmBase CSLOmBase::getParent() const {
  return m_parent.lock();
}

const RefTVec_RefCSLOmBase CSLOmBase::getChildrenAsBase(ECSLOmType typeFilter) const {
  if(typeFilter == TYPE_ALL_TYPES || !getChildrenVec().get()) {
    return getChildrenVec();
  }
  TVec_RefCSLOmBase* filteredChildren = 0;
  for(TVec_RefCSLOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
    if((typeFilter == TYPE_ALL_TOP_LEVELS    && (*iter)->isTopLevel())    ||
       (typeFilter == TYPE_ALL_SCOPE_HOLDERS && (*iter)->isScopeHolder()) ||
       (typeFilter == TYPE_ALL_IDS           && (*iter)->isID())          ||
       (typeFilter == TYPE_ALL_SIGNALS       && (*iter)->isSignal())      ||
       (typeFilter == TYPE_ALL_INTERFACES    && (*iter)->isInterface())   ||
       (typeFilter == TYPE_ALL_PORTS         && (*iter)->isPort())        ||
       (typeFilter == TYPE_ALL_GROUPS        && (*iter)->isGroup())       ||
       (typeFilter == TYPE_ALL_FIELDS        && (*iter)->isField())       ||
       (typeFilter == TYPE_ALL_ISA && ((*iter)->isIsaField() || (*iter)->isIsaElement())) ||
       (typeFilter == TYPE_DECL_UNIT && (*iter)->isUnitDecl() && !(*iter)->isVerifComp() && !(*iter)->isTestBench()) ||
       (typeFilter == TYPE_ALL_VERIF_COMPS && (*iter)->isVerifComp()) ||
       (typeFilter == TYPE_ALL_TBS && (*iter)->isTestBench()) ||
       // this line is for filtering the childs after a ECSLOmType
       // for example if typeFilter is set to TYPE_DECL_UNIT this will add all unit declaration to the returned vector
       // another example: typeFilter is set to TYPE_UNIT_INSTANTIATION; this line will select all unit instantiations from the m_children vector
       (*iter)->getType() == typeFilter && typeFilter != TYPE_DECL_UNIT) {
      if(!filteredChildren) {
        filteredChildren = new TVec_RefCSLOmBase();
      }
      filteredChildren->push_back(*iter);
    }
  }
  return RefTVec_RefCSLOmBase(filteredChildren);
}

TLineNumberType CSLOmBase::getLineNumber() const {
  return m_lineNumber;
}
// returns all ids from a subtree
// used for geting all instance identifiers from a unit instantiation subtree
void CSLOmBase::getIdsFromSubTree(TBackInsertIterator_TVec_RefCSLOmIdentifier inserter) const {
  TBool tst = FALSE;
  if (m_children.get()) {
    for(TVec_RefCSLOmBase_const_iter it = m_children->begin(); it<m_children->end(); ++it) {
      if((*it)->isID()) { 
        // if child node is id, we add it to the vector and set test on TRUE so that we don't continue recursing to the children
        tst = TRUE;
        *inserter = CSLOmIdentifier::cast(*it);
        inserter++;
      }
    }
    if(!tst && m_children.get() && m_children->size()) { 
      // if node doesn't have ids and has children then we get all id's from the children nodes
      for(TVec_RefCSLOmBase_const_iter it = m_children->begin(); it<m_children->end(); ++it) {
        (*it)->getIdsFromSubTree(inserter);
      }
    }
  }
}


}
