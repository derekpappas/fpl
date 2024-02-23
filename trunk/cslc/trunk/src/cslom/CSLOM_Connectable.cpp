//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007,2008 Fastpath Logic
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

// Author BogdanZ & AlinaP

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
const std::string PORT_CONSTRUCT("csl_port constructor");
const std::string PORT_CONSTRUCT_BR("csl_port constructor: bitrange or width");
const std::string PORT_CONSTRUCT_CP("csl_port copy constructor: source port");
const std::string SIG_CONSTRUCT("csl_signal constructor");
const std::string SIG_CONSTRUCT_BR("csl_signal constructor: bitrange or width");
const std::string SIG_CONSTRUCT_CP("csl_signal copy constructor: source signal");

// ********************************************************************************
// CSLOmConnectable class
// ********************************************************************************

RefTMap_RefCSLOmExprLink_RefCSLOmExpr CSLOmConnectable::m_connectionMap = RefTMap_RefCSLOmExprLink_RefCSLOmExpr(new TMap_RefCSLOmExprLink_RefCSLOmExpr);
CSLOmConnectable::CSLOmConnectable(ECSLOmConnectableType type, TLineNumberType lineNumber,RefString fileName) : 
  CSLOmBase(TYPE_CONNECTABLE, lineNumber, fileName), 
  m_connectableType(type),
  m_isConnected(FALSE),
  m_isArGenerated(FALSE),
  m_arInstance() { }

RefCSLOmConnectable CSLOmConnectable::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmConnectable();
  }
  else {
    ASSERT(object->isConnectable(), "type check on cast failure");
    return boost::static_pointer_cast<CSLOmConnectable>(object);
  }
}

CSLOmConnectable::ECSLOmConnectableType CSLOmConnectable::getConnectableType() const {
  return m_connectableType;
}

TBool CSLOmConnectable::isConnected() const {
  return m_isConnected;
}

void CSLOmConnectable::addConnection(RefCSLOmExprLink object1, RefCSLOmExprLink object2) {
  ASSERT(object1.get(),"object to be connected should not be NULL");
  //  ASSERT(object1->isResolved(), "expression should be resolved by now");
  ASSERT(object2.get(),"object to be connected should not be NULL");
  //  ASSERT(object2->isResolved(), "expression should be resolved by now");
  RefCSLOmExprLink fullPath1 = object1->getFullPathLink();
  RefCSLOmExprLink fullPath2 = object2->getFullPathLink();
  m_connectionMap->insert(std::make_pair(fullPath1,fullPath2));
  RefCSLOmConnectable obj1 = CSLOmConnectable::cast(fullPath1->doEval());
  RefCSLOmConnectable obj2 = CSLOmConnectable::cast(fullPath2->doEval());
  ASSERT(obj1.get(), "object cannot be evaluated, error should be given already");
  ASSERT(obj2.get(), "object cannot be evaluated, error should be given already");
  obj1->m_isConnected = TRUE;
  obj2->m_isConnected = TRUE;
}

const RefCSLOmUnitDecl CSLOmConnectable::getParentUnit() const {
  RefCSLOmBase temp=getThis();
  while(!(temp->isUnitDecl())){
    if (temp->isDesign()) {
      return RefCSLOmUnitDecl();
    }
    temp = temp->getParent();
  }
  return CSLOmUnitDecl::cast(temp);
}

const RefCSLOmExprLink CSLOmConnectable::getF2ALink() const {
  RefCSLOmBase temp=getThis()->getParent();
  RefCSLOmExprLink expr = CSLOmExprLink::build(m_lineNumber, m_fileName, CSLOmIdentifier::cast(getChild(ID))->getName());
  while(!(temp->isUnitDecl())){
    if (!(temp->isInterface() && CSLOmInterface::cast(temp)->isDefaultIfc())) {
      expr->addScopeItem(CSLOmIdentifier::cast(temp->getChild(ID))->getName());
    }
    temp = temp->getParent();
  }
  expr->setValue(getThis());
  expr->addID(CSLOmIdentifier::cast(getChild(ID)));
  return expr;
}


TBool CSLOmConnectable::wasAssociatedClockSet() const { 

  TBool isClockAssociated = m_associatedClock.lock().get();

  if (!isClockAssociated) {

    if (!cIsSignal() && !cIsPort()) {

      if (cIsInterface()) {

        RefTVec_RefCSLOmPortDecl ports = CSLOmInterface::cast(getThis())->getAllPorts();
        for (TVec_RefCSLOmPortDecl::iterator it = ports->begin(); it != ports->end() && !isClockAssociated; ++it) {

          if ((*it)->wasAssociatedClockSet()) { isClockAssociated = TRUE; }
        }
      }
      else if (cIsSignalGroup()) {

        RefTVec_RefCSLOmSignal signals = CSLOmGroupSignal::cast(getThis())->getAllSignals();
        for (TVec_RefCSLOmSignal::iterator it = signals->begin(); it != signals->end() && !isClockAssociated; ++it) {

          if ((*it)->wasAssociatedClockSet()) { isClockAssociated = TRUE; }
        }
      }
    }
  }

  return isClockAssociated;
}


void CSLOmConnectable::associateClock(RefCSLOmConnectable clock) {
  ASSERT(clock.get(), "Received null ref");
  ASSERT(!wasAssociatedClockSet(), "trying to set the associated clock twice");
  ASSERT(!clock->cIsSignal() || ( clock->cIsSignal() && CSLOmSignal::cast(clock)->getSignalAttr() == ATTR_CLK ), "clock signal must have clk attr set");
  ASSERT(!clock->cIsPort() || ( clock->cIsPort() && CSLOmPortDecl::cast(clock)->getAttr() == ATTR_CLK ), "clock port must have clk attr set");

  m_associatedClock = WeakRefCSLOmConnectable(clock);
}


RefCSLOmConnectable CSLOmConnectable::getAssociatedClock() const {
  
  if (!m_associatedClock.lock().get()) { return RefCSLOmConnectable(); }
  else { return m_associatedClock.lock(); }
}

void  CSLOmConnectable::overrideParamList(RefCSLOmScope scope, RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap) {
  ASSERT(scope.get(), "received null scope");
  RefCSLOmBase holderObjBase = scope->getHolderObject();
  ASSERT(holderObjBase->isConnectable(), "scope should be attached to connectable object");
  ASSERT(holderObjBase->isInterface() || holderObjBase->isSignalGroup(), "scope should be attached to interface or signal group");
  ASSERT(!holderObjBase->isInterface() || (holderObjBase->isInterface() && CSLOmInterface::cast(holderObjBase)->isInstantiation()), "scope should be attached to instance of interface");
  ASSERT(!holderObjBase->isSignalGroup() || (holderObjBase->isSignalGroup() && CSLOmGroupSignal::cast(holderObjBase)->isInstantiation()), "scope should be attached to instance of signal group"); 
  

  for (TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator it = overrideParamMap->begin(); it != overrideParamMap->end(); ++it) {

    RefCSLOmIdentifier paramId = scope->lookupLocal(it->first->getName());

    ASSERT(paramId.get(), "id not found. this should not be");
    ASSERT(paramId->getParent()->isParameter(), "id is not from a parameter. this should not be");
    
    RefCSLOmBase base = it->second->doEval();
    
    ASSERT(base->isNumber(), "expression is not number. this should not be");

    CSLOmParameter::cast(paramId->getParent())->override(CSLOmNumber::cast(base));
  }

  return;
}



// ********************************************************************************
// CSLOmSignal class
// ********************************************************************************
 CSLOmSignal::CSLOmSignal(TLineNumberType lineNumber, RefString fileName, ECSLOmSignalType signalType, TBool used, TBool assigned)
   : CSLOmConnectable(CSLOmConnectable::TYPE_DECL_SIGNAL, lineNumber, fileName), 
    m_signalType(SIGNAL_UNDEFINED), 
    m_signalAccessType(SAT_UNDEFINED), 
    m_attrType(ATTR_UNDEFINED),
    m_isDecoder(FALSE), 
    m_hasDecOutput(FALSE), 
    m_hasDecUnit(FALSE), 
    m_signals() { }

RefCSLOmSignal CSLOmSignal::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmSignal();
  }
  else {
    RefCSLOmConnectable connectableObject = CSLOmConnectable::cast(object);
    ASSERT(connectableObject->cIsSignal() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmSignal>(connectableObject);
  }
}
void CSLOmSignal::addSignal(RefCSLOmSignal sig) {
  ASSERT(sig.get(), "CSLOmSignal::addSignal() Null input signal received");
  if(!m_signals.get()) {
    m_signals = RefTVec_WeakRefCSLOmSignal(new TVec_WeakRefCSLOmSignal());
  }
  m_signals->push_back(boost::weak_ptr<CSLOmSignal>(sig));
}

RefTVec_WeakRefCSLOmSignal CSLOmSignal::getSignals() const {
  return m_signals;
}

void CSLOmSignal::setDirection(ECSLOmPortDirection dir) {
  m_direction = dir;
}

