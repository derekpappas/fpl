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

// Author AndreiS

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
// CSLOmVerifCompInfo class
// ********************************************************************************

CSLOmVerifCompInfo::CSLOmVerifCompInfo(TLineNumberType lineNumber, RefString fileName)
  : CSLOmUnitInfo(lineNumber,fileName),
    m_radix(CSLOmVerifCompInfo::VC_RADIX_UNDEFINED),
    m_captureEdgeType(CSLOmVerifCompInfo::VC_EDGE_RISE),

    m_numericID(),
    m_version(),
    m_maxEventsCount(),
    m_maxMismatchesCount(),
    m_timeout(),
    m_maxNumStates(),
    m_numOfTransactionsEvents(),
    m_maxCycles(),
    m_vcName(),
    m_vcHeaderComment(),
    m_outputFilename(),
    m_cppRDName(),
    m_cppWRName(),
    m_clock(),
    m_reset(),
    m_stall(),
    m_compareTrigger(),
    m_startGenerationTrigger(),
    m_endGenerationTrigger()
 {
   m_alreadySetVcName=FALSE;
 }

//set functions

//ints
void CSLOmVerifCompInfo::setNumericID(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_numericID=(CSLOmNum32::cast(eval))->getValue();
}

void CSLOmVerifCompInfo::setVersion(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_version=(CSLOmNum32::cast(eval))->getValue();
}

void CSLOmVerifCompInfo::setMaxEventsCount(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_maxEventsCount=(CSLOmNum32::cast(eval))->getValue();
}

void CSLOmVerifCompInfo::setMaxMismatchesCount(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_maxMismatchesCount=(CSLOmNum32::cast(eval))->getValue();
}

void CSLOmVerifCompInfo::setTimeout(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_timeout=(CSLOmNum32::cast(eval))->getValue();
}

void CSLOmVerifCompInfo::setMaxNumStates(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_maxNumStates=(CSLOmNum32::cast(eval))->getValue();
}

void CSLOmVerifCompInfo::setNumOfTransactionEvents(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_numOfTransactionsEvents=(CSLOmNum32::cast(eval))->getValue();
}

void CSLOmVerifCompInfo::setMaxCycles(RefCSLOmExpr numericExpr){
  ASSERT(numericExpr.get(), "numeric id should not be null");

  RefCSLOmBase eval = numericExpr->doEval(TRUE);
  m_maxCycles=(CSLOmNum32::cast(eval))->getValue();
}

//enums and strings

void CSLOmVerifCompInfo::setName(const RefString &inputValue){
  ASSERT(inputValue.get(), "numeric id should not be null");

  m_alreadySetVcName=TRUE;
  m_vcName=inputValue;
}

void CSLOmVerifCompInfo::setVCHeaderComment(const RefString &inputValue){
  ASSERT(inputValue.get(), "numeric id should not be null");

  m_vcHeaderComment=inputValue;
}

void CSLOmVerifCompInfo::setOutputFilename(const RefString &inputValue){
  ASSERT(inputValue.get(), "string should not be null");
 
  m_outputFilename=inputValue;
}

void CSLOmVerifCompInfo::setCppRDName(const RefString &inputValue){
  ASSERT(inputValue.get(), "numeric id should not be null");

  m_cppRDName=inputValue;
}

void CSLOmVerifCompInfo::setCppWRName(const RefString &inputValue){
  ASSERT(inputValue.get(), "numeric id should not be null");

  m_cppWRName=inputValue;
}

void CSLOmVerifCompInfo::setRadix(ECSLOmVCRadix inputValue){
  m_radix=inputValue;
}

void CSLOmVerifCompInfo::setCaptureEdgeType(ECSLOmVCEdgeType inputValue){
  m_captureEdgeType=inputValue;
}

//signals
void CSLOmVerifCompInfo::setClock(RefCSLOmSignal inputValue){
  ASSERT(inputValue.get(),"signal should not be null");

  m_clock=inputValue;//CSLOmSignal::cast(inputValue);
}

void CSLOmVerifCompInfo::setReset(RefCSLOmSignal inputValue){
  ASSERT(inputValue.get(),"signal should not be null");

  m_reset=inputValue;//CSLOmSignal::cast(inputValue);
}

void CSLOmVerifCompInfo::setStall(RefCSLOmSignal inputValue){
  ASSERT(inputValue.get(),"signal should not be null");

  m_stall=inputValue;//CSLOmSignal::cast(inputValue);
}

void CSLOmVerifCompInfo::setCompareTrigger(RefCSLOmSignal inputValue){
  ASSERT(inputValue.get(),"signal should not be null");

  m_compareTrigger=inputValue;//CSLOmSignal::cast(inputValue);
}

