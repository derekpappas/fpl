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
// CSLOmDesign class
// ********************************************************************************
// This class is the absolute root of a design.
// It contains all top level units and scope blocks
CSLOmDesign::CSLOmDesign() : 
  CSLOmBase(TYPE_DESIGN, ZERO, RefString(new std::string(""))), 
  m_scope() {}

RefCSLOmDesign CSLOmDesign::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmDesign();
  }
  else {
    ASSERT(object->isDesign() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmDesign>(object);
  }
}

RefCSLOmDesign CSLOmDesign::build() {
  CSLOmDesign* design;
  try {
    design = new CSLOmDesign();
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmDesign refDesign(design);
  design->m_weakRef = boost::weak_ptr<CSLOmBase>( refDesign);
  // initialize attached scope
  design->m_scope = CSLOmScope::build();
  CSLOmScopeBlock::enterScope(design->m_scope);

  //***** fifo info default port names ******

  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_PUSH, RefString(new std::string("push"))));
  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_POP, RefString(new std::string("pop"))));
  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_FULL, RefString(new std::string("full"))));
  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_EMPTY, RefString(new std::string("empty"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_VALID, RefString(new std::string("valid"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_CLOCK_, RefString(new std::string("clock_"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_RESET_, RefString(new std::string("reset_"))));
  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_CLOCK, RefString(new std::string("clock"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_WR_CLOCK, RefString(new std::string("wr_clock"))));
  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_RESET, RefString(new std::string("reset"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_RD_CLOCK, RefString(new std::string("rd_clock"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_ASYNCH_RESET, RefString(new std::string("asynch_reset"))));
  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_DATA_OUT, RefString(new std::string("data_out"))));
  //CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_DATA_IN, RefString(new std::string("data_in"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_CNTL_POP, RefString(new std::string("cntl_pop"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_CNTL_PUSH_BACK, RefString(new std::string("cntl_pushback"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_CNTL_STALL, RefString(new std::string("cntl_stall"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_WR_CNTL_WR_RELEASE, RefString(new std::string("wr_cntl_wr_release"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_STATUS_FULL, RefString(new std::string("status_full"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_STATUS_EMPTY, RefString(new std::string("status_empty"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_STATUS_ALMOST_EMPTY, RefString(new std::string("almost_empty"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_STATUS_ALMOST_FULL, RefString(new std::string("almost_full"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_STATUS_WR_ADDRESS, RefString(new std::string("wr_address"))));
  ////CSLOmFifoInfo::m_nameMap->insert(std::make_pair(FIFO_PN_STATUS_RD_ADDRESS, RefString(new std::string("rd_address"))));
  //
  //
  ////***** register file info default port names ******
  //
  //
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_CLOCK_,  RefString(new std::string("clock_" ))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_RESET_,  RefString(new std::string("reset_" ))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_VALID,   RefString(new std::string("valid"  ))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_CLOCK,   RefString(new std::string("clock"  ))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_WR_ADDR, RefString(new std::string("wr_addr"))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_RD_ADDR, RefString(new std::string("rd_addr"))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_WR_DATA, RefString(new std::string("wr_data"))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_RD_DATA, RefString(new std::string("rd_data"))));
  //CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_WR_EN,   RefString(new std::string("wr_en"  ))));
  ////CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_RD_EN,   RefString(new std::string("rd_en"  ))));
  ////CSLOmRegisterFileInfo::m_nameMap->insert(std::make_pair(RF_PN_CLEAR,   RefString(new std::string("clear"  ))));


  return refDesign;
}

RefCSLOmScope CSLOmDesign::getAttachedScope() const {
  return m_scope;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getTops() const {
  return getChildrenVec();
}

const RefTVec_RefCSLOmUnitDecl CSLOmDesign::getUnitDeclarations() const {
  RefTVec_RefCSLOmUnitDecl temp = getChildren<CSLOmUnitDecl>(TYPE_DECL_UNIT);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getUnitDeclarationsAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_DECL_UNIT);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getVerifCompsAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_ALL_VERIF_COMPS);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getTBsAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_ALL_TBS);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getEnumDeclarationsAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_ENUM);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getMemoryMapsAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_MEMORY_MAP);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getMemoryMapPagesAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_MEMORY_MAP_PAGE);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getISAAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_ALL_ISA);
  return temp;
}

