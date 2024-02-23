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

// Author BogdanZ & OctavS

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
// CSLOmUnitDecl class
// ********************************************************************************
CSLOmUnitDecl::CSLOmUnitDecl(TLineNumberType lineNumber, RefString fileName, CSLOmUnitDecl::EUnitType type)
  : CSLOmBase(TYPE_DECL_UNIT, lineNumber, fileName), 
    m_instances(new TVec_WeakCSLOmUnitInstance),
    m_verifComps(new TVec_WeakCSLOmVerifCompInfo),
    m_inputVerilogType(v2001), 
    m_outputVerilogType(v2001),
    m_unitType(type),
    m_signalPrefixLocal(),
    m_signalPrefixIO(),
    m_numId(), 
    m_address(),
    m_instanceAlterationBit(FALSE), 
    m_isVisited(FALSE),
    m_isInstantiated(FALSE), 
    m_doNotGenRTL(FALSE),
    m_doNotGenCPP(FALSE),
    m_genUniqueRTL(FALSE),
    m_unitPrefix(), 
    m_scope(), 
    m_state(STATE_INIT), 
    m_isDUT(FALSE) { 
  m_isDefined = FALSE;
}

RefCSLOmUnitDecl CSLOmUnitDecl::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmUnitDecl();
  }
  else {
    ASSERT(object->isUnitDecl() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmUnitDecl>(object);
  }
}

void CSLOmUnitDecl::generateUniqueRTL() {
  m_genUniqueRTL = TRUE;

  while (m_instances->size()) {
    RefCSLOmUnitInstance instance = m_instances->back().lock();
    RefCSLOmUnitInstantiation instantiation = CSLOmUnitInstantiation::cast(instance->getParent());
    RefCSLOmUnitDecl instFrom = CSLOmUnitDecl::cast(instantiation->getParent());
    TLineNumberType lineNumber = instance->getLineNumber();
    RefString fileName = instance->getFileName();
    RefString instanceName = instance->getName();
    RefTMap_RefCSLOmExprLink_RefCSLOmExpr connectionMap = instance->getConnectionMap();

    RefCSLOmUnitReplica unitReplica = CSLOmUnitReplica::build(lineNumber, fileName, getParent(), instFrom->getName(), instanceName, getThis());
    RefCSLOmExprLink replicaExprLink = CSLOmExprLink::build(lineNumber, fileName, unitReplica->getName());
    replicaExprLink->addID(unitReplica->getID());

    instantiation->removeChild(instance);

    if (!instantiation->getUnitInstances().get()) {
      instFrom->removeChild(instantiation);
    }

    instFrom->addInstance(lineNumber, fileName, replicaExprLink, instanceName, connectionMap);

    m_instances->back() = WeakCSLOmUnitInstance(RefCSLOmUnitInstance());
    m_instances->pop_back();
  }
}

void CSLOmUnitDecl::registerInstance(RefCSLOmUnitInstance inst) {
  ASSERT(inst.get(), "null ptr received");
  boost::weak_ptr<CSLOmUnitInstance> instance(inst);
  m_instances->push_back(instance);
}

void CSLOmUnitDecl::registerVerifComp(RefCSLOmVerifCompInfo verifComp) {
  ASSERT(verifComp.get(), "null ptr received");
  boost::weak_ptr<CSLOmVerifCompInfo> verifComponent(verifComp);
  m_verifComps->push_back(verifComponent);
}

RefCSLOmUnitInfo CSLOmUnitDecl::buildInfoObject() {
  switch (m_unitType) {
    case CSL_UNIT_DECL:          return         CSLOmUnitInfo::build(m_lineNumber, m_fileName);                     break;
    case CSL_FIFO_DECL:          return         CSLOmFifoInfo::build(m_lineNumber, m_fileName, getThis());          break;
    case CSL_TESTBENCH_DECL:     return           CSLOmTBInfo::build(m_lineNumber, m_fileName);                     break;
    case CSL_REGISTER_DECL:      return      CSLOmRegDeclInfo::build(m_lineNumber, m_fileName);                     break;
    case CSL_REGISTER_FILE_DECL: return CSLOmRegisterFileInfo::build(m_lineNumber, m_fileName, getThis());          break;
    case CSL_VECTOR:             return       CSLOmVectorInfo::build(m_lineNumber, m_fileName, getThis());          break;
    case CSL_STATE_DATA:         return    CSLOmStateDataInfo::build(m_lineNumber, m_fileName, getThis());          break;
    case CSL_MEMORY_DECL:        return       CSLOmMemoryInfo::build(m_lineNumber, m_fileName);                     break;
    default: ASSERT(FAIL, "undefined unit type");
  }
};

RefCSLOmUnitDecl CSLOmUnitDecl::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, CSLOmUnitDecl::EUnitType type) {
  ASSERT(parent.get(), "null parent received");
  if (!parent->isDesign()) {
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException("UnitDecl::build - parent should be the Design");
  }
  checkIdName(name, lineNumber, fileName);

  CSLOmUnitDecl* unitDecl;
  try {
    unitDecl = new CSLOmUnitDecl(lineNumber, fileName, type);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmUnitDecl refUnitDecl(unitDecl);
  unitDecl->m_weakRef = boost::weak_ptr<CSLOmBase>( refUnitDecl);
  unitDecl->setParent(parent);
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refUnitDecl, CSLOmIdentifier::ID_CSL_UNIT, name);
  unitDecl->m_scope = CSLOmScope::build(id);                                                              //*2
  RefString ifcName = RefString(new std::string("*"));
  ifcName->append(*name);
  ifcName->append(std::string("_default_ifc"));
  RefCSLOmInterface defaultInterface = CSLOmInterface::build(lineNumber, fileName, refUnitDecl, ifcName);            //*1
  RefCSLOmUnitInfo unitInfo = unitDecl->buildInfoObject();
  unitInfo->setParent(refUnitDecl);
  unitInfo->initialize();
  return refUnitDecl;
}

RefCSLOmUnitInfo CSLOmUnitDecl::getUnitInfo() const {
  return CSLOmUnitInfo::cast(getChild(UNIT_INFO));
}

void CSLOmUnitDecl::setUnitPrefix(const RefString& prefix) {
  ASSERT(prefix.get(), "null prefix received");
  ASSERT(prefix->length(), "empty prefix received");

  m_unitPrefix = RefString (new std::string(*prefix));
}

const RefString CSLOmUnitDecl::getUnitPrefix() const {
  return m_unitPrefix;
}

void CSLOmUnitDecl::setUnitNumericID(RefCSLOmNumber num) {
  ASSERT(num.get(),"numerical id is null");
  ASSERT(!m_numId.get(),"id already set");
  
  m_numId = num;
}

const RefCSLOmNumber CSLOmUnitDecl::getUnitNumericID() const {
  return m_numId;
}

void CSLOmUnitDecl::setUnitAddress(RefCSLOmNumber num) {
  ASSERT(num.get(),"address is null");
  ASSERT(!m_address.get(),"address already set");
  
  m_address = num;
}

const RefCSLOmNumber CSLOmUnitDecl::getUnitAddress() const {
  return m_address;
}

void CSLOmUnitDecl::setExternalUnitEnable(RefCSLOmExprLink enLink) {
  ASSERT(FAIL,"NOT IMPLEMENTED: void CSLOmUnitDecl::setExternalUnitEnable(RefCSLOmExprLink enLink)");
}

const RefCSLOmExprLink CSLOmUnitDecl::getExternalUnitEnable() const {
  ASSERT(FAIL,"NOT IMPLEMENTED: void CSLOmUnitDecl::setExternalUnitEnable(RefCSLOmExprLink enLink)");
  return RefCSLOmExprLink();
}

void CSLOmUnitDecl::genInternalUnitEnable(const RefString& enName) {
  ASSERT(enName.get(),"null name");
  ASSERT(!enName->empty(),"empty name");

  RefCSLOmSignal en = addSignal(getLineNumber(), getFileName(), enName, SIGNAL_WIRE);
  en->setSignalAttr(ATTR_EN);
}

void CSLOmUnitDecl::addInstance(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink unitDecl, const RefString& instName, RefTVec_RefCSLOmExpr connectableObjects/*, RefCSLOmBitRange bitRange*/) {
  ASSERT(unitDecl.get(), "null unitDecl received");
  ASSERT(instName.get(), "null instName received");
  ASSERT(instName->length(), "empty instName received");
  ASSERT(!(connectableObjects->size() % 2), "wrong number of els");
  ASSERT(unitDecl->isResolved(),"this should be resolved by now");

  RefCSLOmUnitDecl declaration = CSLOmUnitDecl::cast(unitDecl->toID()->getParent());
  RefCSLOmUnitInstantiation unitInstantiation = RefCSLOmUnitInstantiation();

  if (declaration->isSetGenerateUniqueRTL()) {
    RefCSLOmUnitReplica unitReplica = CSLOmUnitReplica::build(lineNumber, fileName, declaration->getParent(), getName(), instName, declaration);
    unitDecl = RefCSLOmExprLink();
    unitDecl = CSLOmExprLink::build(lineNumber, fileName, unitReplica->getName());
    unitDecl->addID(unitReplica->getID());
  }
  else {
    RefTVec_RefCSLOmUnitInstantiation instantiations = getInstantiations();
    if (instantiations.get()) {
      TVec_RefCSLOmUnitInstantiation_const_iter iter = instantiations->begin();
      for ( ; iter < instantiations->end() ; iter++) {
        if ((*iter)->getUnitDeclExprLink() == unitDecl) {
          unitInstantiation = (*iter);
          break;
        }
      }
    }

  }

  if (!unitInstantiation.get()) {
    unitInstantiation = CSLOmUnitInstantiation::build(lineNumber, fileName, getThis(), unitDecl);
  }

  ASSERT(unitInstantiation.get(), "unitInstantiation should not be null at this moment");
  RefCSLOmUnitInstance in = RefCSLOmUnitInstance();
  in = unitInstantiation->buildUnitInstance(lineNumber, fileName, instName/*, bitRange*/); 
  in->copyParametersFromDeclToInst();
  for(TUInt i = 0; i < connectableObjects->size(); i += 2) {
    in->addConnectionPair(connectableObjects->at(i + 1), CSLOmExprLink::cast(connectableObjects->at(i)));
  }

  if (getUnitType() != CSL_TESTBENCH_DECL) {
    declaration->m_isInstantiated = TRUE;
  }
  else {
    declaration->m_isDUT = TRUE;
  }
}

void CSLOmUnitDecl::addInstance(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink unitDecl, const RefString& instName, const RefTMap_RefCSLOmExprLink_RefCSLOmExpr& connectionMap) {
  ASSERT(unitDecl.get(), "null unitDecl received");
  ASSERT(instName.get(), "null instName received");
  ASSERT(instName->length(), "empty instName received");
  ASSERT(connectionMap.get(), "null connectionMap received");
  ASSERT(unitDecl->isResolved(),"this should be resolved by now");

  RefCSLOmUnitDecl declaration = CSLOmUnitDecl::cast(unitDecl->toID()->getParent());
  RefCSLOmUnitInstantiation unitInstantiation = RefCSLOmUnitInstantiation();

  if (declaration->isSetGenerateUniqueRTL()) {
    RefCSLOmUnitReplica unitReplica = CSLOmUnitReplica::build(lineNumber, fileName, declaration->getParent(), getName(), instName, declaration);
    unitDecl = RefCSLOmExprLink();
    unitDecl = CSLOmExprLink::build(lineNumber, fileName, unitReplica->getName());
    unitDecl->addID(unitReplica->getID());
  }
  else {
    RefTVec_RefCSLOmUnitInstantiation instantiations = getInstantiations();
    if (instantiations.get()) {
      TVec_RefCSLOmUnitInstantiation_const_iter iter = instantiations->begin();
      for ( ; iter < instantiations->end() ; iter++) {
        if ((*iter)->getUnitDeclExprLink() == unitDecl) {
          unitInstantiation = (*iter);
          break;
        }
      }
    }

  }

  if (!unitInstantiation.get()) {
    unitInstantiation = CSLOmUnitInstantiation::build(lineNumber, fileName, getThis(), unitDecl);
  }

  ASSERT(unitInstantiation.get(), "unitInstantiation should not be null at this moment");
  RefCSLOmUnitInstance in = RefCSLOmUnitInstance();
  in = unitInstantiation->buildUnitInstance(lineNumber, fileName, instName); 
  in->copyParametersFromDeclToInst();
  for (TMap_RefCSLOmExprLink_RefCSLOmExpr_const_iter iter = connectionMap->begin(); iter != connectionMap->end(); ++iter) {
    in->addConnectionPair((*iter).second, (*iter).first);
  }

  if (getUnitType() != CSL_TESTBENCH_DECL) {
    declaration->m_isInstantiated = TRUE;
  }
  else {
    declaration->m_isDUT = TRUE;
  }
}

void CSLOmUnitDecl::addInstanceList(TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink unitDecl, RefCSLOmList list/*, RefCSLOmBitRange bitRange*/) {
  ASSERT(unitDecl.get(), "null unitDecl received");
  ASSERT(list.get(), "null instName received");
  ASSERT(unitDecl->isResolved(),"this should be resolved by now");
  ASSERT(list->getListType() == TYPE_ALL_TYPES, "invalid list type, error should be allready null");
  ASSERT(list->getListType() == TYPE_ALL_TYPES, "invalid list type, error should be allready null");

  RefCSLOmUnitDecl declaration = CSLOmUnitDecl::cast(unitDecl->toID()->getParent());
  RefCSLOmUnitInstantiation unitInstantiation = RefCSLOmUnitInstantiation();

  if (declaration->isSetGenerateUniqueRTL()) {
    RefTVec_RefCSLOmBase objects = list->getObjects();
    if (objects.get()) {
      TVec_RefCSLOmBase::iterator it = objects->begin();
      for (; it < objects->end(); it++) {
        RefCSLOmUnitReplica unitReplica = CSLOmUnitReplica::build(lineNumber, fileName, declaration->getParent(), getName(), CSLOmExprLink::cast(*it)->getName(), declaration);
        unitDecl = RefCSLOmExprLink();
        unitDecl = CSLOmExprLink::build(lineNumber, fileName, unitReplica->getName());
        unitDecl->addID(unitReplica->getID());

        unitInstantiation = CSLOmUnitInstantiation::build(lineNumber, fileName, getThis(), unitDecl);
        unitInstantiation->buildUnitInstance(lineNumber, fileName, CSLOmExprLink::cast(*it)->getName());
      }
    }
  }
  else {
    RefTVec_RefCSLOmUnitInstantiation instantiations = getInstantiations();
    if (instantiations.get()) {
      TVec_RefCSLOmUnitInstantiation_const_iter iter = instantiations->begin();
      for ( ; iter < instantiations->end() ; iter++) {
        if ((*iter)->getUnitDeclExprLink() == unitDecl) {
          unitInstantiation = (*iter);
          break;
        }
      }
    }

    if (!unitInstantiation.get()) {
      unitInstantiation = CSLOmUnitInstantiation::build(lineNumber, fileName, getThis(), unitDecl);     //*3
    }
    ASSERT(unitInstantiation.get(), "unitInstantiation should not be null at this moment");
    RefTVec_RefCSLOmBase objects = list->getObjects();
    if (objects.get()) {
      TVec_RefCSLOmBase::iterator it = objects->begin();
      for (; it < objects->end(); it++) {
        unitInstantiation->buildUnitInstance(lineNumber, fileName, CSLOmExprLink::cast(*it)->getName()/*, bitRange*/);                                         //*4
      }
    }
  }

  declaration->m_isInstantiated = TRUE;
}

RefTVec_RefCSLOmUnitInstance CSLOmUnitDecl::getUnitInstances() {
  RefTVec_RefCSLOmUnitInstance temp = RefTVec_RefCSLOmUnitInstance(new TVec_RefCSLOmUnitInstance);
  RefTVec_RefCSLOmUnitInstantiation inst = getInstantiations();
  if (inst.get()) {
    TVec_RefCSLOmUnitInstantiation::iterator it = inst->begin();
    for (; it < inst->end(); ++it) {
      RefTVec_RefCSLOmUnitInstance aux = (*it)->getUnitInstances();
      TVec_RefCSLOmUnitInstance::iterator iter = aux->begin();
      for (; iter < aux->end(); ++iter) {
        temp->push_back(*iter);
      }
    }
  }
  return temp;
}