ECSLOmPortDirection CSLOmSignal::getDirection() const {
  return m_direction;
}

 RefCSLOmSignal CSLOmSignal::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmSignalType signalType,  RefCSLOmExpr width){
  ASSERT(parent.get(), "null parent received");
  ASSERT(parent->isScopeHolder(), "parent should be a scope holder"); // ensures that parent is a scope

//   if(width.get()) {
//     RefCSLOmBase eval = width->doEval(TRUE);
//     if (eval.get() && eval->isNumber() && CSLOmNumber::cast(eval)->getValue() <= 0 ) {
//       args.push_back(SIG_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmSignal();
//     }
//     else if (!eval.get() || (!eval->isBitRange() && !eval->isSignal() && !eval->isNumber())) {
//       args.push_back(SIG_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmSignal();
//     }
//   }

  CSLOmSignal* signal;
  try {
    signal = new CSLOmSignal(lineNumber, fileName, signalType,FALSE,FALSE);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmSignal refSignal(signal);
  signal->m_weakRef = boost::weak_ptr<CSLOmBase>( refSignal);
  signal->setParent(parent);
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refSignal, CSLOmIdentifier::ID_CSL_SIGNAL, name);
  RefCSLOmSimpleBitRange signalBitRange = CSLOmSimpleBitRange::build(lineNumber, fileName, refSignal, RefString(new std::string("")));
  if (width.get() && width->isExprLink()) {
    RefCSLOmBase evalObj = width->doEval(TRUE);
    if (evalObj.get()) {
      if(evalObj->isBitRange()) {
        signal->setBitRange(CSLOmBaseRange::cast(evalObj));
      }
      else if (evalObj->isNumber() || evalObj->isParameter()) {
        signalBitRange->setWidth(width);
      }
      else if (evalObj->isSignal()) {
        signal->setBitRange(CSLOmSignal::cast(evalObj)->getBitRange());
        signal->m_signalType = CSLOmSignal::cast(evalObj)->m_signalType;
      } 
    }
    else {
      args.push_back("csl_signal constructor");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmSignal();
    }
    if (evalObj->isSignal() && signalType != SIGNAL_UNDEFINED) {
      args.push_back("csl_signal constructor");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmSignal();
    }
    else if (!evalObj->isSignal()){
      signal->m_signalType = signalType;
    }
  }
  else {
    if (width.get()) {
      signal->setWidth(width);
    }
    signal->m_signalType = signalType;
  }

  return refSignal;
}

TBool CSLOmSignal::hasBitRange() const { 
  return getBitRange().get() != ZERO;
}

 RefCSLOmSignal CSLOmSignal::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmSignalType signalType,  RefCSLOmExpr lower, RefCSLOmExpr upper){
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isScopeHolder(), "parent is not a scope holder"); // ensures that parent is a scope
  ASSERT(lower.get(), "null lower index received");
  ASSERT(upper.get(), "null lower index received");

  CSLOmSignal* signal;
  try {
    signal = new CSLOmSignal(lineNumber,fileName,signalType,FALSE,FALSE);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmSignal refSignal(signal);
  signal->m_weakRef = boost::weak_ptr<CSLOmBase>( refSignal);
  signal->setParent(parent);
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refSignal, CSLOmIdentifier::ID_CSL_SIGNAL, name);

  RefCSLOmSimpleBitRange signalBitRange = CSLOmSimpleBitRange::build(lineNumber, fileName, refSignal, RefString(new std::string("")), lower, upper);
  signal->m_signalType = signalType;
  return refSignal;
}

RefCSLOmBaseRange CSLOmSignal::getBitRange() const {
  return (CSLOmBaseRange::cast(getChild(SIGNAL_BR)));
}

const RefCSLOmBase CSLOmSignal::getBitRangeAsBase() const {
  return getChild(SIGNAL_BR);
}

void CSLOmSignal::setBitRange(RefCSLOmExprLink bitRange) {
  ASSERT(bitRange.get(), "null bitRange param received");
  if (bitRange->doEval()->isField()) {
    removeChild(getChild(SIGNAL_BR));
    RefString name = RefString(new std::string(""));
    RefCSLOmField field = CSLOmField::build(m_lineNumber, m_fileName, getThis(), name, CSLOmField::cast(bitRange->getLocalNameID()->getParent()));
  }
  else if (bitRange->doEval()->isMultiDimBitRange()) {
    removeChild(getChild(SIGNAL_BR));
    RefCSLOmMultiDimBitRange field = CSLOmMultiDimBitRange::build(m_lineNumber, m_fileName, getThis(), RefString(new std::string("")), CSLOmMultiDimBitRange::cast(bitRange->doEval()));
  }
  else if (!CSLOmSimpleBitRange::cast(bitRange->getLocalNameID()->getParent())->isDefault()) {
    CSLOmSimpleBitRange::cast(getChild(SIGNAL_BR))->setBitRange(CSLOmExpr::cast(bitRange));
  }
}

void CSLOmSignal::setBitRange(RefCSLOmBaseRange bitRange) {
  ASSERT(bitRange.get(), "null bitrange param received");
  if (bitRange->isField()) {
    removeChild(getChild(SIGNAL_BR));
    RefString name = RefString(new std::string(""));
    RefCSLOmField field = CSLOmField::build(m_lineNumber, m_fileName, getThis(), name, CSLOmField::cast(bitRange));
  }
  else if (bitRange->isMultiDimBitRange()) {
    removeChild(getChild(SIGNAL_BR));
    RefCSLOmMultiDimBitRange field = CSLOmMultiDimBitRange::build(m_lineNumber, m_fileName, getThis(), RefString(new std::string("")), CSLOmMultiDimBitRange::cast(bitRange));
  }
  else if (!CSLOmSimpleBitRange::cast(bitRange)->isDefault()) {
    CSLOmSimpleBitRange::cast(getChild(SIGNAL_BR))->setBitRange(CSLOmSimpleBitRange::cast(bitRange));
  }
}

void CSLOmSignal::setDimBitRange(RefCSLOmExpr dim, RefCSLOmExpr bitRange) {
  ASSERT(bitRange.get(), "null bitRange param received");
  ASSERT(dim.get(), "null dimension number received");

  (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->setDimBitRange(dim, bitRange);
}

void CSLOmSignal::setDimBitRange(RefCSLOmExpr dim, RefCSLOmSimpleBitRange bitRange) {
  ASSERT(bitRange.get(), "null bitRange param received");
  ASSERT(dim.get(), "null dimension number received");

  (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->setDimBitRange(dim, bitRange);
}

RefCSLOmSimpleBitRange CSLOmSignal::getDimBitRange(RefCSLOmExpr dim) const {
  return CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR))->getDimBitRange(dim);
}

//RefCSLOmBase CSLOmSignal::getDimBitRangeAsBase(RefCSLOmExpr dim) const {
//  return getChild(1)->getDimBitRange(dim);
//}

void CSLOmSignal::setSignalType(ECSLOmSignalType type) {
  m_signalType = type;
}

void CSLOmSignal::setSignalAttr(ECSLOmSignalAttr attr) {
  m_attrType = attr;
}

ECSLOmSignalAttr CSLOmSignal::getSignalAttr() const {
  return m_attrType;
}

ECSLOmSignalType CSLOmSignal::getSignalType() const {
  return m_signalType;
}
    
void CSLOmSignal::setNumberOfDimensions(RefCSLOmExpr numOfDim) {
  ASSERT(numOfDim.get(), "null number of dimensions received");
  if (!getChild(SIGNAL_BR)->isMultiDimBitRange()) {
    removeChild(getChild(SIGNAL_BR));
    CSLOmMultiDimBitRange::build(m_lineNumber, m_fileName,  getThis(), RefString(new std::string("")), numOfDim);
  }
  else {
    ASSERT(FAIL, "this should be checked in cmd");
  }
  CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR))->setNoOfDims(numOfDim);
}

const RefCSLOmExpr CSLOmSignal::getNumberOfDimensions() const{
  return CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR))->getNoOfDims();
}