void CSLOmVerifCompInfo::setStartGenerationTrigger(RefCSLOmSignal inputValue){
  ASSERT(inputValue.get(),"signal should not be null");

  m_startGenerationTrigger=inputValue;//CSLOmSignal::cast(inputValue);
}

void CSLOmVerifCompInfo::setEndGenerationTrigger(RefCSLOmSignal inputValue){
  ASSERT(inputValue.get(),"signal should not be null");

  m_endGenerationTrigger=inputValue;//CSLOmSignal::cast(inputValue);
}

//GET functions

//ints
RefCSLOmNumber CSLOmVerifCompInfo::getNumericID()               const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_numericID);
  return no;
}
RefCSLOmNumber CSLOmVerifCompInfo::getVersion()                 const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_version);
  return no;
}
RefCSLOmNumber CSLOmVerifCompInfo::getMaxEventsCount()           const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_maxEventsCount);
  return no;
}
RefCSLOmNumber CSLOmVerifCompInfo::getMaxMismatchesCount()        const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_maxMismatchesCount);
  return no;
}
RefCSLOmNumber CSLOmVerifCompInfo::getTimeout()                 const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_timeout);
  return no;
}
RefCSLOmNumber CSLOmVerifCompInfo::getMaxNumOfStates()          const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_maxNumStates);
  return no;
}
RefCSLOmNumber CSLOmVerifCompInfo::getNumOfTransactionEvents()  const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_numOfTransactionsEvents);
  return no;
}

RefCSLOmNumber CSLOmVerifCompInfo::getMaxCycles()               const{
  RefCSLOmNum32 no=CSLOmNum32::build(m_lineNumber,m_fileName, m_maxCycles);
  return no;
}


//enums and strings
RefString CSLOmVerifCompInfo::getName()                         const{
  return m_vcName;
}
RefString CSLOmVerifCompInfo::getVCHeaderComment()              const{
  return m_vcHeaderComment;
}
RefString CSLOmVerifCompInfo::getOutputFilename()               const{
  return m_outputFilename;
}
RefString CSLOmVerifCompInfo::getCppRDName()                    const{
  return m_cppRDName;
}
RefString CSLOmVerifCompInfo::getCppWRName()                    const{
  return m_cppWRName;
}
CSLOmVerifCompInfo::ECSLOmVCRadix CSLOmVerifCompInfo::getRadix()                    const{
  return m_radix;
}
CSLOmVerifCompInfo::ECSLOmVCEdgeType CSLOmVerifCompInfo::getCaptureEdgeType()       const{
  return m_captureEdgeType;
}

//signals
RefCSLOmSignal CSLOmVerifCompInfo::getClock()                   const{
  return m_clock;
}
RefCSLOmSignal CSLOmVerifCompInfo::getReset()                   const{
  return m_reset;
}
RefCSLOmSignal CSLOmVerifCompInfo::getStall()                   const{
  return m_stall;
}
RefCSLOmSignal CSLOmVerifCompInfo::getCompareTrigger()          const{
  return m_compareTrigger;
}
RefCSLOmSignal CSLOmVerifCompInfo::getStartGenerationTrigger()  const{
  return m_startGenerationTrigger;
}
RefCSLOmSignal CSLOmVerifCompInfo::getEndGenerationTrigger()    const{
  return m_endGenerationTrigger;
}
 
RefCSLOmVerifCompInfo CSLOmVerifCompInfo::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmVerifCompInfo();
  }
  else {
    return boost::static_pointer_cast<CSLOmVerifCompInfo>(object);
  }
}

   
// ********************************************************************************
// CSLOmVectorInfo class
// ********************************************************************************

 CSLOmVectorInfo::CSLOmVectorInfo(TLineNumberType lineNumber, RefString fileName):
   CSLOmVerifCompInfo(lineNumber, fileName),
  m_moduleName(),
  m_ports(RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink())),
  m_portMask(RefTVec_TBool(new TVec_TBool()))
{
  m_direction=DIR_UNDEFINED;
  m_stimulusElseExpected=TRUE;
  m_includeOnlyUsed=FALSE;
}