void CSLOmUnitDecl::addParameter(TLineNumberType lineNumber, RefString fileName, const RefString& paramName, RefCSLOmNumber defaultValue) {
  ASSERT(paramName.get(), "null name received");
  ASSERT(defaultValue.get(), "null value received");
  
  CSLOmParameter::build(lineNumber, fileName, getThis(), paramName, CSLOmExpr::cast(defaultValue));
}


void CSLOmUnitDecl::addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName) {
  ASSERT(signalName.get(), "null signalName received");
  ASSERT(signalName->length(), "empty signalName received");

  RefCSLOmSignal signal = CSLOmSignal::build(lineNumber, fileName, getThis(), signalName, SIGNAL_UNDEFINED);
}

void CSLOmUnitDecl::addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, RefCSLOmExprLink bitRange) {
  ASSERT(signalName.get(), "null signalName received");
  ASSERT(signalName->length(), "empty signalName received");

  RefCSLOmSignal signal = CSLOmSignal::build(lineNumber, fileName, getThis(), signalName, SIGNAL_UNDEFINED);
  signal->setBitRange(bitRange);
}

RefCSLOmSignal CSLOmUnitDecl::addSignal(TLineNumberType lineNumber, RefString fileName, const RefString& signalName, ECSLOmSignalType signalType, RefCSLOmExprLink bitRange) {
  ASSERT(signalName.get(), "null signalName received");
  ASSERT(signalName->length(), "empty signalName received");
  RefCSLOmSignal signal = CSLOmSignal::build(lineNumber, fileName, getThis(), signalName, signalType, bitRange);
  return signal;
}

void CSLOmUnitDecl::addSignalList(TLineNumberType lineNumber, RefString fileName, RefCSLOmList list, ECSLOmSignalType signalType, RefCSLOmExprLink bitRange) {
  ASSERT(list.get(), "null List received");
  ASSERT(list->getListType() == TYPE_CONNECTABLE || list->getListType() == TYPE_ALL_TYPES, "List is not a list of signals or a list of names");

  RefTVec_RefCSLOmBase signals = list->getObjects();
  if (signals.get()) {
    TVec_RefCSLOmBase::iterator it = signals->begin();
    for (; it < signals->end(); it++) {
      if ((*it)->isExpr()) {
        CSLOmSignal::build(lineNumber, fileName, getThis(), CSLOmExprLink::cast(*it)->getName(), signalType, bitRange);
      }
      else if ((*it)->isSignal()) {
        CSLOmSignal::build(lineNumber, fileName, getThis(), CSLOmSignal::cast(*it)->getName(), CSLOmSignal::cast(*it)->getSignalType(), CSLOmSignal::cast(*it)->getBitRange()->getBitRangeLink());
      }
    }
  }
  else {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_EMPTY_LIST, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException("warning: add_signal_list: list is empty; no signals added to unit");
  }
}

void CSLOmUnitDecl::addSignalGroup(TLineNumberType lineNumber, RefString fileName, RefCSLOmGroupSignal signalGroup) {
  ASSERT(signalGroup.get(), "null group received");
  
  RefCSLOmGroupSignal groupSignal = CSLOmGroupSignal::build(lineNumber, fileName, getThis(), signalGroup->getName(), signalGroup);
  //RefTVec_RefCSLOmBase signals = signalGroup->getSignalsAsBase();
  //RefCSLOmGroupSignal group = CSLOmGroupSignal::build(lineNumber, getThis(), signalGroup->getName());
  //if (signals.get()) {
  //  TVec_RefCSLOmBase_const_iter it = signals->begin();
  //  for (; it < signals->end(); ++it) {
  //    group->addItem(*it);
  //  }
  //}
  //else {
  //  addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_EMPTY_GROUP, args, lineNumber);
  //  cslomHasErrors = TRUE;
  //  //throw NSBase::IllegalArgumentException("warning: add_signal_group: source group is empty");
  //}
}

RefCSLOmPortDecl CSLOmUnitDecl::addPort(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, const RefString& portName, RefCSLOmExprLink bitRange) {
  RefCSLOmInterface ifc = getDefaultInterface();
  return ifc->addPort(lineNumber, fileName, portName, portType, signalType, bitRange);
}

void CSLOmUnitDecl::addPortList(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection portType, ECSLOmSignalType signalType, RefCSLOmList name, RefCSLOmExprLink bitRange) {
  RefCSLOmInterface ifc = getDefaultInterface();
  ifc->addPortList(lineNumber, fileName, name, portType, signalType, bitRange);
}

void CSLOmUnitDecl::addInterface(TLineNumberType lineNumber, RefString fileName, const RefCSLOmExprLink ifc, const RefString& ifcName) {
  ASSERT(ifc.get(), "Expression Link is Null!");
  ASSERT(ifc->isResolved(), "Expression Link should be resolved by now!");
  //  ASSERT(ifc->getValue().get(), "Expression link does not point to any object (error should be given in the check of the command section)");
  //  ASSERT(ifc->getValue()->isInterface(), "object is not an interface(error should be given in the check of the command section)");
  ASSERT(ifcName.get(), "Null name given");
  ASSERT(ifcName->length(), "empty name given");

  RefCSLOmInterface defaultInterface = getDefaultInterface();
  RefCSLOmInterface sourceInterface = CSLOmInterface::cast(ifc->getLocalNameID()->getParent());//boost::static_pointer_cast<CSLOmInterface>(ifc->getValue());
  RefCSLOmInterface interface = CSLOmInterface::build(lineNumber, fileName, defaultInterface, ifcName, sourceInterface);
}

void CSLOmUnitDecl::addInterface(TLineNumberType lineNumber, RefString fileName, ECSLOmPortDirection direction, const RefCSLOmExprLink ifc, const RefString& ifcName) {
  ASSERT(ifc.get(), "Expression Link is Null!");
  ASSERT(ifc->isResolved(), "Expression Link should be resolved by now!");
  ASSERT(ifc->getValue().get(), "Expression link does not point to any object (error should be given in the check of the command section)");
  //ASSERT(ifc->getValue()->isInterface(), "object is not an interface(error should be given in the check of the command section)");
  ASSERT(ifcName.get(), "Null name given");
  ASSERT(!ifcName->empty(), "empty name given");

  RefCSLOmInterface defaultInterface = getDefaultInterface();
  RefCSLOmGroupSignal sourceInterface = CSLOmGroupSignal::cast(ifc->getValue());
  RefCSLOmInterface interface = CSLOmInterface::build(lineNumber, fileName, defaultInterface, ifcName, direction, sourceInterface);
}

void CSLOmUnitDecl::setSignalPrefixLocal(const RefString& prefix) {
  m_signalPrefixLocal = prefix;
}

void CSLOmUnitDecl::setSignalPrefixIO(const RefString& prefix) {
  m_signalPrefixIO = prefix;
}


EVerilogType CSLOmUnitDecl::getInputVerilogType() const {
  return m_inputVerilogType;
}

void CSLOmUnitDecl::setInputVerilogType(EVerilogType type) {
  if (type <= VERILOG_TYPE_UD || type >= VERILOG_TYPE_MAX) {
    throw NSBase::IllegalStateException("[CSLOmUnitDecl::setInputVerilogType(EVerilogType) ] illegal type value", m_lineNumber);
  }
  m_inputVerilogType = type;
}

EVerilogType CSLOmUnitDecl::getOutputVerilogType() const {
  return m_outputVerilogType;
}

void CSLOmUnitDecl::setOutputVerilogType(EVerilogType type) {
  if (type<=VERILOG_TYPE_UD || type >= VERILOG_TYPE_MAX) {
    throw NSBase::IllegalStateException("[CSLOmUnitDecl::setOutputVerilogType(EVerilogType) ] illegal type value", m_lineNumber);
  }
  m_outputVerilogType=type;
}

RefCSLOmScope CSLOmUnitDecl::getAttachedScope() const {
  return m_scope;
}


RefTVec_RefCSLOmSignal CSLOmUnitDecl::getAllSignals() const {
  RefTVec_RefCSLOmGroupSignal ifcs = getSignalGroups();
  
  RefTVec_RefCSLOmSignal ports = getSignals();
  if(!ports.get()) { ports = RefTVec_RefCSLOmSignal(new TVec_RefCSLOmSignal()); }
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

RefTVec_RefCSLOmPortDecl CSLOmUnitDecl::getPortListFull() const {
  RefCSLOmInterface defaultInterface = getDefaultInterface();
  
  //added by AS in order to get recursive ports in hierarchical interfaces
//   RefTVec_RefCSLOmPortDecl ports = RefTVec_RefCSLOmPortDecl(new TVec_RefCSLOmPortDecl);
  
//   TInt bla=getRecursivePorts(ports, defaultInterface);

  //RefTVec_RefCSLOmPortDecl returned = defaultInterface->getPorts();
  //RefTVec_RefCSLOmInterface interfaces = defaultInterface->getInterfaces();
  //
  //if(interfaces.get() && interfaces->size()) {
  //  for(TVec_RefCSLOmInterface_iter it = interfaces->begin(); interfaces->end() > it; ++it) {
  //    RefTVec_RefCSLOmPortDecl tmp = (*it)->getPorts();
  //    if(tmp.get() && tmp->size()) {
  //      if(!returned.get())
  //        returned = RefTVec_RefCSLOmPortDecl(new TVec_RefCSLOmPortDecl());
  //      for(TVec_RefCSLOmPortDecl::iterator it1 = tmp->begin(); it1 < tmp->end(); ++it1)
  //        returned->push_back(*it1);
  //    }
  //  }
  //}
  //return returned;

  return defaultInterface->getAllPorts();
}

RefTVec_RefCSLOmBase CSLOmUnitDecl::getAssignListFull() const {
  RefTVec_RefCSLOmBase assignStmts = getChildrenAsBase(TYPE_STMT);
  
  RefTVec_RefCSLOmGroupSignal ifcs = getChildren<CSLOmGroupSignal>(TYPE_ALL_GROUPS);

  if (!assignStmts.get()) { assignStmts = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase()); }
  if (ifcs.get()) {
    for (TVec_RefCSLOmGroupSignal::iterator it = ifcs->begin(); it < ifcs->end(); it++) {
      RefTVec_RefCSLOmBase temp = (*it)->getAssignListFull();
      for (TVec_RefCSLOmBase::iterator iter = temp->begin(); iter < temp->end(); iter++) {
        assignStmts->push_back(*iter);
      }
    }
  }
  
  RefTVec_RefCSLOmBase defIfcStmts = getDefaultInterface()->getAssignListFull();
  for (TVec_RefCSLOmBase::iterator iter = defIfcStmts->begin(); iter < defIfcStmts->end(); iter++) {
    assignStmts->push_back(*iter);
  }
  
  
  return assignStmts;
}
  
 
// TInt CSLOmUnitDecl::getRecursivePorts(RefTVec_RefCSLOmPortDecl allPorts, RefCSLOmInterface ifc) const{
//   RefTVec_RefCSLOmPortDecl ports=ifc->getPorts();
//   if(ports.get() && ports->size()){
//     for(int i=0; i<ports->size(); ++i){
//       allPorts->push_back(ports->at(i));
//     }
//   }
//   RefTVec_RefCSLOmInterface interfaces = ifc->getInterfaces();
//   if(interfaces.get() && interfaces->size()){
//     for(TVec_RefCSLOmInterface_iter it = interfaces->begin(); interfaces->end() > it; ++it) {
//       getRecursivePorts(allPorts, *(it));
//     }
//   }
//   return 1;
//}

RefTVec_RefCSLOmPortDecl CSLOmUnitDecl::getPortList() const {
  RefCSLOmInterface defaultInterface = getDefaultInterface();
  return defaultInterface->getPorts();
}

TBool CSLOmUnitDecl::portExists(RefCSLOmExprLink portLink) const {
  ASSERT(portLink.get(), "Null link received");
  ASSERT(portLink->isResolved(), "ExprLink should have been resolved at the time of the call of this method");
  ASSERT(portLink->toID().get(), "id is null");
  ASSERT(portLink->toID()->getParent()->isPort(), "link should point to a portDecl");
  RefCSLOmInterface defaultInterface = getDefaultInterface();
  return defaultInterface->containsPort(CSLOmPortDecl::cast(portLink->getValue()));
}

// RefTVec_RefCSLOmUnitInstance CSLOmUnitDecl::getChildInstances() const {
//   RefTVec_RefCSLOmUnitInstantiation instantiations = getInstantiations();
//   RefTVec_RefCSLOmUnitInstance returnValue = RefTVec_RefCSLOmUnitInstance();
//   for (TVec_RefCSLOmUnitInstantiation::iterator it = instantiations->begin(); it < instantiations->end(); it++) {
//     RefTVec_RefCSLOmUnitInstance aux = (*it)->getUnitInstances();
//     for (TVec_RefCSLOmUnitInstance::iterator inst = aux->begin(); inst < aux->end(); inst++) {
//       returnValue->push_back(*inst);
//     }
//   }
//   return returnValue;
// }

TBool CSLOmUnitDecl::wasAssociatedClockSet() const { 

  TBool isClockAssociated = m_associatedClock.lock().get();

  if (!isClockAssociated) {

    //for instances
    RefTVec_WeakCSLOmUnitInstance instances = getInstances();

    if (instances.get()) {

      for (TVec_WeakCSLOmUnitInstance::iterator it = instances->begin(); it != instances->end() && !isClockAssociated; ++it) {

        if ( ((*it).lock())->wasAssociatedClockSet() ) { isClockAssociated = TRUE; }
      }
    }

    if (!isClockAssociated) {

      //for children
      RefTVec_RefCSLOmBase children = getChildrenAsBase(TYPE_CONNECTABLE);

      if (children.get()) {
    
        for (TVec_RefCSLOmBase::iterator it = children->begin(); it != children->end() && !isClockAssociated; ++it) {
      
          if ( CSLOmConnectable::cast(*it)->wasAssociatedClockSet() ) { isClockAssociated = TRUE; }
        }
      }
    }
  }

  return isClockAssociated; 

}


void CSLOmUnitDecl::associateClock(RefCSLOmConnectable clock) {
  ASSERT(clock.get(), "received null ref");
  ASSERT(!wasAssociatedClockSet(), "trying to set the clock twice - this should be an error");//to implement
  ASSERT(!clock->cIsSignal() || ( clock->cIsSignal() && CSLOmSignal::cast(clock)->getSignalAttr() == ATTR_CLK ), "signal doesn't have the clk attr set");
  ASSERT(!clock->cIsPort() || ( clock->cIsPort() && CSLOmPortDecl::cast(clock)->getAttr() == ATTR_CLK ), "port doesn't have the clk attr set");
  
  m_associatedClock = WeakRefCSLOmConnectable(clock);

  //for instances
  RefTVec_WeakCSLOmUnitInstance instances = getInstances();

  if (instances.get()) {

    for (TVec_WeakCSLOmUnitInstance::iterator it = instances->begin(); it != instances->end(); ++it) {

      ((*it).lock())->associateClock(clock);
    }
  }

  //for children
  RefTVec_RefCSLOmBase children = getChildrenAsBase(TYPE_CONNECTABLE);

  if (children.get()) {
    
    for (TVec_RefCSLOmBase::iterator it = children->begin(); it != children->end(); ++it) {
      
      CSLOmConnectable::cast(*it)->associateClock(clock);
    }
  }
}


RefCSLOmConnectable CSLOmUnitDecl::getAssociatedClock() const {
  
  if (!m_associatedClock.lock().get()) { return RefCSLOmConnectable(); }
  else { return m_associatedClock.lock(); }
}



void CSLOmUnitDecl::setAlterationBit(TBool value) {
  m_instanceAlterationBit = value;
}

const TBool CSLOmUnitDecl::isTopUnit() const {
  return !m_isInstantiated;
}

TBool CSLOmUnitDecl::getAlterationBit() const {
  return m_instanceAlterationBit;
}

void CSLOmUnitDecl::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  if (!isSetGenerateUniqueRTL() || isTopUnit()) {
    visitor.visit(getThis());
  }
}

// ********************************************************************************
// CSLOmUnitReplica class
// ********************************************************************************
CSLOmUnitReplica::CSLOmUnitReplica(TLineNumberType lineNumber, RefString fileName)
  : CSLOmUnitDecl(lineNumber, fileName, CSLOmUnitDecl::CSL_UNIT_REPLICA) {
}