void CSLOmSignal::setDimensionWidth(RefCSLOmExpr dim, RefCSLOmExpr width){
  ASSERT(width.get(), "null width param received");
  (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->setDimWidth(dim, width);
}

const RefCSLOmExpr CSLOmSignal::getDimensionWidth(RefCSLOmExpr dim) const{
  return (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->getDimWidth(dim);
}

void CSLOmSignal::setWidth(RefCSLOmExpr width){
  ASSERT(width.get(), "null width param received");

  (CSLOmSimpleBitRange::cast(getChild(SIGNAL_BR)))->setWidth(width);
}

void CSLOmSignal::setRange(RefCSLOmExpr lowerIndex, RefCSLOmExpr upperIndex) {
  CSLOmSimpleBitRange::cast(getBitRange())->setRange(lowerIndex, upperIndex);
}

const RefCSLOmExpr CSLOmSignal::getWidth() const{
  RefCSLOmBaseRange baseRange=CSLOmBaseRange::cast(getChild(SIGNAL_BR));
  if(baseRange->isSimpleBitRange()){
    return (CSLOmSimpleBitRange::cast(baseRange))->getWidth();
  }
  else{
    return (CSLOmMultiDimBitRange::cast(baseRange))->getNoOfDims();
  }
}

void CSLOmSignal::setDimRange(RefCSLOmExpr dim, RefCSLOmExpr lowerIndex, RefCSLOmExpr upperIndex){
  ASSERT(lowerIndex.get(), "null lowerIndex param received");
  ASSERT(upperIndex.get(), "null upperIndex param received");

  (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->setDimRange(dim, lowerIndex, upperIndex);
}

void CSLOmSignal::setOffset(RefCSLOmExpr offset){
  ASSERT(offset.get(), "null offset param received");

  (CSLOmSimpleBitRange::cast(getChild(SIGNAL_BR)))->setOffset(offset);
}

const RefCSLOmExpr CSLOmSignal::getOffset() const {
  return (CSLOmSimpleBitRange::cast(getChild(SIGNAL_BR)))->getOffset();
}

void CSLOmSignal::setDimOffset(RefCSLOmExpr dim, RefCSLOmExpr offset){
  ASSERT(offset.get(), "null offset param received");

  (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->setDimOffset(dim, offset);
}

const RefCSLOmExpr CSLOmSignal::getDimOffset(RefCSLOmExpr dim) const{
  return (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->getDimOffset(dim);
}

RefCSLOmExpr CSLOmSignal::getLowerIndex(){
  return (CSLOmSimpleBitRange::cast(getChild(SIGNAL_BR)))->getLower();
}

RefCSLOmExpr CSLOmSignal::getUpperIndex(){
  return (CSLOmSimpleBitRange::cast(getChild(SIGNAL_BR)))->getUpper();
}

RefCSLOmExpr CSLOmSignal::getDimLowerIndex(RefCSLOmExpr dim){
  ASSERT(dim.get(), "null dimension number received");

  return (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->getDimLower(dim);
}

RefCSLOmExpr CSLOmSignal::getDimUpperIndex(RefCSLOmExpr dim){
  ASSERT(dim.get(), "null dimension number received");

  return (CSLOmMultiDimBitRange::cast(getChild(SIGNAL_BR)))->getDimUpper(dim);
}

const RefTVec_RefCSLOmBase CSLOmSignal::getFieldsAsBase() const{
  return getChildrenAsBase(TYPE_ALL_FIELDS);
}

void CSLOmSignal::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmGroupSignal class
// ********************************************************************************
 CSLOmGroupSignal::CSLOmGroupSignal(TLineNumberType lineNumber, RefString fileName) : 
   CSLOmConnectable(CSLOmConnectable::TYPE_GROUP_SIGNAL, lineNumber, fileName),
   m_generateIndividualRtlSignals(TRUE), m_noPrefix(FALSE),
   m_hasPrefix(FALSE),
   m_instantiation(FALSE),
   m_className(new string("")){}

RefCSLOmGroupSignal CSLOmGroupSignal::cast(RefCSLOmBase object) {
  if(!object.get()) {
    return RefCSLOmGroupSignal();
  }
  else {
    //RefCSLOmConnectable objectAsConnectable = CSLOmConnectable::cast(object);
    //ASSERT(objectAsConnectable->cIsSignalGroup(), "CSLOmGroupSignal::cast() Type check failure");
    ASSERT(object->isSignalGroup(), "CSLOmGroupSignal::cast() Type check failure");
    return boost::static_pointer_cast<CSLOmGroupSignal>(object) ;
  }
}

RefTVec_RefCSLOmSignal CSLOmGroupSignal::getAllSignals() const {
  RefTVec_RefCSLOmGroupSignal ifcs = getGroupSignals();
  
  RefTVec_RefCSLOmSignal ports = getSignals();

  if(!ports.get()){
    ports = RefTVec_RefCSLOmSignal(new TVec_RefCSLOmSignal());
  }

  if(ifcs.get()) {
    for (TVec_RefCSLOmGroupSignal::iterator it = ifcs->begin(); it < ifcs->end(); it++) {
      RefTVec_RefCSLOmSignal ifcPorts = (*it)->getAllSignals();
      if (ifcPorts.get()) {
        for (TVec_RefCSLOmSignal::iterator itp = ifcPorts->begin(); itp < ifcPorts->end(); itp++) {
          ports->push_back(*itp);
        }
      }
    }
  }

  return ports;
}

RefCSLOmScope CSLOmGroupSignal::getAttachedScope() const {
  return m_scope;
}

const RefString CSLOmGroupSignal::getGroupSignalClassName() const {
  return m_className;
}
void CSLOmGroupSignal::setGroupSignalClassName(RefString name) {
  m_className = name;
}

 RefCSLOmGroupSignal CSLOmGroupSignal::allocate(TLineNumberType lineNumber, RefString fileName,  RefCSLOmBase parent, const RefString& name ) {
  
  CSLOmGroupSignal* signalGroup;
  try {
    signalGroup = new CSLOmGroupSignal(lineNumber, fileName);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "CSLOmGroupSignal::build() new operator failed");
  }
  
  RefCSLOmGroupSignal refSignalGroup(signalGroup);
  signalGroup->m_weakRef = boost::weak_ptr<CSLOmBase>(refSignalGroup);
  signalGroup->setParent(parent);

  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName,  refSignalGroup, CSLOmIdentifier::ID_CSL_GROUP, name);
  signalGroup->m_scope = CSLOmScope::build(id);
  //  signalGroup->m_prefix = RefString(new std::string(*name));

  return refSignalGroup;

}

RefCSLOmGroupSignal CSLOmGroupSignal::build( TLineNumberType lineNumber,
                                             RefString fileName,
                                             RefCSLOmBase parent, 
                                             const RefString& name, 
                                             RefCSLOmExprLink expr,
                                             RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap ) {

  ASSERT( parent.get(), "CSLOmGroupSignal::build() Parent is null");
  ASSERT( parent->isUnitDecl() || parent->isDesign() || parent->isGroup(), "CSLOmGroupSignal::build() Illegal parent type");
  ASSERT( name.get(), "CSLOmGroupSignal::build() Null name received");
  ASSERT( name->length(), "CSLOmGroupSignal::build() Empty name received");
  checkIdName(name, lineNumber, fileName);
  
  if(expr.get()) {
    RefCSLOmIdentifier id = expr->getLocalNameID();
    ASSERT(id.get(), "CSLOmGroupSignal::build() ExprLink id is null");
    if(id->getParent()->isSignalGroup()) {
      RefCSLOmGroupSignal sourceSgGroup = CSLOmGroupSignal::cast(id->getParent());
      RefCSLOmGroupSignal newSigGr = build(lineNumber,fileName, parent, name, sourceSgGroup, overrideParamMap);
      return newSigGr;
    }
    else {
      args.push_back(*(id->getName()));
      args.push_back("signal_group");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmGroupSignal();
    }
  }
  else {
    RefCSLOmGroupSignal sig_group = allocate(lineNumber,fileName, parent, name);
    sig_group->setGroupSignalClassName(name);
    return sig_group;
  }
}
 
RefCSLOmGroupSignal CSLOmGroupSignal::build( TLineNumberType lineNumber,
                                             RefString fileName,
                                             RefCSLOmBase parent,
                                             const RefString name,
                                             RefCSLOmGroupSignal groupSignal,
                                             RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap ){

  ASSERT( parent.get(), "CSLOmGroupSignal::build() Parent is null");
  ASSERT( parent->isUnitDecl() || parent->isDesign() || parent->isGroup(), "CSLOmGroupSignal::build() Illegal parent type");
  ASSERT( name.get(), "CSLOmGroupSignal::build() Null name received");
  ASSERT( name->length(), "CSLOmGroupSignal::build() Empty name received");
  ASSERT( groupSignal.get(), "CSLOmGroupSignal::build() Null signal group received");
  checkIdName(name, lineNumber, fileName);
 
  RefCSLOmGroupSignal gs = allocate(lineNumber, fileName, parent, name);
  gs->m_instantiation = TRUE;
  gs->copyInterfaceOrSignalGroup(groupSignal);
  gs->m_prefix = groupSignal->m_prefix;
  gs->setGroupSignalClassName(groupSignal->getGroupSignalClassName());

  if (overrideParamMap.get()) {

    if (!overrideParamMap->empty()) {

      CSLOmConnectable::overrideParamList(gs->getAttachedScope(), overrideParamMap);
    }
  }


  return gs;
}

void CSLOmGroupSignal::copyInterfaceOrSignalGroup(RefCSLOmConnectable connectable) {
  if(connectable->cIsSignalGroup()) {//called from buid2
    RefCSLOmGroupSignal groupSignal = cast(connectable);
    RefTVec_RefCSLOmBase groupSignalChildren = groupSignal->getChildrenAsBase();
    if(groupSignalChildren.get()) {
      for(TVec_RefCSLOmBase_const_iter it = groupSignalChildren->begin(); it < groupSignalChildren->end(); ++it) {
        if((*it)->isID()) {
        }
        else if((*it)->isSignalGroup()) {
          RefCSLOmGroupSignal source = cast(*it);
          build(groupSignal->getLineNumber(), groupSignal->getFileName(), getThis(), source->getName(), source);
        }
        else if((*it)->isSignal()) {
          RefCSLOmSignal source = CSLOmSignal::cast(*it);
          RefString sourceName = source->getName();
          ECSLOmSignalType sourceType = source->getSignalType();

          RefCSLOmExprLink sourceBrLink;
          if(source->getBitRange().get()) {
            sourceBrLink = source->getBitRange()->getBitRangeLink();
          }
          addSignal(groupSignal->getLineNumber(), groupSignal->getFileName(), sourceName, sourceType, sourceBrLink);
        }
        else if ((*it)->isParameter()) {
          RefCSLOmParameter oldParam = CSLOmParameter::cast(*it);
          RefCSLOmParameter param = addParameter(oldParam->getLineNumber(), oldParam->getFileName(), oldParam);
        }
      }
    }
  }
  else if(connectable->cIsInterface()) {//called from build3
    RefCSLOmInterface interface = CSLOmInterface::cast(connectable);
    RefTVec_RefCSLOmBase interfaceChildren = interface->getChildrenAsBase();
    if(interfaceChildren.get()) {
      for(TVec_RefCSLOmBase_const_iter it = interfaceChildren->begin(); it < interfaceChildren->end(); ++it) {
        if((*it)->isID()) {
        }
        else if((*it)->isInterface()) {
          RefCSLOmInterface source = CSLOmInterface::cast(*it);
          build(interface->getLineNumber(), interface->getFileName(), getThis(), source->getInterfaceName(), source);
        }
        else if((*it)->isPort()) {
          RefCSLOmPortDecl source = CSLOmPortDecl::cast(*it);
          RefString sourceName = source->getName();
          ECSLOmSignalType sourceType = source->getPortType();

          RefCSLOmExprLink sourceBrLink;
          if(source->getBitRange().get()) {
            sourceBrLink = source->getBitRange()->getBitRangeLink();
          }
          addSignal(interface->getLineNumber(), interface->getFileName(), sourceName, sourceType, sourceBrLink);
        }
        else if ((*it)->isParameter()) {
          RefCSLOmParameter oldParam = CSLOmParameter::cast(*it);
          RefCSLOmParameter param = addParameter(oldParam->getLineNumber(), oldParam->getFileName(), oldParam);
        }
      }
    }
  }
  else {
    ASSERT(FAIL, "CSLOmGroupSignal::copyInterfaceOrSignalGroup() Connectable object's type is illegal");
  }

}

RefCSLOmGroupSignal CSLOmGroupSignal::build( TLineNumberType lineNumber,
                                             RefString fileName,
                                             RefCSLOmBase parent,
                                             const RefString name,
                                             RefCSLOmInterface interface,
                                             RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap ) {
  
  ASSERT( parent.get(), "CSLOmGroupSignal::build() Parent is null");
  ASSERT( parent->isUnitDecl() || parent->isDesign() || parent->isGroup(), "CSLOmGroupSignal::build() Illegal parent type");
  ASSERT( name.get(), "CSLOmGroupSignal::build() Null name received");
  ASSERT( name->length(), "CSLOmGroupSignal::build() Empty name received");
  ASSERT( interface.get(), "CSLOmGroupSignal::build() Empty interface received");
  checkIdName(name, lineNumber, fileName);

  RefCSLOmGroupSignal signalGroup = allocate(lineNumber, fileName,  parent, name);
  signalGroup->m_instantiation = TRUE;
  signalGroup->copyInterfaceOrSignalGroup(interface);
  signalGroup->setGroupSignalClassName(interface->getInterfaceClassName());

  if (overrideParamMap.get()) {

    if (!overrideParamMap->empty()) {

      CSLOmConnectable::overrideParamList(signalGroup->getAttachedScope(), overrideParamMap);
    }
  }

  return signalGroup;
}


void CSLOmGroupSignal::setGenerateIndividualRtlSignals(TBool option) {
  if(option == FALSE) {
    TBool ok;
    RefTVec_RefCSLOmSignal signalChildren = getSignals();
    if(signalChildren.get()) {
      ECSLOmSignalType type = (*(signalChildren->begin()))->getSignalType();
      for(TVec_RefCSLOmSignal_const_iter it = signalChildren->begin(); it < signalChildren->end(); ++it) {
        if(it == signalChildren->begin()) {
          continue;
        }
        if (type != (*it)->getSignalType()) {
          ok = 0;
          break;
        }
      }
      ASSERT(ok, "CSLOmGroupSignal::setGenerateIndividualRtlSignals() Signals are not of the same type");
    }
    else {
      ASSERT(FAIL, "CSLOmGroupSignal::setGenerateIndividualRtlSignals() There are no signals in the group");
    }
  }
  m_generateIndividualRtlSignals = option;
}

RefTVec_RefCSLOmBase CSLOmGroupSignal::getAssignListFull() const {
  RefTVec_RefCSLOmBase assignStmts = getChildrenAsBase(TYPE_STMT);
  RefTVec_RefCSLOmGroupSignal ifcs = getGroupSignals();

  if (!assignStmts.get()) { assignStmts = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase()); }
  if (ifcs.get()) {
    for (TVec_RefCSLOmGroupSignal::iterator it = ifcs->begin(); it < ifcs->end(); it++) {
      RefTVec_RefCSLOmBase temp = (*it)->getAssignListFull();
      for (TVec_RefCSLOmBase::iterator iter = temp->begin(); iter < temp->end(); iter++) {
        assignStmts->push_back(*iter);
      }
    }
  }
  
  return assignStmts;
}

TBool CSLOmGroupSignal::getGenerateIndividualRtlSignals() {
  return m_generateIndividualRtlSignals;
}

    
RefCSLOmSignal CSLOmGroupSignal::addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& name, ECSLOmSignalType sigType, RefCSLOmExprLink bitRange) {
   RefCSLOmSignal sig = CSLOmSignal::build(lineNumber, fileName, getThis(), name, sigType);
  if(bitRange.get()) {
    sig->setBitRange(bitRange);
  }
  return sig;
    
}
void CSLOmGroupSignal::removeSignal(RefCSLOmSignal sig){
  ASSERT(sig.get(), "CSLOmGroupSignal::removeSignal() Null signal received");
  ASSERT(containsSignal(sig), "CSLOmGroupSignal::removeSignal() Signal is not registered in the signal group");
  ASSERT(getParent()->isDesign(), "CSLOmGroupSignal::removeSignal() Cannot perform this operation on a signal group that is not global");

  removeChild(sig);
}

RefTVec_RefCSLOmSignal CSLOmGroupSignal::getSignals() const {
  return getChildren<CSLOmSignal>(TYPE_ALL_SIGNALS);
}
RefTVec_RefCSLOmBase CSLOmGroupSignal::getSignalsAsBase() const {
  return getChildrenAsBase(TYPE_ALL_SIGNALS);
}
RefTVec_RefCSLOmGroupSignal CSLOmGroupSignal::getGroupSignals() const {
  return getChildren<CSLOmGroupSignal>(TYPE_ALL_GROUPS);
}
RefTVec_RefCSLOmBase CSLOmGroupSignal::getGroupSignalsAsBase() const {
  return getChildrenAsBase(TYPE_ALL_GROUPS);
}
    
TBool CSLOmGroupSignal::containsSignal(const RefCSLOmSignal& sig) const {
  RefTVec_RefCSLOmSignal sigChildren= getSignals();
  if(sigChildren.get()) {
    for(TVec_RefCSLOmSignal_const_iter it = sigChildren->begin(); it < sigChildren->end(); ++it) {
      if(*it == sig) {
        return TRUE;
      }
    }
    return FALSE;
  }
  return FALSE;
}

void CSLOmGroupSignal::setPrefix(const RefString& prefix) {
  m_prefix = prefix;
}
const RefString CSLOmGroupSignal::getPrefix() const {
  return (!m_noPrefix) ? m_prefix : RefString(new std::string); 
}

void CSLOmGroupSignal::setSuffix(const RefString& suffix) {
  m_suffix = suffix;
}
const RefString CSLOmGroupSignal::getSuffix() const {
  return m_suffix; 
}


RefCSLOmParameter  CSLOmGroupSignal::addParameter(TLineNumberType lineNumber, RefString fileName, RefCSLOmParameter oldParam, RefCSLOmNumber value) {
  ASSERT(oldParam.get(), "NULL param" );
  
  return CSLOmParameter::build(lineNumber, fileName, getThis(), oldParam, value);
}


RefTVec_RefCSLOmBase CSLOmGroupSignal::getParameters() {
  
  return getChildrenAsBase(TYPE_PARAMETER);
}


void CSLOmGroupSignal::enableNoPrefix() {
  m_noPrefix = TRUE;
}

TBool CSLOmGroupSignal::getNoPrefixBit() const {
  return m_noPrefix;
}


RefCSLOmNumber CSLOmGroupSignal::getWidth() const {
  RefTVec_RefCSLOmSignal ports = getAllSignals();

  TUInt width = 0;
  for (TVec_RefCSLOmSignal::iterator it = ports->begin(); it < ports->end(); it++) {
    width += CSLOmNumber::cast((*it)->getWidth()->doEval())->getValue(); 
  }

  return CSLOmNum32::build(m_lineNumber, m_fileName, width);
}


TBool CSLOmGroupSignal::isInstantiation() const { return m_instantiation; }


void CSLOmGroupSignal::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


// ********************************************************************************
// CSLOmInterface class
// ********************************************************************************
CSLOmInterface::CSLOmInterface(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmConnectable(CSLOmConnectable::TYPE_INTERFACE, lineNumber, fileName),
  m_hasPrefix(FALSE),
  m_noPrefix(FALSE),
  m_isReversed(FALSE),
  m_instantiation(FALSE),
  m_className(new string("")) {}

RefCSLOmInterface CSLOmInterface::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmInterface();
  }
  else {
    RefCSLOmConnectable connectableObject = CSLOmConnectable::cast(object);
    ASSERT(connectableObject->cIsInterface() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmInterface>(connectableObject);
  }
}

void CSLOmInterface::setInterface(RefCSLOmInterface interface) {
  ASSERT(interface.get(), "null input interface");
  
  RefTVec_RefCSLOmBase interfacePorts = interface->getChildrenAsBase();
  if (interfacePorts.get()) {
    TVec_RefCSLOmBase_const_iter it;
    for (it = interfacePorts->begin(); it < interfacePorts->end();it++) {
      if ((*it)->isConnectable()) {
        if (CSLOmConnectable::cast(*it)->cIsInterface()) {
          RefCSLOmInterface sourceInterface = cast(*it);//CSLOmInterface::cast(*it);
          RefCSLOmInterface interface = CSLOmInterface::build(sourceInterface->getLineNumber(), sourceInterface->getFileName(), getThis(), sourceInterface->getInterfaceName(), sourceInterface);
        }
        else if (CSLOmConnectable::cast(*it)->cIsPort()) {
          RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);//CSLOmPortDecl::cast(*it);
          RefString name = port->getName();
          ECSLOmPortDirection portDirection = port->getPortDirection();
          ECSLOmSignalType portType = port->getPortType();
          RefCSLOmExprLink bitRangeLink = RefCSLOmExprLink();        
          if (port->getBitRange().get()) {
            bitRangeLink = port->getBitRange()->getBitRangeLink();
          }
          ECSLOmSignalAttr attr= port->getAttr();
        
          addPort (interface->getLineNumber(), interface->getFileName(), name, portDirection, portType, attr, bitRangeLink);
        }
      }
      else if ((*it)->isParameter()) {
        RefCSLOmParameter oldParam = CSLOmParameter::cast(*it);
        RefCSLOmParameter param = addParameter(oldParam->getLineNumber(), oldParam->getFileName(), oldParam);
      }
      else if ((*it)->isStmtAssign()) {
        CSLOmStmtAssign::build((*it)->getLineNumber(), (*it)->getFileName(), getThis(), CSLOmStmtAssign::cast(*it)->getLHS()->dupp(), CSLOmStmtAssign::cast(*it)->getRHS()->dupp());
      }
    }
  }
  setInterfaceClassName(interface->getInterfaceClassName());
}

void CSLOmInterface::transformGroup(ECSLOmPortDirection direction, RefCSLOmGroupSignal group) {
  ASSERT(group.get(), "null input group");
  
  RefTVec_RefCSLOmBase interfacePorts = group->getChildrenAsBase();
  if (interfacePorts.get()) {
    TVec_RefCSLOmBase_const_iter it;
    for (it = interfacePorts->begin(); it < interfacePorts->end();it++) {
      if ((*it)->isConnectable()) {
        if (CSLOmConnectable::cast(*it)->cIsSignalGroup()) {
          RefCSLOmGroupSignal sourceInterface = CSLOmGroupSignal::cast(*it);
          RefCSLOmInterface interface = CSLOmInterface::build(sourceInterface->getLineNumber(), sourceInterface->getFileName(), getThis(), sourceInterface->getName(), direction, sourceInterface);
        }
        else if (CSLOmConnectable::cast(*it)->cIsSignal()) {
          RefCSLOmSignal port = CSLOmSignal::cast(*it);
          RefString name = port->getName();
          ECSLOmSignalType portType = port->getSignalType();
          RefCSLOmExprLink bitRangeLink = RefCSLOmExprLink();        
          if (port->getBitRange().get()) {
            bitRangeLink = port->getBitRange()->getBitRangeLink();
          }
        
          addPort (group->getLineNumber(), group->getFileName(), name, direction, portType, bitRangeLink);
        }
      }
    }
  }
  setInterfaceClassName(group->getName());
}

RefTVec_RefCSLOmPortDecl CSLOmInterface::getAllPorts() const {
  RefTVec_RefCSLOmInterface ifcs = getInterfaces();
  
  RefTVec_RefCSLOmPortDecl ports = getPorts();

  if(!ports.get()){
    ports = RefTVec_RefCSLOmPortDecl(new TVec_RefCSLOmPortDecl());
  }

  if(ifcs.get()) {
    for (TVec_RefCSLOmInterface::iterator it = ifcs->begin(); it < ifcs->end(); it++) {
      RefTVec_RefCSLOmPortDecl ifcPorts = (*it)->getAllPorts();
      if (ifcPorts.get()) {
        for (TVec_RefCSLOmPortDecl::iterator itp = ifcPorts->begin(); itp < ifcPorts->end(); itp++) {
          ports->push_back(*itp);
        }
      }
    }
  }

  return ports;
}


RefCSLOmInterface CSLOmInterface::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent,const RefString& name, RefCSLOmExprLink expr, 
                                        RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap) {
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isUnitDecl() || 
         parent->isDesign() ||
         parent->isInterface(),
         "invalid parent type");
  ASSERT(name.get(), "null name");
  ASSERT(name->length(), "empty name string");
  if (name.get())
    checkIdName(name, lineNumber, fileName);
  if (expr.get()) {
    RefCSLOmIdentifier id = expr->getLocalNameID();
    if (id.get()) {
      if (id->getParent()->isInterface()) {
        return CSLOmInterface::build(lineNumber, fileName, parent,name,CSLOmInterface::cast(id->getParent()), overrideParamMap);
      }
      else {
        args.push_back(*(id->getName()));
        args.push_back("interface");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
        //throw NSBase::IllegalArgumentException("param object type is not supported by this constructor");
      }
    }
    else {
      
      throw NSBase::IllegalArgumentException("param object does not exist");
    }
  }

  CSLOmInterface* interface;
  try {
    interface = new CSLOmInterface(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmInterface refInterface(interface);
  interface->m_weakRef= boost::weak_ptr<CSLOmBase>(refInterface);
  interface->setParent(parent);
  //  interface->m_prefix = RefString(new std::string(*name));

  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refInterface, CSLOmIdentifier::ID_CSL_INTERFACE, name);
  interface->m_scope = CSLOmScope::build(id);
  ASSERT(id.get(), "Invalid id created");
  if(!expr.get()) {
    interface->setInterfaceClassName(name);
  }
  //interface->m_ports = RefTMap_RefString_RefCSLOmIdentifier(new TMap_RefString_RefCSLOmIdentifier());
  return refInterface;
}

