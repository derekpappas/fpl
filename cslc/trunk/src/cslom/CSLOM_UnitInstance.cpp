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
// CSLOmParameter class
// ********************************************************************************
/*
CSLOmParameter::CSLOmParameter(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmBase(TYPE_PARAMETER, lineNumber, fileName) { }

RefCSLOmParameter CSLOmParameter::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmParameter();
  }
  else {
    ASSERT(object->isParameter() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmParameter>(object);
  }
}

RefCSLOmParameter CSLOmParameter::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString &name, RefCSLOmExpr defaultValue) {
  ASSERT(parent.get(), "Null parent recieved");
  if (!parent->isUnitDecl()) {
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL_PARENT, args, lineNumber);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException("Parameter::build - parent should be a Unit Declaration");
  }
  CSLOmParameter *parameter;
  try {
    parameter = new CSLOmParameter(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmParameter refParameter(parameter);
  parameter->m_weakRef = boost::weak_ptr<CSLOmBase>( refParameter);

  parameter->setParent(parent);
  CSLOmIdentifier::build(lineNumber, fileName, refParameter, CSLOmIdentifier::ID_PARAMETER, name);

  if(defaultValue.get()) {
    defaultValue->setParent(refParameter);
  }

  return refParameter;
}

RefCSLOmExpr CSLOmParameter::getDefaultValue() const {
  ASSERT(getChildrenVec()->size(), "Error, no children in this class");
  if(getChildrenVec()->size() == 2) {
    RefCSLOmBase exprAsBase = getChild(DEFAULT_VALUE);
    //ASSERT(exprAsBase->getType() == TYPE_EXPR, "Invalid child, expecting an expresison"); this assert is performed in the CSLOmExpr::cast() function
    RefCSLOmExpr expr = CSLOmExpr::cast(exprAsBase);
    return expr;//boost::static_pointer_cast<CSLOmExpr>(getChild(1));
  }
  return RefCSLOmExpr();
}

RefCSLOmBase CSLOmParameter::getDefaultValueAsBase() const {
  ASSERT(getChildrenVec()->size(), "Error, no children in this class");
  if(getChildrenVec()->size() == 2) {
    RefCSLOmBase exprAsBase = getChild(DEFAULT_VALUE);
    return exprAsBase;
  }
  return RefCSLOmBase();
}

const RefString CSLOmParameter::getParamName() const {
  ASSERT(getChildrenVec()->size(), "Error, no children in this class");
  RefCSLOmIdentifier id = getID();
  return id->getName();//boost::static_pointer_cast<CSLOmIdentifier>(getChild(0))->getName();
}

void CSLOmParameter::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmParameterOverride class
// ********************************************************************************
CSLOmParameterOverride::CSLOmParameterOverride(TLineNumberType lineNumber, RefString fileName, const RefString& paramName) 
  : CSLOmBase(TYPE_PARAMETER_OVERRIDE, lineNumber, fileName), 
    m_paramName(RefString(new std::string(*paramName))) { }

RefCSLOmParameterOverride CSLOmParameterOverride::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmParameterOverride();
  }
  else {
    ASSERT(object->isParameterOverride() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmParameterOverride>(object);
  }
}

RefCSLOmParameterOverride CSLOmParameterOverride::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink paramName, RefCSLOmNumber value) {
  ASSERT(parent.get(), "null parent");
  if (!parent->isInstance()) {
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL_PARENT1, args, lineNumber);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException("ParamOverride::build parent should be an instance");
  }
  ASSERT(paramName.get(), "Null param name");
  ASSERT(value.get(), "Null value");
  ASSERT(paramName->isResolved(), "param name must be resolved");
  ASSERT(paramName->toID().get(), "null identifier");
  ASSERT(paramName->toID()->getParent().get(), "Null id parent");
  ASSERT(paramName->toID()->getParent()->isParameter(), "The type of the object must be parameter");
  ASSERT(paramName->toID()->getParent()->getParent().get(), "Null parameter parent");
  //ASSERT(paramName->toID()->getParent()->getParent()->isUnitDecl(), "The type of the parent of the parameter must be a unit decl");
  //ASSERT(paramName->toID()->getParent()->getParent() == parent, "This is not the correct unit decl");
  ASSERT(paramName->toID()->getName().get(),"Bug detected: null id name");
  
  CSLOmParameterOverride *paramOverride;
  try {
    paramOverride = new CSLOmParameterOverride(lineNumber, fileName, paramName->toID()->getName());
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmParameterOverride refParamOverride(paramOverride);
  paramOverride->m_weakRef = boost::weak_ptr<CSLOmBase>( refParamOverride);
  paramOverride->setParent(parent);
  value->setParent(refParamOverride);

  return refParamOverride;
}

const RefString CSLOmParameterOverride::getParamName() const {
  ASSERT(m_paramName.get(), "null name");
  return m_paramName;
}

RefCSLOmNumber CSLOmParameterOverride::getValue() const {
  ASSERT(getChildrenVec().get(), "Bug detected: no children");
  ASSERT(getChildrenVec()->size() == 1, "This object has to have only one child");
  ASSERT(getChild(OVERRIDE_VALUE)->isExpr(), "The type of the child must be EXPR");
  RefCSLOmBase numberAsBase = getChild(OVERRIDE_VALUE);
  //ASSERT(boost::static_pointer_cast<CSLOmExpr>(getChild(0))->getExprType() == CSLOmExpr::EXPR_NUMBER, "The type of the expression must be number");
  RefCSLOmNumber number = CSLOmNumber::cast(numberAsBase);
  return number;//boost::static_pointer_cast<CSLOmNumber>(getChild(0));
}

RefCSLOmBase CSLOmParameterOverride::getValueAsBase() const {
  ASSERT(getChildrenVec().get(), "Bug detected: no children");
  ASSERT(getChildrenVec()->size() == 1, "This object has to have only one child");
  ASSERT(getChild(OVERRIDE_VALUE)->isExpr(), "The type of the child must be EXPR");
  RefCSLOmBase numberAsBase = getChild(OVERRIDE_VALUE);
  return numberAsBase;
}

void CSLOmParameterOverride::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}
*/