RefCSLOmUnitReplica CSLOmUnitReplica::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmUnitReplica();
  }
  else {
    ASSERT(object->isUnitDecl() , "type check on cast failure");
    //    ASSERT(CSLOmUnitDecl::cast(object)->getUnitType() == CSLOmUnitDecl::CSL_UNIT_REPLICA, "type check on cast failure");
    return boost::static_pointer_cast<CSLOmUnitReplica>(object);
  }
}

RefCSLOmUnitReplica CSLOmUnitReplica::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& declName, const RefString& instName, const RefCSLOmUnitDecl& unitDecl) {
  ASSERT(parent.get(), "null parent received");
  if (!parent->isDesign()) {
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
  }

  RefString rtlName = RefString(new std::string(""));
  rtlName->append(*declName);
  rtlName->append("_");
  rtlName->append(*instName);
 
  checkIdName(rtlName, lineNumber, fileName);

  CSLOmUnitReplica* unitReplica;
  try {
    unitReplica = new CSLOmUnitReplica(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmUnitReplica refUnitReplica(unitReplica);
  unitReplica->m_weakRef = boost::weak_ptr<CSLOmBase>(refUnitReplica);
  unitReplica->m_unitDecl = WeakCSLOmUnitDecl(unitDecl);
  unitReplica->setParent(parent);

  /*0*/
  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber, fileName, refUnitReplica, CSLOmIdentifier::ID_CSL_UNIT, rtlName);

  unitReplica->m_scope = CSLOmScope::build(id);
  RefCSLOmScope parentScope = unitDecl->getAttachedScope();
  for (TVec_RefCSLOmIdentifier::iterator iter = parentScope->m_ids->begin();
       iter < parentScope->m_ids->end();
       ++iter) {

    unitReplica->m_scope->registerID(*iter);
  }

  /*1*/
  RefString ifcName = RefString(new std::string("*"));
  ifcName->append(*rtlName);
  ifcName->append(std::string("_default_ifc"));
  RefCSLOmInterface defaultInterface = CSLOmInterface::build(lineNumber, fileName, refUnitReplica, ifcName);

  refUnitReplica->defineObject();
  return refUnitReplica;
}

RefCSLOmBase CSLOmUnitReplica::getUnitDeclAsBase() const {
  return boost::static_pointer_cast<CSLOmBase>(m_unitDecl.lock());
}

RefCSLOmUnitDecl CSLOmUnitReplica::getUnitDecl() const {
  return m_unitDecl.lock();
}

RefTVec_RefCSLOmUnitInstantiation CSLOmUnitReplica::getInstantiations() const {
  return getUnitDecl()->getChildren<CSLOmUnitInstantiation>(TYPE_UNIT_INSTANTIATION);
}

RefTVec_RefCSLOmBase CSLOmUnitReplica::getInstantiationsAsBase() const {
  return getUnitDecl()->getChildrenAsBase(TYPE_UNIT_INSTANTIATION);
}

RefTVec_RefCSLOmSignal CSLOmUnitReplica::getSignals() const {
  return getUnitDecl()->getChildren<CSLOmSignal>(TYPE_ALL_SIGNALS);
}

RefTVec_RefCSLOmBase CSLOmUnitReplica::getSignalsAsBase() const {
  return getUnitDecl()->getChildrenAsBase(TYPE_ALL_SIGNALS);
}

RefTVec_RefCSLOmGroupSignal CSLOmUnitReplica::getSignalGroups() const {
  return getUnitDecl()->getChildren<CSLOmGroupSignal>(TYPE_ALL_GROUPS);
}

RefTVec_RefCSLOmBase CSLOmUnitReplica::getSignalGroupsAsBase() const {
  return getUnitDecl()->getChildrenAsBase(TYPE_ALL_GROUPS);
}

RefTVec_RefCSLOmBase CSLOmUnitReplica::getUnitParamsAsBase() const {
  return getUnitDecl()->getChildrenAsBase(TYPE_PARAMETER);
}

RefCSLOmInterface CSLOmUnitReplica::getDefaultInterface() const {
  return getUnitDecl()->getDefaultInterface();
}

RefCSLOmInterface CSLOmUnitReplica::getReplicaDefaultInterface() const {
  return getUnitDecl()->getDefaultInterface();
}

RefCSLOmBase CSLOmUnitReplica::getDefaultInterfaceAsBase() const {
  return getUnitDecl()->getDefaultInterfaceAsBase();
}

RefCSLOmBase CSLOmUnitReplica::getReplicaDefaultInterfaceAsBase() const {
  return getUnitDecl()->getDefaultInterfaceAsBase();
}

CSLOmUnitDecl::EUnitType CSLOmUnitReplica::getUnitType() const {
  return getUnitDecl()->getUnitType();
}

RefCSLOmUnitInfo CSLOmUnitReplica::getUnitInfo() const {
  return getUnitDecl()->getUnitInfo();
}

TBool CSLOmUnitReplica::isSetDoNotGenerateRTL() const {
  return getUnitDecl()->isSetDoNotGenerateRTL();
}

TBool CSLOmUnitReplica::isSetDoNotGenerateCPP() const {
  return getUnitDecl()->isSetDoNotGenerateCPP();
}

TBool CSLOmUnitReplica::isSetGenerateUniqueRTL() const {
  return FALSE;
}

const TBool CSLOmUnitReplica::isTopUnit() const {
  return FALSE;
}

TBool CSLOmUnitReplica::isDUT() const {
  return getUnitDecl()->isDUT();
}

const RefString CSLOmUnitReplica::getUnitPrefix() const {
  return getUnitDecl()->getUnitPrefix();
}

const RefCSLOmNumber CSLOmUnitReplica::getUnitNumericID() const {
  return getUnitDecl()->getUnitNumericID();
}

const RefCSLOmNumber CSLOmUnitReplica::getUnitAddress() const {
  return getUnitDecl()->getUnitAddress();
}

const RefCSLOmExprLink CSLOmUnitReplica::getExternalUnitEnable() const {
  return getUnitDecl()->getExternalUnitEnable();
}

EVerilogType CSLOmUnitReplica::getInputVerilogType() const {
  return getUnitDecl()->getInputVerilogType();
}

EVerilogType CSLOmUnitReplica::getOutputVerilogType() const {
  return getUnitDecl()->getOutputVerilogType();
}

RefTVec_RefCSLOmPortDecl CSLOmUnitReplica::getPortListFull() const {
  return getUnitDecl()->getPortListFull();
}

RefTVec_RefCSLOmPortDecl CSLOmUnitReplica::getPortList() const {
  return getUnitDecl()->getPortList();
}

TBool CSLOmUnitReplica::portExists(RefCSLOmExprLink portLink) const {
  return getUnitDecl()->portExists(portLink);
}

TBool CSLOmUnitReplica::wasAssociatedClockSet() const {
  return getUnitDecl()->wasAssociatedClockSet();
}

RefCSLOmConnectable CSLOmUnitReplica::getAssociatedClock() const {
  return getUnitDecl()->getAssociatedClock();
}

// ********************************************************************************
// CSLOmUnitInfo class
// ********************************************************************************
CSLOmUnitInfo::CSLOmUnitInfo(TLineNumberType lineNumber, RefString fileName)
  : CSLOmBase(TYPE_UNIT_INFO, lineNumber, fileName) {} // TODO IMPLEMENT

RefCSLOmUnitInfo CSLOmUnitInfo::cast(RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmUnitInfo();
  }
  else {
    ASSERT(TYPE_UNIT_INFO == object->getType(), "type check on cast failure");
    return boost::static_pointer_cast<CSLOmUnitInfo>(object);
  }
}

RefCSLOmUnitInfo CSLOmUnitInfo::build(TLineNumberType lineNumber, RefString fileName) {

  CSLOmUnitInfo* unitInfo;
  try {
    unitInfo = new CSLOmUnitInfo(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmUnitInfo refUnitInfo(unitInfo);
  unitInfo->m_weakRef = boost::weak_ptr<CSLOmBase>( refUnitInfo);

  return refUnitInfo;
}

void CSLOmUnitInfo::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmMemoryInfo class
// ********************************************************************************
CSLOmMemoryInfo::CSLOmMemoryInfo(TLineNumberType lineNumber, RefString fileName) :
  CSLOmUnitInfo(lineNumber, fileName),
  m_hasSetDepth(FALSE),
  m_hasSetWidth(FALSE),
  m_noOfRdIfc(MEM_DEF_NO_RD_IFC),
  m_noOfWrIfc(MEM_DEF_NO_WR_IFC) {}

RefCSLOmMemoryInfo CSLOmMemoryInfo::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmMemoryInfo();
  }
  else {
    return boost::static_pointer_cast<CSLOmMemoryInfo>(object);
  }
}

RefCSLOmMemoryInfo CSLOmMemoryInfo::build(TLineNumberType lineNumber, RefString fileName) {

  CSLOmMemoryInfo* unitInfo;
  try {
    unitInfo = new CSLOmMemoryInfo(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmMemoryInfo refMem = RefCSLOmMemoryInfo(unitInfo);
  unitInfo->m_weakRef = boost::weak_ptr<CSLOmBase>( refMem);

  return refMem;
}

void CSLOmMemoryInfo::setWidth(RefCSLOmExpr width) {
  ASSERT(width.get(), "null received");

  m_width = width;
//   RefCSLOmBase eval = width->doEval(TRUE);
//   ASSERT(eval.get(), "null eval");
//   ASSERT(eval->isNumber(), "eval NAN");

//   m_width = CSLOmNumber::cast(eval)->getValue();


  if (m_hasSetDepth) {
    CSLOmInterface::buildRD(m_lineNumber, m_fileName, CSLOmUnitDecl::cast(getParent())->getDefaultInterface(), RefString(new std::string("rd0")), getWidth(), getDepth());
    CSLOmInterface::buildWR(m_lineNumber, m_fileName, CSLOmUnitDecl::cast(getParent())->getDefaultInterface(), RefString(new std::string("wr0")), getWidth(), getDepth());
  }

  //for design checker
  m_mandatoryCounter++;
}

void CSLOmMemoryInfo::setDepth(RefCSLOmExpr depth) {
  ASSERT(depth.get(), "null received");
  m_depth = depth;
  
//   RefCSLOmBase eval = depth->doEval(TRUE);
//   ASSERT(eval.get(), "null eval");
//   ASSERT(eval->isNumber(), "eval NAN");

//   m_depth = CSLOmNumber::cast(eval)->getValue();

  if (m_hasSetWidth) {
    CSLOmInterface::buildRD(m_lineNumber, m_fileName, CSLOmUnitDecl::cast(getParent())->getDefaultInterface(), RefString(new std::string("rd0")), getWidth(), getDepth());
    CSLOmInterface::buildWR(m_lineNumber, m_fileName, CSLOmUnitDecl::cast(getParent())->getDefaultInterface(), RefString(new std::string("wr0")), getWidth(), getDepth());
  }

  //for design checker
  m_mandatoryCounter++;
}

RefCSLOmExpr CSLOmMemoryInfo::getWidth() const {
  return m_width;
}

RefCSLOmExpr CSLOmMemoryInfo::getDepth() const {
  return m_depth;
}

void CSLOmMemoryInfo::setNoOfRdIfc(RefCSLOmExpr no) {
  ASSERT(no.get(),"null received");
  ASSERT(m_noOfRdIfc == MEM_DEF_NO_RD_IFC, "this has already been set");

  RefCSLOmBase eval = no->doEval(TRUE);
  
  ASSERT(eval.get(),"null received");
  ASSERT(eval->isNumber(),"eval NAN");

  m_noOfRdIfc = CSLOmNumber::cast(eval)->getValue();

  for (TUInt i = 1; i < m_noOfRdIfc; i++) {
    RefString name = RefString(new std::string("rd"));
    name->append(intToString(i));
    CSLOmInterface::buildRD(m_lineNumber, m_fileName, CSLOmUnitDecl::cast(getParent())->getDefaultInterface(), name, getWidth(), getDepth());
  }
}

void CSLOmMemoryInfo::setNoOfWrIfc(RefCSLOmExpr no) {
  ASSERT(no.get(),"null received");
  ASSERT(m_noOfWrIfc == MEM_DEF_NO_WR_IFC, "this has already been set");

  RefCSLOmBase eval = no->doEval(TRUE);
  
  ASSERT(eval.get(),"null received");
  ASSERT(eval->isNumber(),"eval NAN");

  m_noOfWrIfc = CSLOmNumber::cast(eval)->getValue();

  for (TUInt i = 1; i < m_noOfWrIfc; i++) {
    RefString name = RefString(new std::string("wr"));
    name->append(intToString(i));
    CSLOmInterface::buildWR(m_lineNumber, m_fileName, CSLOmUnitDecl::cast(getParent())->getDefaultInterface(), name, getWidth(), getDepth());
  }
}

void CSLOmMemoryInfo::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmFifoInfo class
// ********************************************************************************
//RefTMap_EFifoPortNames_RefString CSLOmFifoInfo::m_nameMap = RefTMap_EFifoPortNames_RefString(new TMap_EFifoPortNames_RefString);
CSLOmFifoInfo::CSLOmFifoInfo(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl parent) : 
  CSLOmUnitInfo(lineNumber, fileName),
  m_portMap(new TMap_EFifoPortNames_RefCSLOmPortDecl),
  m_childrenNoMap(new TMap_EFifoChildrenTypes_TInt),
  m_impTypeIType(IMP_UNDEF),
  m_prefixName() { 

  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_WIDTH, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_DEPTH, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_ALMOST_EMPTY, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_ALMOST_FULL, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_WR_HOLD  , INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_RD_WORDS_FIRST, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_RD_WORDS_SECOND, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_WR_WORDS_FIRST, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_WR_WORDS_SECOND, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_FLOW_THROUGH, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_PROGRAMMABLE_DEPTH, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_LOW_WATERMARK, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_HIGH_WATERMARK, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_PARALLEL_INPUT, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_PARALLEL_OUTPUT, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_DEPTH_EXTEND, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(FIFO_CHILD_WIDTH_EXTEND, INFO_CLASS_MAP_INDEX_NOT_SET));

  


  m_setLowWatermark             = FALSE;
  m_setHighWatermark            = FALSE;
  m_setDepth                    = FALSE;
  m_setWidth                    = FALSE;
  m_setImpType                  = FALSE;
  m_setAsynch                   = FALSE;
  m_setDepthExtend              = FALSE;
  m_setWidthExtend              = FALSE;
  m_setWrHold                   = FALSE;
  m_setParallelOutput           = FALSE;
  m_setParallelInput            = FALSE;
  m_rdWords                     = FALSE;
  m_wrWords                     = FALSE;
  m_flowThrough                 = FALSE;
  m_setPrefixName               = FALSE;
  m_addPortPush                 = FALSE;
  m_addPortPop                  = FALSE;
  m_addPortFull                 = FALSE;
  m_addPortEmpty                = FALSE;
  m_addPortProgrammableDepth    = FALSE;
  m_addPortPriorityBypass       = FALSE;
  m_addPortPrioritySelect       = FALSE;
  m_addPortValid                = FALSE;
  m_addPortClock                = FALSE;
  m_addPortWrClock              = FALSE;
  m_addPortRdClock              = FALSE;
  m_addPortSynchReset           = FALSE;
  m_addPortAsynchReset          = FALSE;
  m_addPortDataOut              = FALSE;
  m_addPortDataIn               = FALSE;
  m_addPortPushback             = FALSE;
  m_addPortStall                = FALSE;
  m_addPortStallRdSide          = FALSE;
  m_addPortStallWrSide          = FALSE;
  m_addPortSramRdData           = FALSE;
  m_addPortSramRdEn             = FALSE;
  m_addPortSramRdAddr           = FALSE;
  m_addPortSramWrData           = FALSE;
  m_addPortSramWrEn             = FALSE;
  m_addPortSramWrAddr           = FALSE;
  m_addPortWrRelease            = FALSE;
  m_addPortAlmostEmpty          = FALSE;
  m_addPortAlmostFull           = FALSE;
  m_addSignalWrAddress          = FALSE;
  m_addSignalRdAddress          = FALSE;
  m_addPortCredit               = FALSE;
  m_addPortRdCredit             = FALSE;
  m_addPortWrCredit             = FALSE;
  
}


void CSLOmFifoInfo::initialize() {
  RefCSLOmNum32 width = CSLOmNum32::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(), CSLOmUnitDecl::cast(getParent())->getFileName(), 1);
  addChildFifo(width, FIFO_CHILD_WIDTH);
  RefCSLOmNum32 depth = CSLOmNum32::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(), CSLOmUnitDecl::cast(getParent())->getFileName(), 2);
  addChildFifo(depth, FIFO_CHILD_DEPTH);

  addPortPush        ( );
  addPortPop         ( );
  addPortFull        ( );
  addPortEmpty       ( );
  addPortDataOut     ( );
  addPortDataIn      ( );
  addPortAsynchReset ( );
  addPortClock       ( );
  addPortValid       ( );
}