RefCSLOmInterface CSLOmInterface::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmInterface interfaceIn, 
                                        RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap) {
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isUnitDecl() || 
         parent->isDesign() || 
         parent->isInterface(),
         "invalid parent type");
  ASSERT(name.get(), "null name");
  ASSERT(name->length(), "empty name string");
  ASSERT(interfaceIn.get(), "null interface");
  if (name.get())
    checkIdName(name, lineNumber, fileName);
  
  CSLOmInterface* interface;
  try {
    interface = new CSLOmInterface(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmInterface refInterface(interface);
  interface->m_weakRef= boost::weak_ptr<CSLOmBase>(refInterface);
  interface->setParent(parent);
  interface->m_prefix = interfaceIn->m_prefix;//RefString(new std::string(*name));
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refInterface, CSLOmIdentifier::ID_CSL_INTERFACE, name);
  interface->m_scope = CSLOmScope::build(id);
  interface->setInterface(interfaceIn);
  interface->m_instantiation = TRUE;

  if (overrideParamMap.get()) {

    if (!overrideParamMap->empty()) {

      CSLOmConnectable::overrideParamList(interface->getAttachedScope(), overrideParamMap);
    }
  }
  return refInterface;
}

RefCSLOmInterface CSLOmInterface::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection direction, 
                                        RefCSLOmGroupSignal groupIn, RefTMap_RefCSLOmExprLink_RefCSLOmExpr overrideParamMap) {
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isUnitDecl() || 
         parent->isDesign() || 
         parent->isInterface(),
         "invalid parent type");
  ASSERT(name.get(), "null name");
  ASSERT(name->length(), "empty name string");
  ASSERT(groupIn.get(), "null interface");
  if (name.get())
    checkIdName(name, lineNumber, fileName);
  
  CSLOmInterface* interface;
  try {
    interface = new CSLOmInterface(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmInterface refInterface(interface);
  interface->m_weakRef= boost::weak_ptr<CSLOmBase>(refInterface);
  interface->setParent(parent);
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refInterface, CSLOmIdentifier::ID_CSL_INTERFACE, name);
  interface->m_scope = CSLOmScope::build(id);
  interface->transformGroup(direction, groupIn);
  interface->m_instantiation = TRUE;//does this interface count as instantiation?

  if (overrideParamMap.get()) {

    if (!overrideParamMap->empty()) {

      CSLOmConnectable::overrideParamList(interface->getAttachedScope(), overrideParamMap);
    }
  }

  return refInterface;
}

 RefCSLOmInterface CSLOmInterface::buildRD(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr width, RefCSLOmExpr depth) {
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isUnitDecl() || 
         parent->isDesign() || 
         parent->isInterface(),
         "invalid parent type");
  ASSERT(name.get(), "null name");
  ASSERT(name->length(), "empty name string");
  
  CSLOmInterface* interface;
  try {
    interface = new CSLOmInterface(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmInterface refInterface(interface);
  interface->m_weakRef= boost::weak_ptr<CSLOmBase>(refInterface);
  interface->setParent(parent);
  //  interface->m_prefix = RefString(new std::string(*name));
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refInterface, CSLOmIdentifier::ID_CSL_INTERFACE, name);
  interface->m_scope = CSLOmScope::build(id);

  RefCSLOmPortDecl rdEn = interface->addPort(lineNumber, fileName, RefString(new std::string("en")), INPUT, SIGNAL_WIRE);
  RefCSLOmPortDecl rdData = interface->addPort(lineNumber, fileName, RefString(new std::string("data")), OUTPUT, SIGNAL_WIRE);
  RefCSLOmPortDecl rdAddr = interface->addPort(lineNumber, fileName, RefString(new std::string("address")), INPUT, SIGNAL_WIRE);

  RefCSLOmNumber evalDepth = CSLOmNumber::cast(depth->doEval(TRUE));

  TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(evalDepth->getValue()))));
  if (evalDepth->getValue() == 1) {
    t = 1;
  }

  RefCSLOmNumber addrWidth = CSLOmNum32::build(lineNumber,fileName, t);
  
  rdData->setWidth(width);
  rdAddr->setWidth(addrWidth);

  return refInterface;
}

 RefCSLOmInterface CSLOmInterface::buildWR(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr width, RefCSLOmExpr depth) {
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isUnitDecl() || 
         parent->isDesign() || 
         parent->isInterface(),
         "invalid parent type");
  ASSERT(name.get(), "null name");
  ASSERT(name->length(), "empty name string");

  CSLOmInterface* interface;
  try {
    interface = new CSLOmInterface(lineNumber,fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmInterface refInterface(interface);
  interface->m_weakRef= boost::weak_ptr<CSLOmBase>(refInterface);
  interface->setParent(parent);
  //  interface->m_prefix = RefString(new std::string(*name));
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refInterface, CSLOmIdentifier::ID_CSL_INTERFACE, name);
  interface->m_scope = CSLOmScope::build(id);

  RefCSLOmPortDecl wrEn = interface->addPort(lineNumber,fileName, RefString(new std::string("en")), INPUT, SIGNAL_WIRE);
  RefCSLOmPortDecl wrData = interface->addPort(lineNumber, fileName, RefString(new std::string("data")), INPUT, SIGNAL_WIRE);
  RefCSLOmPortDecl wrAddr = interface->addPort(lineNumber, fileName, RefString(new std::string("address")), INPUT, SIGNAL_WIRE);

  RefCSLOmNumber evalDepth = CSLOmNumber::cast(depth->doEval(TRUE));

  TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(evalDepth->getValue()))));
  if (evalDepth->getValue() == 1) {
    t = 1;
  }
  RefCSLOmNumber addrWidth = CSLOmNum32::build(lineNumber,fileName, t);
  
  wrData->setWidth(width);
  wrAddr->setWidth(addrWidth);

  return refInterface;
}

