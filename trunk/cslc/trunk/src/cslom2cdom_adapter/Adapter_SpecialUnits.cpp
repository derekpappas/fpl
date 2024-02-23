//---------------------------------------------------------------------
// Copyright (c) 2005, 2006 Fastpathlogic
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

#include "Adapter.h"
#include <cmath>


using namespace NSCdom;
using namespace NSCSLOm;
using namespace std;

namespace NSAdapter {

void CAdapterToCDOM::adaptFifoModule(const NSCSLOm::RefCSLOmUnitDecl &unitDecl, RefString fifoMemName) {
  ASSERT(m_cdomCurrParent->getType() == TYPE_DECL_MODULE, "Fifo should be a module");
  
  TInt lineNumber = unitDecl->getLineNumber();

  //flags for FIFO type
  TBool isSync  = TRUE; //default - FALSE is async
  
  //fifo depth 
  RefCSLOmExpr depthAsExpr = CSLOmFifoInfo::cast(unitDecl->getUnitInfo())->getDepth();
  RefCSLOmNum32 depthAsNumber;
  TInt depth;
  RefString commentText;
  RefCDOmComment depthComment;
  
  switch(depthAsExpr->getType()) {
    case CSLOmExpr::EXPR_NUMBER:
      depthAsNumber = CSLOmNum32::cast(depthAsExpr);
      if (depthAsNumber.get()) {
        depth = depthAsNumber->getValue();
      }
      else {
        depth = 1;
      }
      break;
    case CSLOmExpr::EXPR_HID:
      depth = 1;
      commentText = RefString(new string("The depth of fifo module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
      depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      break;
    case CSLOmExpr::EXPR_OP:
      depth = 1;
      commentText = RefString(new string("The depth of fifo module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
      depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      break;
    default:
      commentText = RefString(new string("The depth of fifo module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is of illegal type. Depth set to 1.");
      depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      depth = 1;
      break;
  }
 
  
  //fifo width
  RefCSLOmExpr widthAsExpr = CSLOmFifoInfo::cast(unitDecl->getUnitInfo())->getWidth();
  RefCSLOmNum32 widthAsNumber;
  TInt width;
  RefCDOmComment widthComment;

  switch(widthAsExpr->getType()) {
    case CSLOmExpr::EXPR_NUMBER:
      widthAsNumber = CSLOmNum32::cast(widthAsExpr);
      if (widthAsNumber.get()) {
        width = widthAsNumber->getValue();
      }
      else {
        width = 1;
      }
      break;
    case CSLOmExpr::EXPR_HID:
      width = 1;
      commentText = RefString(new string("The width of fifo module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is not a number. No evaluation support available. Width set to 1.");
      widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      break;
    case CSLOmExpr::EXPR_OP:
      width = 1;
      commentText = RefString(new string("The width of fifo module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is not a number. No evaluation support available. Width set to 1.");
      widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      break;
    default:
      commentText = RefString(new string("The width of fifo module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is of illegal type. Width set to 1.");
      widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      width = 1;
      break;
  }

  //addr width 
  TInt nrOfAddrBits = static_cast<TInt>(log2(depth));
  if(log2(depth) - floor(log2(depth)) > 0) {
    ++nrOfAddrBits;
  }
  
  
 // parameter ADDR_WIDTH = <number>;
  RefCDOmExpr number = buildCDOmNum32WithValue(lineNumber, nrOfAddrBits);
  RefCDOmMinTypMax value = buildCDOmMinTypMax(lineNumber, number);
  RefCDOmParamDecl addrWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  addrWidth->addParam(lineNumber, RefString(new string("ADDR_WIDTH")), value);
  
// parameter DATA_WIDTH = <number>;
  RefCDOmExpr number1 = buildCDOmNum32WithValue(lineNumber, width);
  RefCDOmMinTypMax value1 = buildCDOmMinTypMax(lineNumber, number1);
  RefCDOmParamDecl dataWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  dataWidth->addParam(lineNumber, RefString(new string("DATA_WIDTH")), value1);
  
// parameter NUM_WORDS = (1<<ADDR_WIDTH);// pow(2, addr_width) = fifo_depth
  //RefCDOmExpr leftOfShift = buildCDOmNum32WithValue(lineNumber, 1);
  //RefCDOmExpr rightOfShift = buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH")));
  //RefCDOmExpr shiftExpr = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_SHIFT_LEFT, leftOfShift, rightOfShift);
  //RefCDOmMinTypMax value2 = buildCDOmMinTypMax(lineNumber, shiftExpr);
  //RefCDOmParamDecl nrOfWords = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  //nrOfWords->addParam(lineNumber, RefString(new string("NUM_WORDS")), value2);
 
  //mandatory fifo ports
  RefCDOmPortDecl push = RefCDOmPortDecl();
  RefCDOmPortDecl pop = RefCDOmPortDecl();
  RefCDOmPortDecl full = RefCDOmPortDecl();
  RefCDOmPortDecl empty = RefCDOmPortDecl();
  RefCDOmPortDecl dataIn = RefCDOmPortDecl();
  RefCDOmPortDecl dataOut = RefCDOmPortDecl();
  RefCDOmPortDecl reset = RefCDOmPortDecl();

  RefString pushName = RefString();
  RefString popName = RefString();
  RefString fullName = RefString();
  RefString emptyName = RefString();
  RefString dataInName = RefString();
  RefString dataOutName = RefString();
  RefString resetName = RefString();

  //implementation dependant ports
  //sync
  RefCDOmPortDecl clock = RefCDOmPortDecl();
  //async
  RefCDOmPortDecl wrClock = RefCDOmPortDecl();
  RefCDOmPortDecl rdClock = RefCDOmPortDecl();  

  //sync
  RefString clockName = RefString();
  //async
  RefString wrClockName = RefString();
  RefString rdClockName = RefString();


  //custom fifo ports
  RefCDOmPortDecl valid = RefCDOmPortDecl();

  RefString validName = RefString();

  //extract mandatory fifo ports from map
  map<EFifoPortNames, RefCDOmPortDecl>::const_iterator fifoPortsIter;
  
  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_PUSH);
  ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Fifo has no push port");
  push = fifoPortsIter->second;
  RefTVec_RefCDOmIdentifier pushIDs = push->getIDs();
  pushName = (*(pushIDs->begin()))->getName();
  
  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_POP);
  ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Fifo has no pop port") ;
  pop = fifoPortsIter->second;
  RefTVec_RefCDOmIdentifier popIDs = pop->getIDs();
  popName = (*(popIDs->begin()))->getName();

  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_FULL);
  ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Fifo has no full port");
  full = fifoPortsIter->second;
  RefTVec_RefCDOmIdentifier fullIDs = full->getIDs();
  fullName = (*(fullIDs->begin()))->getName();
  
  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_EMPTY);
  ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Fifo has no empty port"); 
  empty = fifoPortsIter->second;
  RefTVec_RefCDOmIdentifier emptyIDs = empty->getIDs();
  emptyName = (*(emptyIDs->begin()))->getName();
  
  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_DATA_IN);
  ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Fifo has no dataIn(wrData) port"); 
  dataIn = fifoPortsIter->second;
  RefTVec_RefCDOmIdentifier dataInIDs = dataIn->getIDs();
  dataInName = (*(dataInIDs->begin()))->getName();
  
  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_DATA_OUT);
  ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Fifo has no dataOut(rdData) port");
  dataOut = fifoPortsIter->second;
  RefTVec_RefCDOmIdentifier dataOutIDs = dataOut->getIDs();
  dataOutName = (*(dataOutIDs->begin()))->getName();
  
  if(CSLOmFifoInfo::cast(unitDecl->getUnitInfo())->getSetAsynch()) {
    isSync  = FALSE;//reset default type - now is async

    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_WR_CLOCK);
    ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Asynch fifo has no wrClock port");
    wrClock = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier wrClockIDs = wrClock->getIDs();
    wrClockName = (*(wrClockIDs->begin()))->getName();

    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_RD_CLOCK);
    ASSERT(fifoPortsIter!= m_cdomFifoPorts.end(), "Asynch fifo has no rdClock port");
    rdClock = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier rdClockIDs = rdClock->getIDs();
    rdClockName = (*(rdClockIDs->begin()))->getName();
  }
  else {
    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_CLOCK);
    ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Synch fifo has no clock port");
    clock = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier clockIDs = clock->getIDs();
    clockName = (*(clockIDs->begin()))->getName();
  } 
  
  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_ASYNCH_RESET);
  ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Fifo has no asynch_reset port");
  reset = fifoPortsIter->second;
  RefTVec_RefCDOmIdentifier resetIDs = reset->getIDs();
  resetName = (*(resetIDs->begin()))->getName();
  
  //extract or build custom fifo ports and port items
  fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_VALID);
  if(fifoPortsIter != m_cdomFifoPorts.end()) {
    valid = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier validIDs = valid->getIDs();
    validName = (*(validIDs->begin()))->getName();
  }
  else {
    validName = RefString(new string("valid"));
    RefCDOmPortItem validItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, validName);
    RefCDOmRange validRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    valid = buildCDOmPortDeclVar(lineNumber, m_cdomCurrParent, VAR_REG, validRange, validName);
  }

  //build fifo internal signals
  RefCDOmVarDecl wrAddr = RefCDOmVarDecl();
  RefCDOmVarDecl rdAddr = RefCDOmVarDecl();
  RefCDOmVarDecl rdEn = RefCDOmVarDecl();
  RefCDOmVarDecl wrEn = RefCDOmVarDecl();
  //RefCDOmVarDecl mem = RefCDOmVarDecl();
  RefCDOmNetDecl zero = RefCDOmNetDecl();

  
  RefCDOmExprOp wrAddrExprOp = buildCDOmExprOp( lineNumber, 
                                                CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                buildCDOmNum32WithValue(lineNumber, 1)
                                              );
  RefCDOmRange wrAddrRange = buildCDOmRange( lineNumber, 
                                             wrAddrExprOp,
                                             buildCDOmNum32WithValue(lineNumber, 0)
                                           );
  RefString wrAddrName = RefString(new string("wr_addr"));
  wrAddr = buildCDOmVarDecl(lineNumber, m_cdomCurrParent, VAR_REG, wrAddrRange, wrAddrName);
  
  RefCDOmExprOp rdAddrExprOp = buildCDOmExprOp( lineNumber, 
                                                CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                buildCDOmNum32WithValue(lineNumber, 1)
                                              );
  RefCDOmRange rdAddrRange = buildCDOmRange( lineNumber, 
                                             rdAddrExprOp, 
                                             buildCDOmNum32WithValue(lineNumber, 0)
                                           );
  RefString rdAddrName = RefString(new string("rd_addr"));
  rdAddr = buildCDOmVarDecl(lineNumber, m_cdomCurrParent, VAR_REG, rdAddrRange, rdAddrName);
    
  RefCDOmRange wrEnRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
  RefString wrEnName = RefString(new string("wr_en"));
  wrEn = buildCDOmVarDecl(lineNumber, m_cdomCurrParent, VAR_REG, wrEnRange, wrEnName);
  
  RefCDOmRange rdEnRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
  RefString rdEnName = RefString(new string("rd_en"));
  rdEn = buildCDOmVarDecl(lineNumber, m_cdomCurrParent, VAR_REG, rdEnRange, rdEnName);
  
  RefString zeroName = RefString(new string("zero"));
  zero = buildCDOmNetDecl(lineNumber,
                          m_cdomCurrParent,
                          NET_WIRE,
                          buildCDOmRange(lineNumber,
                                         buildCDOmExprOp(lineNumber, 
                                                         CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                         buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                         buildCDOmNum32WithValue(lineNumber, 2)
                                                         ),
                                         buildCDOmNum32WithValue(lineNumber, 0)
                                         )
                          );
  zero->addNet(lineNumber, zeroName);
  //memory instance
  RefCDOmExprLink memExprLink = buildCDOmExprLink(lineNumber, fifoMemName);
  RefCDOmModuleOrUdpInstantiation memInstantiation = buildCDOmModuleOrUdpInstantiation(lineNumber, m_cdomCurrParent, memExprLink) ;
  RefCDOmModuleOrUdpInstance memInstance = memInstantiation->buildModuleInstance(lineNumber, RefString(new string("fifo_memory_instance")));

  //connect memory to fifo ports
  RefCDOmExprLink clockExprLink = RefCDOmExprLink();
  //sync case
  if(isSync){
    clockExprLink = buildCDOmExprLink(lineNumber, clockName);
    memInstance->addPortConnection(RefCDOmAttrListCollection(), clockExprLink, clockName);
  }
  //async case
  else{
    clockExprLink = buildCDOmExprLink(lineNumber, rdClockName);
    memInstance->addPortConnection(RefCDOmAttrListCollection(), clockExprLink, rdClockName);
  }

  RefCDOmExprLink resetExprLink = buildCDOmExprLink(lineNumber, resetName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), resetExprLink, resetName);
  
  RefCDOmExprLink dataInExprLink = buildCDOmExprLink(lineNumber, dataInName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), dataInExprLink, dataInName);

  RefCDOmExprLink dataOutExprLink = buildCDOmExprLink(lineNumber, dataOutName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), dataOutExprLink, dataOutName);
  
  RefCDOmExprLink validExprLink = buildCDOmExprLink(lineNumber, validName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), validExprLink, validName);
  
  //connect memory to fifo signals
  //DCOUT( "Connecting signals" << endl);
  RefCDOmExprLink wrAddrExprLink = buildCDOmExprLink(lineNumber, wrAddrName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), wrAddrExprLink, wrAddrName);
  
  RefCDOmExprLink rdAddrExprLink = buildCDOmExprLink(lineNumber, rdAddrName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdAddrExprLink, rdAddrName);
  
  RefCDOmExprLink wrEnExprLink = buildCDOmExprLink(lineNumber, wrEnName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), wrEnExprLink, wrEnName);

  RefCDOmExprLink rdEnExprLink = buildCDOmExprLink(lineNumber, rdEnName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdEnExprLink, rdEnName);

  //RefCDOmExprLink memoryExprLink = buildCDOmExprLink(lineNumber, memName);
  //memInstance->addPortConnection(RefCDOmAttrListCollection(), memoryExprLink, memName);
  
  //DCOUT( "Done connecting signals" << endl);

  if(rdClock.get()) { //fifo is asynch
    adaptCounter( lineNumber, rdClockName, resetName, rdAddrName, popName, zeroName);
  }
  else {
    adaptCounter( lineNumber, clockName, resetName, rdAddrName, popName, zeroName);
  }
  DCERR( "After first counter" << endl);
  if(wrClock.get()) { //fifo is asynch
    adaptCounter( lineNumber, wrClockName, resetName, wrAddrName, pushName, zeroName);
  }
  else {
    adaptCounter( lineNumber, clockName, resetName, wrAddrName, pushName, zeroName);
  }
  DCERR( "After second counter" << endl);
  
  adaptCompare(lineNumber, wrAddrName, rdAddrName, fullName, clockName, resetName);
  adaptCompare(lineNumber, wrAddrName, rdAddrName, emptyName, clockName, resetName);
  adaptAndGate(lineNumber, pushName, fullName, wrEnName, clockName, resetName, 1);
  adaptAndGate(lineNumber, popName, emptyName, rdEnName, clockName, resetName, 1);
  DCERR( "After and gates" << endl);
}