// ********************************************************************************
// CSLOmUnitInstance class
// ********************************************************************************
CSLOmUnitInstance::CSLOmUnitInstance(TLineNumberType lineNumber, RefString fileName):
  CSLOmBase(TYPE_INST_UNIT,lineNumber, fileName), 
  m_explicitPortNameMap(), 
  //  m_parameterOverrideMap(),
  m_connections(new TMap_RefCSLOmExprLink_RefCSLOmExpr) { }

RefCSLOmUnitInstance CSLOmUnitInstance::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmUnitInstance();
  }
  else {
    ASSERT(object->isInstance() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmUnitInstance>(object);
  }
}

/**
 * This is the csl_unit_instance build method. According to csl_unit_instance specification we create a 
 * generic instance that becomes specific as we perform commands on the instance
 */
RefCSLOmUnitInstance CSLOmUnitInstance::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& instName/*, RefCSLOmBitRange bitRange*/){
  ASSERT(parent.get(), "null parent param received");
  if (!parent->isUnitInstantiation()) {
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL_PARENT1, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException("ParamOverride::build parent should be an instance");
  }
  if (instName.get())
    checkIdName(instName,lineNumber, fileName);

  CSLOmUnitInstance* unitInst;
  try {
    unitInst = new CSLOmUnitInstance(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmUnitInstance refUnitInst(unitInst);
  unitInst->m_weakRef = boost::weak_ptr<CSLOmBase>( refUnitInst);
  unitInst->setParent(parent);
  if (instName.get()) {
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName,refUnitInst,CSLOmIdentifier::ID_UNIT_INST,instName/*,bitRange*/);
  }
  unitInst->getUnitDecl()->registerInstance(refUnitInst);
  return refUnitInst;
}

void CSLOmUnitInstance::addConnectionPair(RefCSLOmExpr fromUnit, RefCSLOmExprLink fromInstance) {
  ASSERT(fromInstance.get(), "null object");
//   ASSERT(fromInstance->isResolved(), "el should have been resolved");
  if (m_connections->find(fromInstance) != m_connections->end()) {
    args.push_back(*(fromInstance->getName()));
    args.push_back(*CSLOmIdentifier::cast(getChild(ID))->getName());
    addErr(NSWarningErr::DEE_CSA_PORT_MULTIPLE_CONNECTION_FOUND, args, getLineNumber(), getFileName());
    cslomHasErrors = TRUE;
  }
  else {
    m_connections->insert(std::make_pair(fromInstance, fromUnit));
  }
}
/*
void CSLOmUnitInstance::paramOverride(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink paramName, RefCSLOmNumber value) {
  ASSERT(paramName.get(), "Null param name");
  ASSERT(value.get(), "Null value");
  ASSERT(paramName->isResolved(), "param name must be resolved");
  ASSERT(paramName->toID().get(), "null identifier");
  ASSERT(paramName->toID()->getParent().get(), "Null id parent");
  ASSERT(paramName->toID()->getParent()->isParameter(), "The type of the object must be parameter");
  ASSERT(paramName->toID()->getParent()->getParent().get(), "Null parameter parent");
  ASSERT(paramName->toID()->getParent()->getParent()->isUnitDecl(), "The parent of the parameter is not an ID");
  ASSERT(paramName->toID()->getParent()->getParent() == getUnitDecl(), "This is not the corrent unit decl");
  RefString paramNameString = RefString(new std::string(*paramName->toID()->getName()));
  if(m_parameterOverrideMap.get()) {
    std::pair<TMap_RefString_RefCSLOmNumber::iterator, bool> p = m_parameterOverrideMap->insert(make_pair(paramNameString, value));
    ASSERT(p.second, "Parameter already overridden");
  }
  else {
    m_parameterOverrideMap = RefTMap_RefString_RefCSLOmNumber(new TMap_RefString_RefCSLOmNumber());
    m_parameterOverrideMap->insert(make_pair(paramNameString, value));
  }
  CSLOmParameterOverride::build(lineNumber, fileName, getThis(), paramName, value);
}
*/
void CSLOmUnitInstance::addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, RefCSLOmExprLink bitRange) {
  checkIdName(signalName, lineNumber, fileName);
  RefCSLOmUnitDecl unitDecl = getUnitDecl();
  ASSERT(unitDecl.get(), "Null unit Decl");
  ASSERT(unitDecl->getAlterationBit(), "Alteration bit for the unit decl must be set to true");
  
  RefCSLOmSignal sig = CSLOmSignal::build(m_lineNumber, m_fileName, unitDecl, signalName, SIGNAL_WIRE, bitRange);
}