RefTVec_RefCSLOmBase CSLOmInterface::getAssignListFull() const {
  RefTVec_RefCSLOmBase assignStmts = getChildrenAsBase(TYPE_STMT);
  RefTVec_RefCSLOmInterface ifcs = getInterfaces();

  if (!assignStmts.get()) { assignStmts = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase()); }
  if (ifcs.get()) {
    for (TVec_RefCSLOmInterface::iterator it = ifcs->begin(); it < ifcs->end(); it++) {
      RefTVec_RefCSLOmBase temp = (*it)->getAssignListFull();
      for (TVec_RefCSLOmBase::iterator iter = temp->begin(); iter < temp->end(); iter++) {
        assignStmts->push_back(*iter);
      }
    }
  }
  
  return assignStmts;
}

RefCSLOmPortDecl CSLOmInterface::addPort(TLineNumberType lineNumber,RefString fileName, const RefString& name, ECSLOmPortDirection direction, ECSLOmSignalType type, RefCSLOmExpr bitRange) {
  RefCSLOmPortDecl auxPort = CSLOmPortDecl::build(lineNumber,fileName, getThis(), name, direction, type);
  if(bitRange.get()) {
    auxPort->setBitRange(bitRange);
  }
  return auxPort;
}

RefCSLOmPortDecl CSLOmInterface::addPort(TLineNumberType lineNumber,RefString fileName, const RefString& name, ECSLOmPortDirection direction, ECSLOmSignalType type,ECSLOmSignalAttr attr, RefCSLOmExpr bitRange) {
  RefCSLOmPortDecl auxPort = CSLOmPortDecl::build(lineNumber,fileName, getThis(), name, direction, type);
  if(bitRange.get()) {
    auxPort->setBitRange(bitRange);
  }
  auxPort->setAttr(attr);
  return auxPort;
}