RefCSLOmFifoInfo CSLOmFifoInfo::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmFifoInfo();
  }
  else {
    return boost::static_pointer_cast<CSLOmFifoInfo>(object);
  }
}

RefCSLOmFifoInfo CSLOmFifoInfo::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit) {

  CSLOmFifoInfo* fifoInfo;
  try {
    fifoInfo = new CSLOmFifoInfo(lineNumber, fileName,unit);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmFifoInfo refFifoInfo(fifoInfo);
  fifoInfo->m_weakRef = boost::weak_ptr<CSLOmBase>( refFifoInfo);

  return refFifoInfo;
}


TInt CSLOmFifoInfo::getChildPos(EFifoChildrenTypes type) {
  TInt i = INFO_CLASS_MAP_INDEX_NOT_FOUND;
  TMap_EFifoChildrenTypes_TInt::iterator iter = m_childrenNoMap->find(type);
  if (m_childrenNoMap->end() != iter) {
    i = (*iter).second;
  }
  return i;
}

void CSLOmFifoInfo::addChildFifo(RefCSLOmBase base,EFifoChildrenTypes type) {
  ASSERT(base.get(), "null object received");
  ASSERT(FIFO_CHILD_UNDEFINED < type && FIFO_CHILD_MAX > type, "illegal value for enum");
  ASSERT(m_childrenNoMap.get(), "null map");
  TMap_EFifoChildrenTypes_TInt::iterator iter = m_childrenNoMap->find(type);
  if (m_childrenNoMap->end() != iter) {
    //    RefTVec_RefCSLOmBase children = getChildrenVec();
    (*iter).second = getChildrenSize();
  }
  base->setParent(getThis());
}


void CSLOmFifoInfo::setLowWatermark              (RefCSLOmExpr numericExpression) {
  ASSERT(numericExpression.get(), "null expression received");
  ASSERT(numericExpression->isNumber(), "expecting numeric expression");
  RefCSLOmNumber lowWatermark = CSLOmNumber::cast(numericExpression);
  ASSERT(lowWatermark.get(), "null object");
  addChildFifo(lowWatermark, FIFO_CHILD_LOW_WATERMARK);
  m_setLowWatermark = TRUE;
}

void CSLOmFifoInfo::setHighWatermark             (RefCSLOmExpr numericExpression) {
  ASSERT(numericExpression.get(), "null expression received");
  ASSERT(numericExpression->isNumber(), "expecting numeric expression");
  RefCSLOmNumber highWatermark = CSLOmNumber::cast(numericExpression);
  ASSERT(highWatermark.get(), "null object");
  addChildFifo(highWatermark, FIFO_CHILD_HIGH_WATERMARK);
  m_setHighWatermark = TRUE;
}

void CSLOmFifoInfo::setDepth                     (RefCSLOmExpr numericExpression) {
//   ASSERT(numericExpression.get(), "null expression received");
//   ASSERT( numericExpression->isNumber(), "expecting numeric expression for depth");

  //for design checker
  m_mandatoryCounter++;

  TInt pos = getChildPos(FIFO_CHILD_DEPTH);
  setChild(pos, numericExpression);
//   ASSERT(base.get(), "null object");
//   ASSERT(base->isExpr(), "expecting expression");
//   RefCSLOmExpr expr = CSLOmExpr::cast(base);
//   ASSERT(expr->isNumber(), "expecting numeric expression");
//   RefCSLOmNumber number = CSLOmNumber::cast(expr);
//   ASSERT(number->getNumType(), "expecting num32");
//   RefCSLOmNum32 depth = CSLOmNum32::cast(number);

//   RefCSLOmNumber num2 = CSLOmNumber::cast(numericExpression);
//   ASSERT(CSLOmNumber::NUM_INT32 == num2->getNumType(), "expecting num32");
//   RefCSLOmNum32 num32 = CSLOmNum32::cast(num2);

  //  depth->setValue(num32->getValue());
  m_setDepth = TRUE;

//   TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(depth->getValue()))));
//   if (depth->getValue() == 1) {
//     t = 1;
//   }

  RefCSLOmExpr num = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_UNARY_LOG_2, numericExpression);
  TBool wasSet = getAddSignalWrAddress();
  if (wasSet) {
    RefCSLOmBase wrAddrBase = CSLOmUnitDecl::cast(getParent())->getAttachedScope()->lookupLocal(RefString(new std::string("wr_addr")));
    ASSERT(wrAddrBase.get(), "null object found");
    ASSERT(wrAddrBase->isSignal(), "expecting signal");
    RefCSLOmSignal  wrAddr = CSLOmSignal::cast(wrAddrBase);
    ASSERT(!wrAddr->hasBitRange(), "width already set");
    wrAddr->setWidth(num);
  }

  wasSet = getAddSignalRdAddress();

  if (wasSet) {
    RefCSLOmBase rdAddrBase = CSLOmUnitDecl::cast(getParent())->getAttachedScope()->lookupLocal(RefString(new std::string("rd_addr")));
    ASSERT(rdAddrBase.get(), "null object found");
    ASSERT(rdAddrBase->isSignal(), "expecting signal");
    RefCSLOmSignal rdAddr = CSLOmSignal::cast(rdAddrBase);
    ASSERT(!rdAddr->hasBitRange(), "width already set");
    rdAddr->setWidth(num);
  }

  TMap_EFifoPortNames_RefCSLOmPortDecl::iterator iter = m_portMap->begin();
  while (iter != m_portMap->end()) {
    if (FIFO_PN_SRAM_RD_ADDR == iter->first 
        || FIFO_PN_SRAM_WR_ADDR == iter->first ) {
      iter->second->setWidth(num);
    }
    ++iter;
  }
  
}


void CSLOmFifoInfo::setWidth                     (RefCSLOmExpr numericExpression) {
  ASSERT(numericExpression.get(), "null expression received");
  //  ASSERT( numericExpression->isNumber(), "expecting numeric expression for width");
  
  //for design checker
  m_mandatoryCounter++;

  TInt pos = getChildPos(FIFO_CHILD_WIDTH);
  setChild(pos, numericExpression);
//   RefCSLOmBase base = getChild(pos);
//   ASSERT(base.get(), "null object");
//   ASSERT(base->isExpr(), "expecting expression");
//   RefCSLOmExpr expr = CSLOmExpr::cast(base);
//   ASSERT(expr->isNumber(), "expecting numeric expression");
//   RefCSLOmNumber num = CSLOmNumber::cast(expr);
//   ASSERT(num->getNumType(), "expecting num32");
   RefCSLOmExpr width = numericExpression;

//   RefCSLOmNumber num2 = CSLOmNumber::cast(numericExpression);
//   ASSERT(CSLOmNumber::NUM_INT32 == num2->getNumType(), "expecting num32");
//   RefCSLOmNum32 num32 = CSLOmNum32::cast(num2);

//   width->setValue(num32->getValue());
  m_setWidth = TRUE;

  TMap_EFifoPortNames_RefCSLOmPortDecl::iterator iter = m_portMap->begin();
  while (iter != m_portMap->end()) {
    if (FIFO_PN_DATA_IN == iter->first || FIFO_PN_DATA_OUT == iter->first || FIFO_PN_PROGRAMMABLE_DEPTH == iter->first 
        || FIFO_PN_PRIORITY_SELECT == iter->first || FIFO_PN_PRIORITY_BYPASS == iter->first || FIFO_PN_SRAM_RD_DATA == iter->first
        || FIFO_PN_SRAM_WR_DATA == iter->first || FIFO_PN_CREDIT == iter->first 
        || FIFO_PN_RD_CREDIT == iter->first || FIFO_PN_WR_CREDIT == iter->first) {
      iter->second->setWidth(width);
    }
    ++iter;
  }
}

void CSLOmFifoInfo::setImpType                   (EImpType iType) {
  ASSERT(iType > IMP_UNDEF && iType < IMP_MAX, "illegal value for argument");
  m_impTypeIType = iType;
  m_setImpType = TRUE;
}

void CSLOmFifoInfo::setAsynch                    () {
  m_setAsynch = TRUE;
  //remove clock port && add wr and rd clock ports
  RefCSLOmIdentifier p = CSLOmIdentifier::cast(m_portMap->find(FIFO_PN_CLOCK)->second->getChild(ID));
  //  ASSERT(p.get(), "null object");
  if (!p.get()) { 
    RefCSLOmBase pp = p->getParent();
    ASSERT(pp.get(), "null object");
    CSLOmUnitDecl::cast(getParent())->getDefaultInterface()->removeChild(pp);
  }
  addPortWrClock() ;
  addPortRdClock() ;
}

void CSLOmFifoInfo::setDepthExtend               (RefCSLOmExpr numericExpression) {
  ASSERT(numericExpression.get(), "null expression received");
  ASSERT(numericExpression->isNumber(),"numeric expresion expected");
  RefCSLOmNumber depthExtend = CSLOmNumber::cast(numericExpression);
  addChildFifo(depthExtend, FIFO_CHILD_DEPTH_EXTEND);
  m_setDepthExtend = TRUE;
}

void CSLOmFifoInfo::setWidthExtend              (RefCSLOmExpr numericExpression) {
  ASSERT(numericExpression.get(), "null expression received");
  ASSERT(numericExpression->isNumber(),"numeric expresion expected");
  RefCSLOmNumber widthExtend = CSLOmNumber::cast(numericExpression);
  addChildFifo(widthExtend, FIFO_CHILD_WIDTH_EXTEND);
  m_setWidthExtend = TRUE;
}

void CSLOmFifoInfo::setWrHold                    (RefCSLOmExpr numericExpression) {
  ASSERT(numericExpression.get(), "null expression received");
  ASSERT(numericExpression->isNumber(),"numeric expresion expected");
  RefCSLOmNumber wrHoldExpr = CSLOmNumber::cast(numericExpression);
  addChildFifo(wrHoldExpr, FIFO_CHILD_WR_HOLD);
  m_setWrHold = TRUE;
}

void CSLOmFifoInfo::setParallelOutput            (RefTVec_RefCSLOmExpr addressVector) {
  ASSERT(addressVector.get(), "NULL parameter received");
  TVec_RefCSLOmExpr::iterator iter;
  TInt size = getChildrenSize();
  RefCSLOmContainer parallelOutput = CSLOmContainer::build(getLineNumber(), getFileName(), getThis(), TYPE_EXPR);
  for(iter = addressVector->begin(); iter != addressVector->end(); ++iter) {
    ASSERT((*iter).get(), "null expression in vector reveived");
    ASSERT((*iter)->isNumber(), "numeric expression expected");
    parallelOutput->addItem(*iter);
  }
  TMap_EFifoChildrenTypes_TInt::iterator iter2 = m_childrenNoMap->find(FIFO_CHILD_PARALLEL_OUTPUT);
  ASSERT(m_childrenNoMap->end() != iter2, "map entry should exist at this point");
  iter2->second = size;
  m_setParallelOutput = TRUE;
}

void CSLOmFifoInfo::setParallelInput             (RefTVec_RefCSLOmExpr addressVector) {
  ASSERT(addressVector.get(), "NULL parameter");
  TVec_RefCSLOmExpr::iterator iter ;
  TInt size = getChildrenSize();
  RefCSLOmContainer parallelInput = CSLOmContainer::build(getLineNumber(), getFileName(),getThis(), TYPE_EXPR );
  for (iter = addressVector->begin(); iter != addressVector->end(); ++iter) {
    ASSERT((*iter).get(), "null expression in vector reveived");
    ASSERT((*iter)->isNumber(), "numeric expression expected");
    parallelInput->addItem(*iter);
  }
  TMap_EFifoChildrenTypes_TInt::iterator iter2 = m_childrenNoMap->find(FIFO_CHILD_PARALLEL_INPUT);
  ASSERT(m_childrenNoMap->end() != iter2, "map entry should exist at this point");
  iter2->second = size;
  m_setParallelInput = TRUE;
}

void CSLOmFifoInfo::rdWords                      (RefCSLOmExpr expression1, RefCSLOmExpr expression2) {
  ASSERT(expression1.get(), "null expression received");
  ASSERT(expression1->isNumber(), "numeric expression expected");
  ASSERT(expression2.get(), "null expression received");
  ASSERT(expression2->isNumber(), "numeric expression expected");
  RefCSLOmNumber rdWordsExpressionFirst = CSLOmNumber::cast(expression1);
  RefCSLOmNumber rdWordsExpressionSecond = CSLOmNumber::cast(expression2);
  addChildFifo(rdWordsExpressionFirst, FIFO_CHILD_RD_WORDS_FIRST);
  addChildFifo(rdWordsExpressionSecond, FIFO_CHILD_RD_WORDS_SECOND);
  m_rdWords = TRUE;
}

void CSLOmFifoInfo::wrWords                      (RefCSLOmExpr expression1, RefCSLOmExpr expression2) {
  ASSERT(expression1.get(), "null expression received");
  ASSERT(expression1->isNumber(), "numeric expression expected");
  ASSERT(expression2.get(), "null expression received");
  ASSERT(expression2->isNumber(), "numeric expression expected");
  RefCSLOmNumber wrWordsExpressionFirst = CSLOmNumber::cast(expression1);
  RefCSLOmNumber wrWordsExpressionSecond = CSLOmNumber::cast(expression2);
  addChildFifo(wrWordsExpressionFirst, FIFO_CHILD_WR_WORDS_FIRST);
  addChildFifo(wrWordsExpressionSecond, FIFO_CHILD_WR_WORDS_SECOND);
  m_wrWords = TRUE;
}

void CSLOmFifoInfo::flowThrough                   (RefCSLOmExpr expression) {
  ASSERT(expression.get(), "null expressoin received");
  ASSERT(expression->isNumber(), "numeric expression expected");
  RefCSLOmNumber flowThroughExpression = CSLOmNumber::cast(expression);
  addChildFifo(flowThroughExpression, FIFO_CHILD_FLOW_THROUGH);
  m_flowThrough = TRUE;
}

void CSLOmFifoInfo::setPrefixName                (const RefString prefixName) {
  ASSERT(prefixName.get(), "null argument received");
  m_prefixName = prefixName;
  m_setPrefixName = TRUE;
}

void CSLOmFifoInfo::addPort(RefString& portName, EFifoPortNames portEnum, ECSLOmPortDirection portType, RefCSLOmExprLink bitRange, 
                            ECSLOmSignalType signalType) {
  RefCSLOmExprLink brLink = bitRange;
  RefCSLOmPortDecl portDecl = RefCSLOmPortDecl();
  if (!bitRange.get()) {
    if (FIFO_PN_DATA_IN != portEnum && FIFO_PN_DATA_OUT != portEnum && FIFO_PN_PROGRAMMABLE_DEPTH != portEnum 
        && FIFO_PN_PRIORITY_SELECT != portEnum && FIFO_PN_PRIORITY_BYPASS != portEnum && FIFO_PN_SRAM_RD_DATA != portEnum 
        && FIFO_PN_SRAM_RD_ADDR != portEnum && FIFO_PN_SRAM_WR_ADDR != portEnum && FIFO_PN_SRAM_WR_DATA != portEnum 
        && FIFO_PN_CREDIT != portEnum && FIFO_PN_RD_CREDIT != portEnum && FIFO_PN_WR_CREDIT != portEnum) {
      RefCSLOmExpr width = CSLOmNum32::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), 1);
      RefCSLOmSimpleBitRange br = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(),CSLOmUnitDecl::cast(getParent()),RefString(new std::string("")), width);
      brLink = br->getBitRangeLink();
    }
  }
  if (FIFO_PN_DATA_OUT == portEnum) {
    signalType = SIGNAL_REG;
  }
  portDecl = CSLOmUnitDecl::cast(getParent())->addPort(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), portType, signalType, portName, brLink);
  TMap_EFifoPortNames_RefCSLOmPortDecl::iterator it = m_portMap->find(portEnum);
  if (it != m_portMap->end()) {
    m_portMap->erase(it);
  }
  m_portMap->insert(std::make_pair( portEnum, portDecl));
}