void CSLOmUnitInstance::addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, ECSLOmSignalType signalType ) {
  checkIdName(signalName, lineNumber, fileName);
  RefCSLOmUnitDecl unitDecl = getUnitDecl();
  ASSERT(unitDecl.get(), "Null unit Decl");
  ASSERT(unitDecl->getAlterationBit(), "Alteration bit for the unit decl must be set to true");
  RefCSLOmSignal sig = CSLOmSignal::build(m_lineNumber, m_fileName, unitDecl, signalName, signalType, RefCSLOmExpr());
}

void CSLOmUnitInstance::addPort(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, const RefString& portName, RefCSLOmExprLink bitRange) {
  RefCSLOmUnitDecl unitDecl = getUnitDecl();
  ASSERT(unitDecl.get(), "Null unit Decl");
  ASSERT(unitDecl->getAlterationBit(), "Alteration bit for the unit decl must be set to true");
  unitDecl->addPort(lineNumber, fileName, portType, signalType, portName, bitRange);
}

void CSLOmUnitInstance::addPortList(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, RefCSLOmList name, RefCSLOmExprLink bitRange) {
  RefCSLOmUnitDecl unitDecl = getUnitDecl();
  ASSERT(unitDecl.get(), "Null unit Decl");
  ASSERT(unitDecl->getAlterationBit(), "Alteration bit for the unit decl must be set to true");
  unitDecl->addPortList(lineNumber, fileName, portType, signalType, name, bitRange);
}