const RefTVec_RefCSLOmBase CSLOmDesign::getFieldsAsBase() const {
  RefTVec_RefCSLOmBase temp = getChildrenAsBase(TYPE_ALL_FIELDS);
  return temp;
}

void CSLOmDesign::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmInclude class
// ********************************************************************************
CSLOmInclude::CSLOmInclude(TLineNumberType lineNumber, RefString fileName, EIncludeFileType type, RefString ifileName) : 
  CSLOmBase(TYPE_INCLUDE, lineNumber, fileName),
  m_fileType(type),
  m_incFileName(ifileName) {}

RefCSLOmInclude CSLOmInclude::build(TLineNumberType lineNumber, RefString fileName, EIncludeFileType type, const RefString& ifileName) {
  RefCSLOmBase parent = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
  if (!(CSLOmScopeBlock::getCurrentScope()->isUnitDeclScope())) {
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL_PARENT_UD, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmInclude();
    //throw NSBase::IllegalArgumentException("UnitDecl::build - parent should be the Design");
  }

  CSLOmInclude* include;
  try {
    include = new CSLOmInclude(lineNumber, fileName, type, ifileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmInclude refInclude(include);
  include->m_weakRef = boost::weak_ptr<CSLOmBase>( refInclude);
  include->setParent(parent);
  return refInclude;
}

const RefString CSLOmInclude::getIncFileName() const {
  return m_incFileName;
}

const EIncludeFileType CSLOmInclude::getFileType() const {
  return m_fileType;
}

void CSLOmInclude::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmList class
// ********************************************************************************
CSLOmList::CSLOmList(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmBase(TYPE_LIST, lineNumber, fileName), 
  m_listType(TYPE_ALL_TYPES) { }

RefCSLOmList CSLOmList::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmList();
  }
  else {
    ASSERT(object->isList() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmList>(object);
  }
}

TULong CSLOmList::m_anonymousCounter=ZERO;
RefCSLOmList CSLOmList::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name) { 
  ASSERT(parent.get(), "null input parent");
  ASSERT(parent->isScopeHolder(), "invalid parent for a List");
  ASSERT(name.get(), "null name reference, for no name the string should be null, no the reference");

  CSLOmList *list;
  try {
    list = new CSLOmList(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmList refList(list);
  list->m_weakRef= boost::weak_ptr<CSLOmBase>(refList);
  list->setParent(parent);

  if (name->empty()) {
    RefString name1 = RefString(new std::string("*CSLList_"));
    name1->append(*(ltos(m_anonymousCounter)));
    ++m_anonymousCounter;
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refList, CSLOmIdentifier::ID_CSL_LIST, name1);
  }
  else {
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refList, CSLOmIdentifier::ID_CSL_LIST, name);
  }

  return refList;
}

void CSLOmList::addItemToList(RefCSLOmExprLink item) {
  ASSERT((item).get(), "null item in list");
  (item)->setParent(getThis());
  if (!verifyObjectType(item)) {
    // args.push_back();
    //     args.push_back("bitrange");
    //     addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    throw NSBase::IllegalArgumentException("list object type checking failed");
  }
}

void CSLOmList::removeItemFromList(RefCSLOmExprLink item) {
  ASSERT(item.get(), "null item received");

  RefCSLOmBase eval = item->doEval();

  TVec_RefCSLOmBase::iterator it = m_children->begin();
  it++;
  for (; it < m_children->end(); it++) {
    if (eval.get() == CSLOmExpr::cast(*it)->doEval().get()) {
      removeChild(*it);
    }
  }
}

RefTVec_RefCSLOmBase CSLOmList::getObjects() {
  RefTVec_RefCSLOmExprLink objLinks = getLinks();
  if(!objLinks.get()) {
    return RefTVec_RefCSLOmBase();
  }
  RefTVec_RefCSLOmBase objs(new TVec_RefCSLOmBase);
  TVec_RefCSLOmExprLink::iterator it;
  for (it = objLinks->begin(); it < objLinks->end(); it++) {
    RefCSLOmIdentifier id = (*it)->getLocalNameID();
    if (id.get()) {
      objs->push_back(id->getParent());
    }
    else {
      objs->push_back(*it);
    }
  }
  return objs;
}

ECSLOmType CSLOmList::getListType() {
  return m_listType;
}

TBool CSLOmList::isSignalList() {
  RefCSLOmIdentifier testId = RefCSLOmIdentifier();
  if (getChildrenSize() > 1) {
    testId = CSLOmExprLink::cast(getChild(LIST_FIRST_ITEM))->getLocalNameID();
  }
  if (m_listType == TYPE_CONNECTABLE && testId.get() && testId->getParent()->isSignal()) {
    return TRUE;
  }
  return FALSE;
}

TBool CSLOmList::isPortList() {
  RefCSLOmIdentifier testId = RefCSLOmIdentifier();
  if (getChildrenSize() > 1) {
    testId = CSLOmExprLink::cast(getChild(LIST_FIRST_ITEM))->getLocalNameID();
  }
  if (m_listType == TYPE_CONNECTABLE && testId.get() && testId->getParent()->isSignal()) {
    return TRUE;
  }
  return FALSE;
}

TBool CSLOmList::isGroupList() {
  RefCSLOmIdentifier testId = RefCSLOmIdentifier();
  if (getChildrenSize() > 1) {
    testId = CSLOmExprLink::cast(getChild(LIST_FIRST_ITEM))->getLocalNameID();
  }
  if (m_listType == TYPE_CONNECTABLE && testId.get() && testId->getParent()->isSignal()) {
    return TRUE;
  }
  return FALSE;
}

TBool CSLOmList::isInterfaceList() {
  RefCSLOmIdentifier testId = RefCSLOmIdentifier();
  if (getChildrenSize() > 1) {
    testId = CSLOmExprLink::cast(getChild(LIST_FIRST_ITEM))->getLocalNameID();
  }
  if (m_listType == TYPE_CONNECTABLE && testId.get() && testId->getParent()->isSignal()) {
    return TRUE;
  }
  return FALSE;
}

RefCSLOmExprLink CSLOmList::getListLink() {
  ASSERT(getID().get(),"list has no id");
  RefCSLOmExprLink listLink = CSLOmExprLink::build(m_lineNumber, m_fileName, getName());
  listLink->addID(getID());
  return listLink;
}

TBool CSLOmList::verifyObjectType(RefCSLOmExprLink object) {
  ASSERT(object.get(), "null object received");

  RefCSLOmIdentifier id;
  id = object->getLocalNameID();
  if (getChildrenVec()->size() > 2) {
    if (!(id.get()) && m_listType != TYPE_ALL_TYPES) {
      return FALSE;
    }

    if (!(id.get()) && m_listType == TYPE_ALL_TYPES) {
      return TRUE;
    }
  
    if ((id->getParent())->getType() != m_listType && !(id->getParent())->isList()) {
      return FALSE;
    }
    return TRUE;
  }
  else {
    if (id.get() && id->getType() != TYPE_LIST) {
      m_listType = id->getParent()->getType();
    }
    else if(id.get() && id->getType() == TYPE_LIST) {
      return FALSE;
    }
    else {
      m_listType = TYPE_ALL_TYPES; 
    }
      
    return TRUE;
  }
}

void CSLOmList::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmEnum class
// ********************************************************************************
CSLOmEnum::CSLOmEnum(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmBase(TYPE_ENUM, lineNumber, fileName),
  m_currentMaxValue(-1) { }

RefCSLOmEnum CSLOmEnum::cast(RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmEnum();
  } 
  else {
    ASSERT(object->getType() == TYPE_ENUM, "type check on cast failure");
    return boost::static_pointer_cast<CSLOmEnum>(object);
  }
}

RefCSLOmEnum CSLOmEnum::allocate( TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name) {
  ASSERT(parent.get(),"null parent");
  ASSERT(name.get(),"null name");
  ASSERT(!name->empty(),"empty name");

  CSLOmEnum *enum_;
  try {
    enum_ = new CSLOmEnum(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmEnum refEnum(enum_);
  enum_->m_weakRef = boost::weak_ptr<CSLOmBase>( refEnum);

  refEnum->setParent(parent);

  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refEnum, CSLOmIdentifier::ID_ENUM, name);

  return refEnum;
}

RefCSLOmEnum CSLOmEnum::build( TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name) {
  ASSERT(parent.get(),"null parent");
  ASSERT(name.get(),"null name");
  ASSERT(!name->empty(),"empty name");

  return allocate(lineNumber, fileName, parent, name);
}

void CSLOmEnum::addPair(RefString itemName, RefCSLOmNumber itemValue) {
  ASSERT(itemName.get(), "NULL item name");
  ASSERT(!itemName->empty(), "empty item name");

  if (itemValue.get()) {

    RefTVec_RefCSLOmIdentifier items = getChildren<CSLOmIdentifier>(TYPE_ID_SIMPLE);
    TVec_RefCSLOmIdentifier::iterator it = items->begin();
    it++; // jumps over the id with the enum name
    TBool isMax = TRUE;
    for (; it < items->end(); ++it) {
      if (itemValue->getValue() < CSLOmNumber::cast((*it)->getPayload())->getValue()) {
        isMax = FALSE;
      }
    }
    
    if (isMax) {
      m_currentMaxValue = itemValue->getValue();
    }

    RefCSLOmIdentifier id = CSLOmIdentifier::build(getLineNumber(), getFileName(), getThis(), CSLOmIdentifier::ID_ENUM_ITEM, itemName, itemValue);
  }
  else {
    m_currentMaxValue++;
    RefCSLOmNum32 value = CSLOmNum32::build(getLineNumber(), getFileName(), m_currentMaxValue);
    RefCSLOmIdentifier id = CSLOmIdentifier::build(getLineNumber(), getFileName(), getThis(), CSLOmIdentifier::ID_ENUM_ITEM, itemName, value);
  }
  //  RefCSLOmNum32 maxNum = CSLOmNum32::build(m_lineNumber)
}

RefCSLOmNumber CSLOmEnum::getValue(RefString itemName) {
  ASSERT(itemName.get(), "NULL itemName");
  ASSERT(!itemName->empty(), "NULL itemName");
  
  RefCSLOmScope scope = getParentScope();
  RefCSLOmIdentifier id = scope->lookupLocal(itemName);
  if (id.get()) {
    return CSLOmNumber::cast(id->getPayload());
  }
  else {
    return RefCSLOmNumber();
  }
}

RefString CSLOmEnum::getName(RefCSLOmNumber itemValue) {
  ASSERT(itemValue.get(), "NULL item value");
  TVec_RefCSLOmBase_const_iter it;
  for( it = m_children->begin()+1; it < m_children->end(); ++it) {
    RefCSLOmIdentifier id = CSLOmIdentifier::cast(*it);
    RefCSLOmNumber val = CSLOmNumber::cast(id->getPayload());
    if (val->equality(itemValue)->getValue() == 1) {
      return id->getName(); 
    }
  }
  return RefString();
}

TBool CSLOmEnum::isEmpty(){
  //  getChildren<CSLOmIdentifier>(TYPE_ID_SIMPLE)
  RefTVec_RefCSLOmIdentifier ids=getChildren<CSLOmIdentifier>(TYPE_ID_SIMPLE);//getChildrenAsBase(ID);
  if(ids->size()==1){
    return true;
  }
  return false;
}

TBool CSLOmEnum::hasItem(RefCSLOmNumber itemValue) {
  ASSERT(itemValue.get(), "NULL item value");

  TVec_RefCSLOmBase_const_iter it;
  for( it = m_children->begin()+1; it < m_children->end(); ++it) {
    RefCSLOmIdentifier id = CSLOmIdentifier::cast(*it);
    RefCSLOmNumber val = CSLOmNumber::cast(id->getPayload());
    if (val->equality(itemValue)->getValue() == 1) {
      return TRUE; 
    }
  }
  return FALSE;
}

TBool CSLOmEnum::hasItem(RefString itemName) {
  ASSERT(itemName.get(), "NULL itemName");
  ASSERT(!itemName->empty(), "NULL itemName");
  
  RefCSLOmScope scope = getParentScope();
  RefCSLOmIdentifier id = scope->lookupLocal(itemName);
  if (id.get() && id->getIdType() == CSLOmIdentifier::ID_ENUM_ITEM && id->getParent() == getThis()) {
    return TRUE;
  }
  else {
    return FALSE;
  }
}

TUInt CSLOmEnum::getWidth() {
  RefCSLOmNum32 num = CSLOmNum32::build(m_lineNumber, m_fileName, m_currentMaxValue);
  return num->getWidth();
}

void CSLOmEnum::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmContainer class
// ********************************************************************************

CSLOmContainer::CSLOmContainer(TLineNumberType lineNumber, RefString fileName, ECSLOmType type) : 
  CSLOmBase(TYPE_CONTAINER, lineNumber, fileName), 
  m_containedType(type) { }


RefCSLOmContainer CSLOmContainer::cast(RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmContainer();
  } 
  else {
    ASSERT(object->getType() == TYPE_CONTAINER, "type check on cast failure");
    return boost::static_pointer_cast<CSLOmContainer>(object);
  }
}


RefCSLOmContainer CSLOmContainer::allocate( TLineNumberType lineNumber, RefString fileName, ECSLOmType type) {
  ASSERT(type != TYPE_ALL_TYPES, "TYPE_ALL_TYPES type received");

  CSLOmContainer *container;
  try {
    container = new CSLOmContainer(lineNumber, fileName, type);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmContainer refContainer(container);
  container->m_weakRef = boost::weak_ptr<CSLOmBase>( refContainer);
  return refContainer; 
}


RefCSLOmContainer CSLOmContainer::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, ECSLOmType type) {
  ASSERT(parent.get(),"null parent received");
  ASSERT(type != TYPE_ALL_TYPES,"type cannot be ALL_TYPES");

  RefCSLOmContainer container = allocate(lineNumber, fileName, type);
  container->setParent(parent);

  return container;
}

RefCSLOmContainer CSLOmContainer::build(TLineNumberType lineNumber, RefString fileName, ECSLOmType type) {
  ASSERT(type != TYPE_ALL_TYPES,"type cannot be ALL_TYPES");

  RefCSLOmContainer container = allocate(lineNumber, fileName, type);

  return container;
}
    
void CSLOmContainer::addItem(RefCSLOmBase item) {
  //add to CSLOM_cmd
  ASSERT(item.get(),"NULL item");
  ASSERT(!item->getParent().get(),"item has already a parent");
  //assert because users should not access this directly
  ASSERT(item->getType() == m_containedType, "Trying to add an object different than the type contained");

  if( item->getType() == TYPE_ADDRESS_RANGE) {

    TVec_RefCSLOmBase::iterator it;
    for(it = m_children->begin(); it < m_children->end(); ++it) {
      if( (*it)->getType() == TYPE_ADDRESS_RANGE) {
        if( (CSLOmAddressRange::cast(item))->overlaps(CSLOmAddressRange::cast(*it)) ) {
          //concat current range to the existing range...
          //also check if the new concated range overlaps with the any of the old ranges
        }
        else {
          item->setParent(getThis());
        }
      } 
      else {
        //throw error: found not range field
      }
    }
  }
}

ECSLOmType CSLOmContainer::getContainedType() const {
  return m_containedType;
}

void CSLOmContainer::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmMux class
// ********************************************************************************
//CSLOmMux::CSLOmMux

// ********************************************************************************
// CSLOmParameter class
// ********************************************************************************
// author - eugennc

CSLOmParameter::CSLOmParameter(TLineNumberType lineNumber, RefString fileName, ECSLOmParameterType type) :
  CSLOmBase(TYPE_PARAMETER, lineNumber, fileName),
  m_instanceLinks(RefTVec_WeakCSLOmUnitInstance()) ,
  m_parameterType(type)                            ,
  m_width(0)                                       ,
  m_isOveriden(FALSE) {}




RefCSLOmParameter CSLOmParameter::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmParameter oldParam, RefCSLOmNumber value) {
  ASSERT(parent.get(), "Null parent recieved");
  ASSERT(oldParam.get(), "Null param recieved");
  ASSERT(parent->isInterface() || parent->isSignalGroup(), "call only allowed for parent interface or signal group");

  CSLOmParameter *parameter;
  try {
    parameter = new CSLOmParameter(lineNumber, fileName, PARAMETER_TYPE_OVR);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmParameter refParameter(parameter);
  parameter->m_weakRef = boost::weak_ptr<CSLOmBase>( refParameter);

  parameter->setParent(parent);
  RefCSLOmIdentifier oldParamId = oldParam->getID();
  RefCSLOmIdentifier newParamId = CSLOmIdentifier::build(lineNumber, fileName, refParameter, oldParamId->getIdType(), oldParamId->getName());

  parameter->m_width = oldParam->getWidth();

  if(value.get()) {

    if (value->getWidth() > parameter->m_width) {

      args.push_back(*(oldParam->getName()));//push parameter name
      addErr(NSWarningErr::CSE_CSC_PARM_VALUE_HAS_LARGER_WIDTH_THAN_PARAM, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmParameter();
    }

    value->setParent(refParameter);

  }
  else {
    RefCSLOmExpr parentValue = oldParam->getValueAsExpr();
    RefCSLOmExpr actualValue = parentValue->dupp();
    actualValue->setParent(refParameter);
  }

  return refParameter;
}





RefCSLOmParameter CSLOmParameter::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink declName, RefCSLOmNumber value) {
  ASSERT(parent.get(), "Null parent recieved");
  ASSERT(declName.get(), "Null name recieved");
  ASSERT(parent->isInstance(), "parent should be instance");

  CSLOmParameter *parameter;
  try {
    parameter = new CSLOmParameter(lineNumber, fileName, PARAMETER_TYPE_OVR);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmParameter refParameter(parameter);
  parameter->m_weakRef = boost::weak_ptr<CSLOmBase>( refParameter);

  parameter->setParent(parent);
  declName->setParent(refParameter);

  RefCSLOmBase base = declName->doEval();
  ASSERT(base->isParameter(), "base should be parameter ");
  parameter->m_width = CSLOmParameter::cast(base)->getWidth();

  if(value.get()) {

    if (value->getWidth() > parameter->m_width) {
      args.push_back(*(CSLOmParameter::cast(base)->getName()));//push parameter name
      addErr(NSWarningErr::CSE_CSC_PARM_VALUE_HAS_LARGER_WIDTH_THAN_PARAM, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmParameter();
    }

    value->setParent(refParameter);
  }
  else {
    RefCSLOmExpr parentValue = CSLOmParameter::cast(declName->doEval())->getValueAsExpr();
    RefCSLOmExpr actualValue = parentValue->dupp();
    actualValue->setParent(refParameter);
  }

  return refParameter;
}






RefCSLOmParameter CSLOmParameter::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString &name, RefCSLOmExpr value, RefCSLOmExpr width) {
  ASSERT(parent.get(), "Null parent recieved");
  ASSERT(value.get(), "Null value recieved");
  if (!parent->isUnitDecl() && !parent->isInterface() && !parent->isSignalGroup()) {
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL_PARENT, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmParameter();
    //throw NSBase::IllegalArgumentException("Parameter::build - parent should be a Unit Declaration");
  }

  if (width.get() && width->isExprLink() && !CSLOmExprLink::cast(width)->doEval().get()) {
    
    args.push_back(*name);//push parameter name
    addErr(NSWarningErr::CSE_CSC_PARM_EXPECTING_NUMBER_AS_WIDTH, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmParameter();

  }


  CSLOmParameter *parameter;
  try {
    parameter = new CSLOmParameter(lineNumber, fileName, PARAMETER_TYPE_DECL);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmParameter refParameter(parameter);
  parameter->m_weakRef = boost::weak_ptr<CSLOmBase>( refParameter);

  parameter->setParent(parent);
  CSLOmIdentifier::build(lineNumber, fileName, refParameter, CSLOmIdentifier::ID_PARAMETER, name);

  if (!width.get()) {
    
    parameter->m_width = 32;
  }
  else {


    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval = width->doParamEval(refParameter);
    RefCSLOmBase widthBase = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), eval);
    if (!widthBase->isNumber()) {
    
      args.push_back(*name);//push parameter name
      addErr(NSWarningErr::CSE_CSC_PARM_EXPECTING_NUMBER_AS_WIDTH, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      parent->removeChild(refParameter);
      return RefCSLOmParameter();

    }
    else {

      RefCSLOmNumber widthNumber = CSLOmNumber::cast(widthBase);

      if (widthNumber->getValue() <= 0) {

        args.push_back(*name);//push parameter name
        addErr(NSWarningErr::CSE_CSC_PARM_EXPECTING_POSITIVE_VALUE_AS_WIDTH, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
        parent->removeChild(refParameter);
        return RefCSLOmParameter();

      }
      else {
      
        parameter->m_width = widthNumber->getValue();
      }
    }
  }

  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval1 = value->doParamEval(refParameter);
  if(!eval1.get()) {
    parent->removeChild(refParameter);
    return RefCSLOmParameter();
  }
  RefCSLOmBase valueBase = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), eval1);
  if (!valueBase.get() || (valueBase.get() && !valueBase->isNumber())) {

    args.push_back(*name);//push parameter name
    addErr(NSWarningErr::CSE_CSC_PARM_EXPECTING_NUMBER_AS_VALUE, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    parent->removeChild(refParameter);
    return RefCSLOmParameter();

  }

  RefCSLOmNumber valueNumber = CSLOmNumber::cast(valueBase);
    
  if (valueNumber->getWidth() > parameter->m_width) {
      
    args.push_back(*name);//push parameter name
    addErr(NSWarningErr::CSE_CSC_PARM_VALUE_HAS_LARGER_WIDTH_THAN_PARAM, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    parent->removeChild(refParameter);
    return RefCSLOmParameter();

  }

  value->setParent(refParameter);
 
  return refParameter;
}




RefCSLOmParameter CSLOmParameter::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmParameter();
  }
  else {
    ASSERT(object->isParameter() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmParameter>(object);
  }
}





RefCSLOmNumber CSLOmParameter::getValue() const {
  ASSERT(getChildrenVec().get(), "Bug detected: no children");
  ASSERT(getChildrenVec()->size() == PARAM_CHILDREN_COUNT, "This object has to have only one child");
  ASSERT(getChild(PARAM_VALUE_CHILD_POS)->isExpr(), "The type of the child must be EXPR");
  RefCSLOmBase numberAsBase = getChild(PARAM_VALUE_CHILD_POS);
  ASSERT(CSLOmExpr::cast(getChild(PARAM_VALUE_CHILD_POS))->isNumber(), "The type of the expression must be number");
  RefCSLOmNumber number = CSLOmNumber::cast(numberAsBase);
  return number;//boost::static_pointer_cast<CSLOmNumber>(getChild(0));
}




void CSLOmParameter::override (RefCSLOmNumber value) {
  ASSERT(value.get(), "Null value recieved");
  
  if (value->getWidth() > m_width) {

    args.push_back(*(getName()));//push parameter name
    addErr(NSWarningErr::CSE_CSC_PARM_VALUE_HAS_LARGER_WIDTH_THAN_PARAM, args, getLineNumber(), getFileName());
    cslomHasErrors = TRUE;
  }

  setChild(PARAM_VALUE_CHILD_POS, value->dupp());
  m_isOveriden = TRUE;
}

RefCSLOmBase CSLOmParameter::getIDAsBase() const {
 ASSERT(getChildrenVec().get(), "Bug detected: no children");
 return getChild(ID);
}



RefCSLOmIdentifier CSLOmParameter::getID() const {
 ASSERT(getChildrenVec().get(), "Bug detected: no children");
 ASSERT(!m_parent.lock()->isInstance(), "The type of the parameter must be overridding");
 return CSLOmIdentifier::cast(getChild(ID));
}




RefCSLOmBase CSLOmParameter::getValueAsBase() const {
 ASSERT(getChildrenVec().get(), "Bug detected: no children");
 // ASSERT(getChild(ID)->isExpr(), "The type of the child must be EXPR");
 return getChild(1);
}


RefCSLOmExpr CSLOmParameter::getValueAsExpr() const {
 ASSERT(getChildrenVec().get(), "Bug detected: no children");
 // ASSERT(getChild(ID)->isExpr(), "The type of the child must be EXPR");
 return CSLOmExpr::cast(getChild(1));
}

RefString CSLOmParameter::getName() const {
 return getID()->getName();
}




RefCSLOmExprLink CSLOmParameter::getParamAsLink() const {
  ASSERT(m_parameterType == PARAMETER_TYPE_DECL, "getParamAsLink() can only be called on param of type decl");
  
  RefCSLOmExprLink paramLink = CSLOmExprLink::build(getLineNumber(), getFileName(), getName());
  paramLink->addID(getID());
  paramLink->setValue(getThis());
  
  return paramLink;
}




void CSLOmParameter::registerUnitInstance(RefCSLOmUnitInstance unitInst) {
  ASSERT(unitInst.get(), "received null unit instance");
  
  if (!m_instanceLinks.get()) { m_instanceLinks = RefTVec_WeakCSLOmUnitInstance(new TVec_WeakCSLOmUnitInstance()); }

  WeakCSLOmUnitInstance weakRef = WeakCSLOmUnitInstance(unitInst);

  m_instanceLinks->push_back(weakRef);
}



RefTVec_WeakCSLOmUnitInstance CSLOmParameter::getUnitInstances() const { return m_instanceLinks; }



TUInt CSLOmParameter::getWidth() const { return m_width; }



void CSLOmParameter::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis()); //not implemented yet
}


}