void CSLOmFifoInfo::addPortPush                  (RefString signalName ) {
  RefString name;
  if(m_addPortPush == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_PUSH)->second);
  }
  else {
    name = RefString(new std::string("push"));
  }
  //   if (signalName.get()){
  //     name->insert(0, "_");
  //     name->insert(0, *signalName); 
  //   }
  addPort(name, FIFO_PN_PUSH);
  m_addPortPush = TRUE;
}

void CSLOmFifoInfo::addPortPop                   (RefString signalName ) {
  RefString name;
  if(m_addPortPop == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_POP)->second);
  }
  else {
    name = RefString(new std::string("pop"));
  }
//   RefString name = RefString(new std::string("pop"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName); 
//   }
  addPort(name, FIFO_PN_POP);
  m_addPortPop = TRUE;
}

void CSLOmFifoInfo::addPortFull                  (RefString signalName ) {
  RefString name;
  if(m_addPortFull == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_FULL)->second);
  }
  else {
    name = RefString(new std::string("full"));
  }
//   RefString name = RefString(new std::string("full"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, FIFO_PN_FULL, OUTPUT, RefCSLOmExprLink(), SIGNAL_REG);
  m_addPortFull = TRUE;
}

void CSLOmFifoInfo::addPortEmpty                 (RefString signalName ) {
  RefString name;
  if(m_addPortEmpty == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_EMPTY)->second);
  }
  else {
    name = RefString(new std::string("empty"));
  }
//   RefString name = RefString(new std::string("empty"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, FIFO_PN_EMPTY, OUTPUT, RefCSLOmExprLink(), SIGNAL_REG);
  m_addPortEmpty = TRUE;
}

void CSLOmFifoInfo::addPortProgrammableDepth     (RefCSLOmExpr expression, RefString signalName) {
  ASSERT(expression.get(), "null expression");
  ASSERT(expression->isNumber(), "expecting numeric expression");

  RefString name = RefString(new std::string("programmable_depth"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink brLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_PROGRAMMABLE_DEPTH, INPUT, brLink);
  }
  else {
    addPort(name, FIFO_PN_PROGRAMMABLE_DEPTH);
  }
  RefCSLOmNumber programmableDepthDefaultExpr = CSLOmNumber::cast(expression);
  addChildFifo(programmableDepthDefaultExpr, FIFO_CHILD_PROGRAMMABLE_DEPTH);
  m_addPortProgrammableDepth = TRUE;
}

void CSLOmFifoInfo::addPortPriorityBypass        (RefString signalName ) {
  RefString name = RefString(new std::string("priority_bypass"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink brLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_PRIORITY_BYPASS, OUTPUT, brLink);
  }
  else {
    addPort(name, FIFO_PN_PRIORITY_BYPASS, OUTPUT);
  }
  m_addPortPriorityBypass = TRUE;
}

void CSLOmFifoInfo::addPortPrioritySelect        (RefString signalName ) {
  RefString name = RefString(new std::string("priority_select"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink exprLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_PRIORITY_SELECT, INPUT, exprLink);
  }
  else {
    addPort(name, FIFO_PN_PRIORITY_SELECT);
  }
  m_addPortPrioritySelect = TRUE;
}

void CSLOmFifoInfo::addPortValid                 (RefString signalName ) {
  RefString name;
  if(m_addPortValid == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_VALID)->second);
  }
  else {
    name = RefString(new std::string("valid"));
  }
//   RefString name = RefString(new std::string("valid"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, FIFO_PN_VALID, OUTPUT);
  m_addPortValid = TRUE;
}

void CSLOmFifoInfo::addPortClock                 (RefString clockName ) {
  RefString name;
  if(m_addPortClock == TRUE) {
    ASSERT(clockName.get(), "null name");
    ASSERT(!clockName->empty(), "empty name");
    name = clockName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_CLOCK)->second);
  }
  else {
    name = RefString(new std::string("clock"));
  }
//   RefString name = RefString(new std::string("clock"));
//   if (clockName.get()){
//     name->insert(0, "_");
//     name->insert(0, *clockName);
//   }
  addPort(name, FIFO_PN_CLOCK);
  m_addPortClock = TRUE;
}

void CSLOmFifoInfo::addPortRdClock               (RefString clockName ) {
  RefString name;
  if(m_addPortRdClock == TRUE) {
    ASSERT(clockName.get(), "null name");
    ASSERT(!clockName->empty(), "empty name");
    name = clockName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_RD_CLOCK)->second);
  }
  else {
    name = RefString(new std::string("rd_clock"));
  }
//   RefString name = RefString(new std::string("rd_clock"));
//   if (clockName.get()){
//     name->insert(0, "_");
//     name->insert(0, *clockName);
//   }
  addPort(name, FIFO_PN_RD_CLOCK);
  m_addPortRdClock = TRUE;
}
 
void CSLOmFifoInfo::addPortWrClock               (RefString clockName ) {
  RefString name;
  if(m_addPortWrClock == TRUE) {
    ASSERT(clockName.get(), "null name");
    ASSERT(!clockName->empty(), "empty name");
    name = clockName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_WR_CLOCK)->second);
  }
  else {
    name = RefString(new std::string("wr_clock"));
  }
//   RefString name = RefString(new std::string("wr_clock"));
//   if (clockName.get()){
//     name->insert(0, "_");
//     name->insert(0, *clockName);
//   }
  addPort(name, FIFO_PN_WR_CLOCK);
  m_addPortWrClock = TRUE;
}
 
void CSLOmFifoInfo::addPortSynchReset            (RefString resetName ) {
  RefString name = RefString(new std::string("reset"));
  if (resetName.get()){
    name->insert(0, "_");
    name->insert(0, *resetName);
  }
  addPort(name, FIFO_PN_SYNCH_RESET);
  m_addPortSynchReset = TRUE;
}

void CSLOmFifoInfo::addPortAsynchReset           (RefString resetName ) {
  RefString name = RefString(new std::string("reset_"));
  if (resetName.get()){
    name->insert(0, "_");
    name->insert(0, *resetName);
  }
  addPort(name, FIFO_PN_ASYNCH_RESET);
  m_addPortAsynchReset = TRUE;
}

void CSLOmFifoInfo::addPortDataOut               (RefString signalName) {
  RefString name;
  if(m_addPortDataOut == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_DATA_OUT)->second);
  }
  else {
    name = RefString(new std::string("rd_data"));
  }
//   RefString name = RefString(new std::string("data_out"));
//   if (signalName.get()) {
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }

  if (getSetWidth()) {
    RefCSLOmExprLink exprLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_DATA_OUT, OUTPUT, exprLink);
  }
  else {
    addPort(name, FIFO_PN_DATA_OUT, OUTPUT);
  }
  m_addPortDataOut = TRUE;
}

void CSLOmFifoInfo::addPortDataIn                (RefString signalName) {
  RefString name;
  if(m_addPortDataIn == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(FIFO_PN_DATA_IN)->second);
  }
  else {
    name = RefString(new std::string("wr_data"));
  }
//   RefString name = RefString(new std::string("data_in"));
//   if (signalName.get()) {
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }

  if (getSetWidth()) {
    RefCSLOmExprLink exprLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_DATA_IN, INPUT, exprLink);
  }
  else {
    addPort(name, FIFO_PN_DATA_IN);
  }
  m_addPortDataIn = TRUE;
}

void CSLOmFifoInfo::addPortPushback              (RefString signalName) {
  RefString name = RefString(new std::string("pushback"));
  if (signalName.get()) {
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_PUSHBACK);
  m_addPortPushback = TRUE;
}

void CSLOmFifoInfo::addPortStall                 (RefString signalName) {
  RefString name = RefString(new std::string("stall"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_STALL);
  m_addPortStall = TRUE;
}

void CSLOmFifoInfo::addPortStallRdSide           (RefString signalName) {
  RefString name = RefString(new std::string("stall_rd_side"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_STALL_RD_SIDE);
  m_addPortStallRdSide = TRUE;
}
  
void CSLOmFifoInfo::addPortStallWrSide           (RefString signalName) {
  RefString name = RefString(new std::string("stall_wr_side"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_STALL_WR_SIDE);
  m_addPortStallWrSide = TRUE;
}

void CSLOmFifoInfo::addPortWrRelease             (RefString signalName) {
  RefString name = RefString(new std::string("wr_release"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_WR_RELEASE);
  m_addPortWrRelease = TRUE;
}

void CSLOmFifoInfo::addPortSramRdData            (RefString signalName) {
  RefString name = RefString(new std::string("sram_rd_data"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink exprLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_SRAM_RD_DATA, OUTPUT, exprLink);
  }
  else {
    addPort(name, FIFO_PN_SRAM_RD_DATA, OUTPUT);
  }
  m_addPortSramRdData = TRUE;
}

void CSLOmFifoInfo::addPortSramRdEn              (RefString signalName) {
  RefString name = RefString(new std::string("sram_rd_en"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_SRAM_RD_EN);
  m_addPortSramRdEn = TRUE;
}

void CSLOmFifoInfo::addPortSramRdAddr            (RefString signalName) {
  RefString name = RefString(new std::string("sram_rd_addr"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetDepth()) {
    RefCSLOmExpr depth = getDepth();
//     TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(depth->getValue()))));
//     if (depth->getValue() == 1) {
//       t = 1;
//     }

    RefCSLOmExpr width = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_UNARY_LOG_2, depth);
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), width);
    RefCSLOmExprLink brLink = bitRange->getBitRangeLink();
    addPort(name, FIFO_PN_SRAM_RD_ADDR, OUTPUT, brLink);
  }
  else {
    addPort(name, FIFO_PN_SRAM_RD_ADDR, OUTPUT);
  }
  m_addPortSramRdAddr = TRUE;
}

void CSLOmFifoInfo::addPortSramWrData            (RefString signalName) {
  RefString name = RefString(new std::string("sram_wr_data"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink brLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_SRAM_WR_ADDR, OUTPUT, brLink);
  }
  else {
    addPort(name, FIFO_PN_SRAM_WR_ADDR, OUTPUT);
  }
  m_addPortSramWrData = TRUE;
}

void CSLOmFifoInfo::addPortSramWrEn              (RefString signalName) {
  RefString name = RefString(new std::string("sram_wr_en"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_SRAM_WR_EN);
  m_addPortSramWrEn = TRUE;
}

void CSLOmFifoInfo::addPortSramWrAddr            (RefString signalName) {
  RefString name = RefString(new std::string("sram_wr_addr"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetDepth()) {
    RefCSLOmExpr depth = getDepth();
//     TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(depth->getValue()))));
//     if (depth->getValue() == 1) {
//       t = 1;
//     }

    RefCSLOmExpr width = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_UNARY_LOG_2, depth);
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), width);
    RefCSLOmExprLink brLink = bitRange->getBitRangeLink();
    addPort(name, FIFO_PN_SRAM_WR_ADDR, INPUT, brLink);
  }
  else {
    addPort(name, FIFO_PN_SRAM_WR_ADDR);
  }
  m_addPortSramWrAddr = TRUE;
}

void CSLOmFifoInfo::addPortAlmostEmpty     (RefCSLOmExpr addr, RefString address) {
  ASSERT(addr.get(), "null expression received");
  ASSERT(addr->isNumber(), "numeric expression expected");
  RefString name = RefString(new std::string("almost_empty"));
  if (address.get()){
    name->insert(0, "_");
    name->insert(0, *address);
  }
  addPort(name, FIFO_PN_ALMOST_EMPTY, OUTPUT);
  RefCSLOmNumber almostEmptyAddress = CSLOmNumber::cast(addr);
  addChildFifo(almostEmptyAddress, FIFO_CHILD_ALMOST_EMPTY);
  m_addPortAlmostEmpty = TRUE;
}
  
void CSLOmFifoInfo::addPortAlmostFull      (RefCSLOmExpr addr, RefString address) {
  ASSERT(addr.get(), "null expression received");
  ASSERT(addr->isNumber(), "numeric expression expected");
  RefString name = RefString(new std::string("almost_full"));
  if (address.get()){
    name->insert(0, "_");
    name->insert(0, *address);
  }
  addPort(name, FIFO_PN_ALMOST_FULL, OUTPUT);
  RefCSLOmNumber almostFullAddress = CSLOmNumber::cast(addr);
  addChildFifo(almostFullAddress, FIFO_CHILD_ALMOST_FULL);
  m_addPortAlmostFull = TRUE;
}
  
void CSLOmFifoInfo::addSignalWrAddress       (RefString signalName) {
  RefString name = RefString(new std::string("wr_addr"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  RefCSLOmSignal wrAddress = RefCSLOmSignal();
  if (!getSetDepth()) {
    wrAddress = CSLOmUnitDecl::cast(getParent())->addSignal(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), name, SIGNAL_WIRE);
  }
  else {
    RefCSLOmExpr depth = getDepth();
//     TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(depth->getValue()))));
//     if (depth->getValue() == 1) {
//       t = 1;
//     }
    RefCSLOmExpr num = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_UNARY_LOG_2, depth);
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), num);
    RefCSLOmExprLink exprLink = bitRange->getBitRangeLink();
    wrAddress = CSLOmUnitDecl::cast(getParent())->addSignal(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), name, SIGNAL_WIRE, exprLink);
  }
  m_addSignalWrAddress = TRUE;
}
  
void CSLOmFifoInfo::addSignalRdAddress       (RefString signalName) {
  RefString name = RefString(new std::string("rd_addr"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  RefCSLOmSignal rdAddress = RefCSLOmSignal();
  if (!getSetDepth()) {
    rdAddress = CSLOmUnitDecl::cast(getParent())->addSignal(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), name, SIGNAL_WIRE);
  }
  else {
    RefCSLOmExpr depth = getDepth();
//     TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(depth->getValue()))));
//     if (depth->getValue() == 1) {
//       t = 1;
//     }

    RefCSLOmExpr num = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_UNARY_LOG_2, depth);
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), num);
    RefCSLOmExprLink exprLink = bitRange->getBitRangeLink();
    rdAddress = CSLOmUnitDecl::cast(getParent())->addSignal(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), name, SIGNAL_WIRE, exprLink);
  }
  m_addSignalRdAddress = TRUE;
}

void CSLOmFifoInfo::addPortCredit                (RefString signalName )  {
  RefString name = RefString(new std::string("credit"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink exprLink = getWidthAsBitRangeLink();;
    addPort(name, FIFO_PN_CREDIT, OUTPUT, exprLink);
  }
  else {
    addPort(name, FIFO_PN_CREDIT, OUTPUT);
  }
  m_addPortCredit = TRUE;
}

void CSLOmFifoInfo::addPortRdCredit              (RefString signalName )  {
  RefString name = RefString(new std::string("rd_credit"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink exprLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_RD_CREDIT, OUTPUT, exprLink);
  }
  else {
    addPort(name, FIFO_PN_RD_CREDIT, OUTPUT);
  }
  m_addPortRdCredit = TRUE;
}

void CSLOmFifoInfo::addPortWrCredit              (RefString signalName )  {
  RefString name = RefString(new std::string("wr_credit"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  if (getSetWidth()) {
    RefCSLOmExprLink exprLink = getWidthAsBitRangeLink();
    addPort(name, FIFO_PN_WR_CREDIT, OUTPUT, exprLink);
  }
  else {
    addPort(name, FIFO_PN_WR_CREDIT, OUTPUT);
  }
  m_addPortWrCredit = TRUE;
}

void CSLOmFifoInfo::addPortOverflow  (RefString signalName) {
  RefString name = RefString(new std::string("overflow"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_OVERFLOW, OUTPUT);  
  m_addPortOverflow = TRUE;
}

void CSLOmFifoInfo::addPortUnderflow  (RefString signalName) {
  RefString name = RefString(new std::string("underflow"));
  if (signalName.get()){
    name->insert(0, "_");
    name->insert(0, *signalName);
  }
  addPort(name, FIFO_PN_UNDERFLOW, OUTPUT);  
  m_addPortUnderflow = TRUE;
}

RefCSLOmExpr  CSLOmFifoInfo::getWidth                                ()   {
  TInt pos = getChildPos(FIFO_CHILD_WIDTH);    
  return CSLOmExpr::cast(getChild(pos));
}

RefCSLOmExprLink CSLOmFifoInfo::getWidthAsBitRangeLink                   () {
  RefCSLOmExprLink link = RefCSLOmExprLink();
  RefCSLOmExpr width = getWidth();
  if (width.get()) {
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), width);
    link = bitRange->getBitRangeLink();
  }
  return link;
}

RefCSLOmNumber  CSLOmFifoInfo::getDepth                                ()   {
  TInt pos = getChildPos(FIFO_CHILD_DEPTH);    
  RefCSLOmBase depthBase = getChild(pos);
  ASSERT(depthBase->isExpr(), "expecting expression");
  RefCSLOmExpr depthExpr = CSLOmExpr::cast(depthBase);
  ASSERT(depthExpr->isNumber(), "expecting numeric expression");
  RefCSLOmNumber depth = CSLOmNumber::cast(depthExpr);
  return depth;
}

RefCSLOmExprLink CSLOmFifoInfo::getDepthAsBitRangeLink                   () {
  RefCSLOmExprLink link = RefCSLOmExprLink();
  RefCSLOmExpr depth = getDepth();
  if (depth.get()) {
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), depth);
    link = bitRange->getBitRangeLink();
  }
  return link;
}