void CSLOmInterface::addPortList(TLineNumberType lineNumber,RefString fileName, RefCSLOmList name, ECSLOmPortDirection direction, ECSLOmSignalType type, RefCSLOmExpr bitRange) {
  ASSERT(name.get(), "The input name is null");
  RefTVec_RefCSLOmBase objs = name->getObjects();
  TVec_RefCSLOmBase_const_iter it;
  if(objs.get()) {
    switch(name->getListType()) {
      case TYPE_ALL_TYPES:
        for( it = objs->begin(); it < objs->end(); ++it) {
          RefCSLOmExprLink exprLink = CSLOmExprLink::cast(*it);
          //ASSERT((*it)->getType() == TYPE_EXPR 
          //&& CSLOmExpr::cast(*it)->getExprType() == CSLOmExpr::EXPR_HID 
          //&& !CSLOmExprLink::cast(*it)->isHID()
          ASSERT(!exprLink->isHID(),"check bug detected");
          RefCSLOmPortDecl auxPort = CSLOmPortDecl::build(lineNumber,fileName, getThis(), /*CSLOmExprLink::cast(*it)*/exprLink->getName(), direction, type);
          if(bitRange.get()) {
            auxPort->setBitRange(bitRange);
          }
        }
        break;
      case TYPE_CONNECTABLE:
        for( it = objs->begin(); it < objs->end(); ++it) {
          if (CSLOmConnectable::cast(*it)->cIsSignal()) {
            ASSERT( CSLOmConnectable::cast(*it)->cIsSignal(), "The type of the object must be of type signal" );
            RefCSLOmPortDecl auxPort = CSLOmPortDecl::build(
                                                            lineNumber,
                                                            fileName,
                                                            getThis(), 
                                                            CSLOmSignal::cast(*it)->getName(), 
                                                            direction,
                                                            CSLOmSignal::cast(*it)->getSignalType()
                                                            );
            if(CSLOmSignal::cast(*it)->getBitRange().get()) {
              auxPort->setBitRange(CSLOmSignal::cast(*it)->getBitRange());
            }
            else if(bitRange.get()) {
              auxPort->setBitRange(bitRange);
            }
          }
          else  if (CSLOmConnectable::cast(*it)->cIsPort()) {
            ASSERT( CSLOmConnectable::cast(*it)->cIsPort(), "The type of the object must be of type port" );
            RefCSLOmPortDecl auxPort = CSLOmPortDecl::build(
                                                            lineNumber,
                                                            fileName,
                                                            getThis(), 
                                                            CSLOmPortDecl::cast(*it)->getName(), 
                                                            direction,
                                                            CSLOmPortDecl::cast(*it)->getPortType()
                                                            );
            if(CSLOmPortDecl::cast(*it)->getBitRange().get()) {
              auxPort->setBitRange(CSLOmPortDecl::cast(*it)->getBitRange());
            }
            else if(bitRange.get()) {
              auxPort->setBitRange(bitRange);
            }
          }
        }
        break;
      default: {
        args.push_back(*name->getID()->getName());
        addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_ID_NAME_EXISTS, args, bitRange->getLineNumber(), fileName);
        cslomHasErrors = TRUE;
        //throw NSBase::IllegalStateException("[CSLOmInterface::addPortList] Names already exist");
      }
    }
  }
}

void CSLOmInterface::reverse() {
  RefTVec_RefCSLOmPortDecl interfacePorts = getPorts();
  if (interfacePorts.get()) {
    TVec_RefCSLOmPortDecl::iterator it;
    for (it = interfacePorts->begin(); it < interfacePorts->end();it++) {
      (*it)->reverse();
    }
  }

  RefTVec_RefCSLOmInterface interfaces = getInterfaces();
  if (interfaces.get()) {
    TVec_RefCSLOmInterface::iterator itifc;
    for (itifc = interfaces->begin(); itifc < interfaces->end();itifc++) {
      (*itifc)->reverse();
    }
  }
  m_isReversed = TRUE;
}

void CSLOmInterface::removePort(RefCSLOmPortDecl port) {
  TRACE_ME(1, "CSLOmInterface::removePort(RefCSLOmPortDecl port)");
  ASSERT(port.get(), "Null input port");
  // TODO ... this test shouldn't be like this
  //  ASSERT(port->getParent() == m_weakRef.lock(), "This port is not in this interface");
  ASSERT(containsPort(port), "This port was already removed from the interface, or was never registered and something very stange happened");
  ASSERT(getParent()->isDesign(), "The remove operation can't be performed on an interface which is not global");
  removeChild(port);
}