void CAdapterToCDOM::adaptRegisterFileModule( const RefCSLOmUnitDecl &unitDecl, RefString regFileMemName)  {
  map<ERFPortNames, RefCDOmPortDecl>::const_iterator regFilePortsIter;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_CLOCK);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no clock port");
  RefCDOmPortDecl clock = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RESET);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "RegIster file has no resert port");
  RefCDOmPortDecl reset = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_WR_ADDR);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no wrAddr port");
  RefCDOmPortDecl wrAddr = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_ADDR);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no rdAddr port");
  RefCDOmPortDecl rdAddr = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_ADDR_S);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no rdAddrSecond port");
  RefCDOmPortDecl rdAddrS = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_WR_EN);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no wrEn port");
  RefCDOmPortDecl wrEnable = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_EN);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no rdEn port");
  RefCDOmPortDecl rdEnable = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_EN_S);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no rdEnSecond port");
  RefCDOmPortDecl rdEnableS = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_DATA_IN);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no dataIn port");
  RefCDOmPortDecl wrData = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_DATA_OUT);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no dataOut port");
  RefCDOmPortDecl rdData = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_DATA_OUT_S);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no dataOutSecond port");
  RefCDOmPortDecl rdDataS = regFilePortsIter->second;

  regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_VALID);
  ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no valid port");
  RefCDOmPortDecl valid = regFilePortsIter->second;

  
  RefTVec_RefCDOmIdentifier clockIDs = clock->getIDs();
  RefString clockName = (*(clockIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier resetIDs = reset->getIDs();
  RefString resetName = (*(resetIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier wrAddrIDs = wrAddr->getIDs();
  RefString wrAddrName = (*(wrAddrIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier rdAddrIDs = rdAddr->getIDs();
  RefString rdAddrName = (*(rdAddrIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier rdAddrSIDs = rdAddrS->getIDs();
  RefString rdAddrSName = (*(rdAddrSIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier wrEnableIDs = wrEnable->getIDs();
  RefString wrEnableName = (*(wrEnableIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier rdEnableIDs = rdEnable->getIDs();
  RefString rdEnableName = (*(rdEnableIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier rdEnableSIDs = rdEnableS->getIDs();
  RefString rdEnableSName = (*(rdEnableSIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier wrDataIDs = wrData->getIDs();
  RefString wrDataName = (*(wrDataIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier rdDataIDs = rdData->getIDs();
  RefString rdDataName = (*(rdDataIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier rdDataSIDs = rdDataS->getIDs();
  RefString rdDataSName = (*(rdDataSIDs->begin()))->getName();
  RefTVec_RefCDOmIdentifier validIDs = valid->getIDs();
  RefString validName = (*(validIDs->begin()))->getName();

  TInt lineNumber = unitDecl->getLineNumber();
  
  RefCSLOmExpr depthAsExpr = CSLOmRegisterFileInfo::cast(unitDecl->getUnitInfo())->getDepth();
  RefCSLOmNum32 depthAsNumber;
  TInt depth;
  RefString commentText;
  RefCDOmComment depthComment;

  switch(depthAsExpr->getType()) {
    case CSLOmExpr::EXPR_NUMBER:
      depthAsNumber = CSLOmNum32::cast(depthAsExpr);
      depth = depthAsNumber->getValue();
      break;
    case CSLOmExpr::EXPR_HID:
      depth = 1;
      commentText = RefString(new string("The depth of register file module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
      depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      break;
    case CSLOmExpr::EXPR_OP:
      depth = 1;
      commentText = RefString(new string("The depth of register file module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
      depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      break;
    default:
      commentText = RefString(new string("The depth of register file module "));
      commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
      commentText->append(" is of illegal type. Depth set to 1.");
      depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
      depth = 1;
      break;
  }
  
  //memory instance
  RefCDOmExprLink memExprLink = buildCDOmExprLink(lineNumber, regFileMemName);
  RefCDOmModuleOrUdpInstantiation memInstantiation = buildCDOmModuleOrUdpInstantiation(lineNumber, m_cdomCurrParent, memExprLink) ;
  RefCDOmModuleOrUdpInstance memInstance = memInstantiation->buildModuleInstance(lineNumber, RefString(new string("register_file_memory_instance")));

  //connect memory to regfile ports
  RefCDOmExprLink clockExprLink = buildCDOmExprLink(lineNumber, clockName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), clockExprLink, clockName);

  RefCDOmExprLink resetExprLink = buildCDOmExprLink(lineNumber, resetName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), resetExprLink, resetName);
  
  RefCDOmExprLink wrDataExprLink = buildCDOmExprLink(lineNumber, wrDataName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), wrDataExprLink, wrDataName);

  RefCDOmExprLink rdDataExprLink = buildCDOmExprLink(lineNumber, rdDataName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdDataExprLink, rdDataName);
  
  RefCDOmExprLink rdDataSecExprLink = buildCDOmExprLink(lineNumber, rdDataSName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdDataSecExprLink, rdDataSName);

  RefCDOmExprLink validExprLink = buildCDOmExprLink(lineNumber, validName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), validExprLink, validName);
  
  RefCDOmExprLink wrAddrExprLink = buildCDOmExprLink(lineNumber, wrAddrName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), wrAddrExprLink, wrAddrName);
  
  RefCDOmExprLink rdAddrExprLink = buildCDOmExprLink(lineNumber, rdAddrName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdAddrExprLink, rdAddrName);
  
  RefCDOmExprLink rdAddrSecExprLink = buildCDOmExprLink(lineNumber, rdAddrSName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdAddrSecExprLink, rdAddrSName);

  RefCDOmExprLink wrEnableExprLink = buildCDOmExprLink(lineNumber, wrEnableName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), wrEnableExprLink, wrEnableName);

  RefCDOmExprLink rdEnableExprLink = buildCDOmExprLink(lineNumber, rdEnableName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdEnableExprLink, rdEnableName);

  RefCDOmExprLink rdEnableSecExprLink = buildCDOmExprLink(lineNumber, rdEnableSName);
  memInstance->addPortConnection(RefCDOmAttrListCollection(), rdEnableSecExprLink, rdEnableSName);

}

void CAdapterToCDOM::adaptMemoryModule( const NSCSLOm::RefCSLOmUnitDecl &unitDecl) {

  TInt lineNumber = unitDecl->getLineNumber();
  
  //mandatory ports
  RefCDOmPortDecl clock = RefCDOmPortDecl();
  RefCDOmPortDecl reset = RefCDOmPortDecl();
  RefCDOmPortDecl dataIn = RefCDOmPortDecl();
  RefCDOmPortDecl dataOut = RefCDOmPortDecl();
  
  //custom ports
  RefCDOmPortDecl wrAddr = RefCDOmPortDecl();
  RefCDOmPortDecl rdAddr = RefCDOmPortDecl();
  RefCDOmPortDecl wrEn = RefCDOmPortDecl();
  RefCDOmPortDecl rdEn = RefCDOmPortDecl();
  RefCDOmPortDecl valid = RefCDOmPortDecl();

  if( unitDecl->getUnitType() == CSLOmUnitDecl::CSL_FIFO_DECL) {
    //fifo depth
    RefCSLOmExpr depthAsExpr = CSLOmFifoInfo::cast(unitDecl->getUnitInfo())->getDepth();
    RefCSLOmNum32 depthAsNumber;
    TInt depth;
    RefString commentText;
    RefCDOmComment depthComment;

    switch(depthAsExpr->getType()) {
      case CSLOmExpr::EXPR_NUMBER:
        depthAsNumber = CSLOmNum32::cast(depthAsExpr);
        if (depthAsNumber.get()) {
          depth = depthAsNumber->getValue();
        }
        else {
          depth = 1;
        }
        break;
      case CSLOmExpr::EXPR_HID:
        depth = 1;
        commentText = RefString(new string("The depth of fifo module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      case CSLOmExpr::EXPR_OP:
        depth = 1;
        commentText = RefString(new string("The depth of fifo module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      default:
        commentText = RefString(new string("The depth of fifo module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is of illegal type. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        depth = 1;
        break;
    }

    //fifo width
    
    RefCSLOmExpr widthAsExpr = CSLOmFifoInfo::cast(unitDecl->getUnitInfo())->getWidth();
    RefCSLOmNum32 widthAsNumber;
    TInt width;
    RefCDOmComment widthComment;

    switch(widthAsExpr->getType()) {
      case CSLOmExpr::EXPR_NUMBER:
        widthAsNumber = CSLOmNum32::cast(widthAsExpr);
        if (widthAsNumber.get()) {
          width = widthAsNumber->getValue();
        }
        else {
          width = 1;
        }
        break;
      case CSLOmExpr::EXPR_HID:
        width = 1;
        commentText = RefString(new string("The width of fifo module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      case CSLOmExpr::EXPR_OP:
        width = 1;
        commentText = RefString(new string("The width of fifo module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      default:
        commentText = RefString(new string("The width of fifo module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is of illegal type. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        width = 1;
        break;
    }

    //addr width 
    TInt nrOfAddrBits = static_cast<TInt>(log2(depth));
    if(log2(depth) - floor(log2(depth)) > 0) {
      ++nrOfAddrBits;
    }
    //++nrOfAddrBits;

    //extract mandatory ports
    map<EFifoPortNames, RefCDOmPortDecl>::const_iterator fifoPortsIter;

    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_CLOCK);
    ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Memory has no clock port");
    clock = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier clockIDs = clock->getIDs();
    RefString clockName = (*(clockIDs->begin()))->getName();
    RefCDOmRange clockRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem clockItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, clockName);
    RefCDOmPortDecl clockPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, clockRange, clockName);

    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_ASYNCH_RESET);
    ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Memory has no reset port");
    reset = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier resetIDs = reset->getIDs();
    RefString resetName = (*(resetIDs->begin()))->getName();
    RefCDOmRange resetRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem resetItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, resetName);
    RefCDOmPortDecl resetPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, resetRange, resetName);

    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_DATA_IN);
    ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Memory has no wr_data port");
    dataIn = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier dataInIDs = dataIn->getIDs();
    RefString dataInName = (*(dataInIDs->begin()))->getName();
    RefCDOmExpr leftOfMin = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr rightOfMin = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmRange dataInRange = buildCDOmRange ( lineNumber, 
                                                buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, leftOfMin, rightOfMin), 
                                                buildCDOmNum32WithValue(lineNumber, 0)
                                              );
    RefCDOmPortItem dataInItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, dataInName);
    RefCDOmPortDecl dataInPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, dataInRange, dataInName);

    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_DATA_OUT);
    ASSERT(fifoPortsIter != m_cdomFifoPorts.end(), "Memory has no rd_data port");
    dataOut = fifoPortsIter->second;
    RefTVec_RefCDOmIdentifier dataOutIDs = dataOut->getIDs();
    RefString dataOutName = (*(dataOutIDs->begin()))->getName();
    RefCDOmExpr leftOfMin1 = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr rightOfMin1 = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmRange dataOutRange = buildCDOmRange ( lineNumber, 
                                                 buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, leftOfMin1, rightOfMin1),
                                                 buildCDOmNum32WithValue(lineNumber, 0)
                                               );
    RefCDOmPortItem dataOutItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, dataOutName);
    RefCDOmPortDecl dataOutPort = buildCDOmPortDeclVar(lineNumber, m_cdomCurrParent, VAR_REG, dataOutRange, dataOutName);

    // parameter ADDR_WIDTH = <number>;
    RefCDOmExpr number = buildCDOmNum32WithValue(lineNumber, nrOfAddrBits);
    RefCDOmMinTypMax value = buildCDOmMinTypMax(lineNumber, number);
    RefCDOmParamDecl addrWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    addrWidth->addParam(lineNumber, RefString(new string("ADDR_WIDTH")), value);

    // parameter DATA_WIDTH = <number>;
    RefCDOmExpr n = buildCDOmNum32WithValue(lineNumber, width);
    RefCDOmMinTypMax val = buildCDOmMinTypMax(lineNumber, n);
    RefCDOmParamDecl dataWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    dataWidth->addParam(lineNumber, RefString(new string("DATA_WIDTH")), val);

    //parameter NUM_WORDS = (1<<fifo_depth);
    RefCDOmExpr leftOfShift = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmExpr rightOfShift = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr shiftExpr = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_SHIFT_LEFT, leftOfShift, rightOfShift);
    RefCDOmMinTypMax value2 = buildCDOmMinTypMax(lineNumber, shiftExpr);
    RefCDOmParamDecl nrOfWords = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    nrOfWords->addParam(lineNumber, RefString(new string("NUM_WORDS")), value2);

    //extract or build custom ports
    RefString validName;
    fifoPortsIter = m_cdomFifoPorts.find(FIFO_PN_VALID);
    if(fifoPortsIter != m_cdomFifoPorts.end()) {
      valid = fifoPortsIter->second;
      validName = valid->getIDs()->at(0)->getName();
      RefCDOmRange validRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
      RefCDOmPortItem validItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, validName);
      RefCDOmPortDecl validPort = buildCDOmPortDeclVar(lineNumber, m_cdomCurrParent, VAR_REG, validRange, validName);
    }
    else {
      RefCDOmRange validRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
      validName = RefString(new string("valid"));
      RefCDOmPortItem validItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, validName);
      valid = buildCDOmPortDeclVar(lineNumber, m_cdomCurrParent, VAR_REG, validRange, validName);
    }

    //build remaining memory ports
    RefCDOmExprOp wrAddrExprOp = buildCDOmExprOp( lineNumber, 
                                                  CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                  buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                  buildCDOmNum32WithValue(lineNumber, 1)
                                                  );
    RefCDOmRange wrAddrRange = buildCDOmRange( lineNumber, 
                                               wrAddrExprOp,
                                               buildCDOmNum32WithValue(lineNumber, 0)
                                               );
    RefString wrAddrName = RefString(new string("wr_addr"));
    RefCDOmPortItem wrAddrItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, wrAddrName);
    wrAddr = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, wrAddrRange, wrAddrName);

    RefCDOmExprOp rdAddrExprOp = buildCDOmExprOp( lineNumber, 
                                                  CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                  buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                  buildCDOmNum32WithValue(lineNumber, 1)
                                                  );
    RefCDOmRange rdAddrRange = buildCDOmRange( lineNumber, 
                                               rdAddrExprOp, 
                                               buildCDOmNum32WithValue(lineNumber, 0)
                                               );
    RefString rdAddrName = RefString(new string("rd_addr"));
    RefCDOmPortItem rdAddrItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, rdAddrName);
    rdAddr = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, rdAddrRange, rdAddrName);

    RefCDOmRange wrEnRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefString wrEnName = RefString(new string("wr_en"));
    RefCDOmPortItem wrEnItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, wrEnName);
    wrEn = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, wrEnRange, wrEnName);

    RefCDOmRange rdEnRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefString rdEnName = RefString(new string("rd_en"));
    RefCDOmPortItem rdEnItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, rdEnName);
    rdEn = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, rdEnRange, rdEnName);

    // reg [DATA_WIDTH-1:0] mem [0:NUM_WORDS-1];
    RefCDOmExpr leftOfMinus4 = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr rightOfMinus4 = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmExpr fe = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, leftOfMinus4, rightOfMinus4);
    RefCDOmExpr se = buildCDOmNum32WithValue(lineNumber, 0);
    RefCDOmRange memWidth = buildCDOmRange(lineNumber, fe, se);

    RefCDOmExpr ex2 = buildCDOmExprOp(lineNumber, 
                                      CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                      buildCDOmExprLink(lineNumber, RefString(new string("NUM_WORDS"))),
                                      buildCDOmNum32WithValue(lineNumber, 1)
                                      );
    RefCDOmExpr ex1 = buildCDOmNum32WithValue(lineNumber, 0);
    RefCDOmRange memDepth = buildCDOmRange(lineNumber, ex1, ex2);
    RefCDOmRangeList memDepthList = buildCDOmRangeList(lineNumber, memDepth);

    RefString memName = RefString(new string("internal_memory"));
    RefCDOmVarDecl mem = buildCDOmVarDecl(lineNumber, m_cdomCurrParent, VAR_REG, memWidth, memName, memDepthList);

    //DCOUT( "Before adaptMemory()" << endl);
    adaptMemory(lineNumber, clockName, resetName, rdAddrName, rdEnName, dataOutName, memName, wrAddrName, wrEnName, dataInName, validName);
  }
  else if( unitDecl->getUnitType() == CSLOmUnitDecl::CSL_REGISTER_FILE_DECL) {
    
    //regfile depth
    RefCSLOmExpr depthAsExpr = CSLOmRegisterFileInfo::cast(unitDecl->getUnitInfo())->getDepth();
    RefCSLOmNum32 depthAsNumber;
    TInt depth;
    RefString commentText;
    RefCDOmComment depthComment;

    switch(depthAsExpr->getType()) {
      case CSLOmExpr::EXPR_NUMBER:
        depthAsNumber = CSLOmNum32::cast(depthAsExpr);
        depth = depthAsNumber->getValue();
        break;
      case CSLOmExpr::EXPR_HID:
        depth = 1;
        commentText = RefString(new string("The depth of register file module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      case CSLOmExpr::EXPR_OP:
        depth = 1;
        commentText = RefString(new string("The depth of register file module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      default:
        commentText = RefString(new string("The depth of register file module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is of illegal type. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        depth = 1;
        break;
    }

    //regfile width
    RefCSLOmExpr widthAsExpr = CSLOmRegisterFileInfo::cast(unitDecl->getUnitInfo())->getWidth();
    RefCSLOmNum32 widthAsNumber;
    TInt width;
    RefCDOmComment widthComment;

    switch(widthAsExpr->getType()) {
      case CSLOmExpr::EXPR_NUMBER:
        widthAsNumber = CSLOmNum32::cast(widthAsExpr);
        width = widthAsNumber->getValue();
        break;
      case CSLOmExpr::EXPR_HID:
        width = 1;
        commentText = RefString(new string("The width of register file module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      case CSLOmExpr::EXPR_OP:
        width = 1;
        commentText = RefString(new string("The width of register file module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      default:
        commentText = RefString(new string("The width of register file module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is of illegal type. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        width = 1;
        break;
    }

    //addr width 
    TInt nrOfAddrBits = static_cast<TInt>(log2(depth));
    if(log2(depth) - floor(log2(depth)) > 0) {
      ++nrOfAddrBits;
    }
    //++nrOfAddrBits;

    //extract mandatory ports
    map<ERFPortNames, RefCDOmPortDecl>::const_iterator regFilePortsIter;

    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_CLOCK);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no clock port");
    clock = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier clockIDs = clock->getIDs();
    RefString clockName = (*(clockIDs->begin()))->getName();
    RefCDOmRange clockRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem clockItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, clockName);
    RefCDOmPortDecl clockPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, clockRange, clockName);

    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RESET);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no reset port");
    reset = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier resetIDs = reset->getIDs();
    RefString resetName = (*(resetIDs->begin()))->getName();
    RefCDOmRange resetRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem resetItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, resetName);
    RefCDOmPortDecl resetPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, resetRange, resetName);

    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_DATA_IN);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no wr_data port");
    dataIn = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier dataInIDs = dataIn->getIDs();
    RefString dataInName = (*(dataInIDs->begin()))->getName();
    RefCDOmExpr leftOfMin = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr rightOfMin = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmRange dataInRange = buildCDOmRange ( lineNumber, 
                                                buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, leftOfMin, rightOfMin), 
                                                buildCDOmNum32WithValue(lineNumber, 0)
                                                );
    RefCDOmPortItem dataInItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, dataInName);
    RefCDOmPortDecl dataInPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, dataInRange, dataInName);

    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_DATA_OUT);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no rd_data port");
    dataOut = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier dataOutIDs = dataOut->getIDs();
    RefString dataOutName = (*(dataOutIDs->begin()))->getName();
    RefCDOmExpr leftOfMin1 = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr rightOfMin1 = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmRange dataOutRange = buildCDOmRange ( lineNumber, 
                                                 buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, leftOfMin1, rightOfMin1),
                                                 buildCDOmNum32WithValue(lineNumber, 0)
                                                 );
    RefCDOmPortItem dataOutItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, dataOutName);
    RefCDOmPortDecl dataOutPort = buildCDOmPortDeclVar(lineNumber, m_cdomCurrParent, VAR_REG, dataOutRange, dataOutName);


    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_DATA_OUT_S);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no dataOutSecond port");
    RefCDOmPortDecl dataOutS = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier dataOutSIDs = dataOutS->getIDs();
    RefString dataOutSName = (*(dataOutSIDs->begin()))->getName();
    RefCDOmExpr leftOfMin2 = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr rightOfMin2 = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmRange dataOutSRange = buildCDOmRange ( lineNumber, 
                                                 buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, leftOfMin2, rightOfMin2),
                                                 buildCDOmNum32WithValue(lineNumber, 0)
                                                 );
    RefCDOmPortItem dataOutSItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, dataOutSName);
    RefCDOmPortDecl dataOutSPort = buildCDOmPortDeclVar(lineNumber, m_cdomCurrParent, VAR_REG, dataOutSRange, dataOutSName);


    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_WR_ADDR);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no wr_addr port");
    wrAddr = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier wrAddrIDs = wrAddr->getIDs();
    RefString wrAddrName = (*(wrAddrIDs->begin()))->getName();
    RefCDOmExprOp wrAddrExprOp = buildCDOmExprOp( lineNumber, 
                                                  CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                  buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                  buildCDOmNum32WithValue(lineNumber, 1)
                                                  );
    RefCDOmRange wrAddrRange = buildCDOmRange( lineNumber, 
                                               wrAddrExprOp,
                                               buildCDOmNum32WithValue(lineNumber, 0)
                                               );
    RefCDOmPortItem wrAddrItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, wrAddrName);
    RefCDOmPortDecl wrAddrPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, wrAddrRange, wrAddrName);

    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_ADDR);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no rd_addr port");
    rdAddr = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier rdAddrIDs = rdAddr->getIDs();
    RefString rdAddrName = (*(rdAddrIDs->begin()))->getName();
    RefCDOmExprOp rdAddrExprOp = buildCDOmExprOp( lineNumber, 
                                                  CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                  buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                  buildCDOmNum32WithValue(lineNumber, 1)
                                                  );                                        
    RefCDOmRange rdAddrRange = buildCDOmRange( lineNumber, 
                                               rdAddrExprOp, 
                                               buildCDOmNum32WithValue(lineNumber, 0)
                                               );
    RefCDOmPortItem rdAddrItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, rdAddrName);
    RefCDOmPortDecl rdAddrPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, rdAddrRange, rdAddrName);


    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_ADDR_S);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no rd_addr1 port");
    RefCDOmPortDecl rdAddrS = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier rdAddrSIDs = rdAddrS->getIDs();
    RefString rdAddrSName = (*(rdAddrSIDs->begin()))->getName();
    RefCDOmExprOp rdAddrSExprOp = buildCDOmExprOp( lineNumber, 
                                                  CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                  buildCDOmExprLink(lineNumber, RefString(new string("ADDR_WIDTH"))),
                                                  buildCDOmNum32WithValue(lineNumber, 1)
                                                  );                                        
    RefCDOmRange rdAddrSRange = buildCDOmRange( lineNumber, 
                                               rdAddrSExprOp, 
                                               buildCDOmNum32WithValue(lineNumber, 0)
                                               );
    RefCDOmPortItem rdAddrSItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, rdAddrSName);
    RefCDOmPortDecl rdAddrSPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, rdAddrSRange, rdAddrSName);



    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_WR_EN);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no wr_en port");
    wrEn = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier wrEnIDs = wrEn->getIDs();
    RefString wrEnName = (*(wrEnIDs->begin()))->getName();
    RefCDOmRange wrEnRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem wrEnItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, wrEnName);
    RefCDOmPortDecl wrEnPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, wrEnRange, wrEnName);
    
    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_EN);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Memory has no rd_en port");
    rdEn = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier rdEnIDs = rdEn->getIDs();
    RefString rdEnName = (*(rdEnIDs->begin()))->getName();
    RefCDOmRange rdEnRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem rdEnItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, rdEnName);
    RefCDOmPortDecl rdEnPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, rdEnRange, rdEnName);

    
    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_RD_EN_S);
    ASSERT(regFilePortsIter != m_cdomRegisterFilePorts.end(), "Register file has no rdEnSecond port");
    RefCDOmPortDecl rdEnS = regFilePortsIter->second;
    RefTVec_RefCDOmIdentifier rdEnSIDs = rdEnS->getIDs();
    RefString rdEnSName = (*(rdEnSIDs->begin()))->getName();
    RefCDOmRange rdEnSRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem rdEnSItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, rdEnSName);
    RefCDOmPortDecl rdEnSPort = buildCDOmPortDeclNet(lineNumber, m_cdomCurrParent, PORT_INPUT, NET_WIRE, rdEnSRange, rdEnSName);
    
    DCERR("After rdEn" << endl);

    //extract or build custom ports    
    RefString validName = RefString(new string("valid"));
    regFilePortsIter = m_cdomRegisterFilePorts.find(RF_PN_VALID);
    if(regFilePortsIter != m_cdomRegisterFilePorts.end()) {
      valid = regFilePortsIter->second;
      RefTVec_RefCDOmIdentifier validIDs = valid->getIDs();
      validName = (*(validIDs->begin()))->getName();
    }
    RefCDOmRange validRange = buildCDOmRange(lineNumber, buildCDOmNum32WithValue(lineNumber, 0), buildCDOmNum32WithValue(lineNumber, 0));
    RefCDOmPortItem validItem = CDOmModuleDecl::cast(m_cdomCurrParent)->buildPortItem(lineNumber, CDOmPortItem::PORT_ITEM_SIMPLE, validName);
    RefCDOmPortDecl validPort = buildCDOmPortDeclVar(lineNumber, m_cdomCurrParent, VAR_REG, validRange, validName);
    DCERR("After valid" << endl);
    
    // reg [DATA_WIDTH-1:0] mem [0:NUM_WORDS-1];
    RefCDOmExpr leftOfMinus4 = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr rightOfMinus4 = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmExpr fe = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS, leftOfMinus4, rightOfMinus4);
    RefCDOmExpr se = buildCDOmNum32WithValue(lineNumber, 0);
    RefCDOmRange memWidth = buildCDOmRange(lineNumber, fe, se);

    RefCDOmExpr ex2 = buildCDOmExprOp(lineNumber, 
                                      CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                      buildCDOmExprLink(lineNumber, RefString(new string("NUM_WORDS"))),
                                      buildCDOmNum32WithValue(lineNumber, 1)
                                      );
    RefCDOmExpr ex1 = buildCDOmNum32WithValue(lineNumber, 0);
    RefCDOmRange memDepth = buildCDOmRange(lineNumber, ex1, ex2);
    RefCDOmRangeList memDepthList = buildCDOmRangeList(lineNumber, memDepth);

    RefString memName = RefString(new string("internal_memory"));
    RefCDOmVarDecl mem = buildCDOmVarDecl(lineNumber, m_cdomCurrParent, VAR_REG, memWidth, memName, memDepthList);


    // parameter ADDR_WIDTH = <number>;
    RefCDOmExpr number = buildCDOmNum32WithValue(lineNumber, nrOfAddrBits);
    RefCDOmMinTypMax value = buildCDOmMinTypMax(lineNumber, number);
    RefCDOmParamDecl addrWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    addrWidth->addParam(lineNumber, RefString(new string("ADDR_WIDTH")), value);

    // parameter DATA_WIDTH = <number>;
    RefCDOmExpr n = buildCDOmNum32WithValue(lineNumber, width);
    RefCDOmMinTypMax val = buildCDOmMinTypMax(lineNumber, n);
    RefCDOmParamDecl dataWidth = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    dataWidth->addParam(lineNumber, RefString(new string("DATA_WIDTH")), val);

    //parameter NUM_WORDS = (1<<fifo_depth);
    RefCDOmExpr leftOfShift = buildCDOmNum32WithValue(lineNumber, 1);
    RefCDOmExpr rightOfShift = buildCDOmExprLink(lineNumber, RefString(new string("DATA_WIDTH")));
    RefCDOmExpr shiftExpr = buildCDOmExprOp(lineNumber, CDOmExprOp::OP_BINARY_SHIFT_LEFT, leftOfShift, rightOfShift);
    RefCDOmMinTypMax value2 = buildCDOmMinTypMax(lineNumber, shiftExpr);
    RefCDOmParamDecl nrOfWords = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
    nrOfWords->addParam(lineNumber, RefString(new string("NUM_WORDS")), value2);

    //DCOUT( "Before adaptMemory()" << endl);
    adaptMemory(lineNumber, clockName, resetName, rdAddrName, rdEnName, dataOutName, memName, wrAddrName, wrEnName, dataInName, validName, rdEnSName, dataOutSName, rdAddrSName);
  }
  
  else if (unitDecl->getUnitType() == CSLOmUnitDecl::CSL_MEMORY_DECL){
    RefCSLOmMemoryInfo memInfo = CSLOmMemoryInfo::cast(unitDecl->getUnitInfo());
    
    //mem depth
    RefCSLOmExpr depthAsExpr = memInfo->getDepth();
    RefCSLOmNum32 depthAsNumber;
    TInt memDepth;
    RefString commentText;
    RefCDOmComment depthComment;

    switch(depthAsExpr->getType()) {
      case CSLOmExpr::EXPR_NUMBER:
        depthAsNumber = CSLOmNum32::cast(depthAsExpr);
        memDepth = depthAsNumber->getValue();
        break;
      case CSLOmExpr::EXPR_HID:
        memDepth = 1;
        commentText = RefString(new string("The depth of memory module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      case CSLOmExpr::EXPR_OP:
        memDepth = 1;
        commentText = RefString(new string("The depth of memory module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      default:
        commentText = RefString(new string("The depth of memory module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is of illegal type. Depth set to 1.");
        depthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        memDepth = 1;
        break;
    }

    //regfile width
    RefCSLOmExpr widthAsExpr = memInfo->getWidth();
    RefCSLOmNum32 widthAsNumber;
    TInt memWidth;
    RefCDOmComment widthComment;

    switch(widthAsExpr->getType()) {
      case CSLOmExpr::EXPR_NUMBER:
        widthAsNumber = CSLOmNum32::cast(widthAsExpr);
        memWidth = widthAsNumber->getValue();
        break;
      case CSLOmExpr::EXPR_HID:
        memWidth = 1;
        commentText = RefString(new string("The width of memory module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      case CSLOmExpr::EXPR_OP:
        memWidth = 1;
        commentText = RefString(new string("The width of memory module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is not a number. No evaluation support available. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        break;
      default:
        commentText = RefString(new string("The width of memory module "));
        commentText->append(*(CDOmModuleDecl::cast(m_cdomCurrParent)->getModuleName()));
        commentText->append(" is of illegal type. Width set to 1.");
        widthComment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
        memWidth = 1;
        break;
    }
  }
  else {
    DCERR("Memory type not supported" << endl);
  }
}

void CAdapterToCDOM::adaptRegisterModule (RefCSLOmUnitDecl unitDecl) {
  map<ERegPortNames, RefCDOmPortDecl>::const_iterator regPortsIter;
  //Control Flags
  TBool hasSet       = FALSE;
  TBool hasNegOutput = FALSE;
  //TBool hasClear     = FALSE;
  //TBool hasInit      = FALSE;
  TBool hasStartVal = FALSE;
  TBool hasEndVal   = FALSE;
  TBool hasLoad     = FALSE;

  RefCDOmNum32  resetValue = RefCDOmNum32();
  RefCDOmNum32  setValue   = RefCDOmNum32();
  //RefCDOmNum32  clearValue = RefCDOmNum32();
  //RefCDOmNum32  initValue  = RefCDOmNum32();

  TInt lineNumber = unitDecl->getLineNumber();
  RefCSLOmExpr expr=(CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getWidth());
  TInt regWidth; 
  if(expr->isNumber()){
    regWidth=CSLOmNum32::cast(expr)->getValue();
  }
  else{
    regWidth=1;
  }

  //Common ports to all register types
  regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_CLOCK);
  ASSERT(regPortsIter != m_cdomRegisterPorts.end(), "Register has no clock port");
  RefCDOmPortDecl clock = regPortsIter->second;

  regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_RESET);
  ASSERT(regPortsIter != m_cdomRegisterPorts.end(), "Register has no reset port");
  RefCDOmPortDecl reset = regPortsIter->second;
  expr=(CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getResetValue());
  regWidth; 
  if(expr->isNumber()){
    regWidth=CSLOmNum32::cast(expr)->getValue();
  }
  else{
    regWidth=1;
  }
  resetValue = buildCDOmNum32WithValue(lineNumber, regWidth);//CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getResetValue()->getValue());
  //resetValue = buildCDOmNum32WithValue(lineNumber, 0);//CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getResetValue()->getValue());

  regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_REG_OUT);
  ASSERT(regPortsIter != m_cdomRegisterPorts.end(), "Register has no output port");
  RefCDOmPortDecl output = regPortsIter->second;

  regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_ENABLE);
  ASSERT(regPortsIter != m_cdomRegisterPorts.end(), "Register has no enable port");
  RefCDOmPortDecl enable = regPortsIter->second;

  RefTVec_RefCDOmIdentifier clockIDs = clock->getIDs();
  RefString clockName = (*(clockIDs->begin()))->getName();

  RefTVec_RefCDOmIdentifier resetIDs = reset->getIDs();
  RefString resetName = (*(resetIDs->begin()))->getName();

  RefTVec_RefCDOmIdentifier outputIDs = output->getIDs();
  RefString outputName = (*(outputIDs->begin()))->getName();

  RefTVec_RefCDOmIdentifier enableIDs = enable->getIDs();
  RefString enableName = (*(enableIDs->begin()))->getName();
  //enable ExprLink
  RefCDOmExprLink enableExprLink = buildCDOmExprLink(lineNumber, enableName);

  RefString stRegName     = RefString(new std::string("st_reg"));//creating the name for the state reg
  //building reg signal (reg)
  //the range of the port is required to copy it
  RefCDOmRange tempRange = output->getRange();

  RefCDOmExpr fe = tempRange->getFirstExpr();
  RefCDOmExpr se = tempRange->getSecondExpr();
  RefCDOmRange rng; 

  if(fe->getExprType() == CDOmExpr::EXPR_NUMBER && se->getExprType() == CDOmExpr::EXPR_NUMBER) {
    rng = buildCDOmRange(lineNumber,
                         buildCDOmNum32WithValue(lineNumber,
                                                 CDOmNum32::cast(fe)->getValue()),
                         buildCDOmNum32WithValue(lineNumber,
                                                 CDOmNum32::cast(se)->getValue()));//copy range from output
  }
  else {// if(fe->getExprType() == CDOmExpr::EXPR_OP && se->getExprType() == CDOmExpr::EXPR_OP) {
    rng = buildCDOmRange(lineNumber,
                         buildCDOmNum32WithValue(lineNumber, 0),
                         buildCDOmNum32WithValue(lineNumber, 0)
                         );
    RefString commentText = RefString(new string(" Bitrange of state register port for register module "));
    commentText->append(*(unitDecl->getName()));
    commentText->append(" is of another type than number. No evaluation support available. Default is [0:0].");
    RefCDOmComment comment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);
  }

  //WARNING - unsafe 
  RefCDOmVarDecl stReg = buildCDOmVarDecl(lineNumber                                , 
                                          m_cdomCurrParent                          ,
                                          VAR_REG                                   ,
                                          rng,
                                          stRegName);
  //width parameter
  //RefString widthParamName = RefString(new string("WIDTH"));
  //RefCDOmParamDecl widthParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
  //widthParam->addParam(lineNumber, widthParamName, buildCDOmMinTypMax(lineNumber, buildCDOmNum32WithValue(lineNumber, regWidth)));


  if(CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getType() == CSLOmRegDeclInfo::REG_DECL_REGISTER){
    //Optional port names - these will be created only if they exist in CSLOm
    RefString negOutputName = RefString();
    RefString setName       = RefString();
    //RefString clearName     = RefString();
    //RefString initName      = RefString();
   
    regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_REG_IN);
    ASSERT(regPortsIter != m_cdomRegisterPorts.end(), "Register has no input port");
    RefCDOmPortDecl input = regPortsIter->second;
    RefTVec_RefCDOmIdentifier inputIDs = input->getIDs();
    RefString inputName = (*(inputIDs->begin()))->getName();
    
    regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_SET);
    if(regPortsIter != m_cdomRegisterPorts.end()){
      RefCDOmPortDecl set = regPortsIter->second;
      RefTVec_RefCDOmIdentifier setIDs = set->getIDs();
      setName = (*(setIDs->begin()))->getName();
      expr=(CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getSetValue());
      regWidth; 
      if(expr->isNumber()){
        regWidth=CSLOmNum32::cast(expr)->getValue();
      }
      else{
        regWidth=1;
      }
      setValue = buildCDOmNum32WithValue(lineNumber, regWidth);//CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getSetValue()->getValue());
      hasSet = TRUE;
    }

    regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_REG_NEG_OUT);
    if(regPortsIter != m_cdomRegisterPorts.end()){
      RefCDOmPortDecl negOutput = regPortsIter->second;
      RefTVec_RefCDOmIdentifier negOutputIDs = negOutput->getIDs();
      negOutputName = (*(negOutputIDs->begin()))->getName();
      hasNegOutput = TRUE;
    }
        
    // NO LONGER NEEDED DUE TO REMOVAL
    //regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_CLEAR);
    //if(regPortsIter != m_cdomRegisterPorts.end()){
    //  RefCDOmPortDecl clear = regPortsIter->second;
    //  RefTVec_RefCDOmIdentifier clearIDs = clear->getIDs();
    //  clearName = (*(clearIDs->begin()))->getName();
    //  clearValue = buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getClearValue()->getValue());
    //  hasClear = TRUE;
    //}
    //
    //regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_INIT);
    //if(regPortsIter != m_cdomRegisterPorts.end()){
    //  RefCDOmPortDecl init = regPortsIter->second;
    //  RefTVec_RefCDOmIdentifier initIDs = init->getIDs();
    //  initName = (*(initIDs->begin()))->getName();
    //  initValue = buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getInitValue()->getValue());
    //  hasInit = TRUE;
    //}



    if(hasSet && hasNegOutput){
      adaptRegisterRegister(lineNumber, unitDecl, hasSet, hasNegOutput, stRegName, clockName, inputName, outputName, resetName, enableName, negOutputName, setName);
    }
    else if(hasSet){
      adaptRegisterRegister(lineNumber, unitDecl, hasSet, hasNegOutput, stRegName, clockName, inputName, outputName, resetName, enableName, RefString(), setName);
    }
    else if(hasNegOutput){
      adaptRegisterRegister(lineNumber, unitDecl, hasSet, hasNegOutput, stRegName, clockName, inputName, outputName, resetName, enableName, negOutputName);
    }
    else{
      adaptRegisterRegister(lineNumber, unitDecl, hasSet, hasNegOutput, stRegName, clockName, inputName, outputName, resetName, enableName);
    }   

  }
  else if(CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getType() == CSLOmRegDeclInfo::REG_DECL_COUNTER){
    hasStartVal = CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->isSetStartValue();
    hasEndVal   = CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->isSetEndValue();
    RefString startVal = RefString();
    RefString endVal   = RefString();

    RefString loadName       = RefString();
    RefString loadEnableName = RefString();

    //Predeclarations
    RefCDOmStmtAssn  rstStmt          = RefCDOmStmtAssn();
    RefCDOmStmtBlock rstStmtBlock     = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    //RefCDOmStmtBlock rstElseStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    RefCDOmStmtIf    ifEnable         = RefCDOmStmtIf();
    RefCDOmStmtIf    mainIf           = RefCDOmStmtIf();
    RefString resetValName = RefString();

    RefString minValName   = RefString(new std::string("MIN_VALUE"))  ;
    RefString maxValName   = RefString(new std::string("MAX_VALUE"))  ;

    //check for load presence
    regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_LOAD);
    if(regPortsIter != m_cdomRegisterPorts.end()){
      RefCDOmPortDecl load = regPortsIter->second;
      RefTVec_RefCDOmIdentifier loadIDs = load->getIDs();
      loadName = (*(loadIDs->begin()))->getName();
      hasLoad = TRUE;
    }

    //check for load enable presence
    regPortsIter = m_cdomRegisterPorts.find(REG_PORTN_LOAD_EN);
    if(regPortsIter != m_cdomRegisterPorts.end()){
      RefCDOmPortDecl loadEn = regPortsIter->second;
      RefTVec_RefCDOmIdentifier loadEnIDs = loadEn->getIDs();
      loadEnableName = (*(loadEnIDs->begin()))->getName();
      //Assert here because this flag should be true
      //from above load condition 
      ASSERT(hasLoad,"Load port has not been initialized");
    }
    
    
    RefCDOmStmtBlock ifEnableStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

    CSLOmRegDeclInfo::ERegDeclCntDir cntDir = CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getCntDir();

    //this will be used later - supposed to hold the load stmt as well (if there is one)
    RefCDOmStmtBlock cntLoadStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

    RefCDOmStmtAssn cntStmt = RefCDOmStmtAssn();//buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    RefCDOmNum32 minValNum, maxValNum;

    RefCSLOmExpr expr;
    TInt number;
    
    switch(cntDir){
      case CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP : 
        expr=CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getCountAmmout();
        if(expr->isNumber()){
          number=CSLOmNum32::cast(expr)->getValue();
        }
        else{
          number=1;
        }
        cntStmt = buildCDOmStmtAssnSimple(lineNumber,
                                                      CDOmStmtAssn::ASSN_NON_BLOCKING,
                                                      buildCDOmExprLink(lineNumber, stRegName),
                                                      buildCDOmExprOp(lineNumber,
                                                                      CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
                                                                      buildCDOmExprLink(lineNumber, stRegName),
                                                                      buildCDOmNum32WithValue(lineNumber, 
                                                                                              number)));
        //patch
        if(!(hasStartVal || hasEndVal)){
          resetValName = minValName;
          minValNum = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0")));
          minValNum->setIsVeriNumFlag(true);
          RefCDOmParamDecl minValParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
          minValParam->addParam(lineNumber, minValName, buildCDOmMinTypMax(lineNumber, 
                                                                           buildCDOmExprMultiConcat(lineNumber,
                                                                                                    buildCDOmNum32WithValue(lineNumber, regWidth),
                                                                                                    buildCDOmExprConcat(lineNumber,
                                                                                                                        minValNum
                                                                                                                        )
                                                                                                    )
                                                                           )
                                );
        }
                            
        break;
      case CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN : 
        expr=CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getCountAmmout();
        if(expr->isNumber()){
          number=CSLOmNum32::cast(expr)->getValue();
        }
        else{
          number=1;
        }       
       cntStmt = buildCDOmStmtAssnSimple(lineNumber,
                                                      CDOmStmtAssn::ASSN_NON_BLOCKING,
                                                      buildCDOmExprLink(lineNumber, stRegName),
                                                      buildCDOmExprOp(lineNumber,
                                                                      CDOmExprOp::OP_BINARY_ARITHMETIC_MINUS,
                                                                      buildCDOmExprLink(lineNumber, stRegName),
                                                                      buildCDOmNum32WithValue(lineNumber, 
                                                                                              number)));
       //patch
        if(!(hasStartVal || hasEndVal)){
          resetValName = maxValName;
          maxValNum = buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1")));
          maxValNum->setIsVeriNumFlag(true);
          RefCDOmParamDecl maxValParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
          maxValParam->addParam(lineNumber, maxValName, buildCDOmMinTypMax(lineNumber, 
                                                                           buildCDOmExprMultiConcat(lineNumber,
                                                                                                    buildCDOmNum32WithValue(lineNumber, regWidth),
                                                                                                    buildCDOmExprConcat(lineNumber, maxValNum)
                                                                                                    )
                                                                           )
                                );
        }
        break;
     //   //the following should be removed after CSLOM count direction gets sorted out;
     // default: {
     //   cntStmt = buildCDOmStmtAssnSimple(lineNumber,
     //                                                 CDOmStmtAssn::ASSN_NON_BLOCKING,
     //                                                 buildCDOmExprLink(lineNumber, stRegName),
     //                                                 buildCDOmExprOp(lineNumber,
     //                                                                 CDOmExprOp::OP_BINARY_ARITHMETIC_PLUS,
     //                                                                 buildCDOmExprLink(lineNumber, stRegName),
     //                                                                 buildCDOmNum32WithValue(lineNumber, 
     //                                                                                       CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getCountAmmout()->getValue())));
     // }
     //   break;
    }
    //end of case 

    //checking for load and building the right cntStmtBlock
    if(hasLoad){
      RefCDOmStmtBlock cntStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
      RefCDOmStmtBlock loadStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);

      RefCDOmStmtAssn loadStmt = buildCDOmStmtAssnSimple(lineNumber,
                                                         CDOmStmtAssn::ASSN_NON_BLOCKING,
                                                         buildCDOmExprLink(lineNumber,stRegName),
                                                         buildCDOmExprLink(lineNumber,loadName));
      cntStmtBlock->addStmt(cntStmt);
      loadStmtBlock->addStmt(loadStmt);

      RefCDOmStmtIf loadIfStmt = buildCDOmStmtIf(lineNumber,
                                                 buildCDOmExprLink(lineNumber,loadEnableName),
                                                 loadStmtBlock,
                                                 cntStmtBlock);
      cntLoadStmtBlock->addStmt(loadIfStmt);
    }
    else{
      cntLoadStmtBlock->addStmt(cntStmt);
    }

    if(hasStartVal || hasEndVal){
      //names for signals and parameters used in counter variations
      RefString startValName = RefString(new std::string("START_VALUE"));
      RefString endValName   = RefString(new std::string("END_VALUE"))  ;

      RefCDOmExprOp    enableIfExprOp         = RefCDOmExprOp();
      RefString        enableConditionValName = RefString();
      RefCDOmStmtBlock enableIfStmtBlock      = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
      RefCDOmStmtBlock enableIfElseStmtBlock  = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
      RefCDOmStmtIf    enableIfStmt           = RefCDOmStmtIf();
      //start value and end value ints - to be used below
      //WARNING: check this up against tests - it may fail
      //TInt startValAsInt;
      //TInt endValAsInt;
      RefCDOmExpr exprStart;
      RefCDOmExpr exprEnd;
      RefCSLOmExpr expr;
      if(hasStartVal){
        //startValAsInt = CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getStartValue()->getValue();
        expr=CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getStartValue();
        if(expr->isOp()) {
          expr->acceptVisitor(*this);
          exprStart = CDOmExprOp::cast(m_cdomReturnedValue);
        }
        else if(expr->isNumber()) {
          exprStart = buildCDOmNum32WithValue(lineNumber, CSLOmNum32::cast(expr)->getValue());
        }
        //exprStart=CSLOmNum32::cast(expr)->getValue();
      }
      if(hasEndVal){
        expr=CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getEndValue();
        if(expr->isOp()) {
          expr->acceptVisitor(*this);
          exprEnd = CDOmExprOp::cast(m_cdomReturnedValue);
        }
        else if(expr->isNumber()) {
          exprEnd = buildCDOmNum32WithValue(lineNumber, CSLOmNum32::cast(expr)->getValue());
        }
        //exprEnd=CSLOmNum32::cast(expr)->getValue();
        //        endValAsInt   = CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getEndValue()->getValue();
      }
      if(hasStartVal && !hasEndVal){
        //building the wire that holds the start value 
        //wire [RANGE-1:0] START_VALUE = <start_value>;
        RefCDOmNetDecl startVal;
        if(tempRange->getFirstExpr()->getExprType() == CDOmExpr::EXPR_NUMBER && tempRange->getSecondExpr()->getExprType() == CDOmExpr::EXPR_NUMBER) {
          startVal = buildCDOmNetDecl(lineNumber, 
                                      m_cdomCurrParent                          ,
                                      NET_WIRE                                  ,
                                      buildCDOmRange(lineNumber,
                                                     buildCDOmNum32WithValue(lineNumber,
                                                                             CDOmNum32::cast(tempRange->getFirstExpr())->getValue()),
                                                     buildCDOmNum32WithValue(lineNumber,
                                                                             CDOmNum32::cast(tempRange->getSecondExpr())->getValue())),//copy range from output
                                      CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                      startValName,
                                      RefCDOmRangeList(),
                                      // buildCDOmNum32WithValue(lineNumber, startValAsInt)
                                      exprStart
                                      );
        }
        else {
          RefString commentText = RefString(new string(" Bitrange of start value wire for register module "));
          commentText->append(*(unitDecl->getName()));
          commentText->append(" is of another type than number. No evaluation support available. Default is [0:0].");
          RefCDOmComment comment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);

          startVal = buildCDOmNetDecl(lineNumber, 
                                      m_cdomCurrParent                          ,
                                      NET_WIRE                                  ,
                                      buildCDOmRange(lineNumber,
                                                     buildCDOmNum32WithValue(lineNumber, 0),
                                                     buildCDOmNum32WithValue(lineNumber, 0)),
                                      CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                      startValName,
                                      RefCDOmRangeList(),
                                      //buildCDOmNum32WithValue(lineNumber, startValAsInt)
                                      exprStart
                                      );
        }
        //setting Reset value
        resetValName           = startValName;
        //setting value for assignment in else condition 
        enableConditionValName = startValName;
        switch(cntDir){
          case CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP : 
            {
            RefCDOmParamDecl maxValParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
            maxValParam->addParam(lineNumber, maxValName, buildCDOmMinTypMax(lineNumber, 
                                                                               buildCDOmExprMultiConcat(lineNumber,
                                                                                                        buildCDOmNum32WithValue(lineNumber, regWidth),
                                                                                                        buildCDOmExprConcat(lineNumber,
                                                                                                                            buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1"))))
                                                                                                        )));
            enableIfExprOp = buildCDOmExprOp(lineNumber                           ,
                                             CDOmExprOp::OP_BINARY_RELATIONAL_LESS,
                                             buildCDOmExprLink(lineNumber,
                                                               stRegName)         ,
                                             buildCDOmExprLink(lineNumber,
                                                               maxValName));
            }            
            break;
          case CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN :
            {
            RefCDOmParamDecl minValParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
            minValParam->addParam(lineNumber, minValName, buildCDOmMinTypMax(lineNumber, 
                                                                               buildCDOmExprMultiConcat(lineNumber,
                                                                                                        buildCDOmNum32WithValue(lineNumber, regWidth),
                                                                                                        buildCDOmExprConcat(lineNumber,
                                                                                                                            buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0"))))
                                                                                                        )));
            enableIfExprOp = buildCDOmExprOp(lineNumber                              ,
                                             CDOmExprOp::OP_BINARY_RELATIONAL_GREATER,
                                             buildCDOmExprLink(lineNumber,
                                                               stRegName)            ,
                                             buildCDOmExprLink(lineNumber,
                                                               minValName));
            }
            break;
        }
        //enableIfStmtBlock->addStmt(cntStmt); Instead of this
        //the pointer is updated
        enableIfStmtBlock = cntLoadStmtBlock;
        enableIfElseStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber,
                                                               CDOmStmtAssn::ASSN_NON_BLOCKING,
                                                               buildCDOmExprLink(lineNumber, stRegName),
                                                               buildCDOmExprLink(lineNumber, enableConditionValName)));
      }
      else if(!hasStartVal && hasEndVal){
        //building the wire that holds the end value 
        //wire [RANGE-1:0] END_VALUE = <end_value>;
        RefCDOmNetDecl endVal;
        if(tempRange->getFirstExpr()->getExprType() == CDOmExpr::EXPR_NUMBER && tempRange->getSecondExpr()->getExprType() == CDOmExpr::EXPR_NUMBER) {
          endVal = buildCDOmNetDecl(lineNumber, 
                                    m_cdomCurrParent                          ,
                                    NET_WIRE                                  ,
                                    buildCDOmRange(lineNumber,
                                                   buildCDOmNum32WithValue(lineNumber,
                                                                           CDOmNum32::cast(tempRange->getFirstExpr())->getValue()),
                                                   buildCDOmNum32WithValue(lineNumber,
                                                                           CDOmNum32::cast(tempRange->getSecondExpr())->getValue())),//copy range from output
                                    CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                    endValName,
                                    RefCDOmRangeList(),
                                    //buildCDOmNum32WithValue(lineNumber,endValAsInt)
                                    exprEnd
                                    );
        }
        else {
          RefString commentText = RefString(new string(" Bitrange of end value wire for register module "));
          commentText->append(*(unitDecl->getName()));
          commentText->append(" is of another type than number. No evaluation support available. Default is [0:0].");
          RefCDOmComment comment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);

          endVal = buildCDOmNetDecl(lineNumber, 
                                    m_cdomCurrParent                          ,
                                    NET_WIRE                                  ,
                                    buildCDOmRange(lineNumber,
                                                   buildCDOmNum32WithValue(lineNumber, 0),
                                                   buildCDOmNum32WithValue(lineNumber, 0)),
                                    CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                    endValName,
                                    RefCDOmRangeList(),
                                    //buildCDOmNum32WithValue(lineNumber, endValAsInt)
                                    exprEnd
                                    );
        }
        switch(cntDir){
          case CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP : 
            {
              RefCDOmParamDecl minValParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
              minValParam->addParam(lineNumber, minValName, buildCDOmMinTypMax(lineNumber, 
                                                                               buildCDOmExprMultiConcat(lineNumber,
                                                                                                        buildCDOmNum32WithValue(lineNumber, regWidth),
                                                                                                        buildCDOmExprConcat(lineNumber,
                                                                                                                            buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("0"))))
                                                                                                        )));
              enableIfExprOp = buildCDOmExprOp(lineNumber                           ,
                                               CDOmExprOp::OP_BINARY_RELATIONAL_LESS,
                                               buildCDOmExprLink(lineNumber,
                                                                 stRegName)         ,
                                               buildCDOmExprLink(lineNumber,
                                                                 endValName));
              resetValName           = minValName;
              enableConditionValName = minValName;
            }            
            break;
          case CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN : 
            {
              RefCDOmParamDecl maxValParam = buildCDOmParamDecl(lineNumber, m_cdomCurrParent, CDOmParamDecl::PARAM_DECL_SIMPLE);
              maxValParam->addParam(lineNumber, maxValName, buildCDOmMinTypMax(lineNumber, 
                                                                               buildCDOmExprMultiConcat(lineNumber,
                                                                                                        buildCDOmNum32WithValue(lineNumber, regWidth),
                                                                                                        buildCDOmExprConcat(lineNumber,
                                                                                                                            buildCDOmNum32WithString(lineNumber, CDOmNum32::NUM_BASE_BIN, RefString(new string("1"))))
                                                                                                        )));
              enableIfExprOp = buildCDOmExprOp(lineNumber                           ,
                                               CDOmExprOp::OP_BINARY_RELATIONAL_GREATER,
                                               buildCDOmExprLink(lineNumber,
                                                                 stRegName)         ,
                                               buildCDOmExprLink(lineNumber,
                                                                 endValName));
              resetValName           = maxValName;
              enableConditionValName = maxValName;
            }            
            break;
        }
        //enableIfStmtBlock->addStmt(cntStmt);
        //the pointer is updated
        enableIfStmtBlock = cntLoadStmtBlock;
        enableIfElseStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber,
                                                               CDOmStmtAssn::ASSN_NON_BLOCKING,
                                                               buildCDOmExprLink(lineNumber, stRegName),
                                                               buildCDOmExprLink(lineNumber, enableConditionValName)));
      }
      else if(hasStartVal && hasEndVal){
      //this is the case when both startVal and endVal are present
         RefCDOmNetDecl startVal;
         if(tempRange->getFirstExpr()->getExprType() == CDOmExpr::EXPR_NUMBER && tempRange->getSecondExpr()->getExprType() == CDOmExpr::EXPR_NUMBER) {
          startVal = buildCDOmNetDecl(lineNumber, 
                                      m_cdomCurrParent                          ,
                                      NET_WIRE                                  ,
                                      buildCDOmRange(lineNumber,
                                                     buildCDOmNum32WithValue(lineNumber,
                                                                             CDOmNum32::cast(tempRange->getFirstExpr())->getValue()),
                                                     buildCDOmNum32WithValue(lineNumber,
                                                                             CDOmNum32::cast(tempRange->getSecondExpr())->getValue())),//copy range from output
                                      CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                      startValName,
                                      RefCDOmRangeList(),
                                      //buildCDOmNum32WithValue(lineNumber, startValAsInt)
                                      exprStart
                                      );
        }
        else {
          RefString commentText = RefString(new string(" Bitrange of start value wire for register module "));
          commentText->append(*(unitDecl->getName()));
          commentText->append(" is of another type than number. No evaluation support available. Default is [0:0].");
          RefCDOmComment comment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);

          startVal = buildCDOmNetDecl(lineNumber, 
                                      m_cdomCurrParent                          ,
                                      NET_WIRE                                  ,
                                      buildCDOmRange(lineNumber,
                                                     buildCDOmNum32WithValue(lineNumber, 0),
                                                     buildCDOmNum32WithValue(lineNumber, 0)),
                                      CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                      startValName,
                                      RefCDOmRangeList(),
                                      //buildCDOmNum32WithValue(lineNumber, startValAsInt)
                                      exprStart
                                      );
        }


      
      //building the wire that holds the end value 
      //wire [RANGE-1:0] END_VALUE = <end_value>;
        RefCDOmNetDecl endVal;
        if(tempRange->getFirstExpr()->getExprType() == CDOmExpr::EXPR_NUMBER && tempRange->getSecondExpr()->getExprType() == CDOmExpr::EXPR_NUMBER) {
          endVal = buildCDOmNetDecl(lineNumber, 
                                    m_cdomCurrParent                          ,
                                    NET_WIRE                                  ,
                                    buildCDOmRange(lineNumber,
                                                   buildCDOmNum32WithValue(lineNumber,
                                                                           CDOmNum32::cast(tempRange->getFirstExpr())->getValue()),
                                                   buildCDOmNum32WithValue(lineNumber,
                                                                           CDOmNum32::cast(tempRange->getSecondExpr())->getValue())),//copy range from output
                                    CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                    endValName,
                                    RefCDOmRangeList(),
                                    //buildCDOmNum32WithValue(lineNumber, endValAsInt)
                                    exprEnd
                                    );
        }
        else {
          RefString commentText = RefString(new string(" Bitrange of end value wire for register module "));
          commentText->append(*(unitDecl->getName()));
          commentText->append(" is of another type than number. No evaluation support available. Default is [0:0].");
          RefCDOmComment comment = buildCDOmComment(lineNumber, CDOmModuleDecl::cast(m_cdomCurrParent), CDOmComment::TYPE_SLASH_SLASH, commentText);

          endVal = buildCDOmNetDecl(lineNumber, 
                                    m_cdomCurrParent                          ,
                                    NET_WIRE                                  ,
                                    buildCDOmRange(lineNumber,
                                                   buildCDOmNum32WithValue(lineNumber, 0),
                                                   buildCDOmNum32WithValue(lineNumber, 0)),
                                    CDOmNetDecl::VECTOR_ACCESS_UNDEFINED,
                                    endValName,
                                    RefCDOmRangeList(),
                                    //buildCDOmNum32WithValue(lineNumber, endValAsInt)
                                    exprEnd
                                    );
        }


      
        enableIfExprOp = buildCDOmExprOp(lineNumber                           ,
                                         CDOmExprOp::OP_BINARY_EQUALITY_EQ    ,
                                         buildCDOmExprLink(lineNumber,
                                                           stRegName)         ,
                                         buildCDOmExprLink(lineNumber,
                                                           endValName));
        resetValName           = startValName;
        enableConditionValName = startValName;

        enableIfStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber,
                                                           CDOmStmtAssn::ASSN_NON_BLOCKING,
                                                           buildCDOmExprLink(lineNumber, stRegName),
                                                           buildCDOmExprLink(lineNumber, enableConditionValName)));
        //enableIfElseStmtBlock->addStmt(cntStmt);
        //the pointer is updated
        enableIfElseStmtBlock = cntLoadStmtBlock;
              
      }
      enableIfStmt = buildCDOmStmtIf(lineNumber,
                                    enableIfExprOp,
                                    enableIfStmtBlock,
                                    enableIfElseStmtBlock);
      ifEnableStmtBlock->addStmt(enableIfStmt);
    }
    else{
      //ifEnableStmtBlock->addStmt(cntStmt);
      //the pointer is updated
      ifEnableStmtBlock = cntLoadStmtBlock;
    }
    //adding the statement to the rstStmtBlock
    rstStmt = buildCDOmStmtAssnSimple(lineNumber,
                                      CDOmStmtAssn::ASSN_NON_BLOCKING,
                                      buildCDOmExprLink(lineNumber, stRegName),
                                      buildCDOmExprLink(lineNumber, resetValName));
    rstStmtBlock->addStmt(rstStmt);
    ifEnable = buildCDOmStmtIf(lineNumber,
                               buildCDOmExprLink(lineNumber, enableName),
                               ifEnableStmtBlock,
                               RefCDOmStmt());
    mainIf = buildCDOmStmtIf(lineNumber,
                             buildCDOmExprOp(lineNumber                                  ,
                                             CDOmExprOp::OP_UNARY_BITWISE_NOT          ,
                                             buildCDOmExprLink(lineNumber   , resetName)),
                             rstStmtBlock,
                             ifEnable);

    RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);   
    stmtBlock->addStmt(mainIf);

    RefCDOmEventExpr evExpr = buildCDOmEventExprDouble(lineNumber, 
                                                       CDOmEventExpr::EVENT_EXPR_OR, 
                                                       buildCDOmEventExprSimple( lineNumber, 
                                                                                 CDOmEventExpr::EVENT_EXPR_POSEDGE, 
                                                                                 buildCDOmExprLink(lineNumber, clockName)
                                                                                 ),
                                                       buildCDOmEventExprSimple( lineNumber, 
                                                                                 CDOmEventExpr::EVENT_EXPR_NEGEDGE, 
                                                                                 buildCDOmExprLink(lineNumber, resetName)
                                                                                 ));

    RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);
    RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock);

    RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc );

    //building output assignment 
    RefCDOmAssn posAssn = buildCDOmAssn(lineNumber                               ,
                                        buildCDOmExprLink(lineNumber, outputName),
                                        buildCDOmExprLink(lineNumber, stRegName));
    RefCDOmContAssn posContAssn = buildCDOmContAssn(lineNumber, m_cdomCurrParent);
    posContAssn->addNetAssn(posAssn);
  }