RefString CSLOmFifoInfo::getPrefixName                                  () {
  RefString prefix = RefString();
  TBool wasSet = getSetPrefixName();
  if (wasSet) {
    prefix = m_prefixName;
  }
  return prefix;
}

CSLOmFifoInfo::EImpType  CSLOmFifoInfo::getImpType                                     () {
  EImpType type = IMP_UNDEF;
  TBool wasSet = getSetImpType();
  if (wasSet) {
    type = m_impTypeIType;
  }
  return type;
}


TBool CSLOmFifoInfo::getSetLowWatermark                    ()             {
  return m_setLowWatermark;
}

TBool CSLOmFifoInfo::getSetHighWatermark                   ()             {
  return m_setHighWatermark;
}

TBool CSLOmFifoInfo::getSetDepth                           ()             {
  return m_setDepth;
}

TBool CSLOmFifoInfo::getSetWidth                           ()             {
  return m_setWidth;
}

TBool CSLOmFifoInfo::getSetImpType                         ()             {
  return m_setImpType;
}

TBool CSLOmFifoInfo::getSetAsynch                          ()             {
  return m_setAsynch;
}

TBool CSLOmFifoInfo::getSetDepthExtend                     ()             {
  return m_setDepthExtend;
}

TBool CSLOmFifoInfo::getSetWidthExtend                     ()             {
  return m_setWidthExtend;
}

TBool CSLOmFifoInfo::getSetWrHold                          ()             {
  return m_setWrHold;
}

TBool CSLOmFifoInfo::getSetParallelOutput                  ()             {
  return m_setParallelOutput;
}

TBool CSLOmFifoInfo::getSetParallelInput                   ()             {
  return m_setParallelInput;
}

TBool CSLOmFifoInfo::getRdWords                            ()             {
  return m_rdWords;
}

TBool CSLOmFifoInfo::getWrWords                            ()             {
  return m_wrWords;
}

TBool CSLOmFifoInfo::getFlowThrough                        ()             {
  return m_flowThrough;
}

TBool CSLOmFifoInfo::getSetPrefixName                      ()             {
  return  m_setPrefixName;
}

TBool CSLOmFifoInfo::getAddPortPush                        ()             {
  return m_addPortPush;
}

TBool CSLOmFifoInfo::getAddPortPop                         ()             {
  return m_addPortPop;
}

TBool CSLOmFifoInfo::getAddPortFull                        ()             {
  return m_addPortFull;
}

TBool CSLOmFifoInfo::getAddPortEmpty                       ()             {
  return m_addPortEmpty;
}

TBool CSLOmFifoInfo::getAddPortProgrammableDepth           ()             {
  return m_addPortProgrammableDepth;
}

TBool CSLOmFifoInfo::getAddPortPriorityBypass              ()             {
  return m_addPortPriorityBypass;
}

TBool CSLOmFifoInfo::getAddPortPrioritySelect              ()             {
  return m_addPortPrioritySelect;
}

TBool CSLOmFifoInfo::getAddPortValid                       ()             {
  return m_addPortValid;
}

TBool CSLOmFifoInfo::getAddPortClock                       ()             {
  return m_addPortClock;
}

TBool CSLOmFifoInfo::getAddPortRdClock                     ()             {
  return m_addPortRdClock;
}

TBool CSLOmFifoInfo::getAddPortWrClock                     ()             {
  return m_addPortWrClock;
}

TBool CSLOmFifoInfo::getAddPortSynchReset                  ()             {
  return m_addPortSynchReset;
}

TBool CSLOmFifoInfo::getAddPortAsynchReset                 ()             {
  return m_addPortAsynchReset;
}

TBool CSLOmFifoInfo::getAddPortDataOut                     ()             {
  return m_addPortDataOut;
}

TBool CSLOmFifoInfo::getAddPortDataIn                      ()             {
  return  m_addPortDataIn;
}

TBool CSLOmFifoInfo::getAddPortPushback                    ()             {
  return m_addPortPushback;
}

TBool CSLOmFifoInfo::getAddPortStall                       ()             {
  return m_addPortStall;
}

TBool CSLOmFifoInfo::getAddPortStallRdSide                 ()             {
  return m_addPortStallRdSide;
}

TBool CSLOmFifoInfo::getAddPortStallWrSide                 ()             {
  return m_addPortStallWrSide;
}

TBool CSLOmFifoInfo::getAddPortSramRdData                  ()             {
  return m_addPortSramRdData;
}

TBool CSLOmFifoInfo::getAddPortSramRdEn                    ()             {
  return m_addPortSramRdEn;
}

TBool CSLOmFifoInfo::getAddPortSramRdAddr                  ()             {
  return m_addPortSramRdAddr;
}

TBool CSLOmFifoInfo::getAddPortSramWrData                  ()             {
  return m_addPortSramWrData;
}

TBool CSLOmFifoInfo::getAddPortSramWrEn                    ()             {
  return m_addPortSramWrEn;
}

TBool CSLOmFifoInfo::getAddPortSramWrAddr                  ()             {
  return m_addPortSramWrAddr;
}

TBool CSLOmFifoInfo::getAddPortWrRelease                   ()             {
  return m_addPortWrRelease;
}

TBool CSLOmFifoInfo::getAddPortAlmostEmpty                 ()             {
  return m_addPortAlmostEmpty;
}

TBool CSLOmFifoInfo::getAddPortAlmostFull                  ()             {
  return m_addPortAlmostFull;
}

TBool CSLOmFifoInfo::getAddSignalWrAddress                   ()             {
  return m_addSignalWrAddress;
}

TBool CSLOmFifoInfo::getAddSignalRdAddress                   ()             {
  return m_addSignalRdAddress;
}

TBool CSLOmFifoInfo::getAddPortCredit                      ()             {
  return  m_addPortCredit;
}

TBool CSLOmFifoInfo::getAddPortRdCredit                    ()             {
  return m_addPortRdCredit;
}

TBool CSLOmFifoInfo::getAddPortWrCredit                    ()             {
  return m_addPortWrCredit;
}

TBool CSLOmFifoInfo::getAddPortOverflow                    ()           {
  return m_addPortOverflow;
}

TBool CSLOmFifoInfo::getAddPortUnderflow                   ()           {
  return m_addPortUnderflow;
}

void CSLOmFifoInfo::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmRegisterFileInfo class
// ********************************************************************************

CSLOmRegisterFileInfo::CSLOmRegisterFileInfo(TLineNumberType lineNumber, RefString fileName,RefCSLOmUnitDecl parent) : 
  CSLOmUnitInfo(lineNumber, fileName),
  m_portMap(new TMap_ERFPortNames_RefCSLOmPortDecl),
  m_childrenNoMap(new TMap_ERFChildrenTypes_TInt)
{


  m_childrenNoMap->insert(std::make_pair(RF_CHILDTYPE_WIDTH, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(RF_CHILDTYPE_DEPTH, INFO_CLASS_MAP_INDEX_NOT_SET));  
  m_childrenNoMap->insert(std::make_pair(RF_CHILDTYPE_FIELD_FIELD, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(RF_CHILDTYPE_FIELD_EXPR, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(RF_CHILDTYPE_EXTERNAL_EXPR, INFO_CLASS_MAP_INDEX_NOT_SET));
  m_childrenNoMap->insert(std::make_pair(RF_CHILDTYPE_EXTERNAL_PORT, INFO_CLASS_MAP_INDEX_NOT_SET));

  m_setWidth                    = FALSE;
  m_setDepth                    = FALSE;
  m_createRtlModule             = FALSE;
  m_setConstValue               = FALSE;
  m_setField                    = FALSE;
  m_setExternal                 = FALSE;
  m_setPrefix                   = FALSE;
  m_setGroupName                = FALSE;
  m_disconnectRegFieldsFromIos  = FALSE;
  m_connectRegFieldsToIos       = FALSE;
  m_addPortClock                = FALSE;
  m_addPortReset                = FALSE;
  m_addPortClear                = FALSE;
  m_addPortWrAddr               = FALSE;
  m_addPortRdAddr1              = FALSE;
  m_addPortRdAddr2              = FALSE;
  m_addPortWrData               = FALSE;
  m_addPortRdData1              = FALSE;
  m_addPortRdData2              = FALSE;
  m_addPortWrEn                 = FALSE;
  m_addPortRdEn1                = FALSE;
  m_addPortRdEn2                = FALSE;
  m_addPortValid                = FALSE;

}

void CSLOmRegisterFileInfo::initialize() {
  RefCSLOmNum32 width = CSLOmNum32::build(getLineNumber(), getFileName(), 1);
  addChildRegisterFile(width, RF_CHILDTYPE_WIDTH);
  m_setWidth = FALSE;

  RefCSLOmNum32 depth = CSLOmNum32::build(getLineNumber(), getFileName(), 2);
  addChildRegisterFile(depth, RF_CHILDTYPE_DEPTH);
  m_setDepth = FALSE;

  addPortReset   ( );
  addPortClear   ( );
  addPortClock   ( );
  addPortWrAddr  ( );
  addPortRdAddr  ( );
  addPortRdAddrS ( );
  addPortDataIn  ( );
  addPortDataOut ( );
  addPortDataOutS( );
  addPortWrEn    ( );
  addPortRdEn    ( );
  addPortRdEnS   ( );
  addPortValid   ( );
}

RefCSLOmRegisterFileInfo CSLOmRegisterFileInfo::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmUnitDecl unit) {

  CSLOmRegisterFileInfo* regFileInfo;
  try {
    regFileInfo = new CSLOmRegisterFileInfo(lineNumber, fileName, unit);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmRegisterFileInfo refRegisterFileInfo(regFileInfo);
  regFileInfo->m_weakRef = boost::weak_ptr<CSLOmBase>( refRegisterFileInfo);

  return refRegisterFileInfo;
}


RefCSLOmRegisterFileInfo CSLOmRegisterFileInfo::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmRegisterFileInfo();
  }
  else {
    RefCSLOmUnitInfo rfInfo = CSLOmUnitInfo::cast(object);
    return boost::static_pointer_cast<CSLOmRegisterFileInfo>(rfInfo);
  }
}

TInt CSLOmRegisterFileInfo::getChildPos(ERFChildrenTypes type) {
  TInt i = INFO_CLASS_MAP_INDEX_NOT_FOUND;
  TMap_ERFChildrenTypes_TInt_const_iter iter = m_childrenNoMap->find(type);
  if (m_childrenNoMap->end() != iter){
    i = iter->second;
  }
  return i;
}

void CSLOmRegisterFileInfo::addChildRegisterFile(RefCSLOmBase base, ERFChildrenTypes type) {
  ASSERT(base.get(), "null object");
  TMap_ERFChildrenTypes_TInt::iterator iter = m_childrenNoMap->find(type);
  if (m_childrenNoMap->end() != iter) {
    iter->second = getChildrenSize();
  }
  base->setParent(getThis());
}


void CSLOmRegisterFileInfo::setWidth       (RefCSLOmExpr expression) {
  ASSERT(expression.get(), "null expression received");
  //  ASSERT(expression->isNumber(), "numeric expresion expected");

  //for design checker
  m_mandatoryCounter++;
  
  m_width = expression;

  TMap_ERFPortNames_RefCSLOmPortDecl::iterator iter = m_portMap->begin();
  while (m_portMap->end() != iter) {
    if (RF_PN_DATA_IN == iter->first ||
        RF_PN_DATA_OUT == iter->first || 
        RF_PN_DATA_OUT_S == iter->first) {

      if (CSLOmSimpleBitRange::cast((iter->second)->getBitRange())->isDefault()) {
        (iter->second)->setWidth(m_width);
      }
    }
    ++iter;
  }

  m_setWidth = TRUE;
}

void CSLOmRegisterFileInfo::setDepth       (RefCSLOmExpr expression) {
  //  ASSERT(expression.get(), "null object");
  //  ASSERT(expression->isNumber(), "numeric expresion expected");
  TInt pos = getChildPos(RF_CHILDTYPE_DEPTH);
  setChild(pos, expression);
  RefCSLOmExpr depth = getDepth();
  //  ASSERT(depth.get(), "null object");
  //  ASSERT(CSLOmNumber::NUM_INT32 == depth->getNumType(), "num32 expected");

  //for design checker
  m_mandatoryCounter++;

//   RefCSLOmNumber numExpr = CSLOmNumber::cast(expression);
//   ASSERT(numExpr.get(), "null object");
//   ASSERT(CSLOmNumber::NUM_INT32 == numExpr->getNumType(), "num32 expected");

//   depth->setValue(numExpr->getValue());

//   TInt t = static_cast<TInt>(::ceil(::log2(static_cast<double>(depth->getValue())))) ;
//   if (depth->getValue() == 1) {
//     t = 1;
//   }
  RefCSLOmExpr num = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_UNARY_LOG_2, depth);

  TMap_ERFPortNames_RefCSLOmPortDecl::iterator iter = m_portMap->begin();
  while (m_portMap->end() != iter) {
    if (RF_PN_WR_ADDR == iter->first ||
        RF_PN_RD_ADDR == iter->first ||
        RF_PN_RD_ADDR_S == iter->first) {

      if (CSLOmSimpleBitRange::cast((iter->second)->getBitRange())->isDefault()) {
        (iter->second)->setWidth(num);
      }
    }
    ++iter;
  }

  m_setDepth = TRUE;
}

void CSLOmRegisterFileInfo::addPort(const RefString& portName, ERFPortNames portEnum, ECSLOmPortDirection portType, 
                                    RefCSLOmExprLink bitRange, ECSLOmSignalType signalType) {
  RefCSLOmExprLink brLink = bitRange;
//   if (!bitRange.get()) {
//     if (RF_PN_WR_ADDR != portEnum || RF_PN_RD_ADDR != portEnum || 
//         RF_PN_DATA_IN != portEnum || RF_PN_DATA_OUT != portEnum) {
//       RefCSLOmExpr width = CSLOmNum32::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(), 1);
//       RefCSLOmSimpleBitRange br = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), width);
//       brLink = br->getBitRangeLink();
//     }
//     else {
//       if (getSetWidth() && (RF_PN_DATA_IN == portEnum || RF_PN_DATA_OUT == portEnum)) {
//         brLink = getWidthAsBitRangeLink();
//       }
//       else if (getSetDepth() && (RF_PN_WR_ADDR == portEnum || RF_PN_RD_ADDR == portEnum)) {
//         TInt t = static_cast<TInt>(::log2(static_cast<double>(getDepth()->getValue())));
//         RefCSLOmExpr num = CSLOmNum32::build(getLineNumber(), t);
//         RefCSLOmSimpleBitRange br = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent()),RefString(new std::string("")), num);
//         brLink = br->getBitRangeLink();
//       }
//     }
//   }
//   if (RF_PN_DATA_OUT == portEnum) {
//     signalType = SIGNAL_REG;
//   }

  RefCSLOmPortDecl portDecl =  CSLOmUnitDecl::cast(getParent())->addPort(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), portType, signalType, portName, RefCSLOmExprLink());
  TMap_ERFPortNames_RefCSLOmPortDecl::iterator it = m_portMap->find(portEnum);
  if (it != m_portMap->end()) {
    m_portMap->erase(it);
  }
  m_portMap->insert(std::make_pair( portEnum, portDecl));
}

void CSLOmRegisterFileInfo::addPortValid   (RefString signalName) {
  RefString name;
  if (m_addPortValid == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_VALID)->second);
  }
  else {
    name = RefString(new std::string("valid"));
  }
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_VALID, OUTPUT);
  m_addPortValid = TRUE;
}