RefTVec_RefCSLOmPortDecl CSLOmInterface::getPorts() const {
  return getChildren<CSLOmPortDecl>(TYPE_ALL_PORTS);
}

RefTVec_RefCSLOmBase CSLOmInterface::getPortsAsBase() const {
  return getChildrenAsBase(TYPE_ALL_PORTS);
}

RefTVec_RefCSLOmInterface CSLOmInterface::getInterfaces() const {
  return getChildren<CSLOmInterface>(TYPE_ALL_INTERFACES);
}

RefTVec_RefCSLOmBase CSLOmInterface::getInterfacesAsBase() const {
  return getChildrenAsBase(TYPE_ALL_INTERFACES);
}


RefCSLOmScope CSLOmInterface::getAttachedScope() const {
  return m_scope;
}

RefCSLOmNumber CSLOmInterface::getWidth() const {
  RefTVec_RefCSLOmPortDecl ports = getAllPorts();

  TUInt width = 0;
  for (TVec_RefCSLOmPortDecl::iterator it = ports->begin(); it < ports->end(); it++) {
    width += CSLOmNumber::cast((*it)->getWidth()->doEval())->getValue(); 
  }

  return CSLOmNum32::build(m_lineNumber,m_fileName, width);
}

// RefCSLOmList CSLOmInterface::getInputs() const {
// }
//todo
// RefCSLOmList CSLOmInterface::getOutputs() const {
// }

TBool CSLOmInterface::containsPort(const RefCSLOmPortDecl& port) const {
  TRACE_ME(1, "CSLOmInterface::containsPort(const RefCSLOmPortDecl& port) const ");
  RefTVec_RefCSLOmPortDecl ports = getPorts();
  for(TVec_RefCSLOmPortDecl_const_iter it = ports->begin(); it < ports->end(); ++it)
    if(port == *it)
      return TRUE;
  return FALSE;
}

void CSLOmInterface::setPrefix(const RefString& prefix) {
  m_prefix = prefix;
  m_hasPrefix = TRUE;
}

const RefString CSLOmInterface::getPrefix() const {
  return (!m_noPrefix) ? m_prefix : RefString(new std::string);
}

void CSLOmInterface::setSuffix(const RefString& suffix) {
  m_suffix = suffix;
}

const RefString CSLOmInterface::getSuffix() const {
  return m_suffix;
}


RefCSLOmParameter  CSLOmInterface::addParameter(TLineNumberType lineNumber, RefString fileName, RefCSLOmParameter oldParam, RefCSLOmNumber value) {
  ASSERT(oldParam.get(), "NULL param" );
  
  return CSLOmParameter::build(lineNumber, fileName, getThis(), oldParam, value);
}


RefTVec_RefCSLOmBase CSLOmInterface::getParameters() {
  
  return getChildrenAsBase(TYPE_PARAMETER);
}


const RefString CSLOmInterface::getInterfaceName() const {
  RefCSLOmBase idAsBase = getChild(ID);
  RefCSLOmIdentifier id = CSLOmIdentifier::cast(idAsBase);
  return id->getName();//CSLOmIdentifier::cast(getChild(0))->getName();
}

const RefString CSLOmInterface::getInterfaceClassName() const {
  return m_className;
}

void CSLOmInterface::setInterfaceClassName(RefString name) {
  m_className = name;
}

TBool CSLOmInterface::isInstantiation() const { return m_instantiation; }


void CSLOmInterface::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmPortDecl class
// ********************************************************************************
 CSLOmPortDecl::CSLOmPortDecl(TLineNumberType lineNumber,RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType) : 
   CSLOmConnectable (CSLOmConnectable::TYPE_DECL_PORT, lineNumber,fileName), 
  m_portDirection(portType), 
  m_signalType(signalType), 
  m_isSigned(FALSE),
  m_isReversed(FALSE),
  m_portAttr(ATTR_UNDEFINED){}

RefCSLOmPortDecl CSLOmPortDecl::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmPortDecl();
  }
  else {
    RefCSLOmConnectable connectableObject = CSLOmConnectable::cast(object);
    ASSERT(connectableObject->cIsPort() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmPortDecl>(connectableObject);
  }
}

 RefCSLOmPortDecl CSLOmPortDecl::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection portDirection, ECSLOmSignalType signalType) {
   checkIdName(name, lineNumber,fileName);
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isDesign() || parent->isInterface(), "invalid parent type, should be interface");
  ASSERT( !(signalType == SIGNAL_REG && (portDirection == INPUT || portDirection == INOUT) ), "an input or inout port can't be of type reg" );

  CSLOmPortDecl* portDecl;
  try {
    portDecl = new CSLOmPortDecl(lineNumber,fileName, portDirection, signalType);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmPortDecl refPortDecl = RefCSLOmPortDecl(portDecl);
  portDecl->m_weakRef = boost::weak_ptr<CSLOmBase>( refPortDecl);
  portDecl->setParent(parent);
  CSLOmIdentifier::build(lineNumber,fileName, refPortDecl, CSLOmIdentifier::ID_CSL_PORT, name);
  CSLOmSimpleBitRange::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")));

  return refPortDecl;
}

 RefCSLOmPortDecl CSLOmPortDecl::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection portDirection, RefCSLOmExpr expr) {
   checkIdName(name, lineNumber, fileName);
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isDesign() || parent->isInterface(), "invalid parent type, should be interface");
//   if(expr.get()) {
//     RefCSLOmBase eval = expr->doEval(TRUE);
//     if (eval.get() && eval->isNumber() && CSLOmNumber::cast(eval)->getValue() <= 0 ) {
//       args.push_back(PORT_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmPortDecl();
//     }
//     else if (!eval.get() || (!eval->isBitRange() && !eval->isPort() && !eval->isNumber())) {
//       args.push_back(PORT_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmPortDecl();
//     }
//   }

  CSLOmPortDecl* portDecl;
  try {
    portDecl = new CSLOmPortDecl(lineNumber,fileName, portDirection, SIGNAL_WIRE);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmPortDecl refPortDecl = RefCSLOmPortDecl(portDecl);
  portDecl->m_weakRef = boost::weak_ptr<CSLOmBase>( refPortDecl);
  portDecl->setParent(parent);
  CSLOmIdentifier::build(lineNumber,fileName, refPortDecl, CSLOmIdentifier::ID_CSL_PORT, name);

  if(expr.get() && expr->isExprLink()) {
    RefCSLOmBase eval = expr->doEval(TRUE);
    if (!eval.get()) {
      args.push_back(PORT_CONSTRUCT_BR);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmPortDecl();
    }
//     if (!eval.get() || (!eval->isBitRange() && !eval->isNumber())) {
//       args.push_back(PORT_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmPortDecl();
//     }
//     if (eval->isNumber() && CSLOmNumber::cast(eval)->getValue() == ZERO) {
//       args.push_back(PORT_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmPortDecl();
//     }
    if (eval->isSimpleBitRange() || eval->isNumber() || eval->isParameter()) {
      CSLOmSimpleBitRange::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")), expr);
    }
    else {
      CSLOmMultiDimBitRange::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")), expr);
    }
  }
  else {
    CSLOmSimpleBitRange::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")), expr);
  }

  return refPortDecl;
}

 RefCSLOmPortDecl CSLOmPortDecl::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, ECSLOmPortDirection portDirection, RefCSLOmExpr expr1, RefCSLOmExpr expr2) {
   checkIdName(name, lineNumber, fileName);
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isDesign() || parent->isInterface(), "invalid parent type, should be interface");
  ASSERT(expr1.get(), "this should not be null");
  ASSERT(expr2.get(), "this should not be null");

//   RefCSLOmBase eval1 = expr1->doEval(TRUE);
//   if (!eval1.get() || (eval1.get() && !eval1->isNumber())) {
//     args.push_back(PORT_CONSTRUCT);
//     addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//     cslomHasErrors = TRUE;
//     return RefCSLOmPortDecl();
//   }