//////    Commented out due to change
//////    //predeclaration to be used later
//////    RefCDOmStmtIf    mainIf          = RefCDOmStmtIf();
//////    //RefCDOmStmtBlock enableBlock     = RefCDOmStmtBlock();
//////    RefCDOmStmtBlock initStmtBlock   = RefCDOmStmtBlock();
//////    RefCDOmStmtBlock clearStmtBlock  = RefCDOmStmtBlock();
//////    RefCDOmStmtBlock enableStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
//////    RefCDOmStmtIf    ifReset         = RefCDOmStmtIf();
//////    RefCDOmEventExpr evExpr          = RefCDOmEventExpr();
//////    //building standard stmt block (the actual input -> output assignment) - this will be stored for later
//////    RefCDOmStmtBlock stdStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
//////    //building standard assignments
//////    stdStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                  CDOmStmtAssn::ASSN_NON_BLOCKING             ,
//////                                                  buildCDOmExprLink(lineNumber   , outputName),
//////                                                  buildCDOmExprLink(lineNumber   , inputName )
//////                                                  ));
//////    if(hasNegOutput){
//////      stdStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                    CDOmStmtAssn::ASSN_NON_BLOCKING,
//////                                                    buildCDOmExprLink(lineNumber   , negOutputName),
//////                                                    buildCDOmExprOp  (lineNumber, 
//////                                                                      CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                      buildCDOmExprLink(lineNumber, inputName)
//////                                                                      )));
//////    }
//////
//////    //checking for clear presence
//////    if(hasClear){
//////      //building clear stmt block
//////      clearStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
//////      clearStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                      CDOmStmtAssn::ASSN_NON_BLOCKING             ,
//////                                                      buildCDOmExprLink(lineNumber   , outputName),
//////                                                      //buildCDOmExprLink(lineNumber   , clearName )
//////                                                      buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getClearValue()->getValue())
//////                                                      ));
//////      if(hasNegOutput){
//////        clearStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                        CDOmStmtAssn::ASSN_NON_BLOCKING,
//////                                                        buildCDOmExprLink(lineNumber   , negOutputName),
//////                                                        buildCDOmExprOp  (lineNumber, 
//////                                                                          CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                          //buildCDOmExprLink(lineNumber    , clearName)
//////                                                                          buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getClearValue()->getValue())
//////                                                                          )));
//////      }
//////      //If there is no init logic we are creating the clear<->std if block
//////      if(!hasInit){
//////        mainIf = buildCDOmStmtIf(lineNumber, 
//////                                 buildCDOmExprLink(lineNumber, clearName),
//////                                 clearStmtBlock,
//////                                 stdStmtBlock);
//////      }
//////    }
//////    //checking for init presence
//////    if(hasInit){
//////      //building init stmt block
//////      initStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
//////      initStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                     CDOmStmtAssn::ASSN_NON_BLOCKING             ,
//////                                                     buildCDOmExprLink(lineNumber   , outputName),
//////                                                     //buildCDOmExprLink(lineNumber   , initName )
//////                                                     buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getInitValue()->getValue())
//////                                                     ));
//////      if(hasNegOutput){
//////        initStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                       CDOmStmtAssn::ASSN_NON_BLOCKING,
//////                                                       buildCDOmExprLink(lineNumber   , negOutputName),
//////                                                       buildCDOmExprOp  (lineNumber, 
//////                                                                         CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                         //buildCDOmExprLink(lineNumber    , initName)
//////                                                                         buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getInitValue()->getValue())
//////                                                                         )));
//////      }
//////      //If there is no clear logic we are creating the init<->std if block
//////      if(!hasClear){
//////        mainIf = buildCDOmStmtIf(lineNumber, 
//////                                 buildCDOmExprLink(lineNumber, initName),
//////                                 initStmtBlock,
//////                                 stdStmtBlock);
//////      }
//////    }
//////    if(hasClear && hasInit){
//////      RefCDOmStmtIf initAndStdIf = buildCDOmStmtIf(lineNumber, 
//////                                                   buildCDOmExprLink(lineNumber, initName),
//////                                                   initStmtBlock,
//////                                                   stdStmtBlock);
//////      mainIf = buildCDOmStmtIf(lineNumber, 
//////                               buildCDOmExprLink(lineNumber, clearName),
//////                               clearStmtBlock,
//////                               initAndStdIf);
//////
//////    }
//////    if(hasClear || hasInit){
//////      enableStmtBlock->addStmt(mainIf);
//////    }
//////    else{
//////      enableStmtBlock = stdStmtBlock;
//////    }
//////    //
//////    RefCDOmStmtIf ifEnableStmt = buildCDOmStmtIf(lineNumber,
//////                                                 buildCDOmExprLink(lineNumber, enableName),
//////                                                 enableStmtBlock                          ,
//////                                                 RefCDOmStmt());
//////    RefCDOmStmtBlock resetStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
//////    resetStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                    CDOmStmtAssn::ASSN_NON_BLOCKING             ,
//////                                                    buildCDOmExprLink(lineNumber   , outputName),
//////                                                    buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getResetValue()->getValue())
//////                                                    //resetValue
//////                                                    ));
//////    if(hasNegOutput){
//////      RefCDOmStmtAssn negOutputOnReset = buildCDOmStmtAssnSimple(lineNumber, 
//////                                                                 CDOmStmtAssn::ASSN_NON_BLOCKING,
//////                                                                 buildCDOmExprLink(lineNumber   , negOutputName),
//////                                                                 buildCDOmExprOp  (lineNumber, 
//////                                                                                   CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                                   buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getResetValue()->getValue())
//////                                                                                   //resetValue
//////                                                                                   ));
//////      resetStmtBlock->addStmt(negOutputOnReset);
//////    }
//////    if(hasSet){
//////      RefCDOmStmtBlock setStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
//////      setStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                    CDOmStmtAssn::ASSN_NON_BLOCKING             ,
//////                                                    buildCDOmExprLink(lineNumber   , outputName),
//////                                                    buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getSetValue()->getValue())
//////                                                    //setValue
//////                                                    ));
//////      if(hasNegOutput){
//////        setStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
//////                                                      CDOmStmtAssn::ASSN_NON_BLOCKING,
//////                                                      buildCDOmExprLink(lineNumber   , negOutputName),
//////                                                      buildCDOmExprOp  (lineNumber, 
//////                                                                        CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                        buildCDOmNum32WithValue(lineNumber, CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getSetValue()->getValue())
//////                                                                        //setValue
//////                                                                        )));
//////      }
//////      RefCDOmStmtIf ifSet = buildCDOmStmtIf(lineNumber       ,
//////                                            buildCDOmExprOp(lineNumber                                                ,
//////                                                            CDOmExprOp::OP_BINARY_BITWISE_AND,
//////                                                            buildCDOmExprOp(lineNumber,
//////                                                                            CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                            buildCDOmExprLink(lineNumber   , setName)),
//////                                                            buildCDOmExprLink(lineNumber   , enableName)
//////                                                            ),
//////                                            setStmtBlock     ,
//////                                            ifEnableStmt
//////                                            );
//////      ifReset = buildCDOmStmtIf(lineNumber     ,
//////                                buildCDOmExprOp(lineNumber                                                  ,
//////                                                CDOmExprOp::OP_BINARY_BITWISE_AND,
//////                                                buildCDOmExprOp(lineNumber,
//////                                                                CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                buildCDOmExprLink(lineNumber   , resetName)),
//////                                                buildCDOmExprLink(lineNumber   , enableName)
//////                                                ),
//////                                resetStmtBlock   ,
//////                                ifSet
//////                                );
//////      //building event expr
//////      evExpr = buildCDOmEventExprDouble( lineNumber, 
//////                                         CDOmEventExpr::EVENT_EXPR_OR, 
//////                                         buildCDOmEventExprSimple( lineNumber, 
//////                                                                   CDOmEventExpr::EVENT_EXPR_POSEDGE, 
//////                                                                   buildCDOmExprLink(lineNumber, clockName)
//////                                                                   ),
//////                                         buildCDOmEventExprDouble( lineNumber,
//////                                                                   CDOmEventExpr::EVENT_EXPR_OR,
//////                                                                   buildCDOmEventExprSimple( lineNumber, 
//////                                                                                             CDOmEventExpr::EVENT_EXPR_NEGEDGE, 
//////                                                                                             buildCDOmExprLink(lineNumber, resetName)
//////                                                                                             ),
//////                                                                   buildCDOmEventExprSimple( lineNumber,
//////                                                                                             CDOmEventExpr::EVENT_EXPR_NEGEDGE,
//////                                                                                             buildCDOmExprLink(lineNumber, setName)
//////                                                                                             )
//////                                                                   ));
//////                                            
//////    }
//////    else{
//////      ifReset = buildCDOmStmtIf(lineNumber     ,
//////                                buildCDOmExprOp(lineNumber,
//////                                                CDOmExprOp::OP_BINARY_BITWISE_AND                              ,
//////                                                buildCDOmExprOp(lineNumber,
//////                                                                CDOmExprOp::OP_UNARY_BITWISE_NOT,
//////                                                                buildCDOmExprLink(lineNumber   , resetName)),
//////                                                buildCDOmExprLink(lineNumber   , enableName)
//////                                                ),
//////                                resetStmtBlock   ,
//////                                ifEnableStmt
//////                                );   
//////      //building event expr
//////      evExpr = buildCDOmEventExprDouble( lineNumber, 
//////                                         CDOmEventExpr::EVENT_EXPR_OR, 
//////                                         buildCDOmEventExprSimple( lineNumber, 
//////                                                                   CDOmEventExpr::EVENT_EXPR_POSEDGE, 
//////                                                                   buildCDOmExprLink(lineNumber, clockName)
//////                                                                   ),
//////                                         buildCDOmEventExprSimple( lineNumber,
//////                                                                   CDOmEventExpr::EVENT_EXPR_NEGEDGE,
//////                                                                   buildCDOmExprLink(lineNumber, resetName)
//////                                                                   )
//////                                         );
//////       
//////    }
//////
//////    //building always block
//////    RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);   
//////    stmtBlock->addStmt(ifReset);
//////
//////    RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);
//////    RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock);
//////    RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc );
                                                        
  //generating register barebone logic
    //adaptFlipFlop(lineNumber, regWidth, inputName, outputName, clockName, resetName);
  //RefCSLOmRegDeclInfo regInfo = CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo());
  //RefCSLOmNum32 width = CSLOmNum32::cast(regInfo->getWidth());
  //TInt regWidth = 0;
  //if(width.get()) {
  //  regWidth = width->getValue();
  //}
  //
  //RefString regInputName, regOutputName, regClockName, regResetName;
  //RefCDOmPortDecl regInput, regOutput, regClock, regReset;
  //
  //RefString counterClockName, counterResetName, counterValName, counterEnName, counterZeroName;
  //RefCDOmPortDecl counterClock, counterReset, counterEn, counterZero;
  //RefCDOmVarDecl counterVal;
  //
  //switch(regInfo->getType()) {
  //  
  //  case CSLOmRegDeclInfo::REG_DECL_COUNTER:
  //    counterClockName = RefString(new string("clock"));
  //    counterClock = buildCDOmPortDeclNet(unitDecl->getLineNumber(), 
  //                                        m_cdomCurrParent,
  //                                        PORT_INPUT,
  //                                        NET_WIRE,
  //                                        buildCDOmRange(unitDecl->getLineNumber(), 
  //                                                       buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                       buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                       ),
  //                                        counterClockName
  //                                        );
  //
  //    counterResetName = RefString(new string("reset"));
  //    counterReset = buildCDOmPortDeclNet(unitDecl->getLineNumber(), 
  //                                        m_cdomCurrParent,
  //                                        PORT_INPUT,
  //                                        NET_WIRE,
  //                                        buildCDOmRange(unitDecl->getLineNumber(), 
  //                                                       buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                       buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                       ),
  //                                        counterResetName
  //                                        );
  //
  //    counterEnName = RefString(new string("enable"));
  //    counterEn = buildCDOmPortDeclNet(unitDecl->getLineNumber(), 
  //                                     m_cdomCurrParent,
  //                                     PORT_INPUT,
  //                                     NET_WIRE,
  //                                     buildCDOmRange(unitDecl->getLineNumber(), 
  //                                                    buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                    buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                    ),
  //                                     counterEnName
  //                                     );
  //
  //    counterZeroName = RefString(new string("zero"));
  //    counterZero = buildCDOmPortDeclNet(unitDecl->getLineNumber(), 
  //                                       m_cdomCurrParent,
  //                                       PORT_INPUT,
  //                                       NET_WIRE,
  //                                       buildCDOmRange(unitDecl->getLineNumber(), 
  //                                                      buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                      buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                      ),
  //                                       counterZeroName
  //                                       );
  //
  //    counterValName = RefString(new string("value"));
  //    counterVal = buildCDOmVarDecl(unitDecl->getLineNumber(), 
  //                                  m_cdomCurrParent,
  //                                  VAR_REG,
  //                                  buildCDOmRange(unitDecl->getLineNumber(), 
  //                                                 buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                 buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                 ),
  //                                  counterValName
  //                                  );
  //
  //    adaptCounter(unitDecl->getLineNumber(), counterClockName, counterResetName, counterValName, counterEnName, counterZeroName);
  //    break;
  //  default:
  //    regInputName = RefString(new string("reg_input"));
  //    regInput = buildCDOmPortDeclNet(unitDecl->getLineNumber(),
  //                                    m_cdomCurrParent,
  //                                    PORT_INPUT,
  //                                    NET_WIRE,
  //                                    buildCDOmRange(unitDecl->getLineNumber(),
  //                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                   ),
  //                                    regInputName
  //                                    );    
  //
  //    regOutputName = RefString(new string("reg_output"));
  //    regOutput = buildCDOmPortDeclVar(unitDecl->getLineNumber(),
  //                                     m_cdomCurrParent,
  //                                     VAR_REG,
  //                                     buildCDOmRange(unitDecl->getLineNumber(),
  //                                                    buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                    buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                    ),
  //                                     regOutputName
  //                                     );    
  //
  //    regClockName = RefString(new string("clock"));
  //    regClock = buildCDOmPortDeclNet(unitDecl->getLineNumber(),
  //                                    m_cdomCurrParent,
  //                                    PORT_INPUT,
  //                                    NET_WIRE,
  //                                    buildCDOmRange(unitDecl->getLineNumber(),
  //                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                   ),
  //                                    regClockName
  //                                    );    
  //
  //    regResetName = RefString(new string("reset"));
  //    regReset = buildCDOmPortDeclNet(unitDecl->getLineNumber(),
  //                                    m_cdomCurrParent,
  //                                    PORT_INPUT,
  //                                    NET_WIRE,
  //                                    buildCDOmRange(unitDecl->getLineNumber(),
  //                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0),
  //                                                   buildCDOmNum32WithValue(unitDecl->getLineNumber(), 0)
  //                                                   ),
  //                                    regResetName
  //                                    );    
  //
  //    adaptFlipFlop(unitDecl->getLineNumber(), regWidth, regInputName, regOutputName, regClockName, regResetName);
  //    break;
  //}

  

}