void CSLOmRegisterFileInfo::addPortReset   (RefString resetName) {
  RefString name;
  if (m_addPortReset == TRUE) {
    ASSERT(resetName.get(), "null name");
    ASSERT(!resetName->empty(), "empty name");
    name = resetName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_RESET)->second);
  }
  else {
    name = RefString(new std::string("reset"));
  }
//   RefString name = RefString(new std::string("reset"));
//   if (resetName.get()){
//     name->insert(0, "_");
//     name->insert(0, *resetName);
//   }
  addPort(name, RF_PN_RESET);
  m_addPortReset = TRUE;
}

void CSLOmRegisterFileInfo::addPortClock  (RefString clockName) {
  RefString name;
  if (m_addPortClock == TRUE) {
    ASSERT(clockName.get(), "null name");
    ASSERT(!clockName->empty(), "empty name");
    name = clockName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_CLOCK)->second);
  }
  else {
    name = RefString(new std::string("clock"));
  }
//   RefString name = RefString(new std::string("clock"));
//   if (clockName.get()){
//     name->insert(0, "_");
//     name->insert(0, *clockName);
//   }
  addPort(name, RF_PN_CLOCK);  
  m_addPortClock = TRUE;
}

void CSLOmRegisterFileInfo::addPortWrAddr(RefString signalName) {
  RefString name;
  if (m_addPortWrAddr == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_WR_ADDR)->second);
  }
  else {
    name = RefString(new std::string("wr_addr"));
  }
//   RefString name = RefString(new std::string("wr_addr"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_WR_ADDR/*, NEED WIDTH*/);
  m_addPortWrAddr = TRUE;
}

void CSLOmRegisterFileInfo::addPortRdAddr(RefString signalName) {
  RefString name;
  if (m_addPortRdAddr1 == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_RD_ADDR)->second);
  }
  else {
    name = RefString(new std::string("rd_addr0"));
  }
//   RefString name = RefString(new std::string("rd_addr"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_RD_ADDR/*, NEED WIDTH*/);  
  m_addPortRdAddr1 = TRUE;

}

void CSLOmRegisterFileInfo::addPortRdAddrS(RefString signalName) {
  RefString name;
  if (m_addPortRdAddr2 == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_RD_ADDR_S)->second);
  }
  else {
    name = RefString(new std::string("rd_addr1"));
  }
//   RefString name = RefString(new std::string("rd_addr"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_RD_ADDR_S/*, NEED WIDTH*/);  
  m_addPortRdAddr2 = TRUE;

}

void CSLOmRegisterFileInfo::addPortDataIn(RefString signalName) {
  RefString name;
  if (m_addPortWrData == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_DATA_IN)->second);
  }
  else {
    name = RefString(new std::string("data_in"));
  }
//   RefString name = RefString(new std::string("data_in"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_DATA_IN/*, NEED WIDTH*/);  
  m_addPortWrData = TRUE;
}

void CSLOmRegisterFileInfo::addPortDataOut(RefString signalName) {
  RefString name;
  if (m_addPortRdData1 == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_DATA_OUT)->second);
  }
  else {
    name = RefString(new std::string("data_out0"));
  }
//   RefString name = RefString(new std::string("data_out"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_DATA_OUT, OUTPUT/*, NEED WIDTH*/);  
  m_addPortRdData1 = TRUE;
}

void CSLOmRegisterFileInfo::addPortDataOutS(RefString signalName) {
  RefString name;
  if (m_addPortRdData2 == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_DATA_OUT_S)->second);
  }
  else {
    name = RefString(new std::string("data_out1"));
  }
//   RefString name = RefString(new std::string("data_out"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_DATA_OUT_S, OUTPUT/*, NEED WIDTH*/);  
  m_addPortRdData2 = TRUE;
}

void CSLOmRegisterFileInfo::addPortWrEn  (RefString signalName) {
  RefString name;
  if (m_addPortWrEn == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_WR_EN)->second);
  }
  else {
    name = RefString(new std::string("wr_en"));
  }
//   RefString name = RefString(new std::string("wr_en"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_WR_EN);  
  m_addPortWrEn = TRUE;
}

void CSLOmRegisterFileInfo::addPortRdEn  (RefString signalName) {
  RefString name;
  if (m_addPortRdEn1 == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_RD_EN)->second);
  }
  else {
    name = RefString(new std::string("rd_en0"));
  }
//   RefString name = RefString(new std::string("rd_en"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_RD_EN);  
  m_addPortRdEn1 = TRUE;
}


void CSLOmRegisterFileInfo::addPortRdEnS  (RefString signalName) {
  RefString name;
  if (m_addPortRdEn2 == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_RD_EN_S)->second);
  }
  else {
    name = RefString(new std::string("rd_en1"));
  }
//   RefString name = RefString(new std::string("rd_en"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_RD_EN_S);  
  m_addPortRdEn2 = TRUE;
}

void CSLOmRegisterFileInfo::addPortClear  (RefString signalName) {
  RefString name;
  if (m_addPortClear == TRUE) {
    ASSERT(signalName.get(), "null name");
    ASSERT(!signalName->empty(), "empty name");
    name = signalName;
    CSLOmUnitDecl::cast(m_parent.lock())->getDefaultInterface()->removeChild(m_portMap->find(RF_PN_CLEAR)->second);
  }
  else {
    name = RefString(new std::string("clear"));
  }
//   RefString name = RefString(new std::string("clear"));
//   if (signalName.get()){
//     name->insert(0, "_");
//     name->insert(0, *signalName);
//   }
  addPort(name, RF_PN_CLEAR);  
  m_addPortClear = TRUE;
}

void CSLOmRegisterFileInfo::createRtlModule                     () {
  m_createRtlModule = TRUE;
}

void CSLOmRegisterFileInfo::disconnectRegFieldsFromIos          () {
  m_disconnectRegFieldsFromIos = TRUE;
}

void CSLOmRegisterFileInfo::connectRegFieldsToIos               () {
  m_connectRegFieldsToIos = TRUE;
}

void CSLOmRegisterFileInfo::setBypass                           () {
  m_setBypass = TRUE;
}

void CSLOmRegisterFileInfo::setConstValue                      (RefCSLOmExpr expression) {
  ASSERT(expression.get(), "null expression received");
  ASSERT(expression->isNumber(), "numeric expression expected");
  RefCSLOmNumber constValue = CSLOmNumber::cast(expression);;
  ASSERT(constValue.get(), "null object");
  ASSERT(CSLOmNumber::NUM_INT32 != constValue->getNumType(), "num32 expected");
  addChildRegisterFile(constValue, RF_CHILDTYPE_CONSTVAL);
  m_setConstValue = TRUE;
}

void CSLOmRegisterFileInfo::setField                           (RefCSLOmField field, RefCSLOmExpr expression) {
  ASSERT(field.get(), "null field received");
  ASSERT(expression.get(), "null expression received");
  ASSERT(expression->isNumber(), "numeric expression expected");

  addChildRegisterFile(field, RF_CHILDTYPE_FIELD_FIELD);

  RefCSLOmNumber number = CSLOmNumber::cast(expression);
  ASSERT(number.get(), "null object");
  ASSERT(CSLOmNumber::NUM_INT32 == number->getNumType(), "num32 expected");
  addChildRegisterFile(number, RF_CHILDTYPE_FIELD_EXPR);
  m_setField = TRUE;
}

void CSLOmRegisterFileInfo::setExternal                        (RefCSLOmExpr expression, RefCSLOmPortDecl port) {
  ASSERT(expression.get(), "null expression received");
  ASSERT(expression->isNumber(), "expecting numeric expression");
  ASSERT(port.get(), "null port received");

  RefCSLOmNumber num = CSLOmNumber::cast(expression);
  ASSERT(num.get(), "null object");
  ASSERT(CSLOmNumber::NUM_INT32 == num->getNumType(), "num32 expected");
  addChildRegisterFile(num, RF_CHILDTYPE_EXTERNAL_EXPR);

  addChildRegisterFile(port, RF_CHILDTYPE_EXTERNAL_PORT);
  m_setExternal = TRUE;
}

void CSLOmRegisterFileInfo::setPrefix                          (const RefString    prefix    ) {
  ASSERT(prefix.get(), "null object received");
  ASSERT(0 != prefix->size(), "empty string received");
  m_prefix = prefix;
  m_setPrefix = TRUE;
}

void CSLOmRegisterFileInfo::setGroupName                       (RefString    groupName ) {
  ASSERT(groupName.get(), "null object received");
  ASSERT(0 != groupName->size(), "empty string received");
  m_groupName = groupName;
  m_setGroupName = TRUE;
}


TBool  CSLOmRegisterFileInfo::getSetWidth                           () {
  return m_setWidth;
}

TBool  CSLOmRegisterFileInfo::getSetDepth                           () {
  return m_setDepth;
}

TBool  CSLOmRegisterFileInfo::getAddPortReset                       () {
  return m_addPortReset;
}

TBool  CSLOmRegisterFileInfo::getAddPortValid                       () {
  return m_addPortValid;
}

TBool  CSLOmRegisterFileInfo::getAddPortClock                       () {
  return m_addPortClock;
}

TBool  CSLOmRegisterFileInfo::getAddPortWrAddr                      () {
  return m_addPortWrAddr;
}

TBool  CSLOmRegisterFileInfo::getAddPortRdAddr                      () {
  return m_addPortRdAddr1;
}

TBool  CSLOmRegisterFileInfo::getAddPortRdAddrS                      () {
  return m_addPortRdAddr2;
}

TBool  CSLOmRegisterFileInfo::getAddPortWrData                      () {
  return m_addPortWrData;
}

TBool  CSLOmRegisterFileInfo::getAddPortRdData                      () {
  return m_addPortRdData1;
}

TBool  CSLOmRegisterFileInfo::getAddPortRdDataS                      () {
  return m_addPortRdData2;
}

TBool  CSLOmRegisterFileInfo::getAddPortRdEn                        () {
  return m_addPortRdEn1;
}

TBool  CSLOmRegisterFileInfo::getAddPortRdEnS                        () {
  return m_addPortRdEn2;
}

TBool  CSLOmRegisterFileInfo::getAddPortWrEn                        () {
  return m_addPortWrEn;
}

TBool  CSLOmRegisterFileInfo::getAddPortClear                       () {
  return m_addPortClear;
}

TBool  CSLOmRegisterFileInfo::getCreateRtlModule                    () {
  return m_createRtlModule;
}

TBool  CSLOmRegisterFileInfo::getDisconnectRegFieldsFromIos         () {
  return m_disconnectRegFieldsFromIos;
}

TBool  CSLOmRegisterFileInfo::getConnectRegFieldsToIos              () {
  return m_connectRegFieldsToIos;
}

TBool CSLOmRegisterFileInfo::getSetBypass                           () {
  return m_setBypass;
}

TBool  CSLOmRegisterFileInfo::getSetConstValue                      () {
  return m_setConstValue;
}

TBool  CSLOmRegisterFileInfo::getSetPrefix                          () {
  return m_setPrefix;
}

TBool  CSLOmRegisterFileInfo::getSetGroupName                       () {
  return m_setGroupName;
}


RefCSLOmExpr CSLOmRegisterFileInfo::getWidth() {
  TInt pos = getChildPos(RF_CHILDTYPE_WIDTH);
  RefCSLOmBase base = getChild(pos);
//   ASSERT(base.get(), "null object");
//   ASSERT(base->isExpr(), "expecting expression");
//   RefCSLOmExpr expr = CSLOmExpr::cast(base);
//   ASSERT(expr->isNumber(), "expecting numeric expression");
//   RefCSLOmNumber width = CSLOmNumber::cast(expr);
  return CSLOmExpr::cast(base);
}

RefCSLOmExprLink CSLOmRegisterFileInfo::getWidthAsBitRangeLink                   () {
  RefCSLOmExprLink link = RefCSLOmExprLink();
  RefCSLOmExpr width = getWidth();
  if (width.get()) {
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), width);
    link = bitRange->getBitRangeLink();
  }
  return link;
}

RefCSLOmExpr CSLOmRegisterFileInfo::getDepth() {
  TInt pos = getChildPos(RF_CHILDTYPE_DEPTH);
  RefCSLOmBase base = getChild(pos);
  return CSLOmExpr::cast(base);
}

RefCSLOmExprLink CSLOmRegisterFileInfo::getDepthAsBitRangeLink                   () {
  RefCSLOmExprLink link = RefCSLOmExprLink();
  RefCSLOmExpr depth = getDepth();
  if (depth.get()) {
    RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::build(CSLOmUnitDecl::cast(getParent())->getLineNumber(),CSLOmUnitDecl::cast(getParent())->getFileName(), CSLOmUnitDecl::cast(getParent()), RefString(new std::string("")), depth);
    link = bitRange->getBitRangeLink();
  }
  return link;
}

void CSLOmRegisterFileInfo::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmRegDeclInfo class
// ********************************************************************************


CSLOmRegDeclInfo::CSLOmRegDeclInfo(TLineNumberType lineNumber, RefString fileName):
  CSLOmUnitInfo(lineNumber, fileName),
  m_attributes(),  
  m_attrMask(),
  //def
  m_initValue(),
  m_setValue(),
  m_resetValue(),
  m_clearValue(),
  //counter
  m_stopValue(),
  m_startValue(),
  m_endValue(),
  //reg
  m_portMap(new TMap_ERegPortNames_RefCSLOmPortDecl),
  m_tempWidth(RefCSLOmExpr())
 
{ m_attrMask=0;
  m_alreadySetWidth=FALSE;
  m_alreadySetType=FALSE;
  m_alreadySetCntDir=FALSE;

  m_isSetInitValue    =FALSE;
  m_isSetSetValue     =FALSE;
  m_isSetResetValue   =FALSE;
  m_isSetClearValue   =FALSE;
  
  m_isSetCountAmmout  =FALSE;
  m_isSetStopValue    =FALSE;
  m_isSetStartValue   =FALSE;
  m_isSetEndValue     =FALSE;
  m_isSetLoad         =FALSE;

  m_type=REG_DECL_UNDEF;
  m_cntDir = REG_DECL_CNT_DIR_UNDEF;
  //m_attr = CSLOmRegDeclInfo::REG_ATTR_UNDEFINED;

  m_countAmmout=CSLOmNum32::build(lineNumber, fileName,1);
  m_resetValue =CSLOmNum32::build(lineNumber, fileName,0);
  m_initValue  =CSLOmNum32::build(lineNumber, fileName,0);
  m_setValue   =CSLOmNum32::build(lineNumber, fileName,1);
  m_clearValue =CSLOmNum32::build(lineNumber, fileName,0);
}

void CSLOmRegDeclInfo::initializePorts(){
  addPortReset       ( );
  addPortEnable      ( );
  addPortClock       ( );
  addPortRegOut      ( );
  if(m_type==REG_DECL_REGISTER){
    addPortRegIn       ( );
  }
}

void CSLOmRegDeclInfo::addPortReset(){
  RefString pName=RefString(new std::string("reset_"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_RESET,tempPort));
}
void CSLOmRegDeclInfo::addPortEnable(){
  RefString pName=RefString(new std::string("enable"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_ENABLE,tempPort));
}
void CSLOmRegDeclInfo::addPortClock(){
  RefString pName=RefString(new std::string("clock"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_CLOCK,tempPort));
}
void CSLOmRegDeclInfo::addPortRegOut(){
  RefString pName=RefString(new std::string("reg_out"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,OUTPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_REG_OUT,tempPort));
}
void CSLOmRegDeclInfo::addPortRegIn(){
  RefString pName=RefString(new std::string("reg_in"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_REG_IN,tempPort));
}

void CSLOmRegDeclInfo::addPortRegNegOut(){
  RefString pName=RefString(new std::string("reg_out_"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,OUTPUT,SIGNAL_WIRE);
  if(m_alreadySetWidth){
    tempPort->setWidth(m_width);
  }
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_REG_NEG_OUT,tempPort));
}

void CSLOmRegDeclInfo::addPortSet(){
  RefString pName=RefString(new std::string("set"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_SET,tempPort));
}

void CSLOmRegDeclInfo::addPortInit(){
  RefString pName=RefString(new std::string("init"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_INIT,tempPort));
}

void CSLOmRegDeclInfo::addPortClear(){
  RefString pName=RefString(new std::string("clear"));
  
  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_CLEAR,tempPort));
}