RefCSLOmUnitDecl CSLOmUnitInstance::getUnitDecl() const {
  ASSERT(getParent().get(), "The parent of this unit instance is null");
  ASSERT(getParent()->isUnitInstantiation(), "The type of the parent of this class must be of CSLOmUnitInstantiation");
  return CSLOmUnitInstantiation::cast(getParent())->getUnitDecl();
}

void CSLOmUnitInstance::addPortConnection (RefCSLOmExprLink instancePort, RefCSLOmExprLink unitPort) {
  ASSERT(instancePort.get(), "instance port should not be null, error should allready be given");
  
  if (unitPort.get()) {
    RefCSLOmIdentifier id1 = unitPort->getLocalNameID();
    if (!id1.get() || (id1.get() && !id1->getParent()->isPort())) {
      args.push_back(std::string("port " + *unitPort->getName()).c_str());
      addErr(NSWarningErr::CSE_CSB_MINS_MINS_UNIT_NOT_EXIST_CSBCS, args, unitPort->getLineNumber(), unitPort->getFileName());
      cslomHasErrors = TRUE;
      //throw NSBase::IllegalArgumentException("unit port does not exist");
    }
  }

  RefCSLOmUnitDecl instanceType = getUnitDecl();
  CSLOmScopeBlock::enterScope(instanceType->getAttachedScope());
  RefCSLOmIdentifier id2 = instancePort->getLocalNameID();
  if (!id2.get() || (id2.get() && !id2->getParent()->isPort())) {
    args.push_back(std::string("port " + *instancePort->getName()).c_str());
    addErr(NSWarningErr::VEE_CSC_MINS_UNDEFINED_INSTANCE_CSCVE, args, unitPort->getLineNumber(), unitPort->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException("instance port does not exist");
  }
  CSLOmScopeBlock::exitScope();
  // ../cslom/CSLOM_Declarations.h:typedef std::pair<RefCSLOmExprLink, RefCSLOmExprLink>    TPair_RefCSLOmExprLink_RefCSLOmExprLink;
  m_explicitPortNameMap->insert(TPair_RefCSLOmExprLink_RefCSLOmExprLink(instancePort, unitPort));
}


void CSLOmUnitInstance::copyParametersFromDeclToInst() {
  ASSERT(getUnitDecl().get(), "bug found : unitDecl is null");
  
  RefCSLOmUnitDecl unitDecl = getUnitDecl();
  RefTVec_RefCSLOmBase paramVec = unitDecl->getChildrenAsBase(TYPE_PARAMETER);

  if (paramVec.get()) {
    
    for (TVec_RefCSLOmBase::iterator it = paramVec->begin(); it != paramVec->end(); ++it) {
      
      addParameter(getLineNumber(), getFileName(), CSLOmParameter::cast(*it)->getParamAsLink());
      CSLOmParameter::cast(*it)->registerUnitInstance(getThis());
    }
  }
}


RefCSLOmParameter CSLOmUnitInstance::addParameter(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink paramLink, RefCSLOmNumber value) {
  ASSERT(paramLink.get(), "null exprLink received");

  return CSLOmParameter::build(lineNumber, fileName, getThis(), paramLink, value);
}



RefTVec_RefCSLOmBase CSLOmUnitInstance::getParameters() const {
  ASSERT(getChildrenVec().get(), "parameter has no children");

  return getChildrenAsBase(TYPE_PARAMETER);
}


TBool CSLOmUnitInstance::wasAssociatedClockSet() const { return (m_associatedClock.lock().get()); }


void CSLOmUnitInstance::associateClock(RefCSLOmConnectable clock) {
  ASSERT(clock.get(), "received null ref");
  ASSERT(!wasAssociatedClockSet(), "trying to set the clock twice - this should be an error");//to implement
  ASSERT(!clock->cIsSignal() || ( clock->cIsSignal() && CSLOmSignal::cast(clock)->getSignalAttr() == ATTR_CLK ), "signal doesn't have the clk attr set");
  ASSERT(!clock->cIsPort() || ( clock->cIsPort() && CSLOmPortDecl::cast(clock)->getAttr() == ATTR_CLK ), "port doesn't have the clk attr set");

  m_associatedClock = WeakRefCSLOmConnectable(clock);
}


RefCSLOmConnectable CSLOmUnitInstance::getAssociatedClock() const {
  
  if (!m_associatedClock.lock().get()) { return RefCSLOmConnectable(); }
  else { return m_associatedClock.lock(); }
}



void CSLOmUnitInstance::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmUnitInstantiation class
// ********************************************************************************
CSLOmUnitInstantiation::CSLOmUnitInstantiation(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmBase(TYPE_UNIT_INSTANTIATION, lineNumber, fileName) {}

RefCSLOmUnitInstantiation CSLOmUnitInstantiation::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmUnitInstantiation();
  }
  else {
    ASSERT(object->isUnitInstantiation() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmUnitInstantiation>(object);
  }
}

RefCSLOmUnitInstantiation CSLOmUnitInstantiation::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink unitExprLink){
  ASSERT(parent.get(), "null parent received");
  ASSERT(parent->isUnitDecl() || 
         parent->isTestBench()
         , "parent should be a unit declaration or a testbench declaration"); // ensures that parent is a module or a generated instantiation
  ASSERT(unitExprLink.get(), "null exprLink received");
  
  CSLOmUnitInstantiation* unitInstantiation;
  try {
    unitInstantiation = new CSLOmUnitInstantiation(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmUnitInstantiation refUnitInstantiation(unitInstantiation);
  unitInstantiation->m_weakRef = boost::weak_ptr<CSLOmBase>( refUnitInstantiation);
  unitInstantiation->setParent(parent); // self registration                               *1
  unitExprLink->setParent(refUnitInstantiation); // self registration                      *2
  return refUnitInstantiation;
}

RefCSLOmExprLink CSLOmUnitInstantiation::getUnitDeclExprLink() const{
  return CSLOmExprLink::cast(getChild(DECL_LINK));
}

const RefCSLOmBase CSLOmUnitInstantiation::getUnitDeclExprLinkAsBase() const{
  return getChild(DECL_LINK);
}


RefCSLOmUnitDecl CSLOmUnitInstantiation::getUnitDecl() const {
  RefCSLOmExprLink unitDeclExprLink = getUnitDeclExprLink();
  ASSERT(unitDeclExprLink->isResolved(), "The expression link to the unit decl must have been resolved by the time this method is invoked");
  RefCSLOmIdentifier unitDeclID = unitDeclExprLink->toID();
  ASSERT(unitDeclID.get(), "null unit id");
  ASSERT(unitDeclID->getParent().get(), "id parent is null");
  ASSERT(unitDeclID->getParent()->isUnitDecl(), "The parent of the if must be of type CSLOmUnitDecl");
  return CSLOmUnitDecl::cast(unitDeclID->getParent());
}

void CSLOmUnitInstantiation::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

RefCSLOmUnitInstance CSLOmUnitInstantiation::buildUnitInstance(TLineNumberType lineNumber, RefString fileName, const RefString& instName/*, RefCSLOmBitRange bitRange = RefCSLOmBitRange(0)*/) {
  ASSERT(instName.get(), "null name received");
  ASSERT(instName->length(), "empty name received");

  return CSLOmUnitInstance::build(lineNumber, fileName, getThis(), instName);
}

RefTVec_RefCSLOmUnitInstance CSLOmUnitInstantiation::getUnitInstances() const {
  return getChildren<CSLOmUnitInstance>(TYPE_INST_UNIT);
}

const RefTVec_RefCSLOmBase CSLOmUnitInstantiation::getUnitInstancesAsBase() const {
  return getChildrenAsBase(TYPE_INST_UNIT);
}

}