void CAdapterToCDOM::adaptRegisterRegister                                          (TLineNumberType           lineNumber   ,
                                                                                     NSCSLOm::RefCSLOmUnitDecl unitDecl     ,
                                                                                     TBool                     hasSet       ,
                                                                                     TBool                     hasNegOutput ,
                                                                                     RefString                 stRegName    ,
                                                                                     RefString                 clockName    ,
                                                                                     RefString                 inputName    ,
                                                                                     RefString                 outputName   ,
                                                                                     RefString                 resetName    ,
                                                                                     RefString                 enableName   ,
                                                                                     RefString                 negOutputName,
                                                                                     RefString                 setName 
                                                                                     ){
  //generating register logic

    RefCDOmStmtIf    mainIf          = RefCDOmStmtIf();
    RefCDOmEventExpr evExpr          = RefCDOmEventExpr();
    //building standard stmt block (the actual input -> output assignment) - this will be stored for later
    RefCDOmStmtBlock stdStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    //building standard assignment [std_assign_stmt_block]
    ////  Verilog code ////////////
    //
    //    if(enable) begin
    //      st_reg = reg_in;
    //    end
    //
    ///////////////////////////////
    stdStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber                                  , 
                                                  CDOmStmtAssn::ASSN_NON_BLOCKING             ,
                                                  buildCDOmExprLink(lineNumber   , stRegName) ,
                                                  buildCDOmExprLink(lineNumber   , inputName )
                                                  ));
    RefCDOmStmtIf stdIfStmt = buildCDOmStmtIf(lineNumber                               ,
                                              buildCDOmExprLink(lineNumber, enableName),
                                              stdStmtBlock                             ,
                                              RefCDOmStmt());
    //building reset assignment [reset_stmt_block]
    ////  Verilog code ////////////
    //
    //    begin
    //      st_reg = <reset_value>;
    //    end
    //
    ///////////////////////////////
    RefCDOmStmtBlock resetStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
    RefCSLOmExpr expr=CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getResetValue();
    TInt number = 0;
    RefString rstValName = RefString(new string(""));
    if(expr->isNumber()){
      number = CSLOmNumber::cast(expr)->getValue();
      resetStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
                                                    CDOmStmtAssn::ASSN_NON_BLOCKING             ,
                                                    buildCDOmExprLink(lineNumber   , stRegName),
                                                    buildCDOmNum32WithValue(lineNumber,number)
                                                    ));
    }
    else if(expr->isExprLink()){
      rstValName = CSLOmExprLink::cast(expr)->getName();
      resetStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
                                                    CDOmStmtAssn::ASSN_NON_BLOCKING             ,
                                                    buildCDOmExprLink(lineNumber   , stRegName),
                                                    buildCDOmExprLink(lineNumber, rstValName)
                                                    ));
    }                                               





    if(hasSet){
      //building set assignment and if [set_stmt_block_if]
      ////  Verilog code ////////////
      //
      //    else if ( set )  begin 
      //        st_reg <= <set_value>;
      //    end
      //
      ///////////////////////////////
      RefCDOmStmtBlock setStmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);
      RefCSLOmExpr expr=CSLOmRegDeclInfo::cast(unitDecl->getUnitInfo())->getSetValue();
      TInt number = 0;
      RefString setValName = RefString(new string(""));
      if(expr->isNumber()){
        number = CSLOmNumber::cast(expr)->getValue();
        setStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
                                                        CDOmStmtAssn::ASSN_NON_BLOCKING             ,
                                                        buildCDOmExprLink(lineNumber   , stRegName),
                                                        buildCDOmNum32WithValue(lineNumber,number)
                                                        ));
      }
      else if(expr->isExprLink()){
        setValName = CSLOmExprLink::cast(expr)->getName();
        setStmtBlock->addStmt(buildCDOmStmtAssnSimple(lineNumber, 
                                                        CDOmStmtAssn::ASSN_NON_BLOCKING             ,
                                                        buildCDOmExprLink(lineNumber   , stRegName),
                                                        buildCDOmExprLink(lineNumber, setValName)
                                                        ));
      }                    

      RefCDOmStmtIf ifSet = buildCDOmStmtIf(lineNumber                            ,
                                            buildCDOmExprLink(lineNumber, setName),
                                            setStmtBlock                          ,
                                            stdIfStmt);
      mainIf = buildCDOmStmtIf(lineNumber                                                   ,
                                buildCDOmExprOp(lineNumber                                ,
                                                CDOmExprOp::OP_UNARY_BITWISE_NOT          ,
                                                buildCDOmExprLink(lineNumber   , resetName)),
                                resetStmtBlock   ,
                                ifSet
                                );
    }
    else{
            mainIf = buildCDOmStmtIf(lineNumber                                                   ,
                                buildCDOmExprOp(lineNumber                                ,
                                                CDOmExprOp::OP_UNARY_BITWISE_NOT          ,
                                                buildCDOmExprLink(lineNumber   , resetName)),
                                resetStmtBlock   ,
                                stdIfStmt
                                );
    }

    evExpr = buildCDOmEventExprDouble( lineNumber, 
                                       CDOmEventExpr::EVENT_EXPR_OR, 
                                       buildCDOmEventExprSimple( lineNumber, 
                                                                 CDOmEventExpr::EVENT_EXPR_POSEDGE, 
                                                                 buildCDOmExprLink(lineNumber, clockName)
                                                                 ),
                                       buildCDOmEventExprSimple( lineNumber, 
                                                                 CDOmEventExpr::EVENT_EXPR_NEGEDGE, 
                                                                 buildCDOmExprLink(lineNumber, resetName)
                                                                 ));
    //building always statement block [always_stmt_block]
    ////  Verilog code ////////////
    //
    //    begin 
    //      if ( ~reset_ )      
    //         [reset_stmt_block]
    //      else [set_stmt_block_if]
    //         else [std_assign_stmt_block]
    //    end
    //
    ///////////////////////////////
    RefCDOmStmtBlock stmtBlock = buildCDOmStmtBlock(lineNumber, CDOmStmtBlock::BLOCK_SEQUENTIAL);   
    stmtBlock->addStmt(mainIf);

    RefCDOmEventControl evCtrl = buildCDOmEventControlWithEvExpr(lineNumber, evExpr);
    RefCDOmStmtProcTimingControl ptc = buildCDOmStmtProcTimingControlWithEventControl(lineNumber, evCtrl, stmtBlock);
    //building always block
    ////  Verilog code ////////////
    //
    //    always @ (posedge clock or negedge reset) 
    //      [always_stmt_block]
    //
    ///////////////////////////////
    RefCDOmInitOrAlways alwaysBlock = buildCDOmInitOrAlways(lineNumber, m_cdomCurrParent, CDOmInitOrAlways::INIT_OR_ALWAYS_ALWAYS, ptc );

    //building normal output assignment
    RefCDOmAssn posAssn = buildCDOmAssn(lineNumber                               ,
                                        buildCDOmExprLink(lineNumber, outputName),
                                        buildCDOmExprLink(lineNumber, stRegName));
    RefCDOmContAssn posContAssn = buildCDOmContAssn(lineNumber, m_cdomCurrParent);
    posContAssn->addNetAssn(posAssn);
    
    //building negative output assignment (optional)
    if(hasNegOutput){
    RefCDOmAssn negAssn = buildCDOmAssn(lineNumber                                                ,
                                        buildCDOmExprLink(lineNumber, negOutputName)              ,
                                        buildCDOmExprOp(lineNumber                              ,
                                                        CDOmExprOp::OP_UNARY_BITWISE_NOT        ,
                                                        buildCDOmExprLink(lineNumber, stRegName)));
    RefCDOmContAssn negContAssn = buildCDOmContAssn(lineNumber, m_cdomCurrParent);
    negContAssn->addNetAssn(negAssn);
    }
}

}//end of namespace