void CSLOmRegDeclInfo::addPortLoad(){
  RefString pName=RefString(new std::string("load"));
  RefString pNameEn=RefString(new std::string("load_en"));  

  RefCSLOmUnitDecl parentUnit = CSLOmUnitDecl::cast(getParent());
  RefCSLOmInterface defInt = CSLOmInterface::cast(parentUnit->getChild(DEFAULT_IFC));

  RefCSLOmPortDecl tempPort=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pName,INPUT,SIGNAL_WIRE);
  RefCSLOmPortDecl tempPortEn=CSLOmPortDecl::build(m_lineNumber, m_fileName,defInt,pNameEn,INPUT,SIGNAL_WIRE);
  
  if(m_alreadySetWidth){
    tempPort->setWidth(getThis()->getWidth());
  }

  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_LOAD,tempPort));
  m_portMap->insert(std::make_pair<ERegPortNames,RefCSLOmPortDecl>(REG_PORTN_LOAD_EN,tempPortEn));
}

void CSLOmRegDeclInfo::setAttribute(ERegDeclAttr attribute){
  //ASSERT(attributes.get(),"received vector null");
  
  m_attr = attribute;

}

void CSLOmRegDeclInfo::addLogic(CSLOmRegDeclInfo::ERegDeclOperations opType, RefCSLOmExpr incomingExpr){

  switch (opType) {
    case REG_OPER_UNDEF:
      break;
    case REG_OPER_NEG_OUTPUT:
      // ASSERT(getType()!=CSLOmRegDeclInfo::REG_DECL_DEFAULT, "incorrect register type");
      m_IOMask |= 1<<REG_OPER_NEG_OUTPUT;
      addPortRegNegOut();
      break;
    case REG_OPER_SERIAL_INPUT:
      //ASSERT(getType()!=CSLOmRegDeclInfo::REG_DECL_DEFAULT, "incorrect register type");
      m_IOMask |= 1<<REG_OPER_SERIAL_INPUT;
      break;
    case REG_OPER_SERIAL_OUTPUT:
      //ASSERT(getType()!=CSLOmRegDeclInfo::REG_DECL_DEFAULT, "incorrect register type");
      m_IOMask |= 1<<REG_OPER_SERIAL_OUTPUT;
      break;
    case REG_OPER_INIT:
      //ASSERT(getType()!=CSLOmRegDeclInfo::REG_DECL_DEFAULT, "incorrect register type");
      if(incomingExpr.get()){
        m_initValue=incomingExpr;
      }
      addPortInit();
      m_isSetInitValue=TRUE;
      break;
    case REG_OPER_SET:
      //ASSERT(getType()!=CSLOmRegDeclInfo::REG_DECL_DEFAULT, "incorrect register type");
      if(incomingExpr.get()){
        m_setValue=incomingExpr;
      }
      addPortSet();
      m_isSetSetValue=TRUE;
      break;
    case REG_OPER_RESET:
      //ASSERT(getType()!=CSLOmRegDeclInfo::REG_DECL_DEFAULT, "incorrect register type");
      if(incomingExpr.get()) {
        m_resetValue=incomingExpr;
      }
      m_isSetResetValue=TRUE;
      break;
    case REG_OPER_CLEAR:
      //ASSERT(getType()!=CSLOmRegDeclInfo::REG_DECL_DEFAULT, "incorrect register type");
      if(incomingExpr.get()){
        m_clearValue=incomingExpr;
      }
      addPortClear();
      m_isSetClearValue=TRUE;
      break;
    case REG_OPER_LOAD:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER, "incorrect register type");
      m_isSetLoad=TRUE;
      addPortLoad();
      //aici
      break;
    case REG_OPER_GRAY_OUTPUT:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER, "incorrect register type");
      m_IOMask |= 1<< REG_OPER_GRAY_OUTPUT;
      break;
    case REG_OPER_COUNT_AMMOUNT:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER, "incorrect register type");
      ASSERT(incomingExpr.get(),"null numeric expression");
      m_countAmmout=incomingExpr;
      m_isSetCountAmmout=TRUE;
      break;
    case REG_OPER_STOP_VALUE:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER, "incorrect register type");
      ASSERT(incomingExpr.get(),"null numeric expression");
      m_stopValue=incomingExpr;
      m_isSetStopValue=TRUE;
      break;
    case REG_OPER_START_VALUE:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER, "incorrect register type");
      ASSERT(incomingExpr.get(),"null numeric expression");
      m_startValue=incomingExpr;
      m_isSetStartValue=TRUE;
      break;
    case REG_OPER_END_VALUE:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER, "incorrect register type");
      ASSERT(incomingExpr.get(),"null numeric expression");
      m_endValue=incomingExpr;
      m_isSetEndValue=TRUE;
      break;
    case REG_OPER_DIR_CONTROL:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_COUNTER, "incorrect register type");
      ASSERT(incomingExpr.get(),"null signal");
      m_cntDirSig=CSLOmSignal::cast(incomingExpr);
      break;
    case REG_OPER_REG_RESET:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_REGISTER, "incorrect register type");
      m_IOMask |= 1<<REG_OPER_REG_RESET;
      break;
    case REG_OPER_REG_SET:
      ASSERT(getType()==CSLOmRegDeclInfo::REG_DECL_REGISTER, "incorrect register type");
      m_IOMask |= 1<<REG_OPER_REG_SET;
      break;
    default:
      break;
  }

}

void CSLOmRegDeclInfo::setWidth(RefCSLOmExpr numericExpression){
  ASSERT(numericExpression.get(), "void numeric expression");

  m_alreadySetWidth=TRUE;
  m_width = numericExpression;

  if(m_portMap->find(REG_PORTN_REG_NEG_OUT) != m_portMap->end() && (m_portMap->find(REG_PORTN_REG_NEG_OUT)->second).get()){
      m_portMap->find(REG_PORTN_REG_NEG_OUT)->second->setWidth(numericExpression);
  }

  if(m_portMap->find(REG_PORTN_LOAD) != m_portMap->end() && (m_portMap->find(REG_PORTN_LOAD)->second).get()){
      m_portMap->find(REG_PORTN_LOAD)->second->setWidth(numericExpression);
  }

  if(getAlreadySetType()){
    m_portMap->find(REG_PORTN_REG_OUT)->second->setWidth(numericExpression);
    if(getType()==REG_DECL_REGISTER){
      m_portMap->find(REG_PORTN_REG_IN)->second->setWidth(numericExpression);
    }
  }
  else{
    m_tempWidth=numericExpression;
  }

  //for design checker
  m_mandatoryCounter++;
}

TBool CSLOmRegDeclInfo::getSetWidth(){
  return m_alreadySetWidth;
}

RefCSLOmExpr CSLOmRegDeclInfo::getWidth(){
  return m_width;
}

void CSLOmRegDeclInfo::setType(CSLOmRegDeclInfo::ERegDeclType regType){
  m_alreadySetType=TRUE;
  m_type = regType;

  initializePorts();

  if(m_tempWidth.get()){
    m_portMap->find(REG_PORTN_REG_OUT)->second->setWidth(m_tempWidth);
    if(getType()==REG_DECL_REGISTER){
      m_portMap->find(REG_PORTN_REG_IN)->second->setWidth(m_tempWidth);
    }
  }

  //for design checker
  m_mandatoryCounter++;
}

CSLOmRegDeclInfo::ERegDeclType CSLOmRegDeclInfo::getType(){
  return m_type;
}

TBool CSLOmRegDeclInfo::getAlreadySetType(){
  return m_alreadySetType;
}

void CSLOmRegDeclInfo::setCntDir(CSLOmRegDeclInfo::ERegDeclCntDir regCntDir){
  ASSERT(getType() == CSLOmRegDeclInfo::REG_DECL_COUNTER, "Trying to set count direction on a non-counter register");
  m_alreadySetCntDir = TRUE;
  m_cntDir = regCntDir;

  //for checker
  m_mandatoryCounter++;
}

CSLOmRegDeclInfo::ERegDeclCntDir CSLOmRegDeclInfo::getCntDir(){
  ASSERT(getType() == CSLOmRegDeclInfo::REG_DECL_COUNTER, "Trying to retrieve count direction on a non-counter register");
  return m_cntDir;
}

TBool CSLOmRegDeclInfo::getAlreadySetCntDir(){
  return m_alreadySetCntDir;
}

RefCSLOmRegDeclInfo CSLOmRegDeclInfo::cast(RefCSLOmBase object){
  if(!object.get()){
    return RefCSLOmRegDeclInfo();
  }
  else {
    return boost::static_pointer_cast<CSLOmRegDeclInfo>(object);
  }
}

RefCSLOmRegDeclInfo CSLOmRegDeclInfo::build(TLineNumberType lineNumber, RefString fileName){
  CSLOmRegDeclInfo *regInfo;
  try{
    regInfo=new CSLOmRegDeclInfo(lineNumber, fileName);
  }
  catch (std::exception& e){
    ASSERT(FAIL, "new operator failed");
  }

  RefCSLOmRegDeclInfo refInfo=RefCSLOmRegDeclInfo(regInfo);
  refInfo->m_weakRef=boost::weak_ptr<CSLOmBase>(refInfo);

  return refInfo;
}

ERegDeclAttr CSLOmRegDeclInfo::getAttribute(){
  return m_attr;
}

RefCSLOmExpr CSLOmRegDeclInfo::getInitValue(){
  return m_initValue;
}
RefCSLOmExpr CSLOmRegDeclInfo::getSetValue(){
  return m_setValue;
}
RefCSLOmExpr CSLOmRegDeclInfo::getResetValue(){
  return m_resetValue;
}
RefCSLOmExpr CSLOmRegDeclInfo::getClearValue(){
  return m_clearValue;
}

RefCSLOmExpr CSLOmRegDeclInfo::getCountAmmout(){
  return m_countAmmout;
}
RefCSLOmExpr CSLOmRegDeclInfo::getStopValue(){
  return m_stopValue;
}
RefCSLOmExpr CSLOmRegDeclInfo::getStartValue(){
  return m_startValue;
}
RefCSLOmExpr CSLOmRegDeclInfo::getEndValue(){
  return m_endValue;
}
RefCSLOmSignal CSLOmRegDeclInfo::getCndDirSig(){
  return m_cntDirSig;
}
void CSLOmRegDeclInfo::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}



// ********************************************************************************
// CSLOmTBInfo class
// ********************************************************************************

CSLOmTBInfo::CSLOmTBInfo(TLineNumberType lineNumber, RefString fileName):
  CSLOmUnitInfo(lineNumber, fileName),
  m_verilogFilename(),
  m_simTimeoutCounter(),
  m_vecDUTInstanceNames(RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink())),
  m_vecScopesList(RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink())),
  m_waveFilename(),
  m_clockSignal(),
  m_clockPeriod(),
  m_clockTimeBase(),
  m_waveType(TB_WAVE_UNDEF),
  m_vecVULinks(RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink()))
{}

RefCSLOmTBInfo CSLOmTBInfo::build(TLineNumberType lineNumber, RefString fileName) {
   CSLOmTBInfo* tbInfo;
   try {
     tbInfo = new CSLOmTBInfo(lineNumber, fileName);
   }
   catch (std::exception& e) {
     ASSERT(FAIL,"new operator failed");
   }

   RefCSLOmTBInfo refTBInfo(tbInfo);
   tbInfo->m_weakRef = boost::weak_ptr<CSLOmBase>( refTBInfo);

   return refTBInfo;
 }

RefCSLOmTBInfo CSLOmTBInfo::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmTBInfo();
  } 
  else {
    return boost::static_pointer_cast<CSLOmTBInfo>(object);
  }   
}

//links between vector instances and unit instances
void CSLOmTBInfo::setVUInstanceLink(RefCSLOmExprLink vectorInstance, RefCSLOmExprLink unitInstance){
  ASSERT(vectorInstance.get(),"null vector instance name received");
  ASSERT(unitInstance.get(),"null vector instance name received");
  
  m_vecVULinks->push_back(vectorInstance);
  m_vecVULinks->push_back(unitInstance);

}

TBool CSLOmTBInfo::isVUConnected(RefCSLOmExprLink vectorInstance, RefCSLOmExprLink unitInstance){
  ASSERT(vectorInstance.get(),"null vector instance name received");
  ASSERT(unitInstance.get(),"null vector instance name received");
  ASSERT(m_vecVULinks->size()%2, "something went wrong with the connections");

  for(TUInt i=0; i<m_vecVULinks->size(); i+=2){
    if(m_vecVULinks->at(i).get()==vectorInstance.get()){
      if(m_vecVULinks->at(i+1).get()==unitInstance.get()){
        return TRUE;
      }
    }
  }
  return FALSE;
}

RefCSLOmExprLink CSLOmTBInfo::getVectorConnectedUnit(RefCSLOmExprLink vectorInstance){
  ASSERT(vectorInstance.get(),"null vector instance name received");
  ASSERT(m_vecVULinks->size()%2, "something went wrong with the connections");

  for(TUInt i=0; i<m_vecVULinks->size(); i+=2){
    if(m_vecVULinks->at(i).get()==vectorInstance.get()){
      return m_vecVULinks->at(i+1);
    }
  }
  return RefCSLOmExprLink();
}

//set coms
void CSLOmTBInfo::setVerilogFilename(RefString incomingString){
  ASSERT(incomingString.get(),"null string received");
  m_verilogFilename=incomingString;
}

void CSLOmTBInfo::setSimTimeoutCounter(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "null numeric expression");
  m_simTimeoutCounter=numericExpr;
}

void CSLOmTBInfo::setStallGeneration(RefTVec_RefCSLOmExprLink incomingExpr){
  ASSERT(incomingExpr.get(), "null expression link vector");
  for(TUInt i=0; i<incomingExpr->size(); ++i){
    m_vecDUTInstanceNames->push_back(incomingExpr->at(i));
  }
}

void CSLOmTBInfo::setGenerateWaves(RefString incomingString, ETBWaveType incomingWave, RefTVec_RefCSLOmExprLink incomingExpr){
  ASSERT(incomingString.get(), "null string received");
  ASSERT(incomingExpr.get(), "null vector received");

  m_waveFilename = incomingString;
  m_waveType = incomingWave;
  for(TUInt i=0; i<incomingExpr->size(); ++i){
    m_vecScopesList->push_back(incomingExpr->at(i));
  }
}

void CSLOmTBInfo::setGenerateWaves(RefString incomingString, ETBWaveType incomingWave){
  ASSERT(incomingString.get(), "null string received");

  m_waveFilename = incomingString;
  m_waveType = incomingWave;
}

void CSLOmTBInfo::setClock(RefCSLOmSignal incomingSignal, RefCSLOmExpr numericExpr, ETBTimeBase incomingTimeBase){
  ASSERT(incomingSignal.get(),"null clock signal received");
  ASSERT(numericExpr.get(),"null numeric expression received");
 
  //  m_clockSignal=CSLOmSignal::cast(incomingSignal);
  m_clockSignal = incomingSignal;
  m_clockPeriod=CSLOmNumber::cast(numericExpr);
  m_clockTimeBase=incomingTimeBase;        
}

void CSLOmTBInfo::setGenerateReport(ETBReportType incomingReportType){
  m_reportType=incomingReportType;
}

//get coms

RefString CSLOmTBInfo::getVerilogFilename() const {
  return m_verilogFilename;
}
RefCSLOmExpr CSLOmTBInfo::getTimeoutCounter() const {
  return m_simTimeoutCounter;
}
RefTVec_RefCSLOmExprLink CSLOmTBInfo::getDUTInstanceNames() const {
  return m_vecDUTInstanceNames;
}
RefTVec_RefCSLOmExprLink CSLOmTBInfo::getScopesList() const {
  return m_vecScopesList;
}
RefString CSLOmTBInfo::getWaveFilename() const {
  return m_waveFilename;
}
CSLOmTBInfo::ETBWaveType CSLOmTBInfo::getWaveType() const {
  return m_waveType;
}
RefCSLOmSignal CSLOmTBInfo::getClockSignal() const {
  return m_clockSignal;
}
RefCSLOmExpr CSLOmTBInfo::getClockPeriod() const {
  return m_clockPeriod;
}
CSLOmTBInfo::ETBTimeBase CSLOmTBInfo::getClockTimeBase() const {
  return m_clockTimeBase;
}
CSLOmTBInfo::ETBReportType CSLOmTBInfo::getReportType() const {
  return m_reportType;
}
void CSLOmTBInfo::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


}//namespace end