RefCSLOmVectorInfo CSLOmVectorInfo::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmVectorInfo();
  }
  else {
    return boost::static_pointer_cast<CSLOmVectorInfo>(object);
  }
}

 RefCSLOmVectorInfo CSLOmVectorInfo::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmUnitDecl unitDecl){
  CSLOmVectorInfo *vecInfo;
  try{
    vecInfo=new CSLOmVectorInfo(lineNumber,fileName);
  }
  catch (std::exception& e){
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmVectorInfo refVec=RefCSLOmVectorInfo(vecInfo);
  vecInfo->m_weakRef=boost::weak_ptr<CSLOmBase>(refVec);

  //setting default names
  RefCSLOmIdentifier unitId = CSLOmIdentifier::cast(unitDecl->getChild(ID));
  refVec->m_vcName = unitId->getName();

  RefString tempOutFile = RefString(new std::string(""));
  tempOutFile->append(*unitId->getName());
  tempOutFile->append("_output.vec");
  refVec->m_outputFilename=tempOutFile;

  return refVec;
}

//set functions
void CSLOmVectorInfo::setModuleName(RefCSLOmExprLink input){
  ASSERT(input.get(),"null incoming Unit Declaration");

  m_moduleName = input;
  RefCSLOmBase evaledBase = input->doEval();
  ASSERT(evaledBase->isUnitDecl(),"not unit decl");
  
  CSLOmUnitDecl::cast(evaledBase)->registerVerifComp(getThis());
  
  //for design checker
  m_mandatoryCounter++;
  
}

void CSLOmVectorInfo::setStimulusElseExpected(TBool incValue){
  m_stimulusElseExpected=incValue;
}

//filename

RefString CSLOmVectorInfo::getStimulusFilename(){
  ASSERT(m_moduleName.get(),"module name should not be null at this point");
  ASSERT(m_stimulusElseExpected, "vector is not stimulus");

  RefCSLOmBase dutmod = CSLOmUnitDecl::cast(m_moduleName->doEval());
  RefCSLOmIdentifier dutid=CSLOmIdentifier::cast(dutmod->getChild(ID));

  RefCSLOmBase parentUnit = getThis()->getParent();
  RefCSLOmIdentifier unitId = CSLOmIdentifier::cast(parentUnit->getChild(ID));

  RefString str = RefString(new std::string(""));
  str->append(*dutid->getName());
  str->append("_");
  str->append(*unitId->getName());
  str->append("_");
  str->append("stim.vec");
  
  return str;
}

RefString CSLOmVectorInfo::getExpectedFilename(){
  ASSERT(m_moduleName.get(),"module name should not be null at this point");
  ASSERT(!m_stimulusElseExpected, "vector is not expect");

  RefCSLOmBase dutmod = CSLOmUnitDecl::cast(m_moduleName->doEval());
  RefCSLOmIdentifier dutid=CSLOmIdentifier::cast(dutmod->getChild(ID));

  RefCSLOmBase parentUnit = getThis()->getParent();
  RefCSLOmIdentifier unitId = CSLOmIdentifier::cast(parentUnit->getChild(ID));

  RefString str = RefString(new std::string(""));
  str->append(*dutid->getName());
  str->append("_");
  str->append(*unitId->getName());
  str->append("_");
  str->append("expect.vec");
  
  return str;
}

RefString CSLOmVectorInfo::getFilename(){
  ASSERT(FAIL, "deprecated function. use getStimulusFilename() or getExpectedFilename() instead");
  ASSERT(m_vcName.get(),"vc name should not be null at this point");
  ASSERT(m_moduleName.get(),"module name should not be null at this point");
  
  //vector
  RefCSLOmBase dutmod = CSLOmUnitDecl::cast(m_moduleName->doEval());
  RefCSLOmIdentifier dutid=CSLOmIdentifier::cast(dutmod->getChild(ID));

  RefString str = RefString(new std::string(""));
  str->append(*m_vcName);
  str->append("_");
  str->append(*dutid->getName());
  str->append("_vector_");
  
  if(m_stimulusElseExpected){
    str->append("stimulus");
  }else {
    str->append("expected");
  }
  
  return str;
}


// inclusion/exclusion direction


void CSLOmVectorInfo::setDirection(ECSLOmPortDirection direction){
  ASSERT(m_moduleName.get(), "cmd should check that the vector is associated with a module before calling set direction");
  m_direction = direction;

  RefCSLOmUnitDecl dut=CSLOmUnitDecl::cast(m_moduleName->doEval());
  RefTVec_RefCSLOmPortDecl portVec = dut->getPortListFull();
  if(portVec.get()){
    for(TUInt i=0; i<portVec->size(); ++i){
      RefCSLOmExprLink temp = CSLOmExprLink::build(m_lineNumber,m_fileName,CSLOmIdentifier::cast(portVec->at(i)->getChild(ID))->getName());
      RefCSLOmIdentifier ident = CSLOmIdentifier::cast(portVec->at(i)->getChild(ID));
      temp->setValue(portVec->at(i));
      temp->addID(ident);
      m_ports->push_back(temp);
      if(portVec->at(i)->getPortDirection()==direction ){//|| portVec->at(i)->getPortDirection()==INOUT){
        m_portMask->push_back(TRUE);
      }else {
        m_portMask->push_back(FALSE);
      }
    }
  }
  if(direction==OUTPUT){
    m_stimulusElseExpected=FALSE;
  }
  
  //for design checker
  m_mandatoryCounter++;

}

void CSLOmVectorInfo::excludePorts(RefTVec_TInt portList){
  ASSERT(portList.get(),"null param received");
  for(TUInt i=0; i<portList->size(); ++i){
    m_portMask->at(portList->at(i))=FALSE;
  }
}

void CSLOmVectorInfo::includeOnlyPorts(RefTVec_TInt portList){
  ASSERT(portList.get(), "null param received");
  ASSERT(m_includeOnlyUsed==FALSE, "include_only command already called");

  resetPortMask();
  m_includeOnlyUsed=TRUE;

  for(TUInt i=0; i<portList->size(); ++i){
    m_portMask->at(portList->at(i))=TRUE;
  }
}

RefTVec_RefCSLOmExprLink CSLOmVectorInfo::getDUTInputPorts() {
  RefTVec_RefCSLOmExprLink inputPorts = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
  if(m_direction == INPUT) {
    for(TUInt i = 0; i < m_portMask->size(); i++) {
      if(m_portMask->at(i) == TRUE) {
        inputPorts->push_back(m_ports->at(i));
      }
    }
  }
  return inputPorts;
}
RefTVec_RefCSLOmExprLink CSLOmVectorInfo::getDUTOutputPorts() {
  RefTVec_RefCSLOmExprLink outputPorts = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
  if(m_direction == OUTPUT) {
    for(TUInt i = 0; i < m_portMask->size(); i++) {
      if(m_portMask->at(i) == TRUE) {
        outputPorts->push_back(m_ports->at(i));
      }
    }
  }
  return outputPorts;
}
RefTVec_RefCSLOmExprLink CSLOmVectorInfo::getAllPorts(){
  ASSERT(m_ports.get(),"null ports in unit");
  RefTVec_RefCSLOmExprLink ports = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
  for(TUInt i = 0; i < m_ports->size(); ++i){
    ports->push_back(m_ports->at(i));
  }
  return ports;
}

RefTVec_RefCSLOmExprLink CSLOmVectorInfo::getAssociatedPorts(){
  RefTVec_RefCSLOmExprLink ports = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
  for(TUInt i = 0; i < m_ports->size(); ++i){
    if(m_portMask->at(i)){
      ports->push_back(m_ports->at(i));
    }
  }
  return ports;
}

void CSLOmVectorInfo::resetPortMask(){
  for(TUInt i=0; i<m_portMask->size(); ++i){
    m_portMask->at(i)=FALSE;
  }
}


//get functions

RefCSLOmExprLink CSLOmVectorInfo::getModuleName() const{
  return m_moduleName;
}
ECSLOmPortDirection CSLOmVectorInfo::getDirection() const{
  return m_direction;
}

TBool CSLOmVectorInfo::getStimulusElseExpected() const{
  return m_stimulusElseExpected;
}

TBool CSLOmVectorInfo::getIncludeOnlyUsed() const{
  return m_includeOnlyUsed;
}

void CSLOmVectorInfo::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


// ********************************************************************************
// CSLOmStateDataInfo class
// ********************************************************************************

 CSLOmStateDataInfo::CSLOmStateDataInfo(TLineNumberType lineNumber,RefString fileName) :
   CSLOmVerifCompInfo(lineNumber,fileName),
   m_instanceName()
   {}

 RefCSLOmStateDataInfo CSLOmStateDataInfo::build(TLineNumberType lineNumber,RefString fileName, RefCSLOmUnitDecl parent) {
   CSLOmStateDataInfo* stateDataInfo;
   try {
     stateDataInfo = new CSLOmStateDataInfo(lineNumber,fileName);
   }
   catch (std::exception& e) {
     ASSERT(FAIL,"new operator failed");
   }

   RefCSLOmStateDataInfo refStateDataInfo(stateDataInfo);
   stateDataInfo->m_weakRef = boost::weak_ptr<CSLOmBase>( refStateDataInfo);

   return refStateDataInfo;
 }

RefCSLOmStateDataInfo CSLOmStateDataInfo::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmStateDataInfo();
  } 
  else {
    return boost::static_pointer_cast<CSLOmStateDataInfo>(object);
  }   
}

void CSLOmStateDataInfo::setInstanceName(RefCSLOmExprLink input){
  ASSERT(input.get(),"null incoming unit instance");
  m_instanceName = input;
}

RefCSLOmExprLink CSLOmStateDataInfo::getInstanceName()const{
  return m_instanceName;
}

}