//   RefCSLOmBase eval2 = expr2->doEval(TRUE);
//   if (!eval2.get() || (eval2.get() && !eval2->isNumber())) {
//     args.push_back(PORT_CONSTRUCT);
//     addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//     cslomHasErrors = TRUE;
//     return RefCSLOmPortDecl();
//   }

  CSLOmPortDecl* portDecl;
  try {
    portDecl = new CSLOmPortDecl(lineNumber,fileName, portDirection, SIGNAL_WIRE);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmPortDecl refPortDecl = RefCSLOmPortDecl(portDecl);
  portDecl->m_weakRef = boost::weak_ptr<CSLOmBase>( refPortDecl);
  portDecl->setParent(parent);
  CSLOmIdentifier::build(lineNumber,fileName, refPortDecl, CSLOmIdentifier::ID_CSL_PORT, name);

  CSLOmSimpleBitRange::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")), expr1, expr2);

  return refPortDecl;
}


 RefCSLOmPortDecl CSLOmPortDecl::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExprLink portName) {
   checkIdName(name, lineNumber, fileName);
  ASSERT(parent.get(), "null parent");
  ASSERT(parent->isDesign() || parent->isInterface(), "invalid parent type, should be interface");

  RefCSLOmBase port = portName->doEval();
  if(!port.get()){
    args.push_back(PORT_CONSTRUCT_CP);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmPortDecl();
  }
  if (!port->isPort()) {
    args.push_back(PORT_CONSTRUCT_CP);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmPortDecl();
  }

  ECSLOmPortDirection portDirection = CSLOmPortDecl::cast(port)->getPortDirection();
  ECSLOmSignalType signalType = CSLOmPortDecl::cast(port)->getPortType();
  ASSERT( !(signalType == SIGNAL_REG && (portDirection == INPUT || portDirection == INOUT) ), "an input or inout port can't be of type reg" );
  CSLOmPortDecl* portDecl;
  try {
    portDecl = new CSLOmPortDecl(lineNumber,fileName, portDirection, signalType);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmPortDecl refPortDecl = RefCSLOmPortDecl(portDecl);
  portDecl->m_weakRef = boost::weak_ptr<CSLOmBase>( refPortDecl);
  portDecl->setParent(parent);
  CSLOmIdentifier::build(lineNumber,fileName, refPortDecl, CSLOmIdentifier::ID_CSL_PORT, name);
  if (CSLOmPortDecl::cast(port)->getBitRange()->isMultiDimBitRange()) {
    CSLOmMultiDimBitRange::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")), CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(port)->getBitRange()));
  }
  else if (CSLOmPortDecl::cast(port)->getBitRange()->isSimpleBitRange()) {
    CSLOmSimpleBitRange::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")), CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(port)->getBitRange()));
  }
  else if (CSLOmPortDecl::cast(port)->getBitRange()->isField()) {
    CSLOmField::build(lineNumber,fileName, refPortDecl, RefString(new std::string("")), CSLOmField::cast(CSLOmPortDecl::cast(port)->getBitRange()));
  }


  return refPortDecl;
}

ECSLOmPortDirection CSLOmPortDecl::getPortDirection() const {
  return m_portDirection;
}

ECSLOmSignalType CSLOmPortDecl::getPortType() const {
  return m_signalType;
}

void CSLOmPortDecl::setPortDirection(ECSLOmPortDirection portDir) {
  m_portDirection = portDir;
}

void CSLOmPortDecl::setPortType(ECSLOmSignalType portType) {
  m_signalType = portType;
}


void CSLOmPortDecl::setSigned() {
  if(m_signalType != SIGNAL_UNDEFINED && (m_signalType == SIGNAL_VAR_INTEGER || m_signalType == SIGNAL_VAR_TIME)) { // sign is not supported for var integer and var time
    args.push_back("port");
    args.push_back("sign supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber(), getThis()->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::setSigned()] illegal state for this method call.", m_lineNumber);
  }

  m_isSigned = TRUE;
}

TBool CSLOmPortDecl::isSigned() const {
  if(m_signalType != SIGNAL_UNDEFINED && (m_signalType == SIGNAL_VAR_INTEGER || m_signalType == SIGNAL_VAR_TIME)) { // sign is not supported for var integer and var time
    args.push_back("port");
    args.push_back("sign supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber(), getThis()->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::isSigned()] illegal state for this method call.", m_lineNumber);
  }

  return m_isSigned;
}

void CSLOmPortDecl::setBitRange(RefCSLOmExpr bitRange) {
  ASSERT(bitRange.get(), "null bitRange received");
  if(m_signalType != SIGNAL_UNDEFINED && (m_signalType == SIGNAL_VAR_INTEGER || m_signalType == SIGNAL_VAR_TIME)) { // range is not supported for var integer and var time
    args.push_back("port");
    args.push_back("range supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, bitRange->getLineNumber(), bitRange->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  RefCSLOmBaseRange portBitRange = getBitRange();
  if (bitRange->doEval()->isMultiDimBitRange()) {
    removeChild(getChild(SIGNAL_BR));
    CSLOmMultiDimBitRange::build(m_lineNumber,m_fileName, getThis(), RefString(new std::string("")), CSLOmMultiDimBitRange::cast(bitRange->doEval()));
  }
  else if (bitRange->doEval()->isField()) {
    removeChild(getChild(SIGNAL_BR));
    CSLOmField::build(m_lineNumber,m_fileName, getThis(), RefString(new std::string("")), CSLOmField::cast(bitRange->doEval()));
  }
  else {
    CSLOmSimpleBitRange::cast(portBitRange)->setBitRange(bitRange);
  }
}

void CSLOmPortDecl::setBitRange(RefCSLOmBaseRange bitRange) {
  ASSERT(bitRange.get(), "null bitRange received");
  if(m_signalType != SIGNAL_UNDEFINED && (m_signalType == SIGNAL_VAR_INTEGER || m_signalType == SIGNAL_VAR_TIME)) { // range is not supported for var integer and var time
    args.push_back("port");
    args.push_back("range supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, bitRange->getLineNumber(), bitRange->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  RefCSLOmBaseRange portBitRange = getBitRange();
  if (bitRange->isMultiDimBitRange()) {
    removeChild(getChild(SIGNAL_BR));
    CSLOmMultiDimBitRange::build(m_lineNumber,m_fileName, getThis(), RefString(new std::string("")), CSLOmMultiDimBitRange::cast(bitRange));
  }
  else if (bitRange->isField()) {
    removeChild(getChild(SIGNAL_BR));
    CSLOmField::build(m_lineNumber,m_fileName, getThis(), RefString(new std::string("")), CSLOmField::cast(bitRange));
  }
  else {
    CSLOmSimpleBitRange::cast(portBitRange)->setBitRange(CSLOmSimpleBitRange::cast(bitRange));
  }
}

void CSLOmPortDecl::setWidth(RefCSLOmExpr width) {
  ASSERT(width.get(), "null width received");
  if(m_signalType != SIGNAL_UNDEFINED && (m_signalType == SIGNAL_VAR_INTEGER || m_signalType == SIGNAL_VAR_TIME)) { // range is not supported for var integer and var time
    args.push_back("port");
    args.push_back("range supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, width->getLineNumber(), width->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  if((getBitRange()).get()) {
    RefCSLOmBaseRange portBitRange = getBitRange();
    CSLOmSimpleBitRange::cast(portBitRange)->setWidth(width);
  }
  else {
    RefCSLOmSimpleBitRange portBitRange = CSLOmSimpleBitRange::build(m_lineNumber,m_fileName, getThis(), RefString(new std::string("")), width);
  }
}

void CSLOmPortDecl::setOffset(RefCSLOmExpr offset) {
  ASSERT(offset.get(), "null offset received");
  if(m_signalType != SIGNAL_UNDEFINED && (m_signalType == SIGNAL_VAR_INTEGER || m_signalType == SIGNAL_VAR_TIME)) { // range is not supported for var integer and var time
    args.push_back("port");
    args.push_back("range supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, offset->getLineNumber(), offset->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  ASSERT(getBitRange().get(), "this should exist");

  RefCSLOmBaseRange portBitRange = getBitRange();
  CSLOmSimpleBitRange::cast(portBitRange)->setOffset(offset);
}

const RefCSLOmExpr CSLOmPortDecl::getOffset() const {
  return (CSLOmSimpleBitRange::cast(getChild(PORT_BR)))->getOffset();
}

void CSLOmPortDecl::setRange(RefCSLOmExpr lowerIndex, RefCSLOmExpr upperIndex) {
  ASSERT(lowerIndex.get(), "null lowerIndex received");
  ASSERT(upperIndex.get(), "null upperIndex received");
  if(m_signalType != SIGNAL_UNDEFINED && (m_signalType == SIGNAL_VAR_INTEGER || m_signalType == SIGNAL_VAR_TIME)) { // range is not supported for var integer and var time
    args.push_back("port");
    args.push_back("range supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lowerIndex->getLineNumber(), lowerIndex->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  ASSERT((getBitRange()).get(), "BitRange should exist");
  ASSERT(getBitRange()->isSimpleBitRange(), "this should be a simple BitRange");
  if(!CSLOmSimpleBitRange::cast(getBitRange())->isDefault()) {
    args.push_back(*getName());
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lowerIndex->getLineNumber(), lowerIndex->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmPortDecl::setRange()] range already set.", m_lineNumber);
  }
  CSLOmSimpleBitRange::cast(getBitRange())->setRange(lowerIndex, upperIndex);
}

RefCSLOmBaseRange CSLOmPortDecl::getBitRange() const {
  if ((getChild(PORT_BR)).get()) {
    return CSLOmBaseRange::cast(getChild(PORT_BR));
  }
  else {
    return RefCSLOmBaseRange();
  }
}

const RefCSLOmBase CSLOmPortDecl::getBitRangeAsBase() const {
  if ((getChild(PORT_BR)).get()) {
    return getChild(PORT_BR);
  }
  else {
    return RefCSLOmBase();
  }
}

RefCSLOmExpr CSLOmPortDecl::getWidth() const {
  return CSLOmSimpleBitRange::cast(getBitRange())->getWidth();
}

void CSLOmPortDecl::reverse() {
  if (m_portDirection == INPUT) {
    m_portDirection = OUTPUT;
  }
  else if (m_portDirection == OUTPUT) {
    if (m_signalType == SIGNAL_REG) {
      m_signalType = SIGNAL_WIRE;
    }
    m_portDirection = INPUT;
  }
  m_isReversed = TRUE;
}

void CSLOmPortDecl::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

}
