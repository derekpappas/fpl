//---------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpath Logic, Inc.
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic, Inc.;
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

// Author BogdanZ & MihaelaP & AndreiS

#include "CSLOM.h"
#include "CSLOM_cmd.h"
#include <algorithm>
#include <iterator>
#include <vector>
#include <string>
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../support/ErrorAPI.h"

using namespace std;


/*
 *A flag that becomes true if at least one error was encoutered. If the flag is true, the compiler will stop, that is, the adaptor will not be called.
 */
TBool cslomHasErrors = FALSE;

namespace NSCSLOm {

//
//function used to compare two numbers: the first one should be greater than the second one ( number > value )
//
TBool greaterThan(TInt number, TInt value) {
  if(number <= value) {
    return FALSE;
  }
  return TRUE;
}

//
//Function used to compare two numbers: the first one should be different from the second one ( number != value )
//
TBool notEqual(TInt number, TInt value) {
  if(number == value) {
    return FALSE;
  }
  return TRUE;
}


// ********************************************************************************
// CSLOmSetCommand class
// ********************************************************************************
ECSLOmCommandType CSLOmSetCommand::m_keyword = TYPE_CMD_UNDEFINED;


RefString CSLOmSetCommand::getScopeValue(RefCSLOmBase scopeParent) {
  ASSERT(scopeParent.get(), "scopeParent should not be null at this point");

  if(scopeParent->isDesign()) {
    return RefString(new std::string("global"));
  }
  else if(scopeParent->isNumber()) {
    return CSLOmNumber::cast(scopeParent)->getTokenString();
  }
  else {
    if (scopeParent->isEnumItem()) {
      return CSLOmIdentifier::cast(scopeParent)->getName();
    }
    else {
      return CSLOmIdentifier::cast(scopeParent->getChild(ID))->getName();
    }
  }
}

TBool CSLOmSetCommand::checkParamSize(RefTVec_RefCSLOmExpr params, TUInt noMin, TUInt noMax, std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue) {
  TBool throwErr = FALSE;
  if (params->size() < noMin) {
    throwErr = TRUE;
  }
  else if (params->size() > noMax) {
    throwErr = TRUE;
  }
  if(throwErr) {
    args.push_back(errName);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_WRONG_ARG_NR, args, lineNumber, fileName);
    canContinue = FALSE;
    return FALSE;
  }
  return TRUE;
}


RefCSLOmBase CSLOmSetCommand::checkParentScope(RefCSLOmExprLink scope, TLineNumberType lineNumber, RefString fileName, TBool &canContinue) {
  RefCSLOmBase scopeParent;
  if(scope.get()) {
    scopeParent = scope->doEval();
  }
  else{
    scopeParent = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
  }
  if(!scopeParent.get()) {
    args.push_back(*scope->getName());
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE,args,lineNumber, fileName);
    canContinue = FALSE;
  }
  return scopeParent;
}

RefCSLOmBase CSLOmSetCommand::checkParentScope(RefCSLOmExprLink scope, TLineNumberType lineNumber, RefString fileName) {
  RefCSLOmBase scopeParent;
  if(scope.get()) {
    scopeParent = scope->doEval();
  }
  else{
    scopeParent = CSLOmScopeBlock::getCurrentScope()->getHolderObject();
  }
  if(!scopeParent.get()) {
    args.push_back(*scope->getName());
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE,args,lineNumber, fileName);
  }
  return scopeParent;
}

TBool CSLOmSetCommand::checkParentType(TIsPredicate f[],TUInt aSize,RefCSLOmBase parentScope,RefCSLOmExprLink scope,std::string errName,TLineNumberType lineNumber, RefString fileName,TBool &canContinue) {
  ASSERT(parentScope.get(), "parentScope is null");

  TBool flag;               //initialy false; it becomes true when parentScope is of one of the types from the array f, or is a list of elements of one of the types 
                            //from that array     
   
  if(aSize <= 0) {          //if the array is empty, there is no check to be made, so flag is TRUE from the beginning
    flag = TRUE;
  }
  else {
    flag = FALSE;
  }
 
  for(TUInt i = 0; i < aSize; ++i) {
    if(((*parentScope).*f[i])()) {
      flag = TRUE;
    }
  }

  if(!flag && aSize != 0) {
    //if scopeParent wasn't of any of the types from the array, the scopeParent could be a list
    if(parentScope->isList()) {
      RefTVec_RefCSLOmBase objs;
      objs = (CSLOmList::cast(parentScope))->getObjects();//get all the elements of the list
      if(objs.get()) {
        for(TUInt it = 0; it < objs->size(); it++) {
          flag  = FALSE;
          for(TUInt i = 0; i < aSize; i++) {
            if(((*objs->at(it)).*f[i])()) {
              flag = TRUE;
            }
          }
          if(!flag) {             //the curent element wasn't of any of the types from the array f so an error is thrown
            canContinue = FALSE;
            args.push_back(*getScopeValue(parentScope));
            args.push_back(errName);
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED,args,lineNumber, fileName);
            break;
          }
        }
      }
      else {            //the list is empty
        flag = TRUE;
      }
    }
    else {                      //scopeParent is not a list either
      canContinue = FALSE;
      args.push_back(*getScopeValue(parentScope));
      args.push_back(errName);
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED,args,lineNumber, fileName);
    }
  }
  return canContinue;
}

TBool CSLOmSetCommand::checkArgumentForNull(RefTVec_RefCSLOmExpr params, TInt dimension, std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue) {

  //TBool that contains the return valu of the function. We cannot return canContinue since it's value could be FALSE from previous checks.
  TBool flag = TRUE;
  for(int i = 0; i < params->size(); ++i) {
    RefCSLOmBase baseExpr = params->at(i)->doEval();
    if(!baseExpr.get()) {
      flag = FALSE;
      canContinue = FALSE;
      if(params->at(0)->isExprLink()) {
        RefCSLOmExprLink expr = CSLOmExprLink::cast(params->at(0));
        args.push_back(*convertLink(expr));
        args.push_back(errName);
        addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_EXPR_LINK, args, lineNumber, fileName);
      }
      else {
        args.push_back(intToString(dimension));
        args.push_back(errName);
        addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL, args, lineNumber, fileName);
      }
    }
    dimension++;
  }
  return flag;
}

TBool CSLOmSetCommand::checkArgumentForNotNull(RefTVec_RefCSLOmExpr params, TInt dimension, std::string errName,RefCSLOmBase scopeParent,TLineNumberType lineNumber, RefString fileName, TBool &canContinue) {
  ASSERT(scopeParent.get(), "scopeParent is null");

  //TBool that contains the return valu of the function. We cannot return canContinue since it's value could be FALSE from previous checks.
  TBool flag = TRUE;
  
  for(int i = 0; i < dimension; ++i) {
    RefCSLOmBase baseExpr = params->at(i)->doEval();
    // in case we have an instantiation like:  
    //     f1 f1;   
    // f1->doEval() will return true (because the simbol f1 already exists - it's the type of the object). But we want to know only if there are other variables with the same
    // name. So we check the scopeParent for the two of them. If they are declared in the same scope, it means there are two variables with the same name in the same scope.
    // So it's an error.
    //
    if(baseExpr.get()) {
      RefCSLOmScope exprScope = baseExpr->getParentScope();
      if(scopeParent->isScopeHolder() && exprScope == scopeParent->getAttachedScope(scopeParent.get())) {
        flag = FALSE;
      }
      if(!scopeParent->isScopeHolder() && exprScope == scopeParent->getParentScope()) {
        flag = FALSE;
      }
      if(!flag) {
        canContinue = FALSE;
        args.push_back(*CSLOmIdentifier::cast(baseExpr->getChild(ID))->getName());
        if (exprScope->getScopeType() != CSLOmScope::SCOPE_DESIGN) {
          args.push_back(*CSLOmIdentifier::cast(exprScope->getID())->getName());
        }
        else {
          args.push_back("global");
        }
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_ALREDY_DEFINED, args, lineNumber, fileName);
      }
    }
  }
  return flag;
}

TBool CSLOmSetCommand::checkArgumentType(RefCSLOmBase baseExpr,TIsPredicate f[], TInt aSize, std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue) {
  ASSERT(baseExpr.get(), "Null expresion received");

  //TBool that contains the return valu of the function. We cannot return canContinue since it's value could be FALSE from previous checks.
  TBool flag = FALSE;
  for(int i = 0; i < aSize; i++) {
    if(((*baseExpr).*f[i])()) {
      flag = TRUE;
    }
  }
  if(!flag) {
    args.push_back(*getScopeValue(baseExpr));
    args.push_back(errName);
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args,lineNumber, fileName);
    canContinue = FALSE;
    return FALSE;
  }
 
  return TRUE;
}

TBool CSLOmSetCommand::checkNumber(RefCSLOmBase baseExpr, TInt checkValue, TInt value, TInt checkXZ, TBool checkInt32,std::string errName, TLineNumberType lineNumber, RefString fileName, TBool &canContinue) {

  TBool flag = TRUE;

  RefCSLOmNumber no = CSLOmNumber::cast(baseExpr);

  //check that no is greater than "value"
  if(checkValue == NO_GREATER_THAN_VALUE) {
    flag = greaterThan(no->getValue(), value);
  }
  //check that no is not equal to "value"
  else if(checkValue == NO_NOT_EQUAL_TO_VALUE) {
    flag = notEqual(no->getValue(), value);
  }

  if(!flag) {
    //the number doesn't have the correct value
    canContinue = FALSE;
    args.push_back(intToString(no->getValue()));
    addErr(NSWarningErr::CSE_CSC_CHRS_ILL_VAL_CHRS_CSC, args, lineNumber, fileName);
    return FALSE;
  }

  //check that the number has XZ
  if(checkXZ == NO_CHECK_FOR_XZ) {
    if( !no->hasXZ() ) {
      flag = FALSE;
    }
  }
  //check that the number has no XZ
  else if(checkXZ == NO_CHECK_FOR_NOT_XZ) {
    if( no->hasXZ() ) {
      flag = FALSE;
    }
  }

  if(!flag) {
    //the number has XZ although it shouldn't or it does not have XZ although it should
    canContinue = FALSE;
    args.push_back(errName);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args,lineNumber, fileName);
    return FALSE;
  }

  //check if no is of type INT32
  if(checkInt32 == TRUE) {
    if(no->getNumType() != NSCSLOm::CSLOmNumber::NUM_INT32) {
      args.push_back(errName);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args,lineNumber, fileName);
      canContinue = FALSE;
      return FALSE;
    }
  }

  return TRUE;
}


RefCSLOmSetCommand CSLOmSetCommand::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, ECSLOmCommandType keyword, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmSetCommand::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmSetCommand::build()] Received no parameters");
  m_keyword = keyword;
  //  TBool canContinue = TRUE;
  switch (keyword) {
    case TYPE_CMD_UNDEFINED:
      addErr(NSWarningErr::CSE_CSC_FUNC_UNDEFINED_FUNC_CSCCS, args, lineNumber, fileName);
      break;
    case TYPE_CMD_ADD_PAIR:                                          CSLOmCmdEnumAddPair::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_WIDTH:                                            CSLOmCmdSetWidth::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_DEPTH:                                            CSLOmCmdSetDepth::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_BITRANGE:                                      CSLOmCmdSetBitRange::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_OFFSET:                                          CSLOmCmdSetOffset::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_RANGE:                                            CSLOmCmdSetRange::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_NUMBER_OF_DIMENSIONS:                CSLOmCmdSetNumberOfDimensions::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_DIM_WIDTH:                                     CSLOmCmdSetDimWidth::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_DIM_BITRANGE:                               CSLOmCmdSetDimBitRange::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_DIM_OFFSET:                                   CSLOmCmdSetDimOffset::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_DIM_RANGE:                                     CSLOmCmdSetDimRange::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_UNIT_PREFIX:                                 CSLOmCmdSetUnitPrefix::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_SIGNAL_PREFIX:                             CSLOmCmdSetSignalPrefix::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_SIGNAL_PREFIX_LOCAL:                  CSLOmCmdSetSignalPrefixLocal::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_TYPE:                                              CSLOmCmdSetType::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_ATTR:                                              CSLOmCmdSetAttr::build(lineNumber, fileName, parent, scope, params);                  break;
      //field
    case TYPE_CMD_SET_VALUE:                                            CSLOmCmdSetValue::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_ENUM:                                              CSLOmCmdSetEnum::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_ENUM_ITEM:                                     CSLOmCmdSetEnumItem::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_POSITION:                                      CSLOmCmdSetPosition::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_NEXT:                                              CSLOmCmdSetNext::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_PREVIOUS:                                      CSLOmCmdSetPrevious::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_ADD_ALLOWED_RANGE:                             CSLOmCmdAddAllowedRange::build(lineNumber, fileName, parent, scope, params);                  break;

    case TYPE_CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS:  CSLOmCmdGenerateIndividualRTLSignals::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_ADD_INSTANCE_ALL:                               CSLOmCmdAddInstanceAll::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_ADD_UNIT_PARAMETER:                           CSLOmCmdAddUnitParameter::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_OVERRIDE_UNIT_PARAMETER:                 CSLOmCmdOverrideUnitParameter::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_OVERRIDE_PARAMETER_NAMED:               CSLOmCmdOverrideParameterNamed::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_OVERRIDE_PARAMETER_ORDERED:           CSLOmCmdOverrideParameterOrdered::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_INPUT_VERILOG_TYPE:                           CSLOmCmdInputVerilogType::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_OUTPUT_VERILOG_TYPE:                         CSLOmCmdOutputVerilogType::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_REVERSE:                                               CSLOmCmdReverse::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_PREFIX:                                          CSLOmCmdSetPrefix::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_SET_SUFFIX:                                          CSLOmCmdSetSuffix::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_NO_PREFIX:                                            CSLOmCmdNoPrefix::build(lineNumber, fileName, parent, scope, params);                  break;
   
      /*
       *Vector or StateData commands
       */
    
    case  TYPE_CMD_VSD_SET_RADIX:                                    CSLOmCmdVSDSetRadix::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_CAPTURE_EDGE_TYPE:              CSLOmCmdVSDSetCaptureEdgeType::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_NUMERIC_ID:                           CSLOmCmdVSDSetNumericID::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_VERSION:                                CSLOmCmdVSDSetVersion::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_MAX_EVENTS_COUNT:                CSLOmCmdVSDSetMaxEventsCount::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_MAX_MISMATCHES_COUNT:        CSLOmCmdVSDSetMaxMismatchesCount::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_TIMEOUT:                                CSLOmCmdVSDSetTimeout::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_MAX_NUM_STATES:                    CSLOmCmdVSDSetMaxNumStates::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_NUM_OF_TRANSACTION:            CSLOmCmdVSDSetNumOfTransaction::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_NAME:                                      CSLOmCmdVSDSetName::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_HEADER_COMMENT:                   CSLOmCmdVSDSetHeaderComment::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_OUTPUT_FILENAME:                 CSLOmCmdVSDSetOutputFilename::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_CPP_RD_NAME:                          CSLOmCmdVSDSetCppRDName::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_CPP_WR_NAME:                          CSLOmCmdVSDSetCppWRName::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_CLOCK:                                    CSLOmCmdVSDSetClock::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_RESET:                                    CSLOmCmdVSDSetReset::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_STALL:                                    CSLOmCmdVSDSetStall::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_COMPARE_TRIGGER:                 CSLOmCmdVSDSetCompareTrigger::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_START_GENERATION_TRIGGER:CSLOmCmdVSDSetStartGenerationTrigger::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_END_GENERATION_TRIGGER:    CSLOmCmdVSDSetEndGenerationTrigger::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_MODULE_NAME:                         CSLOmCmdVSDSetModuleName::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_INSTANCE_NAME:                     CSLOmCmdVSDSetInstanceName::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_ADD_PORT_SIG_IFC:                 CSLOmCmdVSDSetAddPortSigIfc::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_SET_DIRECTION:                            CSLOmCmdVSDSetDirection::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_INCLUDE_ONLY:                              CSLOmCmdVSDIncludeOnly::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_EXCLUDE_ONLY:                              CSLOmCmdVSDExcludeOnly::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_VSD_MAX_CYCLES:                                   CSLOmCmdVSDMaxCycles::build(lineNumber, fileName, parent, scope, params);                  break;

      /*
       *Testbench commands
       */
    case  TYPE_CMD_TB_ADD_LOGIC:                                      CSLOmCmdTBAddLogic::build(lineNumber, fileName, parent, scope, params);                  break;
    case  TYPE_CMD_TB_ADD_VERILOG_FILENAME:                 CSLOmCmdTBAddVerilogFilename::build(lineNumber, fileName, parent, scope, params);                  break;
    case TYPE_CMD_TB_SET_INSTANCE_NAME:                        CSLOmCmdTBSetInstanceName::build(lineNumber, fileName, parent, scope, params);                  break;
                                                                                            
      /*                                                                                             
       *fifo                                                                                         
       */                                                                                            
    case TYPE_CMD_FIFO_ADD_PROGRAMMABLE_DEPTH:           CSLOmCmdFifoAddProgrammableDepth::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_SET_PHYSICAL_IMP_TYPE:              CSLOmCmdFifoSetPhysicalImpType::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_PRIO_BYPASS:                         CSLOmCmdFifoAddPrioBypass::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_SET_ASYNCH:                                  CSLOmCmdFifoSetAsynch::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_SET_DEPTH_EXTEND:                       CSLOmCmdFifoSetDepthExtend::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_SET_WIDTH_EXTEND:                       CSLOmCmdFifoSetWidthExtend::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_SET_WR_HOLD:                                 CSLOmCmdFifoSetWrHold::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_PARALLEL_OUTPUT:                        CSLOmCmdFifoParallelOutput::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_PARALLEL_INPUT:                          CSLOmCmdFifoParallelInput::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_RD_WORDS:                                      CSLOmCmdFifoRdWords::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_WR_WORDS:                                      CSLOmCmdFifoWrWords::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_SRAM_RD:                                 CSLOmCmdFifoAddSramRd::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_SRAM_WR:                                 CSLOmCmdFifoAddSramWr::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_PUSHBACK:                              CSLOmCmdFifoAddPushback::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_FLOW_THROUGH:                              CSLOmCmdFifoFlowThrough::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_STALL:                                    CSLOmCmdFifoAddStall::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_STALL_RD_SIDE:                      CSLOmCmdFifoAddStallRdSide::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_STALL_WR_SIDE:                      CSLOmCmdFifoAddStallWrSide::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_WR_RELEASE:                           CSLOmCmdFifoAddWrRelease::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_ALMOST_EMPTY:                       CSLOmCmdFifoAddAlmostEmpty::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_ALMOST_FULL:                         CSLOmCmdFifoAddAlmostFull::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_OUT_WR_ADDR:                          CSLOmCmdFifoAddOutWrAddr::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_OUT_RD_ADDR:                          CSLOmCmdFifoAddOutRdAddr::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_CREDIT:                                  CSLOmCmdFifoAddCredit::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_RD_CREDIT:                             CSLOmCmdFifoAddRdCredit::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_FIFO_ADD_WR_CREDIT:                             CSLOmCmdFifoAddWrCredit::build(lineNumber, fileName, parent, scope, params);                 break;

      //memory map
    case TYPE_CMD_ADD_ADDRESS_RANGE:                              CSLOmCmdAddAddressRange::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_ADDRESS_INCREMENT:                      CSLOmCmdSetAddressIncrement::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_NEXT_ADDRESS:                                CSLOmCmdSetNextAddress::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_ADD_RESERVED_RANGE:                            CSLOmCmdAddReservedRange::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_ADD:                                                        CSLOmCmdAdd::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_DATA_WORD_WIDTH:                           CSLOmCmdSetDataWordWidth::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_ALIGNMENT:                                     CSLOmCmdSetAlignment::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_ENDIANESS:                                     CSLOmCmdSetEndianess::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_SYMBOL_MAX_LENGTH:                       CSLOmCmdSetSymbolMaxLength::build(lineNumber, fileName, parent, scope, params);                 break; 
    case TYPE_CMD_AUTO_GEN_MEM_MAP:                                 CSLOmCmdAutoGenMemMap::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_TOP_UNIT:                                        CSLOmCmdSetTopUnit::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_ADD_TO_MEM_MAP:                                  CSLOmCmdAddToMemoryMap::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_ACCESS_RIGHTS:                              CSLOmCmdSetAccessRights::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_ACCESS_RIGHTS_ENUM:                     CSLOmCmdSetAccessRightsEnum::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_INSTANCE_NAME:                              CSLOmCmdSetInstanceName::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_PAGE_NO:                                          CSLOmCmdSetPageNo::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_ASM_MNEMONIC:                                CSLOmCmdSetAsmMnemonic::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_DECODER_NAME:                                CSLOmCmdSetDecoderName::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_DECODER_OUT_NAME_PREFIX:            CSLOmCmdSetDecoderOutNamePrefix::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_DECODER_OUT_NAME_SUFFIX:            CSLOmCmdSetDecoderOutNameSuffix::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_PRINT:                                                    CSLOmCmdPrint::build(lineNumber, fileName, parent, scope, params);                 break;
      //RegisterFile
    case TYPE_CMD_RF_SET_FIELD:                                        CSLOmCmdRFSetField::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_RF_SET_GROUP_NAME:                               CSLOmCmdRFSetGroupName::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_RF_SET_CONST_VALUE:                             CSLOmCmdRFSetConstValue::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_PORT_NAME:                                      CSLOmCmdSetPortName::build(lineNumber, fileName, parent, scope, params);                 break;
      //interconnect
    case TYPE_CMD_NO_GEN_RTL:                                            CSLOmCmdNoGenRTL::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_GEN_UNIQUE_RTL_MODULES:                     CSLOmCmdGenUniqueRTLModules::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_SET_CLOCK:                                             CSLOmCmdSetClock::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_REGISTER_IOS:                                       CSLOmCmdRegisterIOS::build(lineNumber, fileName, parent, scope, params);                 break;
    case TYPE_CMD_DO_NOT_GEN_CPP:                                     CSLOmCmdDoNotGenCPP::build(lineNumber, fileName, parent, scope, params);                 break;
      /*
       *decoder stuff
       */
    case TYPE_CMD_SET_DECODER:                                      CSLOmCmdDecSetDecoder::build(lineNumber, fileName, parent, scope, params);                 break;
                                                                                                                       
    case TYPE_CMD_SET_NAME:                                               CSLOmCmdSetName::build(lineNumber, fileName, parent, scope, params);                 break;
      //register                                                                                                       
    case TYPE_CMD_ADD_LOGIC:                                             CSLOmCmdAddLogic::build(lineNumber, fileName, parent, scope, params);                 break;

    default:
      ASSERT(keyword >= TYPE_CMD_UNDEFINED && keyword < TYPE_CMD_MAX, "[CSLOmSetCommand::build()] KeyWord " << keyword << " doesn't exist");
      addErr(NSWarningErr::CSE_CSC_FUNC_UNDEFINED_FUNC_CSCCS, args, lineNumber, fileName);
      break;
  }
  return RefCSLOmSetCommand();
}

ECSLOmCommandType CSLOmSetCommand::getCommandType() {
  return m_keyword;
}

//some functions used by the TW to set enum variables(like INPUT, WIRE...)
void CSLOmSetCommand::addEnumParam(TBool param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_GENERATE_INDIVIDUAL_RTL_SIGNALS: CSLOmCmdGenerateIndividualRTLSignals::setBitParam(param); break;
    default: ASSERT(0,"Enum param of type ON/OFF doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(EVerilogType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_INPUT_VERILOG_TYPE:  CSLOmCmdInputVerilogType::setVerilogTypeParam(param);  break;
    case TYPE_CMD_OUTPUT_VERILOG_TYPE: CSLOmCmdOutputVerilogType::setVerilogTypeParam(param); break;
    default:
      ASSERT(0,"Enum param of type EVerilogType doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(ECSLOmSignalType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_TYPE:        CSLOmCmdSetType::setSignalTypeParam(param);  break;
    default:
      ASSERT(0,"Enum param of type ECSLOmSignalType doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(EMemoryMapType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_TYPE: CSLOmCmdSetType::setMemoryMapTypeParam(param);      break;
    default:
      ASSERT(0,"Enum param of type CSLOmMemoryMap::EMemoryMapType doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmIsaField::ECSLOmIsaFieldType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_TYPE: CSLOmCmdSetType::setIsaFieldTypeParam(param);      break;
    default:
      ASSERT(0,"Enum param of type CSLOmIsaField::ECSLOmIsaFieldType doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmIsaElement::EIsaElementType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_TYPE: CSLOmCmdSetType::setIsaElementTypeParam(param);      break;
    default:
      ASSERT(0,"Enum param of type CSLOmIsaElement::EIsaElementType doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmRegDeclInfo::ERegDeclType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_TYPE: CSLOmCmdSetType::setRegisterTypeParam(param);      break;
    default:
      ASSERT(0,"Enum param of type CSLOmRegisterFileInfo::_RegType doesn't apply for keyword " + m_keyword);
  }
}
void CSLOmSetCommand::addEnumParam(CSLOmAddressRange::EAddressRangeType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_TYPE: CSLOmCmdSetType::setAddressRangeTypeParam(param);      break;
    default:
      ASSERT(0,"Enum param of type CSLOmAddressRange::EAddressRangeType doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmMemoryMapPage::Endianess param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_ENDIANESS: CSLOmCmdSetEndianess::setEndianessParam(param);      break;
    default:
      ASSERT(0,"Enum param of type CSLOmMemoryMapPage::Endianess doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(ECSLOmSignalAttr param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_ATTR: CSLOmCmdSetAttr::setSignalAttrParam(param); break;
    default:
      ASSERT(0,"Enum param of type ECSLOmSignalAttr doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(ERegDeclAttr param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_ATTR: CSLOmCmdSetAttr::setRegisterAttrParam(param); break;
    default:
      ASSERT(0,"Enum param of type ERegDeclAttr doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmVerifCompInfo::ECSLOmVCRadix param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_ATTR: CSLOmCmdVSDSetRadix::setRadixTypeParam(param); break;
    default:
      ASSERT(0,"Enum param of type ECSLOmVCRadix doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmVerifCompInfo::ECSLOmVCEdgeType param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_ATTR: CSLOmCmdVSDSetCaptureEdgeType::setEdgeTypeParam(param); break;
    default:
      ASSERT(0,"Enum param of type ECSLOmVCEdgeType doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(EPortNames param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_SET_PORT_NAME: CSLOmCmdSetPortName::setPort(param); break;
    default:
      ASSERT(0,"Enum param of type EPortNames doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmRegDeclInfo::ERegDeclOperations param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_ADD_LOGIC: CSLOmCmdAddLogic::setRegOperType(param); break;
    default:
      ASSERT(0,"Enum param of type EPortNames doesn't apply for keyword " + m_keyword);
  }
}

void CSLOmSetCommand::addEnumParam(CSLOmRegDeclInfo::ERegDeclCntDir param, ECSLOmCommandType keyword) {
  switch(keyword) {
    case TYPE_CMD_ADD_LOGIC: CSLOmCmdAddLogic::setRegCntDir(param); break;
    default:
      ASSERT(0,"Enum param of type EPortNames doesn't apply for keyword " + m_keyword);
  }
}



//Each command has a build, a check and an execute method.
//The build method calls the other two methods. First the check method and , if it return true, then the execute method.
//In the check method are made the checks that the scope of the command and the parameters are of the correct type and have legal values.
//The execute method is called only if the check method returns true (meaning there were no errors). Here are called the coresponding methods from CSLOM.
//If one or more errors were found, the flow is suspended (cslomHasErrors becomes TRUE and the adapter and the code generators are not called)



// ********************************************************************************
// CSLOmCmdSetWidth class
// ********************************************************************************


void CSLOmCmdSetWidth::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetWidth::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetWidth::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//will become false if an error occurs

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETWIDTH_LOWER, PARAM_SIZE_CMDSETWIDTH_UPPER, "set_width", lineNumber, fileName, canContinue);
  
  //get the parent scope and check if it has the right type
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isPort, &CSLOmBase::isRegisterFile, &CSLOmBase::isFifo, &CSLOmBase::isAddressRange, 
                      &CSLOmBase::isField, &CSLOmBase::isRegister, &CSLOmBase::isMemory};
  checkParentType(f, PARENT_TYPE_SIZE_SETWIDTH, scopeParent, scope, "signal, port, register file, register, fifo, address range, field, isa field, isa element", 
                  lineNumber, fileName, canContinue);


  checkArgumentForNull(params, ONE, "set_width", lineNumber, fileName, canContinue);
  //    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
    //check if the argument is of the correct type
    /*    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {       //only if the parameter is of the right type can the next checks be made
                                                                                                   //(because they require a cast)
      //check that the number is not 0, has no XZ and is of type int32
      checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_width", lineNumber, fileName, canContinue);
      }*/
  //  }
  //because the value of the argument is used in the next checks, if it is not of the right type the method is stopped
  if(!canContinue) {
    return FALSE;
  }


  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    //check if the width hasn't been already set
    if((*it)->isSignal()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmSignal sg = CSLOmSignal::cast(*it);
      RefCSLOmBaseRange br = sg->getBitRange();
      if(br->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args,lineNumber, fileName);
        canContinue = FALSE;
      }
      else {
        if(!CSLOmSimpleBitRange::cast(br)->isDefault()) {
          args.push_back("width");
          args.push_back(*getScopeValue(*it));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
      ECSLOmSignalType st = sg->getSignalType();
      if(SIGNAL_VAR_INTEGER == st || SIGNAL_VAR_REAL == st || SIGNAL_VAR_REALTIME == st || SIGNAL_VAR_TIME == st) {
        addErr(NSWarningErr::CSE_CSC_SIG_INTEGER_SIGNAL, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isPort()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      if(CSLOmPortDecl::cast(*it)->getBitRange()->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        //bitrange should be simple
        args.push_back(*CSLOmPortDecl::cast(*it)->getBitRange()->getName());
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args, lineNumber, fileName);
      }
      else if(!CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(*it)->getBitRange())->isDefault()) {
        args.push_back("width");
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      ECSLOmSignalType st = CSLOmPortDecl::cast(*it)->getPortType();//check that the port's type supports setting its width
      if(SIGNAL_VAR_INTEGER == st || SIGNAL_VAR_REAL == st || SIGNAL_VAR_REALTIME == st || SIGNAL_VAR_TIME == st) {
        addErr(NSWarningErr::CSE_CSC_SIG_INTEGER_SIGNAL, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isAddressRange()) {
      RefCSLOmAddressRange addrRange = CSLOmAddressRange::cast(*it);
      if(addrRange->hasWidthOrRange()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isFifo()) {
      RefCSLOmFifoInfo fifo = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo());
      if(fifo->getSetWidth()) {
        args.push_back("width");
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isRegisterFile()) {
      if(CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->getSetWidth()) {
        args.push_back("width");
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isRegister()) {
      if(CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->getSetWidth()) {
        args.push_back("width");
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isField()) {
      RefCSLOmField field = CSLOmField::cast(*it);
      //a field is default when it's width isn't set
      if(!field->isDefault()) {
        args.push_back("width");
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      // if(field->isWithEnum()) {
        //if the field has an enum, the width of the field must be at least equal to the width of the enum
        /*        RefCSLOmEnum e = CSLOmEnum::cast(field->getEnum());
                  TInt enumWidth = e->getWidth();
                  RefCSLOmNumber width = CSLOmNumber::cast(params->at(0)->doEval());
                  if(enumWidth > width->getValue()) {
                  args.push_back(*getScopeValue(field));
                  args.push_back(intToString(enumWidth));
                  addErr(NSWarningErr::CSE_CSC_SIG_CSE_CSC_SIG_WRONG_WIDTH, args, lineNumber, fileName);
                  canContinue = FALSE;
                  }*/
      //}
      // RefTVec_RefCSLOmBase children = (*it)->getChildrenAsBase(TYPE_BIT_RANGE);
      //if the field is hierarchical, the default width for it is the sum of the widths of the instantiated fields;
      //so when the user calls set_width, a check must be made that the input width is not smaller than the default width
      //if(children.get()) {
      /*        RefCSLOmExpr defaultWidth = field->getWidth();
                RefCSLOmNumber width = CSLOmNumber::cast(defaultWidth->doEval());
                if(CSLOmNumber::cast(params->at(0)->doEval())->getValue() < width->getValue()) {
                args.push_back(*getScopeValue(*it));
                args.push_back(intToString(width->getValue()));
                addErr(NSWarningErr::CSE_CSC_SIG_CSE_CSC_SIG_WRONG_WIDTH, args,lineNumber, fileName);
                canContinue = FALSE;
                }*/
    }
    if((*it)->isIsaElement()) {
      //only isa_elements that are of type root can call set_width
      if(!CSLOmIsaElement::cast(*it)->getShouldBeRoot()) {
        args.push_back(*getScopeValue(*it));
        args.push_back("root_format");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isMemory()) {
      /* RefCSLOm width = CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->getWidth();
      //the default value for a memory is -1(which is an illegal value)
      if(width->getValue() != -1) {
      args.push_back("width");
      args.push_back(*getScopeValue(*it));
      addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
      canContinue = FALSE;
      }*/
    }
  }
  

  return canContinue;
}

void CSLOmCmdSetWidth::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr width = CSLOmExpr::cast(params->at(0));//EVALUATING THE ARGUMENT ONCE MORE, IT SHOULD RETURN THE VALUE FROM CACHE
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setWidth(width);
        }
        else if ((*it)->isPort()) {
          (CSLOmPortDecl::cast(*it))->setWidth(width);
        }
        if((*it)->isField()) {
          CSLOmField::cast(*it)->setWidth(width);
        }
        else if ((*it)->isAddressRange()) {
          (CSLOmAddressRange::cast(*it))->setWidth(width);
        }
        else if ((*it)->isRegisterFile()) {
          CSLOmRegisterFileInfo::cast((CSLOmUnitDecl::cast(*it))->getUnitInfo())->setWidth(width);
        }
        else if ((*it)->isFifo()) {
          CSLOmFifoInfo::cast((CSLOmUnitDecl::cast(*it))->getUnitInfo())->setWidth(width);
        }
        else if((*it)->isRegister()) {
          CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setWidth(width);
        }
        else if((*it)->isMemory()) {
          CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setWidth(width);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/ports/address ranges/register files/fifos/registers/memories");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setWidth(width);
      }
      else if (scopeParent->isPort()) {
        (CSLOmPortDecl::cast(scopeParent))->setWidth(width);
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("signal or port");               //Wrong connectable object
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    case TYPE_DECL_UNIT:
      if (scopeParent->isRegisterFile()) {
        CSLOmRegisterFileInfo::cast((CSLOmUnitDecl::cast(scopeParent))->getUnitInfo())->setWidth(width);
      }
      else if (scopeParent->isFifo()) {
        CSLOmFifoInfo::cast((CSLOmUnitDecl::cast(scopeParent))->getUnitInfo())->setWidth(width);
      }
      else if(scopeParent->isRegister()) {
        CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setWidth(width);
      }
      else if(scopeParent->isMemory()) {
        CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setWidth(width);
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("register file, fifo or register");               //Wrong unit declaration object
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    case TYPE_ADDRESS_RANGE:
      (CSLOmAddressRange::cast(scopeParent))->setWidth(width);
      break;
    case TYPE_BIT_RANGE:
      if(CSLOmSimpleBitRange::cast(scopeParent)->isField()) {
        CSLOmField::cast(scopeParent)->setWidth(width);
      }
      break;
    default://WE GOT ANOTHER OBJECT, BUT YOU SHOULD NEVER GET HERE IF YOU DO ALL THE CHECKS IN THE CHECK METHOD
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("address range, field, isa field, isa element, port, signal, register file");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  } 


}


// ********************************************************************************
// CSLOmCmdSetDepth class
// ********************************************************************************

void CSLOmCmdSetDepth::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetDepth::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDepth::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//will become false if an error is found

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETDEPTH_LOWER, PARAM_SIZE_CMDSETDEPTH_UPPER,"set_depth", lineNumber, fileName, canContinue);
   
  //get the parent scope and check it has the correct type
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isRegisterFile, &CSLOmBase::isFifo, &CSLOmBase::isMemory};
  checkParentType(f, PARENT_TYPE_SIZE_SETDEPTH, scopeParent, scope, "register file or fifo", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    //check that the objects depth hasn't been already set
    if((*it)->isFifo()) {
      RefCSLOmFifoInfo fifo = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo());
      if(fifo->getSetDepth()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_DEPTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isRegisterFile()) {
      RefCSLOmRegisterFileInfo reg = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo());
      if(reg->getSetDepth()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_DEPTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isMemory()) {
      /* RefCSLOmNumber depth = CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->getDepth();
      if(depth->getValue() != -1) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_DEPTH, args, lineNumber, fileName);
        canContinue = FALSE;
        }*/
    }
  }

  //check if the argument is null(which is an error)
  if(checkArgumentForNull(params, ONE, "set_depth", lineNumber, fileName, canContinue)) {
    //check if the argument is of the correct type
    /*   RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr, f2, ONE,"number", lineNumber, fileName, canContinue)) {
      //check that the number is greater than 0, has no XZ, and is of type int32
      checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_depth", lineNumber, fileName, canContinue);
      }*/
  }

  return canContinue;
}

void CSLOmCmdSetDepth::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr depth = CSLOmExpr::cast(params->at(0));//EVALUATING THE ARGUMENT ONCE MORE, IT SHOULD RETURN THE VALUE FROM CACHE
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isRegisterFile()) {
          CSLOmRegisterFileInfo::cast((CSLOmUnitDecl::cast((*it)))->getUnitInfo())->setDepth(depth);
        }
        else if ((*it)->isFifo()) {
          CSLOmFifoInfo::cast((CSLOmUnitDecl::cast((*it)))->getUnitInfo())->setDepth(depth);
        }
        else if((*it)->isMemory()) {
          CSLOmMemoryInfo::cast((CSLOmUnitDecl::cast((*it)))->getUnitInfo())->setDepth(depth);
        }
        else {
          args.push_back(*getScopeValue(*it));
          args.push_back("register file, memory or fifo");//WRONG PARAM TYPE
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
          break;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if (scopeParent->isRegisterFile()) {
        CSLOmRegisterFileInfo::cast((CSLOmUnitDecl::cast(scopeParent))->getUnitInfo())->setDepth(depth);
      }
      else if (scopeParent->isFifo()) {
        CSLOmFifoInfo::cast((CSLOmUnitDecl::cast(scopeParent))->getUnitInfo())->setDepth(depth);
      }
      else if(scopeParent->isMemory()) {
        CSLOmMemoryInfo::cast((CSLOmUnitDecl::cast(scopeParent))->getUnitInfo())->setDepth(depth);
      }
      break;
    default://WE GOT ANOTHER OBJECT, BUT YOU SHOULD NEVER GET HERE IF YOU DO ALL THE CHECKS IN THE CHECK METHOD
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("register file, memory or fifo");//WRONG PARAM TYPE
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}


// ********************************************************************************
// CSLOmCmdSetBitRange class
// ********************************************************************************

void CSLOmCmdSetBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetBitRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetBitRange::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETBITRANGE_LOWER, PARAM_SIZE_CMDSETBITRANGE_UPPER,"set_bitrange", lineNumber, fileName, canContinue);
   
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isPort, &CSLOmBase::isField};
  checkParentType(f, PARENT_TYPE_SIZE_SETBITRANGE, scopeParent, scope, "signal, port or field", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isSignal()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmSignal sg = CSLOmSignal::cast(*it);
      RefCSLOmBaseRange br = sg->getBitRange();
      if(br->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args,lineNumber, fileName);
        canContinue = FALSE;
      }
      ECSLOmSignalType st = sg->getSignalType();
      if(SIGNAL_VAR_INTEGER == st || SIGNAL_VAR_REAL == st || SIGNAL_VAR_REALTIME == st || SIGNAL_VAR_TIME == st) {
        addErr(NSWarningErr::CSE_CSC_SIG_INTEGER_SIGNAL, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(!(CSLOmSimpleBitRange::cast(sg->getBitRange()))->isDefault()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if ((*it)->isPort()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      if(CSLOmPortDecl::cast(*it)->getBitRange()->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*CSLOmPortDecl::cast(*it)->getBitRange()->getName());
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args, lineNumber, fileName);
      }
      else if(!CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(*it)->getBitRange())->isDefault()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isField()) {
      RefCSLOmField field = CSLOmField::cast(*it);
      if(!field->isDefault()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(!field->isHierarchical() && (field->getFieldType() != CSLOmField::FIELD_UNDEFINED)) {
        args.push_back(*getScopeValue(*it));
        args.push_back("hierarchical or undefined field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;   
      }
    }
  }


  if(checkArgumentForNull(params, ONE, "set_bitrange", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f2[] = {&CSLOmBase::isBitRange};
    checkArgumentType(baseExpr, f2, 1, "bitrange", lineNumber, fileName, canContinue);
  }

  return canContinue;
}

void CSLOmCmdSetBitRange::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBaseRange bitRange = CSLOmBaseRange::cast(params->at(0)->doEval());
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setBitRange(bitRange);
        }
        else if ((*it)->isPort()) {
          (CSLOmPortDecl::cast(*it))->setBitRange(bitRange);
        }
        else if((*it)->isField()) {
          CSLOmField::cast(*it)->setBitRange(CSLOmSimpleBitRange::cast(bitRange));
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("port, signal or field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setBitRange(bitRange);
      }
      else if(scopeParent->isPort()) {
        (CSLOmPortDecl::cast(scopeParent))->setBitRange(bitRange);
      }
      break;
    case TYPE_BIT_RANGE:
      if(scopeParent->isField()) {
        CSLOmField::cast(scopeParent)->setBitRange(CSLOmSimpleBitRange::cast(bitRange));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("port, signal or field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }    
}


// ********************************************************************************
// CSLOmCmdSetOffset class
// ********************************************************************************

void  CSLOmCmdSetOffset::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetOffset::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetOffset::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETOFFSET_LOWER, PARAM_SIZE_CMDSETOFFSET_UPPER,"set_offset", lineNumber, fileName, canContinue);
   
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isPort, &CSLOmBase::isSimpleBitRange, &CSLOmBase::isAddressRange};
  checkParentType(f, PARENT_TYPE_SIZE_SETOFFSET, scopeParent, scope, "signal, port, simple bitrange, address range", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isSignal()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmSignal sg = CSLOmSignal::cast(*it);
      RefCSLOmBaseRange br = sg->getBitRange();
      if(br->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args,lineNumber, fileName);
        canContinue = FALSE;
      }
      ECSLOmSignalType st = sg->getSignalType();
      if(SIGNAL_VAR_INTEGER == st || SIGNAL_VAR_REAL == st || SIGNAL_VAR_REALTIME == st || SIGNAL_VAR_TIME == st) {
        addErr(NSWarningErr::CSE_CSC_SIG_INTEGER_SIGNAL, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      /*if(sg->getOffset() != ZERO) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_OFFSET, args, lineNumber, fileName);
        canContinue = FALSE;
        }*/
    }
    else if((*it)->isPort()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      if((CSLOmPortDecl::cast(*it))->getBitRange()->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*CSLOmPortDecl::cast(*it)->getBitRange()->getName());
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      /*      else if(CSLOmNumber::cast(CSLOmPortDecl::cast(*it)->getOffset()->doEval())->getValue() != ZERO) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_OFFSET, args, lineNumber, fileName);
        canContinue = FALSE;
        }*/
    }
    else if((*it)->isSimpleBitRange()) {
      /*if(CSLOmNumber::cast((CSLOmSimpleBitRange::cast(*it))->getOffset()->doEval())->getValue() != ZERO) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_OFFSET, args, lineNumber, fileName);
        canContinue = FALSE;
        }*/
    }
  }

 
  //check if the argument is not null and is of the correct type
  if(checkArgumentForNull(params, ONE, "set_offset", lineNumber, fileName, canContinue)) {
    /*  RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //check that the number is not 0, has no XZ and is of type int32
      checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_offset", lineNumber, fileName, canContinue); 
      }*/
  }

  return canContinue;
}

void CSLOmCmdSetOffset::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr offset = CSLOmExpr::cast(params->at(0));
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setOffset(offset);
        }
        else if((*it)->isPort()) {
          CSLOmPortDecl::cast(*it)->setOffset(offset);
        }
        else if ((*it)->isSimpleBitRange()) {
          (CSLOmSimpleBitRange::cast(*it))->setOffset(offset);
        }
        else if ((*it)->isAddressRange()) {
          (CSLOmAddressRange::cast(*it))->setOffset(offset);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/simple bitranges/address ranges");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setOffset(offset);
      }
      else if(scopeParent->isPort()) {
        CSLOmPortDecl::cast(scopeParent)->setOffset(offset);
      }
      break;
    case TYPE_BIT_RANGE:
      if(scopeParent->isSimpleBitRange()) {
        (CSLOmSimpleBitRange::cast(scopeParent))->setOffset(offset);
      }
      break;
    case TYPE_ADDRESS_RANGE:      
      (CSLOmAddressRange::cast(scopeParent))->setOffset(offset);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("simple bitrange, address range or signal");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}



// ********************************************************************************
// CSLOmCmdSetRange class
// ********************************************************************************

void  CSLOmCmdSetRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetRange::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //check that the correct number of parameters(2 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETRANGE_LOWER, PARAM_SIZE_CMDSETRANGE_UPPER,"set_range", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isPort, &CSLOmBase::isAddressRange, &CSLOmBase::isField};
  checkParentType(f, PARENT_TYPE_SIZE_SETRANGE, scopeParent, scope, "signal, port, address range or field", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isSignal()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmSignal sg = CSLOmSignal::cast(*it);
      RefCSLOmBaseRange br = sg->getBitRange();
      if(br->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args,lineNumber, fileName);
        canContinue = FALSE;
      }
      else {
        if(!CSLOmSimpleBitRange::cast(br)->isDefault()) {
          args.push_back(*getScopeValue(*it));
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
      ECSLOmSignalType st = sg->getSignalType();
      if(SIGNAL_VAR_INTEGER == st || SIGNAL_VAR_REAL == st || SIGNAL_VAR_REALTIME == st || SIGNAL_VAR_TIME == st) {
        addErr(NSWarningErr::CSE_CSC_SIG_INTEGER_SIGNAL, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isPort()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      if((CSLOmPortDecl::cast(*it))->getBitRange()->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*CSLOmPortDecl::cast(*it)->getBitRange()->getName());
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args, lineNumber, fileName);
        canContinue = FALSE;
      } 
      else if(!CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(*it)->getBitRange())->isDefault()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isAddressRange()) {
      RefCSLOmAddressRange addrRange = CSLOmAddressRange::cast(*it);
      if(addrRange->hasWidthOrRange()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isField()) {
      if(!CSLOmField::cast(*it)->isDefault()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(!CSLOmField::cast(*it)->isHierarchical() && (CSLOmField::cast(*it)->getFieldType() != CSLOmField::FIELD_UNDEFINED)) {
        args.push_back(*getScopeValue(*it));
        args.push_back("hierarchical or undefined field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;   
      }
    }
  }


  if(checkArgumentForNull(params, ONE, "set_range", lineNumber, fileName, canContinue)) {
    /*  RefCSLOmBase baseExpr1 = params->at(0)->doEval(TRUE);
    RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE);

    //check if the arguments have the corect type
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if(checkArgumentType(baseExpr1, f2, 1, "number",lineNumber, fileName, canContinue)) {
      //check that the number has no XZ and is of type int32
      checkNumber(baseExpr1, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_range", lineNumber, fileName, canContinue);  
    }
    if(checkArgumentType(baseExpr2, f2, 1, "number", lineNumber, fileName, canContinue)) {
      //check that the number has no XZ and is of type int32
      checkNumber(baseExpr2, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_range", lineNumber, fileName, canContinue);
      }*/
  }

  return canContinue;
}

void CSLOmCmdSetRange::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr lowerIndex = CSLOmExpr::cast(params->at(0));
  RefCSLOmExpr upperIndex = CSLOmExpr::cast(params->at(1));
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setRange(lowerIndex, upperIndex);
        }
        else if((*it)->isPort()) {
          CSLOmPortDecl::cast(*it)->setRange(lowerIndex, upperIndex);
        }
        else if ((*it)->isAddressRange()) {
          (CSLOmAddressRange::cast(*it))->setRange(lowerIndex, upperIndex);
        }
        else if((*it)->isField()) {
          CSLOmField::cast(*it)->setRange(lowerIndex, upperIndex);
        }
        else {
          args.push_back(*getScopeValue(*it));
          args.push_back("signal, address range, port or field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setRange(lowerIndex, upperIndex);
      }
      else if(scopeParent->isPort()) {
        (CSLOmPortDecl::cast(scopeParent))->setRange(lowerIndex, upperIndex);
      }
      break;
    case TYPE_ADDRESS_RANGE:
      (CSLOmAddressRange::cast(scopeParent))->setRange(lowerIndex, upperIndex);
      break;
    case TYPE_BIT_RANGE:
      if(scopeParent->isField()) {
        CSLOmField::cast(scopeParent)->setRange(lowerIndex, upperIndex);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal, address range, port or field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}

// ********************************************************************************
// CSLOmCmdSetNumberOfDimensions class
// ********************************************************************************

void  CSLOmCmdSetNumberOfDimensions::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetNumberOfDimensions::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetNumberOfDimensions::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETNUMBEROFDIMENSIONS_LOWER, PARAM_SIZE_CMDSETNUMBEROFDIMENSIONS_UPPER,"set_number_of_dimensions", lineNumber, fileName, canContinue);
   
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isPort};
  checkParentType(f, PARENT_TYPE_SIZE_SETNUMBEROFDIMENSIONS, scopeParent, scope, "signal or port", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    //check that the *it's bitrange isn't already multidimensional and has no width or range set
    if((*it)->isSignal()) {
      //Part select not allowed.
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmSignal sg = CSLOmSignal::cast(*it);
      RefCSLOmBaseRange br = sg->getBitRange();
      if(br->getBrType() != CSLOmBaseRange::BR_SIMPLE) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args,lineNumber, fileName);
        canContinue = FALSE;
      }
      else {
        if(!CSLOmSimpleBitRange::cast(br)->isDefault()) {
          args.push_back(*getScopeValue(*it));
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
      ECSLOmSignalType st = sg->getSignalType();
      if(SIGNAL_VAR_INTEGER == st || SIGNAL_VAR_REAL == st || SIGNAL_VAR_REALTIME == st || SIGNAL_VAR_TIME == st) {
        addErr(NSWarningErr::CSE_CSC_SIG_INTEGER_SIGNAL, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isPort()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmBaseRange br = CSLOmPortDecl::cast(*it)->getBitRange();
      if(br->getBrType() == CSLOmBaseRange::BR_MULTI_DIM) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_MULTIDIM_OBJECT, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      else if(!CSLOmSimpleBitRange::cast(br)->isDefault()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }


  if(checkArgumentForNull(params, ONE, "set_number_of_dimensions", lineNumber, fileName, canContinue)) {
    //check if the argument is of the correct type
    /*   RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if(checkArgumentType(baseExpr, f2, 1, "number", lineNumber, fileName, canContinue)) {
      //check that the number is greater than 0 and is of type int32
      checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_DO_NOT_CHECK_XZ, TRUE, "set_number_of_dimensions", lineNumber, fileName, canContinue);
      }*/
  }
  
  return canContinue;
}

void CSLOmCmdSetNumberOfDimensions::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr numberOfDimensions = CSLOmExpr::cast(params->at(0));
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setNumberOfDimensions(numberOfDimensions);
        }
        else if((*it)->isPort()) {
          CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(scopeParent)->getBitRange())->setNoOfDims(numberOfDimensions);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/ports");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setNumberOfDimensions(numberOfDimensions);
      }
      else if(scopeParent->isPort()) {
        CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(scopeParent)->getBitRange())->setNoOfDims(numberOfDimensions);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal or port");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetUnitPrefix class
// ********************************************************************************

void  CSLOmCmdSetUnitPrefix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetUnitPrefix::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetUnitPrefix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETUNITPREFIX_LOWER, PARAM_SIZE_CMDSETUNITPREFIX_UPPER,"set_unit_prefix", lineNumber, fileName, canContinue);   

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  checkParentType(f, PARENT_TYPE_SIZE_SETUNITPREFIX, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue);

  if(checkArgumentForNotNull(params, params->size(), "set_unit_prefix", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetUnitPrefix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmString prefix = CSLOmString::cast(params->at(0)->doEval());
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          (CSLOmUnitDecl::cast(*it))->setUnitPrefix(prefix->getValue());
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
          break;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isUnitDecl()) {
        (CSLOmUnitDecl::cast(scopeParent))->setUnitPrefix(prefix->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  
}

// ********************************************************************************
// CSLOmCmdSetSignalPrefix class
// ********************************************************************************

void  CSLOmCmdSetSignalPrefix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  ASSERT(params.get(), "[CSLOmCmdSetSignalPrefix::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetSignalPrefix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETSIGNALPREFIX_LOWER, PARAM_SIZE_CMDSETSIGNALPREFIX_UPPER,"set_signal_prefix", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  checkParentType(f, PARENT_TYPE_SIZE_SETSIGNALPREFIXLOCAL, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue);
  if(checkArgumentForNull(params, ONE, "set_signal_prefix", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetSignalPrefix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmString prefix = CSLOmString::cast(params->at(0)->doEval());
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          (CSLOmUnitDecl::cast(*it))->setSignalPrefixIO(prefix->getValue());
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isUnitDecl()) {
        (CSLOmUnitDecl::cast(scopeParent))->setSignalPrefixIO(prefix->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}

// ********************************************************************************
// CSLOmCmdSetSignalPrefixLocal class
// ********************************************************************************

void  CSLOmCmdSetSignalPrefixLocal::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetSignalPrefixLocal::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetSignalPrefixLocal::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETSIGNALPREFIXLOCAL_LOWER, PARAM_SIZE_CMDSETSIGNALPREFIXLOCAL_UPPER,"set_signal_prefix_local", lineNumber, fileName, canContinue);
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  checkParentType(f, PARENT_TYPE_SIZE_SETSIGNALPREFIXLOCAL, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue);


  if(checkArgumentForNotNull(params, params->size(), "set_signal_prefix_local", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetSignalPrefixLocal::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmString prefix = CSLOmString::cast(params->at(0)->doEval());
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          (CSLOmUnitDecl::cast(*it))->setSignalPrefixLocal(prefix->getValue());
        }
        else {
          args.push_back(*(getScopeValue(scopeParent)));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isUnitDecl()) {
        (CSLOmUnitDecl::cast(scopeParent))->setSignalPrefixLocal(prefix->getValue());
      }
      break;
    default:
      args.push_back(*(getScopeValue(scopeParent)));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  
}

// ********************************************************************************
// CSLOmCmdSetType class
// ********************************************************************************
ECSLOmSignalType  CSLOmCmdSetType::m_signalType = SIGNAL_UNDEFINED;
CSLOmAddressRange::EAddressRangeType CSLOmCmdSetType::m_addressRangeType = CSLOmAddressRange::ADDR_UNDEFINED;
EMemoryMapType CSLOmCmdSetType::m_memoryMapType = MM_UNDEFINED;
CSLOmIsaField::ECSLOmIsaFieldType CSLOmCmdSetType::m_isaFieldType = CSLOmIsaField::ISA_FIELD_UNDEFINED;
CSLOmIsaElement::EIsaElementType CSLOmCmdSetType::m_isaElementType = CSLOmIsaElement::ISA_ELEM_UNDEFINED;
CSLOmRegDeclInfo::ERegDeclType CSLOmCmdSetType::m_registerType = CSLOmRegDeclInfo::REG_DECL_UNDEF;

void CSLOmCmdSetType::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetType::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetType::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(0 or 1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETTYPE_LOWER, PARAM_SIZE_CMDSETTYPE_UPPER,"set_type", lineNumber, fileName, canContinue);

  if(params->size() == 1) {
    if(!checkArgumentForNull(params, ONE, "set_type", lineNumber, fileName, canContinue)) {
      return FALSE; 
    }
    if(!params->at(0)->isHybridORFuncCall()) {
      args.push_back(*getScopeValue(params->at(0)));
      args.push_back("function call");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isPort, &CSLOmBase::isAddressRange, &CSLOmBase::isMemoryMap, &CSLOmBase::isIsaField, 
                      &CSLOmBase::isIsaElement, &CSLOmBase::isRegister};
  checkParentType(f, PARENT_TYPE_SIZE_SETTYPE, scopeParent, scope, "signal, port, address range, memory map, isa field, isa element, register", lineNumber, 
                  fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isAddressRange()) {
      RefCSLOmAddressRange addrRange = CSLOmAddressRange::cast(*it);
      if(addrRange->getAddressRangeType() != CSLOmAddressRange::ADDR_UNDEFINED) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    
      if(m_addressRangeType <= CSLOmAddressRange::ADDR_UNDEFINED || m_addressRangeType >= CSLOmAddressRange::ADDR_MAX) {
        args.push_back("set_type");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    if((*it)->isSignal()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmSignal sg = CSLOmSignal::cast(*it);
      if(sg->getSignalType() != SIGNAL_UNDEFINED) {
        //the signal already has its type set
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }

      if(params->size() == 1) {
        setSignalTypeParam(static_cast<ECSLOmSignalType>(CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_TYPE)));
      }
    
      if(m_signalType <= SIGNAL_UNDEFINED || m_signalType >= SIGNAL_MAX) {
        args.push_back("set_type");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isPort()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      if(CSLOmPortDecl::cast(*it)->getPortType() != SIGNAL_UNDEFINED && CSLOmPortDecl::cast(*it)->getPortType() != SIGNAL_WIRE) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      //an input port cannot be of type reg
      if(CSLOmPortDecl::cast(*it)->getPortDirection()==INPUT && m_signalType == SIGNAL_REG) {
        addErr(NSWarningErr::CSE_CSC_DSGN_INPUT_PORT_REG, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(params->size() == 1) {
        setSignalTypeParam(static_cast<ECSLOmSignalType>(CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_TYPE)));
      }
    

      if(m_signalType <= SIGNAL_UNDEFINED || m_signalType >= SIGNAL_MAX) {
        args.push_back("set_type");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if ((*it)->isIsaField()) {
      if(m_isaFieldType <= CSLOmIsaField::ISA_FIELD_UNDEFINED || m_isaFieldType >= CSLOmIsaField::ISA_FIELD_MAX) {
        args.push_back("set_type");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(params->size() == 1) {
        setIsaFieldTypeParam(static_cast<CSLOmIsaField::ECSLOmIsaFieldType>(CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_TYPE)));
      }
      if (CSLOmIsaField::cast(*it)->getIsaFieldType() != CSLOmIsaField::ISA_FIELD_UNDEFINED) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if ((*it)->isIsaElement()) {
      if(m_isaElementType <= CSLOmIsaElement::ISA_ELEM_UNDEFINED || m_isaElementType >= CSLOmIsaElement::ISA_ELEM_MAX) {
        args.push_back("set_type");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(params->size() == 1) {
        setIsaElementTypeParam(static_cast<CSLOmIsaElement::EIsaElementType>(CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_TYPE)));
      }
      if ((CSLOmIsaElement::cast(*it))->getIsaType() != CSLOmIsaElement::ISA_ELEM_UNDEFINED) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }

      TBool shouldBeRoot = CSLOmIsaElement::cast(*it)->getShouldBeRoot();
      if(shouldBeRoot && (m_isaElementType != CSLOmIsaElement::ISA_ELEM_ROOT)) {
        args.push_back(*getScopeValue(*it));
        args.push_back("root format");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if((!shouldBeRoot) && (m_isaElementType == CSLOmIsaElement::ISA_ELEM_ROOT)) {
        args.push_back(*getScopeValue(*it));
        args.push_back("not root format");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }

      TBool cannotBeInstr = CSLOmIsaElement::cast(*it)->getCannotBeInstr();
      if(cannotBeInstr && (m_isaElementType == CSLOmIsaElement::ISA_ELEM_INSTR)) {
        args.push_back(*getScopeValue(*it));
        args.push_back("not derived from isa element of type root_format");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isMemoryMap()) {
      if(m_memoryMapType <= MM_UNDEFINED || m_memoryMapType >= MM_MAX) {
        args.push_back("set_type");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(params->size() == 1) {
        setMemoryMapTypeParam(static_cast<EMemoryMapType>(CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_TYPE)));
      }
      if (CSLOmMemoryMap::cast(*it)->getMemMapType() != MM_UNDEFINED && CSLOmMemoryMap::cast(*it)->getMemMapType() != MM_FLAT) {   
        //MM_FLAT is the default type for a memory map
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isRegister()) {
      if(m_registerType <= CSLOmRegDeclInfo::REG_DECL_UNDEF || m_registerType > CSLOmRegDeclInfo::REG_DECL_MAX) {
        args.push_back("set_type");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(params->size() == 1) {
        setRegisterTypeParam(static_cast<CSLOmRegDeclInfo::ERegDeclType>(CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_TYPE)));
      }
      if(CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->getAlreadySetType()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetType::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal() || (*it)->isPort()) {
          (CSLOmSignal::cast(*it))->setSignalType(m_signalType);
        }
        else if((*it)->isAddressRange()) {
          (CSLOmAddressRange::cast(*it))->setType(m_addressRangeType);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/ports");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setSignalType(m_signalType);
      }
      else if(scopeParent->isPort()) {
        (CSLOmPortDecl::cast(scopeParent))->setPortType(m_signalType);
      }
      break;
    case TYPE_ADDRESS_RANGE:
      (CSLOmAddressRange::cast(scopeParent))->setType(m_addressRangeType);
      break;
    case TYPE_MEMORY_MAP:
      (CSLOmMemoryMap::cast(scopeParent))->setMemMapType(m_memoryMapType);
      break;
    case TYPE_BIT_RANGE:
      if(scopeParent->isIsaField()) {
        (CSLOmIsaField::cast(scopeParent)) ->setIsaFieldType(m_isaFieldType);
      }
      else if(scopeParent->isIsaElement()) {
        CSLOmIsaElement::cast(scopeParent)->setIsaType(m_isaElementType);
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("isa field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isRegister()) {
        CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setType(m_registerType);
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("register");               //Wrong unit declaration object
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal, port, memory map or isa field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  } 
  //reseting the values of the member variables
  setSignalTypeParam(SIGNAL_UNDEFINED);
  setAddressRangeTypeParam(CSLOmAddressRange::ADDR_UNDEFINED);
  setIsaFieldTypeParam(CSLOmIsaField::ISA_FIELD_UNDEFINED);
  setIsaElementTypeParam(CSLOmIsaElement::ISA_ELEM_UNDEFINED);
  setMemoryMapTypeParam(MM_UNDEFINED);
  setRegisterTypeParam(CSLOmRegDeclInfo::REG_DECL_UNDEF);
}
/////////////////
//set functions//
////////////////
void CSLOmCmdSetType::setSignalTypeParam(ECSLOmSignalType param) {
  m_signalType = param;
}

void CSLOmCmdSetType::setAddressRangeTypeParam(CSLOmAddressRange::EAddressRangeType param) {
  m_addressRangeType = param;
}

void CSLOmCmdSetType::setMemoryMapTypeParam(EMemoryMapType param) {
  m_memoryMapType = param;
}
void CSLOmCmdSetType::setIsaFieldTypeParam(CSLOmIsaField::ECSLOmIsaFieldType param) {
  m_isaFieldType = param;
}

void CSLOmCmdSetType::setIsaElementTypeParam(CSLOmIsaElement::EIsaElementType param) {
  m_isaElementType = param;
}
void CSLOmCmdSetType::setRegisterTypeParam(CSLOmRegDeclInfo::ERegDeclType param) {
  m_registerType = param;
}

/////////////////
//get functions//
////////////////
ECSLOmSignalType CSLOmCmdSetType::getSignalTypeParam() {
  return m_signalType;
}

CSLOmAddressRange::EAddressRangeType CSLOmCmdSetType::getAddressRangeTypeParam() {
  return m_addressRangeType;
}

EMemoryMapType CSLOmCmdSetType::getMemoryMapTypeParam() {
  return m_memoryMapType;
}

CSLOmIsaField::ECSLOmIsaFieldType CSLOmCmdSetType::getIsaFieldTypeParam() {
  return m_isaFieldType;
}

CSLOmIsaElement::EIsaElementType CSLOmCmdSetType::getIsaElementTypeParam() {
  return m_isaElementType;
}

CSLOmRegDeclInfo::ERegDeclType CSLOmCmdSetType::getRegisterTypeParam() {
  return m_registerType;
}



// ********************************************************************************
// CSLOmCmdSetAttr class
// ********************************************************************************
ECSLOmSignalAttr CSLOmCmdSetAttr::m_signalAttr = ATTR_UNDEFINED;
ERegDeclAttr CSLOmCmdSetAttr::m_registerAttr = REG_ATTR_UNDEF;

void  CSLOmCmdSetAttr::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdSetAttr::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetAttr::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(0 or 1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETATTR_LOWER, PARAM_SIZE_CMDSETATTR_UPPER,"set_attr", lineNumber, fileName, canContinue);
   
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isPort, &CSLOmBase::isRegister};
  checkParentType(f, PARENT_TYPE_SIZE_SETATTR, scopeParent, scope, "signal, port or register", lineNumber, fileName, canContinue);

  //checkArgumentForNull(params, params->size(), "set_attr", lineNumber, fileName, canContinue);

  /*  TInt result;
  if(params->size() == 1 && !params->at(0)->isHybridORFuncCall()) {
    args.push_back("set_attr");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    canContinue = FALSE;
  }
  else if(params->size() == 1) {
    result = static_cast<ECSLOmSignalAttr>(CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_ATTR));
    setSignalAttrParam(static_cast<ECSLOmSignalAttr>(result));
    }*/

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if ((*it)->isSignal() || (*it)->isPort()) {
      if((*it)->isSignal()) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
        if(exprLink->hasBitRange()) {
          canContinue = FALSE;
        }
        //check that the signal doesn't have its attribute set
        if (CSLOmSignal::cast(*it)->getSignalAttr() > ATTR_UNDEFINED && CSLOmSignal::cast(*it)->getSignalAttr() < ATTR_MAX) {
          args.push_back("attribute");
          args.push_back(*getScopeValue(*it));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        //check that, if the attribute to be set is ATTR_CLK the signal has its width 1
        else {
          // RefCSLOmExpr width = CSLOmSignal::cast(*it)->getWidth();
          /*if(getSignalAttrParam() == ATTR_CLK && CSLOmNumber::cast(width->doEval())->getValue() != ONE ) {
            args.push_back(*getScopeValue(*it));
            addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_WIDTH_ONE, args, lineNumber, fileName);
            canContinue = FALSE;
            }*/
        }
      }
      else if((*it)->isPort()) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
        if(exprLink->hasBitRange()) {
          canContinue = FALSE;
        }
        //check that the port doesn't have its attribute already set
        if (CSLOmPortDecl::cast(*it)->getAttr() > ATTR_UNDEFINED && CSLOmPortDecl::cast(*it)->getAttr() < ATTR_MAX) {
          args.push_back("attribute");
          args.push_back(*getScopeValue(*it));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        else if(getSignalAttrParam() == ATTR_CLK) {
          //RefCSLOmExpr width = CSLOmPortDecl::cast(*it)->getWidth();
          /*          if(CSLOmNumber::cast(width->doEval())->getValue() != 1 ) {
            args.push_back(*getScopeValue(*it));
            addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_WIDTH_ONE, args, lineNumber, fileName);
            canContinue = FALSE;
            }*/
          if(CSLOmPortDecl::cast(*it)->getPortDirection() != INPUT ) {
            args.push_back(*getScopeValue(*it));
            args.push_back("input");
            addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_DIR, args, lineNumber, fileName);
            canContinue = FALSE;
          }
        }
      }
      if(getSignalAttrParam() <= ATTR_UNDEFINED || getSignalAttrParam() >= ATTR_MAX) {
        args.push_back("set_attr");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isRegister()) {
      RefCSLOmRegDeclInfo reg = CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo());
      if(getRegisterAttrParam() <= REG_ATTR_UNDEF || getRegisterAttrParam() >= REG_ATTR_MAX) {
        args.push_back("set_attr");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(reg->getAttribute() != REG_ATTR_UNDEF) {
        args.push_back("attribute");
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetAttr::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setSignalAttr(m_signalAttr);
        }
        else if ((*it)->isPort()) {
          (CSLOmPortDecl::cast(*it))->setAttr(m_signalAttr);
        }
        else if((*it)->isRegister()) {
          CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setAttribute(getRegisterAttrParam());
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/ports/registers");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setSignalAttr(m_signalAttr);
      }
      else if (scopeParent->isPort()) {
        (CSLOmPortDecl::cast(scopeParent))->setAttr(m_signalAttr);
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isRegister()) {
        CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setAttribute(getRegisterAttrParam());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal , port or register");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  
}

void CSLOmCmdSetAttr::setSignalAttrParam(ECSLOmSignalAttr param) {
  m_signalAttr = param;
}
ECSLOmSignalAttr CSLOmCmdSetAttr::getSignalAttrParam() {
  return m_signalAttr;
}
void CSLOmCmdSetAttr::setRegisterAttrParam(ERegDeclAttr param) {
  m_registerAttr = param;
}
ERegDeclAttr CSLOmCmdSetAttr::getRegisterAttrParam() {
  return m_registerAttr;
}


// ********************************************************************************
// CSLOmCmdGenerateIndividualRTLSignals class
// ********************************************************************************
TBool CSLOmCmdGenerateIndividualRTLSignals::m_generateIndividualRTLSignals = FALSE;

void  CSLOmCmdGenerateIndividualRTLSignals::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdGenerateIndividualRTLSignals::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdGenerateIndividualRTLSignals::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(0 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDGENERATEINDIVIDUALRTLSIGNALS_LOWER, PARAM_SIZE_CMDGENERATEINDIVIDUALRTLSIGNALS_UPPER,"generate_individual_rtl_signals", 
                 lineNumber, fileName, canContinue);
   
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignalGroup};
  if(checkParentType(f, PARENT_TYPE_SIZE_GENERATEINDIVIDUALRTLSIGNALS, scopeParent, scope, "signal group", lineNumber, fileName, canContinue)) {
    //check that the signal group has at least one signal inside
    if(scopeParent->isSignalGroup()) {
      RefCSLOmGroupSignal signalGroup = CSLOmGroupSignal::cast(scopeParent);
      if(!signalGroup->getSignals().get()) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("not empty signal group");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else {
      RefTVec_RefCSLOmBase objs = CSLOmList::cast(scopeParent)->getObjects();
      TVec_RefCSLOmBase_const_iter it;
      for(it = objs->begin(); it < objs->end(); ++it) {
        RefCSLOmGroupSignal signalGroup = CSLOmGroupSignal::cast(*it);
        if(!signalGroup->getSignals().get()) {
          args.push_back(*getScopeValue(*it));
          args.push_back("not empty signal group");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }

  return canContinue;
}

void CSLOmCmdGenerateIndividualRTLSignals::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignalGroup()) {
          (CSLOmGroupSignal::cast(*it))->setGenerateIndividualRtlSignals(m_generateIndividualRTLSignals);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("signal group");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignalGroup()) {
        (CSLOmGroupSignal::cast(scopeParent))->setGenerateIndividualRtlSignals(m_generateIndividualRTLSignals);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal group");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}

void CSLOmCmdGenerateIndividualRTLSignals::setBitParam(TBool param) {
  m_generateIndividualRTLSignals = param;
}
TBool CSLOmCmdGenerateIndividualRTLSignals::getBitParam() {
  return m_generateIndividualRTLSignals;
}

// ********************************************************************************
// CSLOmCmdAddInstanceAll class
// ********************************************************************************

//In case there is an override also, the build function(from CSLOmCmdOverrideParameterOrdered or CSLOmCmdOverrideParameterNamed) for it will be called after the execute of 
//the CSLOmCmdAddInstanceAll is done.

void  CSLOmCmdAddInstanceAll::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdAddInstance::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdAddInstanceAll::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  TBool canContinue = TRUE;
  TInt paramSize = params->size();
  //this method must receive at least 2 parameters; but there is no maximum number of parameters
  if(params->size() < 2) {
    args.push_back("instantiation");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_WRONG_ARG_NR, args, lineNumber, fileName);
    canContinue = FALSE;
    return FALSE;
  }

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }       
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl, &CSLOmBase::isInterface, &CSLOmBase::isField, &CSLOmBase::isMemoryMapLocationPage, &CSLOmBase::isFifo, 
                      &CSLOmBase::isRegisterFile, &CSLOmBase::isSignalGroup, &CSLOmBase::isVector, &CSLOmBase::isStateData, &CSLOmBase::isRegister};
  checkParentType(f, PARENT_TYPE_SIZE_ADDINSTANCEALL, scopeParent, scope, 
                  "unit declaration, interface, field, isa field, isa element, memory map page,fifo, register file or signal group", lineNumber, fileName, canContinue);

  //getting the name of the scopeParent to later check that there is not a recursive instantiation
  RefString scopeParentName = RefString(new std::string);
  if(scopeParent->isUnitDecl()) {
    scopeParentName = CSLOmIdentifier::cast(CSLOmUnitDecl::cast(scopeParent)->getChild(ID))->getName();
  }
  else if(scopeParent->isInterface()) {
    scopeParentName = CSLOmIdentifier::cast(CSLOmInterface::cast(scopeParent)->getChild(ID))->getName();
  }
  else if(scopeParent->isSignalGroup()) {
    scopeParentName = CSLOmIdentifier::cast(CSLOmGroupSignal::cast(scopeParent)->getChild(ID))->getName();
  }
  else if(scopeParent->isIsaField()) {
    scopeParentName = CSLOmIdentifier::cast(CSLOmIsaField::cast(scopeParent)->getChild(ID))->getName();
  }
  else if(scopeParent->isIsaElement()) {
    //only an isa element that is derived from a root format(so, not a root format) can have instantiations
    if(CSLOmIsaElement::cast(scopeParent)->getShouldBeRoot()) { 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("instr or instr_format");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    scopeParentName = CSLOmIdentifier::cast(CSLOmIsaElement::cast(scopeParent)->getChild(ID))->getName();
  }
  else if(scopeParent->isField()) {
    scopeParentName = CSLOmIdentifier::cast(CSLOmField::cast(scopeParent)->getChild(ID))->getName();
  }
  else if(scopeParent->isInterface()) {
    scopeParentName = CSLOmIdentifier::cast(CSLOmInterface::cast(scopeParent)->getChild(ID))->getName();
  }
  else if(scopeParent->isMemoryMapLocationPage()) {
    scopeParentName = CSLOmIdentifier::cast(CSLOmMemoryMapPage::cast(scopeParent)->getChild(ID))->getName();
  } 

  RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  newParams->push_back(params->at(0));
  RefCSLOmIdentifier id1;
  if(checkArgumentForNull(newParams, ONE, "instantiation", lineNumber, fileName, canContinue)) {
    RefCSLOmExprLink type  = CSLOmExprLink::cast(params->at(0)); 
    id1 = type->getLocalNameID();
    if (!id1.get()) {
      args.push_back(*type->getName());
      addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber, fileName);
      canContinue = FALSE;
      return canContinue;
    }
    //check that there is not the case of a recursive instantiation
    RefString typeName = type->getName();
    if(*typeName == *scopeParentName) {
      args.push_back("instantiation");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      canContinue = FALSE;
      return FALSE;
    }
    ASSERT(id1->getParent().get(), "internal bug, identifier without parent found");
    RefCSLOmBase parent = id1->getParent();
    if ((!id1->getParent()->isUnitDecl()              )&&
        (!id1->getParent()->isInterface()             )&&
        (!id1->getParent()->isList()                  )&&
        (!id1->getParent()->isField()                 )&&
        (!id1->getParent()->isMemoryMapLocationPage() )&&
        (!id1->getParent()->isFifo()                  )&&
        (!id1->getParent()->isRegisterFile()          )&&
        (!id1->getParent()->isSignalGroup()           )
        ) {
      args.push_back(*id1->getName());
      args.push_back("unit|interface|list|field|memory_map_page|fifo|register_file declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    if(!id1->getParent()->isUnitDecl()) {
      if(paramSize > 2) {
        args.push_back(*getScopeValue(id1->getParent()));
        addErr(NSWarningErr::CSE_CSC_EXPR_ILLEGAL_F2A, args, lineNumber, fileName);
        canContinue = FALSE;
        return FALSE;
      }
    }
  }
  
  newParams->pop_back();
  newParams->push_back(params->at(1));
  if(checkArgumentForNotNull(newParams, newParams->size(), "instantiation", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmExprLink name  = CSLOmExprLink::cast(params->at(1));            
    if (name->isHID()) {
      args.push_back("instantiation");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }

  


  /*
   *formal 2 actual mapping
   */
  if(paramSize > 2) {
    for(int i = 2; i < paramSize; ++i) {
      if(i%2) {
        if(!params->at(i)->isExpr()) {
          args.push_back("actual parameter");
          args.push_back("expresion");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
      else {
        if(!params->at(i)->isExprLink()) {
          args.push_back("formal parameter");
          args.push_back("expresion link");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
    if(paramSize%2 != 0) {
      args.push_back("formal to actual");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_WRONG_ARG_NR, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }



//   TBool firstIsSignal;
//   RefString firstName;
//   if(paramSize > 2) {
//     for(int i = 2; i < paramSize; ++i) {
//       RefCSLOmBase param = RefCSLOmBase();
//       if(params->at(i).get()) {
//         if(!(i & 1)) {
//           CSLOmScopeBlock::enterScope(CSLOmUnitDecl::cast(id1->getParent())->getAttachedScope());
//           param = params->at(i)->doEval();
//           CSLOmScopeBlock::exitScope();
//         }
//         else {
//           param = params->at(i)->doEval();
//         }
//       }
//       RefCSLOmIdentifier paramId = RefCSLOmIdentifier();

// //       if(!param.get() && params->at(i).get()) {
// //         args.push_back(*CSLOmExprLink::cast(params->at(i))->getName());
// //         if (i & 1) {
// //           args.push_back(*getScopeValue(scopeParent));
// //         }
// //         else {
// //           args.push_back(*getScopeValue(params->at(0)->doEval()));
// //         }
  //// //       addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, lineNumber, fileName);
// //         canContinue = FALSE;
// //       }

//       if(param.get()) {
//         if(!param->isConnectable()) {
//           args.push_back("instantiation");
//           //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber);
  ////         addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//           canContinue = FALSE;
//         }
//         else {
//           switch(CSLOmConnectable::cast(param)->getConnectableType()) {
//             case CSLOmConnectable::TYPE_DECL_SIGNAL:  paramId      =      CSLOmSignal::cast(param)->getID();        break;
//             case CSLOmConnectable::TYPE_DECL_PORT:    paramId      =    CSLOmPortDecl::cast(param)->getID();        break;
//             case CSLOmConnectable::TYPE_INTERFACE:    paramId      =   CSLOmInterface::cast(param)->getID();        break;
//             case CSLOmConnectable::TYPE_GROUP_SIGNAL: paramId      = CSLOmGroupSignal::cast(param)->getID();        break;
//           }
//         }
// //         if(paramId.get()) {
// //           if(scopeParent->isUnitDecl()) {
// // //             if(i & 1) {
// // //               RefCSLOmBase baseExpr = param;
// // //               RefCSLOmBase parentUnit = baseExpr->getParent();
// // //               while((!parentUnit->isUnitDecl()) && (!parentUnit->isDesign())) {
// // //                 parentUnit = parentUnit->getParent();
// // //               }
// // // //               if(parentUnit->isDesign() || parentUnit.get() != scopeParent.get()) {
// // // //                 args.push_back(*paramId->getName());
// // // //                 args.push_back(*getScopeValue(scopeParent));
// // // //                 //addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, lineNumber);
// // // //               canContinue = FALSE;
// // // //               }
// // //             }
// // //             else {
// // //               RefCSLOmBase baseExpr = param;
// // //               RefCSLOmBase parentUnit = baseExpr->getParent();
// // //               while((!parentUnit->isUnitDecl()) && (!parentUnit->isDesign())) {
// // //                 parentUnit = parentUnit->getParent();
// // //               }
// // // //               if(parentUnit->isDesign() || parentUnit.get() != params->at(0)->doEval().get()) {
// // // //                 args.push_back(*paramId->getName());
// // // //                 args.push_back(*getScopeValue(params->at(0)->doEval()));
// // // //                 //addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, lineNumber);
// // // //               canContinue = FALSE;
// // // //               }
// // //             }

// //           }
// // //           else {
// // //             RefTVec_RefCSLOmBase objs = CSLOmList::cast(scopeParent)->getObjects();
// // //             TVec_RefCSLOmBase_const_iter it = objs->begin();
// // //             for(; it != objs->end(); ++it) {
// // //               if((i & 1)) {
// // // //                 if(!CSLOmUnitDecl::cast((*it)->getParent())->getAttachedScope()->containsID(paramId->getName())) {
// // // //                   args.push_back(*paramId->getName());
// // // //                   args.push_back(*getScopeValue(scopeParent));
// // // //                   //addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, lineNumber);
// // // //                 canContinue = FALSE;
// // // //                 }
// // //               }
// // //             }
// // //          }
// //         }
//         if (!(i & 1)) {
//           if (param->isPort() || param->isSignal()) {
//             firstIsSignal = TRUE;
//           }
//           else {
//             firstIsSignal = FALSE;
//           }
//           firstName = CSLOmIdentifier::cast(param->getChild(ID))->getName();
//         }
//         else {
//           if (params->at(i)->doEval().get() && params->at(i-1)->doEval().get()) {
//             if (firstIsSignal) {
//               if (param->isInterface() || param->isSignalGroup()) {
//                 args.push_back(*firstName);
//                 args.push_back(*CSLOmIdentifier::cast(param->getChild(ID))->getName());
//                 //addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_GR_W_SIG, args, lineNumber);
//               canContinue = FALSE;
//               }
//             }
//             else {
//               if (param->isPort() || param->isSignal()) {
//                 args.push_back(*CSLOmIdentifier::cast(param->getChild(ID))->getName());
//                 args.push_back(*firstName);
//                 //addErr(NSWarningErr::CSE_CSC_SIG_ILLEGAL_CONECTION_GR_W_SIG, args, lineNumber);
//               canContinue = FALSE;
//               }
//             }
//           }
//         }
//       }
//       else if(!(i & 1)) {
//         args.push_back("instantiation");
//         addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber);
//         canContinue = FALSE;
//       }
//     }
//   }
  return canContinue;
}

void CSLOmCmdAddInstanceAll::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExprLink type  = CSLOmExprLink::cast(params->at(0));
  RefCSLOmExprLink name  = CSLOmExprLink::cast(params->at(1));

  RefCSLOmBase evaledName = name->doEval();
  RefCSLOmBase evaledType = type->doEval();

  RefTVec_RefCSLOmExpr connectableObjects(new TVec_RefCSLOmExpr);
  for(TUInt i = 2; i < params->size(); ++i) {
    connectableObjects->push_back(params->at(i));
  }
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          (CSLOmUnitDecl::cast(*it))->addInstance(lineNumber, fileName, type, name->getName(), connectableObjects);
        } 
        else {
          args.push_back(*name->getName());
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
      //in a unit declaration there can be instantiations of : unit declarations, interfaces, signal groups, fields
    case TYPE_DECL_UNIT:                
      if(evaledType->isUnitDecl()) {
        (CSLOmUnitDecl::cast(scopeParent))->addInstance(lineNumber, fileName, type, name->getName(), connectableObjects);
      }
      else if(evaledType->isInterface()) {
        (CSLOmUnitDecl::cast(scopeParent))->addInterface(lineNumber, fileName, type, name->getName());
      }
      else if(evaledType->isSignalGroup()) {
        CSLOmGroupSignal::build(lineNumber, fileName,scopeParent,CSLOmExprLink::cast(params->at(1))->getName(),type);
      }
      else if(evaledType->isField()) {
        CSLOmField::build(lineNumber, fileName, scopeParent, name->getName(), CSLOmField::cast(evaledType));
      }
      else {
        args.push_back(*name->getName());
        args.push_back("unit declaration, interface, field or signal group");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;

      //from the connectable objects, only interface and signal group can have instantiations
    case TYPE_CONNECTABLE:
      if(scopeParent->isInterface()) {
        //in an interface, only another interface can be instantiated
        if(evaledType->isInterface()) {
          //the only way to add an interface to another interface is to call the build function for the "child Interface" and setting the parent to be the "parent" Interface
          CSLOmInterface::build(lineNumber, fileName, scopeParent, name->getName(),type);
        }
        else {
          args.push_back(*name->getName());
          args.push_back("interface");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName); 
          cslomHasErrors = TRUE;
        }
      }
      else if(scopeParent->isSignalGroup()) {
        //in a signal group, only another signal group can be instantiated
        if(evaledType->isSignalGroup()) {
          //the only way to add a signal group to another signal group is by calling the build function for the "child signal group" ant setting the parent to be 
          //the "parent signal group"
          CSLOmGroupSignal::build(lineNumber, fileName, scopeParent, name->getName(), type);
        }
        else{
          args.push_back(*name->getName());
          args.push_back("group_signal");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("interface or signal group");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    case TYPE_BIT_RANGE:
      if(scopeParent->isIsaField()) {
        //in a isa field there can only be an instantiation of nother isa field
        if(evaledType->isIsaField()) {
          CSLOmIsaField::build(lineNumber, fileName, scopeParent, name->getName(), CSLOmIsaField::cast(evaledType));     
        }
        else {
          args.push_back(*name->getName());
          args.push_back("isa field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      else if(scopeParent->isIsaElement()) {
        //in an isa element there can be only instantiations of isa fields
        if(evaledType->isIsaField()) {
          CSLOmIsaField::build(lineNumber, fileName, scopeParent, name->getName(), CSLOmIsaField::cast(evaledType));     
        }
        else {
          args.push_back(*name->getName());
          args.push_back("isa field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      else if(scopeParent->isField()) {
        //in a field there can be instantiations of other fields
        if(evaledType->isField()) {
          CSLOmField::build(lineNumber, fileName, scopeParent, name->getName(), CSLOmField::cast(evaledType));     
        }
        else {
          args.push_back(*name->getName());
          args.push_back("field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("field, isa field or isa element");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    case TYPE_MEMORY_MAP_PAGE:
      //in a memory map page there can be only instantiations of other memory map pages
      if(evaledType->isMemoryMapLocationPage()) {
        CSLOmMemoryMapPageInstance::build(lineNumber, fileName, scopeParent, type, name->getName());
      }
      else {
        args.push_back(*name->getName());
        args.push_back("memory map page");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration, interface, signal group, memory map page, field or isa field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdAddUnitParameter class
// ********************************************************************************

void  CSLOmCmdAddUnitParameter::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdAddUnitParameter::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdAddUnitParameter::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(2 in this case) have been received
  /*  checkParamSize(params, PARAM_SIZE_CMDADDUNITPARAMETER_LOWER, PARAM_SIZE_CMDADDUNITPARAMETER_UPPER,"add_unit_parameter", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  checkParentType(f, PARENT_TYPE_SIZE_ADDUNITPARAMETER, scopeParent, scope, "unit declaration or list of unit declarations", lineNumber, fileName, canContinue);

  if(checkArgumentForNull(params, params->size(), "add_unit_parameter", lineNumber, fileName, canContinue)) {
    RefCSLOmExpr expr = params->at(0);
    RefCSLOmBase baseExpr = params->at(1)->doEval(TRUE);
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //check that the number has no XZ and is of type int32
      checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_unit_parameter", lineNumber, fileName, canContinue);
    }
    if(!expr->isExprLink()) {
      args.push_back("add_unit_parameter");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    }*/


  return canContinue;
}

void CSLOmCmdAddUnitParameter::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  /*  RefCSLOmExprLink name = CSLOmExprLink::cast(params->at(0));
  RefCSLOmExpr value = CSLOmExpr::cast(params->at(1)->doEval(TRUE));
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          (CSLOmUnitDecl::cast(*it))->addParameter(lineNumber, fileName, name->getName(), value);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber);
          //addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      (CSLOmUnitDecl::cast(scopeParent))->addParameter(lineNumber, fileName, name->getName(), value);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration or list of unit declarations");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber);
      //addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
      }*/
}

// ********************************************************************************
// CSLOmCmdOverrideUnitParameter class
// ********************************************************************************
RefCSLOmParameter CSLOmCmdOverrideUnitParameter::m_parameter = RefCSLOmParameter();

void  CSLOmCmdOverrideUnitParameter::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdOverrideUnitParameter::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdOverrideUnitParameter::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(2 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDOVERRIDEUNITPARAMETER_LOWER, PARAM_SIZE_CMDOVERRIDEUNITPARAMETER_UPPER,"override_unit_parameter", lineNumber, fileName, canContinue);
   
   RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
   if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isInstance};
  checkParentType(f, PARENT_TYPE_SIZE_OVERRIDEUNITPARAMETER, scopeParent, scope, "unit instance", lineNumber, fileName, canContinue);
  
  if(scopeParent->isInstance()) {
    RefCSLOmUnitInstance unitInst = CSLOmUnitInstance::cast(scopeParent);
    RefTVec_RefCSLOmBase unitParameters = unitInst->getParameters();
    TInt paramSize = 0;
    if(unitParameters.get()) {
      paramSize = unitParameters->size();
    }
    if(paramSize < ONE) {
      args.push_back(intToString(ONE));
      args.push_back(*getScopeValue(scopeParent));
      args.push_back(intToString(paramSize));
      addErr(NSWarningErr::DEE_CSC_DSGN_OVERRIDE_MORE_PARAMS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    RefCSLOmScope unitScope = CSLOmUnitInstance::cast(unitInst)->getUnitDecl()->getAttachedScope();
    CSLOmScopeBlock::enterScope(unitScope);
    RefCSLOmBase param = params->at(0)->doEval();
    CSLOmScopeBlock::exitScope();
    //instParam will be the parameter from the instance
    //since we cannot evaluate the parameter received as argument inside the unit instance(since unit instance is not a scope holder) we evaluate it in the instantiated
    //unit and then check whitch of the params from the instance (kept in parameters vector) it is
    if(param.get()) {
      for(int it = 0; it < unitParameters->size(); ++it) {
        RefCSLOmBase id = CSLOmExprLink::cast(unitParameters->at(it)->getChild(ID))->doEval();
        if(id.get() == param.get()) {
          m_parameter = RefCSLOmParameter(CSLOmParameter::cast(unitParameters->at(it)));
          break;
        }
      }
    }
    else {
      //the parameter to be overriden does not exist in the unit instance
      if(params->at(0)->isExprLink()) {
        RefCSLOmExprLink expr = CSLOmExprLink::cast(params->at(0));
        args.push_back(*convertLink(expr));
        args.push_back("override");
        addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_EXPR_LINK, args, lineNumber, fileName);
      }
      else {
        args.push_back(intToString(1));
        args.push_back("override");
        addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL, args, lineNumber, fileName);
      }
      canContinue = FALSE;
    }
  }

  //the second parameter recieved must be a number
  RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  newParams->push_back(params->at(1));
  if(checkArgumentForNull(newParams, newParams->size(), "override_parameter", lineNumber, fileName, canContinue)) {
    RefCSLOmBase value = params->at(1)->doEval();
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(value, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //check that the number(the second parameter) has no XZ and is of type int32
      checkNumber(value, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "override_parameter", lineNumber, fileName, canContinue);
    }
  }

  return canContinue;
}

void CSLOmCmdOverrideUnitParameter::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmNumber value = CSLOmNumber::cast(CSLOmExpr::cast(params->at(1)->doEval(TRUE)));
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitInstantiation()) {
          m_parameter->override(value);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit instances");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_INST_UNIT:
      m_parameter->override(value);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit instance");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  m_parameter = RefCSLOmParameter();
  
}




// ********************************************************************************
// CSLOmCmdOverrideParameterOrdered class
// ********************************************************************************

//These functions should be called after the CSLOmCmdAddInstanceAll since they are checking the ordered override from an instantiation.
map<RefCSLOmParameter, RefCSLOmNumber> CSLOmCmdOverrideParameterOrdered::m_overrideMap = map<RefCSLOmParameter, RefCSLOmNumber> ();

void  CSLOmCmdOverrideParameterOrdered::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdOverrideUnitParameter::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdOverrideParameterOrdered::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //the parameters received(except the first one) must be numbers or null expressions
  TInt size = params->size();
  RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  RefCSLOmBase baseExpr = RefCSLOmBase();
  for(int i = 1; i < size; ++i) {
    if(params->at(i).get()) {
      newParams->push_back(params->at(i));
      if(checkArgumentForNull(newParams, ONE, "ordered override", lineNumber, fileName, canContinue)) {
        newParams->pop_back();
        baseExpr = params->at(i)->doEval();
        if(baseExpr.get()) {
          TIsPredicate f2[] = {&CSLOmBase::isNumber};
          if (checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
            //check that the number has no XZ and is of type int32
            checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "override", lineNumber, fileName, canContinue);
          }
        }
      }
    }
  }
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl, &CSLOmBase::isInterface, &CSLOmBase::isSignalGroup};
  checkParentType(f, PARENT_TYPE_SIZE_OVERRIDEPARAMETER, scopeParent, scope, "unit declaration, interface or signal group", lineNumber, fileName, canContinue);

  if(!canContinue) {
    return FALSE;
  }

  newParams->push_back(params->at(0));
  if(!checkArgumentForNull(newParams, ONE, "override", lineNumber, fileName, canContinue)) {
    return FALSE;
  }
  //the first parameter is the instance for which the override is done
  baseExpr = params->at(0)->dupp()->doEval();
  TIsPredicate f2[] = {&CSLOmBase::isInstance, &CSLOmBase::isInterface, &CSLOmBase::isSignalGroup};
  checkArgumentType(baseExpr, f2, 3, "unit instance, interface or signal group", lineNumber, fileName, canContinue);
  
  if(baseExpr->isInterface()) {
    RefCSLOmInterface ifc = CSLOmInterface::cast(baseExpr);
    RefCSLOmBase ifc2 = params->at(0)->doEval();
    RefTVec_RefCSLOmBase ifcParameters = ifc->getParameters();
    TInt paramSize = 0;
    if(ifcParameters.get()) {
      paramSize = ifcParameters->size();
    }
    if(size-1 > paramSize) {
      args.push_back(intToString(size-1));
      args.push_back(*getScopeValue(baseExpr));
      args.push_back(intToString(paramSize));
      addErr(NSWarningErr::DEE_CSC_DSGN_OVERRIDE_MORE_PARAMS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else {
      for(int i = 1; i < size; ++i) {
        if(params->at(i).get()) {
          RefCSLOmBase value = params->at(i)->doEval();
          m_overrideMap.insert(pair<RefCSLOmParameter, RefCSLOmNumber>(CSLOmParameter::cast(ifcParameters->at(i-1)), CSLOmNumber::cast(value)));
        }
      }
    }
  }
  else if(baseExpr->isSignalGroup()) {
    RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(baseExpr);
    RefTVec_RefCSLOmBase sgParameters = sg->getParameters();
    TInt paramSize = 0;
    if(sgParameters.get()) {
      paramSize = sgParameters->size();
    }
    if(size-1 > paramSize) {
      args.push_back(intToString(size-1));
      args.push_back(*getScopeValue(baseExpr));
      args.push_back(intToString(paramSize));
      addErr(NSWarningErr::DEE_CSC_DSGN_OVERRIDE_MORE_PARAMS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else {
      for(int i = 1; i < size; ++i) {
        if(params->at(i).get()) {
          RefCSLOmBase value = params->at(i)->doEval();
          m_overrideMap.insert(pair<RefCSLOmParameter, RefCSLOmNumber>(CSLOmParameter::cast(sgParameters->at(i-1)), CSLOmNumber::cast(value)));
        }
      }
    }
  }
  else if(baseExpr->isInstance()) {
    RefCSLOmUnitInstance unitInst = CSLOmUnitInstance::cast(baseExpr);
    RefTVec_RefCSLOmBase unitParameters = unitInst->getParameters();
    TInt paramSize = 0;
    if(unitParameters.get()) {
      paramSize = unitParameters->size();
    }
    if(size - ONE > paramSize) {
      args.push_back(intToString(size-1));
      args.push_back(*getScopeValue(baseExpr));
      args.push_back(intToString(paramSize));
      addErr(NSWarningErr::DEE_CSC_DSGN_OVERRIDE_MORE_PARAMS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else {
      for(int i = 1; i < size; ++i) {
        if(params->at(i).get()) {
          RefCSLOmExpr value = params->at(i);
          m_overrideMap.insert(pair<RefCSLOmParameter, RefCSLOmNumber>(CSLOmParameter::cast(unitParameters->at(i-1)), CSLOmNumber::cast(value->doEval())));
        }
      }
    }
  }
    
  
  return canContinue;
}

void CSLOmCmdOverrideParameterOrdered::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  map<RefCSLOmParameter, RefCSLOmNumber>::iterator itMap;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl() || (*it)->isInterface() || (*it)->isSignalGroup()) {
          while(!m_overrideMap.empty()) {
            m_overrideMap.begin()->first -> override(m_overrideMap.begin()->second);
            m_overrideMap.erase(m_overrideMap.begin());
          }
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of units, interfaces or signal groups");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      while(!m_overrideMap.empty()) {
        m_overrideMap.begin()->first -> override(m_overrideMap.begin()->second);
        m_overrideMap.erase(m_overrideMap.begin());
      }
      break;
    case TYPE_CONNECTABLE:
      if(scopeParent->isInterface() || scopeParent->isSignalGroup()) {
        while(!m_overrideMap.empty()) {
          m_overrideMap.begin()->first -> override(m_overrideMap.begin()->second);
          m_overrideMap.erase(m_overrideMap.begin());
        }
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("interface or signal group");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit, interface or signal group");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  
}



// ********************************************************************************
// CSLOmCmdOverrideParameterNamed class
// ********************************************************************************
//These functions should be called after the CSLOmCmdAddInstanceAll since they are checking the named override from an instantiation.
map<RefCSLOmParameter, RefCSLOmNumber> CSLOmCmdOverrideParameterNamed::m_overrideMap = map<RefCSLOmParameter, RefCSLOmNumber> ();

void  CSLOmCmdOverrideParameterNamed::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdOverrideUnitParameter::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdOverrideParameterNamed::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
   
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }       
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl, &CSLOmBase::isInterface, &CSLOmBase::isSignalGroup};
  checkParentType(f, PARENT_TYPE_SIZE_OVERRIDEPARAMETER, scopeParent, scope, "unit declaration, interface or signal group", lineNumber, fileName, canContinue);

  TInt size = params->size();
  //The params received must be in odd number: the first one is the instance, while the rest are pairs: parameter - value. 
  //So there should be at least 3 elements in the params vector.
  if(size < 3) {
    args.push_back("override");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_WRONG_ARG_NR, args, lineNumber, fileName);
    canContinue = FALSE;
    return FALSE;
    canContinue = FALSE;
  }
  if(size % 2 != 1) {   
    args.push_back("override");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_WRONG_ARG_NR, args, lineNumber, fileName);
    canContinue = FALSE;
    return FALSE;
  }

  RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  RefCSLOmBase baseExpr = RefCSLOmBase();
  for(int i = 1; i < size; ++i) {
    if(i % 2 != 1) {
      //the odd parameters, except the first one, must be numbers or null expressions
      if(params->at(i).get()) {
        newParams->push_back(params->at(i));
        if(checkArgumentForNull(newParams, ONE, "named override", lineNumber, fileName, canContinue)) {
          baseExpr = params->at(i)->doEval();
          TIsPredicate f[] = {&CSLOmBase::isNumber};
          if (checkArgumentType(baseExpr, f, ONE, "number", lineNumber, fileName, canContinue)) {
            //check that the number has no XZ and is of type int32
            checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "override", lineNumber, fileName, canContinue);
          }
        }
        newParams->pop_back();
      }
    }
  }
  
  //the first parameter must be the instance for which the override is done
  newParams->push_back(params->at(0));
  if(!checkArgumentForNull(newParams, ONE, "override", lineNumber, fileName, canContinue)) {
    return FALSE;
  }
  baseExpr = params->at(0)->doEval();
  TIsPredicate f2[] = {&CSLOmBase::isInstance, &CSLOmBase::isInterface, &CSLOmBase::isSignalGroup};
  checkArgumentType(baseExpr, f2, 3, "unit instance, interface or signal group", lineNumber, fileName, canContinue);

  if(!canContinue) {
    return canContinue;
  }

  RefTVec_RefCSLOmBase parameters = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase);  
  if(baseExpr->isInterface()) {
    //the number of parameters to be overriden must be smaller or equal to the total number of parameters of the interface
    RefCSLOmInterface ifc = CSLOmInterface::cast(baseExpr);
    parameters = ifc->getParameters();
    TInt paramSize = 0;
    if(parameters.get()) {
      paramSize = parameters->size();
    }
    if(size/2 > paramSize) {
      args.push_back(intToString(size/2));
      args.push_back(*getScopeValue(scopeParent));
      args.push_back(intToString(paramSize));
      addErr(NSWarningErr::DEE_CSC_DSGN_OVERRIDE_MORE_PARAMS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else {
      for(int i = 1; i < size; ++i) { 
        //the parameter must be evaluated in the scope of the interface that is instantiated
        RefCSLOmScope ifcScope = ifc->getAttachedScope();
        CSLOmScopeBlock::enterScope(ifcScope);
        RefCSLOmBase param = params->at(i)->doEval();
        CSLOmScopeBlock::exitScope();
        if(param.get()) {
          TIsPredicate f2[] = {&CSLOmBase::isParameter};
          if(checkArgumentType(param, f2, ONE, "parameter", lineNumber, fileName, canContinue)) {
            if(params->at(i+1).get()) {
              RefCSLOmBase value = params->at(i+1)->doEval();
              m_overrideMap.insert(pair<RefCSLOmParameter, RefCSLOmNumber>(CSLOmParameter::cast(param), CSLOmNumber::cast(value)));
            }
          }
        }
        else {
          if(params->at(i)->isExprLink()) {
            RefCSLOmExprLink expr = CSLOmExprLink::cast(params->at(i));
            args.push_back(*convertLink(expr));
            args.push_back("override");
            addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_EXPR_LINK, args, lineNumber, fileName);
          }
          else {
            args.push_back(intToString(i+1));
            args.push_back("override");
            addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL, args, lineNumber, fileName);
          }
          canContinue = FALSE;
        }
        ++i;
      }
    }
  }
  else if(baseExpr->isSignalGroup()) {
    RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(baseExpr);
    parameters = sg->getParameters();
    TInt paramSize = 0;
    if(parameters.get()) {
      paramSize = parameters->size();
    }
    if(size/2 > paramSize) {
      args.push_back(intToString(size/2));
      args.push_back(*getScopeValue(scopeParent));
      args.push_back(intToString(paramSize));
      addErr(NSWarningErr::DEE_CSC_DSGN_OVERRIDE_MORE_PARAMS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else {
      for(int i = 1; i < size; ++i) {
        //the parameter must be evaluated in the scope of the signal group that is instantiated
        RefCSLOmScope sgScope = sg->getAttachedScope();
        CSLOmScopeBlock::enterScope(sgScope);
        RefCSLOmBase param = params->at(i)->doEval();
        CSLOmScopeBlock::exitScope();
        if(param.get()) {
          TIsPredicate f2[] = {&CSLOmBase::isParameter};
          if(checkArgumentType(param, f2, ONE, "parameter", lineNumber, fileName, canContinue)) {
            if(params->at(i+1).get()) {
              RefCSLOmBase value = params->at(i+1)->doEval();
              m_overrideMap.insert(pair<RefCSLOmParameter, RefCSLOmNumber>(CSLOmParameter::cast(param), CSLOmNumber::cast(value)));
            }
          }
        }
        else {
          if(params->at(i)->isExprLink()) {
            RefCSLOmExprLink expr = CSLOmExprLink::cast(params->at(i));
            args.push_back(*convertLink(expr));
            args.push_back("override");
            addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_EXPR_LINK, args, lineNumber, fileName);
          }
          else {
            args.push_back(intToString(i+1));
            args.push_back("override");
            addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL, args, lineNumber, fileName);
          }
          canContinue = FALSE;
        }
        ++i;
      }
    }
  }
  else if(baseExpr->isInstance()) {
    RefCSLOmUnitInstance unitInst = CSLOmUnitInstance::cast(baseExpr);
    parameters = unitInst->getParameters();
    
    TInt paramSize = 0;
    if(parameters.get()) {
      paramSize = parameters->size();
    }
    if(size/2 > paramSize) {
      args.push_back(intToString(size/2));
      args.push_back(*getScopeValue(scopeParent));
      args.push_back(intToString(paramSize));
      addErr(NSWarningErr::DEE_CSC_DSGN_OVERRIDE_MORE_PARAMS, args, lineNumber, fileName);
      canContinue = FALSE;
    } 
    else {
      for(int i = 1; i < size; ++i) {
        RefCSLOmScope unitScope = CSLOmUnitInstance::cast(unitInst)->getUnitDecl()->getAttachedScope();
        CSLOmScopeBlock::enterScope(unitScope);
        RefCSLOmBase param = params->at(i)->doEval();
        CSLOmScopeBlock::exitScope();
        RefCSLOmParameter instParam = RefCSLOmParameter();
        //instParam will be the parameter from the instance
        //Since we cannot evaluate the parameter received as argument inside the unit instance(since unit instance is not a scope holder) we evaluate it in the instantiated
        //unit and then check whitch of the params from the instance(kept in parameters vector) it is
        if(param.get()) {
          TIsPredicate f2[] = {&CSLOmBase::isParameter};
          if(checkArgumentType(param, f2, ONE, "parameter", lineNumber, fileName, canContinue)) {
            for(int it = 0; it < parameters->size(); ++it) {
              //the parameter that has been overriden has an expression link pointing towards the default parameter on the ID posistion in the m_children vector
              RefCSLOmBase id = CSLOmExprLink::cast(parameters->at(it)->getChild(ID))->doEval();
              if(id.get() == param.get()) {
                instParam = RefCSLOmParameter(CSLOmParameter::cast(parameters->at(it)));
                break;
              }
            }
          }
          if(params->at(i+1).get()) {
            RefCSLOmBase value = params->at(i+1)->doEval();
            m_overrideMap.insert(pair<RefCSLOmParameter, RefCSLOmNumber>(instParam, CSLOmNumber::cast(value)));
          }
        }
        else {
          //the parameter to be overriden does not exist in the unit instance
          if(params->at(i)->isExprLink()) {
            RefCSLOmExprLink expr = CSLOmExprLink::cast(params->at(i));
            args.push_back(*convertLink(expr));
            args.push_back("override");
            addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_EXPR_LINK, args, lineNumber, fileName);
          }
          else {
            args.push_back(intToString(i+1));
            args.push_back("override");
            addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL, args, lineNumber, fileName);
          }
          canContinue = FALSE;
        }
        ++i;
      }
    }
  }
    

  return canContinue;
}

void CSLOmCmdOverrideParameterNamed::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl() || (*it)->isInterface() || (*it)->isSignalGroup()) {
          while(!m_overrideMap.empty()) {
            m_overrideMap.begin()->first -> override(m_overrideMap.begin()->second);
            m_overrideMap.erase(m_overrideMap.begin());
          }
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of units, interfaces or signal groups");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      while(!m_overrideMap.empty()) {
        m_overrideMap.begin()->first -> override(m_overrideMap.begin()->second);
        m_overrideMap.erase(m_overrideMap.begin());
      }
      break;
    case TYPE_CONNECTABLE:
      if(scopeParent->isInterface() || scopeParent->isSignalGroup()) {
        while(!m_overrideMap.empty()) {
          m_overrideMap.begin()->first -> override(m_overrideMap.begin()->second);
          m_overrideMap.erase(m_overrideMap.begin());
        }
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("interface or signal group");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit, interface or signal group");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }   
  
}






// ********************************************************************************
// CSLOmCmdInputVerilogType class
// ********************************************************************************
EVerilogType CSLOmCmdInputVerilogType::m_verilogType = VERILOG_TYPE_UD;

void  CSLOmCmdInputVerilogType::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdInputVerilogType::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdInputVerilogType::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(0 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDINPUTVERILOGTYPE_LOWER, PARAM_SIZE_CMDINPUTVERILOGTYPE_UPPER,"input_verilog_type", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  checkParentType(f, PARENT_TYPE_SIZE_INPUTVERILOGTYPE, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue);
 
  if(m_verilogType < VERILOG_TYPE_UD || m_verilogType > VERILOG_TYPE_MAX) {
    args.push_back(*getScopeValue(scopeParent));
    args.push_back("verilog type");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
    canContinue = FALSE;
  }
  return canContinue;
}

void CSLOmCmdInputVerilogType::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          (CSLOmUnitDecl::cast(*it))->setInputVerilogType(m_verilogType);
        }
        else {
          args.push_back(*getScopeValue(*it));
          args.push_back("unit declaration");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      (CSLOmUnitDecl::cast(scopeParent))->setInputVerilogType(m_verilogType);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  } 
  
}

void CSLOmCmdInputVerilogType::setVerilogTypeParam(EVerilogType param) {
  m_verilogType = param;
}

EVerilogType CSLOmCmdInputVerilogType::getVerilogTypeParam() {
  return m_verilogType;
}

// ********************************************************************************
// CSLOmCmdOutputVerilogType class
// ********************************************************************************
EVerilogType CSLOmCmdOutputVerilogType::m_verilogType = VERILOG_TYPE_UD;
//CSLOmCmdOutputVerilogType::CSLOmCmdOutputVerilogType(TLineNumberType lineNumber): CSLOmSetCommand(lineNumber, fileName, TYPE_CMD_OUTPUT_VERILOG_TYPE), m_verilogType(VERILOG_TYPE_UD) {}

void  CSLOmCmdOutputVerilogType::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdOutputVerilogType::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdOutputVerilogType::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(0 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDOUTPUTVERILOGTYPE_LOWER, PARAM_SIZE_CMDOUTPUTVERILOGTYPE_UPPER,"output_verilog_type", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  checkParentType(f, PARENT_TYPE_SIZE_OUTPUTVERILOGTYPE, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue);

  if(m_verilogType < VERILOG_TYPE_UD || m_verilogType > VERILOG_TYPE_MAX) {
    args.push_back(*getScopeValue(scopeParent));
    args.push_back("verilog type");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
    canContinue = FALSE;
  }

  return canContinue;
}

void CSLOmCmdOutputVerilogType::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          (CSLOmUnitDecl::cast(*it))->setOutputVerilogType(m_verilogType);
        }
        else {
          args.push_back(*getScopeValue(*it));
          args.push_back("unit declaration");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_DECL_UNIT:
      (CSLOmUnitDecl::cast(scopeParent))->setOutputVerilogType(m_verilogType);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  } 
  
}

void CSLOmCmdOutputVerilogType::setVerilogTypeParam(EVerilogType param) {
  m_verilogType = param;
}

EVerilogType CSLOmCmdOutputVerilogType::getVerilogTypeParam() {
  return m_verilogType;
}

// ********************************************************************************
// CSLOmCmdReverse class
// ********************************************************************************

void  CSLOmCmdReverse::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "[CSLOmCmdReverse::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdReverse::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(0 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDREVERSE_LOWER, PARAM_SIZE_CMDREVERSE_UPPER,"reverse", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isInterface, &CSLOmBase::isPort};
  checkParentType(f, PARENT_TYPE_SIZE_REVERSE, scopeParent, scope, "interface, port or list of interfaces/ports", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isInterface()) {
      RefTVec_RefCSLOmPortDecl allPorts = CSLOmInterface::cast(*it)->getPorts();
      if(allPorts.get()) {
        TVec_RefCSLOmPortDecl_const_iter iter;
        for(iter = allPorts->begin(); iter < allPorts->end(); ++iter) {
          if((*iter)->getPortType() == SIGNAL_WOR || (*iter)->getPortType() == SIGNAL_WAND) {
            args.push_back(*CSLOmPortDecl::cast(*iter)->getName());
            args.push_back("other than wor/wand");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
            canContinue = FALSE;
          }
        }
      }//the interface has no ports so a warning is issued
      else {
        //TODO : ADD WARNING
      }
    }
    else if((*it)->isPort()) {
      //Part select not allowed
      RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
      if(exprLink->hasBitRange()) {
        canContinue = FALSE;
      }
      RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);
      if(port->getPortDirection() == INOUT) {
        args.push_back(*getScopeValue(*it));
        args.push_back("input or output");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdReverse::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isInterface()) {
          (CSLOmInterface::cast(*it))->reverse();
        }
        else if ((*it)->isPort()) {
          (CSLOmPortDecl::cast(*it))->reverse();
        }
        else {
          args.push_back(*getScopeValue(*it));
          args.push_back("list of ports or interfaces");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isInterface()) {
        (CSLOmInterface::cast(scopeParent))->reverse();
      }
      else if (scopeParent->isPort()) {
        (CSLOmPortDecl::cast(scopeParent))->reverse();
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("port or interface");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }   
}

// ********************************************************************************
// CSLOmCmdSetPrefix class
// ********************************************************************************
void CSLOmCmdSetPrefix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetPrefix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETPREFIX_LOWER, PARAM_SIZE_CMDSETPREFIX_UPPER,"set_prefix", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isInterface, &CSLOmBase::isSignalGroup};
  checkParentType(f, PARENT_TYPE_SIZE_SETPREFIX, scopeParent, scope, "interface or signal group", lineNumber, fileName, canContinue);
  
  if(scopeParent->isInterface()) {
    RefCSLOmInterface ifc = CSLOmInterface::cast(scopeParent);
    if(ifc->getNoPrefixBit()) {
      args.push_back("no_prefix");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else if(!ifc->doesNotHavePrefix()) {
      args.push_back("set_prefix");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  else if(scopeParent->isSignalGroup()){
    RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(scopeParent);
    if(sg->getNoPrefixBit()) {
      args.push_back("no_prefix");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else if(!sg->doesNotHavePrefix()) {
      args.push_back("set_prefix");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
    
    
  if(checkArgumentForNotNull(params, params->size(), "set_prefix", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetPrefix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmString prefix = CSLOmString::cast(params->at(0)->doEval());
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmExprLink instantiationExprLink;
  TBool emptyString = FALSE;
  if(prefix->isEmpty()) {
    emptyString = TRUE;
  }

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      //if the list is not empty, call the function from CSLOM
      if(objs.get()) {                                  
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isInterface()) {
            if(emptyString) {
              CSLOmInterface::cast(*it)->enableNoPrefix();
            }
            else {
              (CSLOmInterface::cast(*it))->setPrefix(prefix->getValue());
            }
          }
          else if ((*it)->isSignalGroup()) { 
            if(emptyString) {
              CSLOmGroupSignal::cast(*it)->enableNoPrefix();
            }
            else {
              (CSLOmGroupSignal::cast(*it))->setPrefix(prefix->getValue());
            }
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of interfaces and signal groups");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
            cslomHasErrors = TRUE;
          }
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if(scopeParent->isInterface()) {
        if(emptyString) {
          CSLOmInterface::cast(scopeParent)->enableNoPrefix();
        }
        else {
          CSLOmInterface::cast(scopeParent)->setPrefix(prefix->getValue());
        }
      }
      else if(scopeParent->isSignalGroup()) {
        if(emptyString) {
          CSLOmGroupSignal::cast(scopeParent)->enableNoPrefix();
        }
        else {
          CSLOmGroupSignal::cast(scopeParent)->setPrefix(prefix->getValue());
        }
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("interface or signal group");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("interface or signal group");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  
}

// ********************************************************************************
// CSLOmCmdSetSuffix class
// ********************************************************************************
void CSLOmCmdSetSuffix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetSuffix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETSUFFIX_LOWER, PARAM_SIZE_CMDSETSUFFIX_UPPER,"set_suffix", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  } 
  TIsPredicate f[] = {&CSLOmBase::isInterface, &CSLOmBase::isSignalGroup};
  if(checkParentType(f,PARENT_TYPE_SIZE_SETSUFFIX,scopeParent, scope, "interface or signal group", lineNumber, fileName, canContinue)) {
    if(scopeParent->isInterface()) {
      if(CSLOmInterface::cast(scopeParent)->getSuffix().get()) {
        args.push_back("set_suffix");
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else {
      if(CSLOmGroupSignal::cast(scopeParent)->getSuffix().get()) {
        args.push_back("set_suffix");
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
        canContinue = FALSE;
      }

    }
  }

  if(checkArgumentForNotNull(params, params->size(), "set_suffix", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetSuffix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmString suffix = CSLOmString::cast(params->at(0)->doEval());
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isInterface()) {
          (CSLOmInterface::cast(*it))->setSuffix(suffix->getValue());
        }
        else if ((*it)->isSignalGroup()) { 
          (CSLOmGroupSignal::cast(*it))->setSuffix(suffix->getValue());
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of interfaces or signal groups");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if(scopeParent->isInterface()) {
        (CSLOmInterface::cast(scopeParent))->setSuffix(suffix->getValue());
      }
      else if(scopeParent->isSignalGroup()) {
        (CSLOmGroupSignal::cast(scopeParent))->setSuffix(suffix->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("interface or signal group");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  
}

// ********************************************************************************
// CSLOmCmdNoPrefix class
// ********************************************************************************
void CSLOmCmdNoPrefix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdNoPrefix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //check that the correct number of parameters(0 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDNOPREFIX_LOWER, PARAM_SIZE_CMDNOPREFIX_UPPER, "no_prefix", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  } 
  TIsPredicate f[] = {&CSLOmBase::isInterface, &CSLOmBase::isSignalGroup};
  if(checkParentType(f, PARENT_TYPE_SIZE_NOPREFIX, scopeParent, scope, "interface or signal group", lineNumber, fileName, canContinue)) {
    if(scopeParent->isInterface()) {
      RefCSLOmInterface ifc = CSLOmInterface::cast(scopeParent);
      if(ifc->getNoPrefixBit()) {
        args.push_back("no_prefix");
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(!ifc->doesNotHavePrefix()) {
        args.push_back("set_prefix");
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else {
      RefCSLOmGroupSignal sg = CSLOmGroupSignal::cast(scopeParent);
      if(sg->getNoPrefixBit()) {
        args.push_back("no_prefix");
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(!sg->doesNotHavePrefix()) {
        args.push_back("set_prefix");
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdNoPrefix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isInterface()) {
          (CSLOmInterface::cast(*it))->enableNoPrefix();
        }
        else if((*it)->isSignalGroup()) {
          (CSLOmGroupSignal::cast(*it))->enableNoPrefix();
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of interfaces or signal groups");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if(scopeParent->isInterface()) {
        (CSLOmInterface::cast(scopeParent))->enableNoPrefix();
      }
      else if(scopeParent->isSignalGroup()) {
        (CSLOmGroupSignal::cast(scopeParent))->enableNoPrefix();
      }
      
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("interface or signal group");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
  
}



// ********************************************************************************
// CSLOmCmdSetValue class
// ********************************************************************************

void  CSLOmCmdSetValue::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetValue::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//will become false when an error is found

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETVALUE_LOWER, PARAM_SIZE_CMDSETVALUE_UPPER,"set_value", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);//return the parent scope as base and  also checks that it is not null
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isField};
  checkParentType(f, PARENT_TYPE_SIZE_SETVALUE, scopeParent, scope, "field or isa field", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isIsaElement()) {
      args.push_back(*getScopeValue(*it));
      args.push_back("field or isa field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    if((*it)->isField() && !(*it)->isIsaElement()) {
      if( CSLOmField::cast(*it)->isWithValue()    || 
          CSLOmField::cast(*it)->isWithEnum()     || 
          CSLOmField::cast(*it)->isWithEnumItem() || 
          CSLOmField::cast(*it)->isHierarchical() ) {
        args.push_back(*getScopeValue(*it));
        args.push_back("undefined field(not with enum, enum item, value or hierarchical)");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;   
      }
    }  
  }

 
  if(checkArgumentForNull(params, ONE, "set_value", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr1 = params->at(0)->doEval(TRUE);
    TIsPredicate f2[] = {&CSLOmBase::isNumber, &CSLOmBase::isEnumItem};
    if (checkArgumentType(baseExpr1,f2, 1+1, "number or enum item", lineNumber, fileName, canContinue)) {
      //check that the number has no XZ and is of type int32
      if(baseExpr1->isNumber()) {
        checkNumber(baseExpr1, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_value", lineNumber, fileName, canContinue);
      }
    }
  }
  
  return canContinue;
  
}

void  CSLOmCmdSetValue::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmNumber value;
  RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
  if(baseExpr->isNumber()) {
    value = CSLOmNumber::cast(baseExpr);
  }
  else {
    value = CSLOmEnum::cast(baseExpr->getParent())->getValue(CSLOmIdentifier::cast(baseExpr)->getName());
  }
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isField()) {
            CSLOmField::cast(*it)->setValue(value);
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of fields");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
           }
        }
        break;
      case TYPE_BIT_RANGE:
        if(scopeParent->isIsaField()) {
          CSLOmField::cast(scopeParent)->setValue(value);
        }
        else if(scopeParent->isField() && !scopeParent->isIsaElement()) {
          CSLOmField::cast(scopeParent)->setValue(value);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("field, isa field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
        break;
    default:
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("isa field or field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        break;
    }
}


// ********************************************************************************
// CSLOmCmdSetEnum class
// ********************************************************************************

void  CSLOmCmdSetEnum::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetEnum::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//will become false when an error is found

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETENUM_LOWER, PARAM_SIZE_CMDSETENUM_UPPER, "set_enum", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isField};
  checkParentType(f, PARENT_TYPE_SIZE_SETENUM, scopeParent, scope, "field or isa field", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isField()) {
      if( CSLOmField::cast(*it)->isWithValue()    || 
          CSLOmField::cast(*it)->isWithEnum()     || 
          CSLOmField::cast(*it)->isWithEnumItem() || 
          CSLOmField::cast(*it)->isHierarchical() ) {
        args.push_back(*getScopeValue(*it));
        args.push_back("undefined field(not hierarchical and not with enum, enum item or value)");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;   
      }
    }
  }
    
  if(checkArgumentForNull(params, ONE, "set_enum", lineNumber, fileName, canContinue)) { 
    RefCSLOmBase baseExpr1 = params->at(0)->doEval();
    //the parameter has to be of type enum
    TIsPredicate f2[] = {&CSLOmBase::isEnum};
    if (checkArgumentType(baseExpr1,f2, 1, "enum", lineNumber, fileName, canContinue)) {
      RefCSLOmEnum enum_ = CSLOmEnum::cast(baseExpr1);
      /*    TInt enumWidth = enum_->getWidth();
      //the width of the enum must be lower or equal to the with of the field(if the width is set)
      RefCSLOmExpr width = CSLOmField::cast(scopeParent)->getWidth();
      if (scopeParent->isField() && !CSLOmField::cast(scopeParent)->isDefault() && CSLOmNumber::cast(width->doEval())->getValue() < enumWidth) {
        args.push_back(*getScopeValue(baseExpr1));
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_ENUM_WIDTH_BIGGER, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
        }*/
    }
  }

  return canContinue;
}


void  CSLOmCmdSetEnum::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase enumBase = params->at(0)->doEval();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isField()) {
            CSLOmField::cast(*it)->setEnum(CSLOmEnum::cast(enumBase));
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of fields");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
            }
        }
        break;
      case TYPE_BIT_RANGE:
        if(scopeParent->isField()) {
          CSLOmField::cast(scopeParent)->setEnum(CSLOmEnum::cast(enumBase));
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("field or isa field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
        break;
      default:
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("field or isa field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        break;
    }
}

// ********************************************************************************
// CSLOmCmdFieldSetEnumItem class
// ********************************************************************************

void  CSLOmCmdSetEnumItem::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetEnumItem::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//will become false when an error is found

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, PARAM_SIZE_CMDSETENUMITEM_LOWER, PARAM_SIZE_CMDSETENUMITEM_UPPER,"set_enum_item", lineNumber, fileName, canContinue);

  //check that the parameter is not null and is of type enum item
  if(checkArgumentForNull(params, ONE, "set_enum_item", lineNumber, fileName, canContinue)) { 
    RefCSLOmBase baseExpr1 = params->at(0)->doEval();
    TIsPredicate f2[] = {&CSLOmBase::isEnumItem};
    if(!checkArgumentType(baseExpr1, f2, 1, "enum item", lineNumber, fileName, canContinue)) {
      return FALSE;
    }
  }
  else {
    return FALSE;
  }


  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  //the scopeParent can be a field (simple field or isa field)
  TIsPredicate f[] = {&CSLOmBase::isField};
  checkParentType(f, PARENT_TYPE_SIZE_SETENUMITEM, scopeParent, scope, "field or isa field", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isField()) {
      RefCSLOmField parentField = CSLOmField::cast(*it);
      //the field must have an enum associated
      if(parentField->isWithEnum()) {
        //if the field is with enum and is instantiated, it can also be asociated with an enum item from that enum
        if(!parentField->isEnumFieldInstance()) {
          //TODO: add correct error message
          args.push_back(*getScopeValue(*it));
          args.push_back("field instance");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        else if(params->at(0)->doEval()->getParent() != parentField->getEnum()) {
          args.push_back(*CSLOmIdentifier::cast(params->at(0)->doEval())->getName());
          args.push_back(*getScopeValue(parentField->getEnum()));
          addErr(NSWarningErr::CSE_CSC_FUNC_ENUM_ITEM_NOT_FOUND, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
      else {
        //the field does not have an enum associated
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NO_ENUM, args, lineNumber, fileName);
        canContinue = FALSE;   
      }
    }
  }
  
 
  return canContinue;

}

void  CSLOmCmdSetEnumItem::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmIdentifier enumItemExpr = CSLOmIdentifier::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isField()) {
            CSLOmField::cast(*it)->setEnumItem(CSLOmIdentifier::cast(enumItemExpr));
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of fields");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
            cslomHasErrors = TRUE;
            }
        }
        break;
      case TYPE_BIT_RANGE:
        if(scopeParent->isField()) {                                    //simple field or isa field
          CSLOmField::cast(scopeParent)->setEnumItem(enumItemExpr);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("field or isa field");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          cslomHasErrors = TRUE;
        }
        break;
      default:
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("field or isa field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
        break;
    }
}





// ********************************************************************************
// CSLOmCmdSetName class
// ********************************************************************************

void  CSLOmCmdSetName::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//will become false when an error is found

  //check that the correct number of parameters(1 in this case) have been received
  checkParamSize(params, 1, 1, "set_name", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  //the scopeParent can be a isa field
  TIsPredicate f[] = {&CSLOmBase::isIsaField};
  checkParentType(f, ONE, scopeParent, scope, "isa field", lineNumber, fileName, canContinue);

  //check that the parameter is not null
  if(checkArgumentForNull(params, ONE, "set_name", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  return canContinue;

}

void  CSLOmCmdSetName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmString expr = CSLOmString::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isIsaField()) {
            CSLOmIsaField::cast(*it)->setName(expr->getValue());
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of isa fields");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
            cslomHasErrors = TRUE;
            }
        }
        break;
      case TYPE_BIT_RANGE:
        if(scopeParent->isIsaField()) {                                   
          CSLOmIsaField::cast(scopeParent)->setName(expr->getValue());
        }
        break;
      default:
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("isa field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
        break;
    }
}



//
//Vector or StateData commands
//


// ********************************************************************************
// CSLOmCmdVSDSetRadix class
// ********************************************************************************
CSLOmVerifCompInfo::ECSLOmVCRadix CSLOmCmdVSDSetRadix::m_radixEnum=CSLOmVerifCompInfo::VC_RADIX_UNDEFINED;

void CSLOmCmdVSDSetRadix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetRadix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  //The command can receive one argument or none.If no arguments are received, the command is called like: 
  //    set_radix(VC_RADIX_BIN);
  //and the enum item(VC_RADIX_BIN) is sent through the method setEnumParam.
  //When one argument is received, the command is called like: 
  //     set_radix(vc.get_radix());
  //and the parameter is of type hybridOrFuncCall.
  checkParamSize(params, ZERO, ONE, "set_radix", lineNumber, fileName, canContinue);
  if(params->size() == 0) {
    if(m_radixEnum <= CSLOmVerifCompInfo::VC_RADIX_UNDEFINED || m_radixEnum >= CSLOmVerifCompInfo::VC_RADIX_MAX) {
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("verification component radix");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  else {
    if(checkArgumentForNull(params, ONE, "set_radix", lineNumber, fileName, canContinue)) {
       TInt enumItem = CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_VSD_RADIX);
       setRadixTypeParam(static_cast<CSLOmVerifCompInfo::ECSLOmVCRadix>(enumItem));
         if(m_radixEnum <= CSLOmVerifCompInfo::VC_RADIX_UNDEFINED || m_radixEnum >= CSLOmVerifCompInfo::VC_RADIX_MAX) {
           args.push_back(*getScopeValue(scopeParent));
           args.push_back("verification component radix");
           addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
           canContinue = FALSE;
         }
     } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetRadix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent=checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setRadix(m_radixEnum);
        }
      }
      break;
     case TYPE_DECL_UNIT:
       if(scopeParent->isVector() || scopeParent->isStateData()) {
         (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setRadix(m_radixEnum);
       }
       else {
         args.push_back(*getScopeValue(scopeParent));
         args.push_back("state data or vector");
         addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
         cslomHasErrors = TRUE;
       }
       break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("state data, vector");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

void CSLOmCmdVSDSetRadix::setRadixTypeParam(CSLOmVerifCompInfo::ECSLOmVCRadix param) {
  m_radixEnum=param;
}
CSLOmVerifCompInfo::ECSLOmVCRadix CSLOmCmdVSDSetRadix::getRadixTypeParam() {
  return m_radixEnum;
}

// ********************************************************************************
// CSLOmCmdVSDSetCaptureEdgeType class
// ********************************************************************************

CSLOmVerifCompInfo::ECSLOmVCEdgeType CSLOmCmdVSDSetCaptureEdgeType::m_edgeEnum=CSLOmVerifCompInfo::VC_EDGE_UNDEFINED;

void CSLOmCmdVSDSetCaptureEdgeType::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetCaptureEdgeType::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //exactly 1 param that must be rise or fall 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);
  
  checkParamSize(params, ZERO, ONE, "set_vc_capture_edge_type", lineNumber, fileName, canContinue);

  if(params->size() == 0) {
    if(m_edgeEnum <= CSLOmVerifCompInfo::VC_EDGE_UNDEFINED || m_edgeEnum >= CSLOmVerifCompInfo::VC_EDGE_MAX) {
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("capture edge type");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  else {
    if(checkArgumentForNull(params, ONE, "set_capture_edge_type", lineNumber, fileName, canContinue)) {
      TBool enumItem = CSLOmExprHybridOrFuncCall::cast(params->at(0))->doEnumEval(ENUM_TYPE_VSD_EDGE_TYPE);
      setEdgeTypeParam(static_cast<CSLOmVerifCompInfo::ECSLOmVCEdgeType>(enumItem));
      if(getEdgeTypeParam() <= CSLOmVerifCompInfo::VC_EDGE_UNDEFINED || getEdgeTypeParam() >= CSLOmVerifCompInfo::VC_EDGE_MAX) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("capture edge type");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetCaptureEdgeType::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent=checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setCaptureEdgeType(m_edgeEnum);
        }
      }
      break;
    case TYPE_DECL_UNIT:
       if(scopeParent->isVector() || scopeParent->isStateData()) {
      (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setCaptureEdgeType(m_edgeEnum);
       }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("state data or vector");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}

void CSLOmCmdVSDSetCaptureEdgeType::setEdgeTypeParam(CSLOmVerifCompInfo::ECSLOmVCEdgeType param) {
  m_edgeEnum=param;
}
CSLOmVerifCompInfo::ECSLOmVCEdgeType CSLOmCmdVSDSetCaptureEdgeType::getEdgeTypeParam() {
  return m_edgeEnum;
}


// ********************************************************************************
// CSLOmCmdVSDMaxCycles class
// ********************************************************************************

void CSLOmCmdVSDMaxCycles::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDMaxCycles::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //exactly 1 param that must be a number

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_num_of_transaction", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_num_of_transaction", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_num_of_transaction", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDMaxCycles::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent=checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmExpr no = params->at(0);
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setMaxCycles(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
       if(scopeParent->isVector() || scopeParent->isStateData()) {
         (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setMaxCycles(no);
       }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("state data or vector");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}




// ********************************************************************************
// CSLOmCmdVSDSetNumericID class
// ********************************************************************************

void CSLOmCmdVSDSetNumericID::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetNumericID::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //exactly 1 param that must be a number

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_numeric_id", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_numeric_id", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_numeric_id", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetNumericID::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setNumericID(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setNumericID(no);
      } 
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetVersion class
// ********************************************************************************

void CSLOmCmdVSDSetVersion::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetVersion::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //exactly 1 param that must be a number

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_version", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_version", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_version", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetVersion::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setVersion(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setVersion(no);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector, state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetMaxEventsCount class
// ********************************************************************************

void CSLOmCmdVSDSetMaxEventsCount::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetMaxEventsCount::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_max_events_count", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_max_events_count", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_max_events_count", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetMaxEventsCount::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setMaxEventsCount(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setMaxEventsCount(no);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetMaxMismatchesCount class
// ********************************************************************************

void CSLOmCmdVSDSetMaxMismatchesCount::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetMaxMismatchesCount::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_vc_max_number_of_mismatches", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_vc_max_number_of_mismatches", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_vc_max_number_of_mismatches", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetMaxMismatchesCount::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setMaxMismatchesCount(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setMaxMismatchesCount(no);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetTimeout class
// ********************************************************************************

void CSLOmCmdVSDSetTimeout::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetTimeout::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_vc_timeout", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_vc_timeout", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_vc_timeout", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetTimeout::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setTimeout(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setTimeout(no);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetMaxNumStates class
// ********************************************************************************

void CSLOmCmdVSDSetMaxNumStates::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetMaxNumStates::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_max_num_states", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_max_num_states", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_max_num_states", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetMaxNumStates::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setMaxNumStates(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setMaxNumStates(no);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetNumOfTransaction class
// ********************************************************************************

void CSLOmCmdVSDSetNumOfTransaction::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetNumOfTransaction::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_num_of_transaction", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_num_of_transaction", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_num_of_transaction", lineNumber, fileName, canContinue);
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetNumOfTransaction::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setNumOfTransactionEvents(no);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setNumOfTransactionEvents(no);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetName class
// ********************************************************************************

void CSLOmCmdVSDSetName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //only 1 param = string
  checkParamSize(params, ONE, ONE,"set_vc_name", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector, &CSLOmBase::isStateData};
  checkParentType(f, ONE+ONE, scopeParent, scope, "vector, state data", lineNumber, fileName, canContinue);
 
  if(checkArgumentForNotNull(params, params->size(), "set_vc_name", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}
void CSLOmCmdVSDSetName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefCSLOmString name = CSLOmString::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setName(name->getValue());
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setName(name->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetHeaderComment class
// ********************************************************************************

void CSLOmCmdVSDSetHeaderComment::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetHeaderComment::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //only 1 param = string
  checkParamSize(params, ONE, ONE, "set_vc_header_comment", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector, &CSLOmBase::isStateData};
  checkParentType(f, ONE+ONE, scopeParent, scope, "vector, state data", lineNumber, fileName, canContinue);
 
  if(checkArgumentForNotNull(params, params->size(), "set_vc_header_comment", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}
void CSLOmCmdVSDSetHeaderComment::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefCSLOmString name = CSLOmString::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setVCHeaderComment(name->getValue());
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setVCHeaderComment(name->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetOutputFilename class
// ********************************************************************************

void CSLOmCmdVSDSetOutputFilename::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetOutputFilename::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //only 1 param = string
  checkParamSize(params, ONE, ONE,"set_vc_output_filename", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector, &CSLOmBase::isStateData};
  checkParentType(f, ONE+ONE, scopeParent, scope, "vector, state data", lineNumber, fileName, canContinue);
 
  if(checkArgumentForNotNull(params, params->size(), "set_vc_output_filename", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}
void CSLOmCmdVSDSetOutputFilename::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefCSLOmString name = CSLOmString::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setOutputFilename(name->getValue());
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setOutputFilename(name->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetCppRDName class
// ********************************************************************************

void CSLOmCmdVSDSetCppRDName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetCppRDName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //only 1 param = string
  checkParamSize(params, ONE, ONE,"set_vc_cpp_rd_name", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector, &CSLOmBase::isStateData};
  checkParentType(f, ONE+ONE, scopeParent, scope, "vector, state data", lineNumber, fileName, canContinue);
 
  if(checkArgumentForNotNull(params, params->size(), "set_vc_cpp_rd_name", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}
void CSLOmCmdVSDSetCppRDName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefCSLOmString name = CSLOmString::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setCppRDName(name->getValue());
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setCppRDName(name->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetCppWRName class
// ********************************************************************************

void CSLOmCmdVSDSetCppWRName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetCppWRName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //only 1 param = string
  checkParamSize(params, ONE, ONE,"set_vc_cpp_wr_name", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector, &CSLOmBase::isStateData};
  checkParentType(f, ONE+ONE, scopeParent, scope, "vector, state data", lineNumber, fileName, canContinue);
 
  if(checkArgumentForNotNull(params, params->size(), "set_vc_cpp_wr_name", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}
void CSLOmCmdVSDSetCppWRName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefCSLOmString name = CSLOmString::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setCppWRName(name->getValue());
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setCppWRName(name->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetClock class
// ********************************************************************************

void CSLOmCmdVSDSetClock::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetClock::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //exactly 1 param that must be a signal

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);
  if(checkParamSize(params, ONE, ONE, "set_vc_clock", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_vc_clock", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isSignal};
      if(checkArgumentType(baseExpr, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
        if(exprLink->hasBitRange()) {
          args.push_back("set_vc_clock");
          addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        //RefCSLOmSignal signal = CSLOmSignal::cast(baseExpr);
        //RefCSLOmExpr width = signal->getWidth();
        /*RefCSLOmNumber noWidth = CSLOmNumber::cast(width->doEval());
        if(noWidth->getValue() != 1) {
          args.push_back(*getScopeValue(signal));
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_WIDTH_ONE, args, lineNumber, fileName);
          canContinue = FALSE;
          }*/
      }
    } 
  }


  return canContinue;
}
void CSLOmCmdVSDSetClock::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase baseExpr = params->at(0)->doEval();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setClock(CSLOmSignal::cast(baseExpr));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setClock(CSLOmSignal::cast(baseExpr));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetReset class
// ********************************************************************************

void CSLOmCmdVSDSetReset::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetReset::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_vc_reset", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_vc_reset", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isSignal};
      if(checkArgumentType(baseExpr, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
        if(exprLink->hasBitRange()) {
          args.push_back("set_vc_reset");
          addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);   
          canContinue = FALSE;
        }
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetReset::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase baseExpr = params->at(0)->doEval();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setReset(CSLOmSignal::cast(baseExpr));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setReset(CSLOmSignal::cast(baseExpr));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetStall class
// ********************************************************************************

void CSLOmCmdVSDSetStall::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetStall::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_stall", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_stall", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isSignal};
      if(checkArgumentType(baseExpr, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
        if(exprLink->hasBitRange()) {
          args.push_back("set_stall");
          addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetStall::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase baseExpr = params->at(0)->doEval();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setStall(CSLOmSignal::cast(baseExpr));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setStall(CSLOmSignal::cast(baseExpr));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetCompareTrigger class
// ********************************************************************************

void CSLOmCmdVSDSetCompareTrigger::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetCompareTrigger::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vetor", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_vc_compare_trigger", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_vc_compare_trigger", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isSignal};
      if(checkArgumentType(baseExpr, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
        if(exprLink->hasBitRange()) {
          args.push_back("set_vc_compare_trigger");
          addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetCompareTrigger::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase baseExpr = params->at(0)->doEval();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setCompareTrigger(CSLOmSignal::cast(baseExpr));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setCompareTrigger(CSLOmSignal::cast(baseExpr));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetStartGenerationTrigger class
// ********************************************************************************

void CSLOmCmdVSDSetStartGenerationTrigger::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetStartGenerationTrigger::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_vc_start_generation_trigger", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_vc_start_generation_trigger", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isSignal};
      if(checkArgumentType(baseExpr, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
        if(exprLink->hasBitRange()) {
          args.push_back("set_vc_start_generation_trigger");
          addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetStartGenerationTrigger::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase baseExpr = params->at(0)->doEval();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setStartGenerationTrigger(CSLOmSignal::cast(baseExpr));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setStartGenerationTrigger(CSLOmSignal::cast(baseExpr));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetEndGenerationTrigger class
// ********************************************************************************

void CSLOmCmdVSDSetEndGenerationTrigger::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetEndGenerationTrigger::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_vc_end_generation_trigger", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_vc_end_generation_trigger", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isSignal};
      if(checkArgumentType(baseExpr, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
        //Part select not allowed
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
        if(exprLink->hasBitRange()) {
          args.push_back("set_vc_end_generation_trigger");
          addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetEndGenerationTrigger::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase baseExpr = params->at(0)->doEval();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setEndGenerationTrigger(CSLOmSignal::cast(baseExpr));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setEndGenerationTrigger(CSLOmSignal::cast(baseExpr));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetModuleName class
// ********************************************************************************

void CSLOmCmdVSDSetModuleName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetModuleName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector, &CSLOmBase::isMemoryMapLocationPage};
  checkParentType(f, PARENT_TYPE_SIZE_SETUNITNAME, scopeParent, scope, "state data, vector, memory map page", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_unit_name", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_unit_name", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isUnitDecl};
      checkArgumentType(baseExpr, f2, ONE, "unit decl", lineNumber, fileName, canContinue);
    } 
  }
  if(scopeParent->isVector()) {
    RefCSLOmVectorInfo vc = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo());
    if(vc->getModuleName().get()) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_UNIT_ALREADY_SET, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  if (scopeParent->isMemoryMapLocationPage()) {
    if(CSLOmMemoryMapPage::cast(scopeParent)->isUnitNameSet()) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_UNIT_ALREADY_SET, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }

  return canContinue;
}
void CSLOmCmdVSDSetModuleName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase name = params->at(0)->doEval()->getChild(ID);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          RefCSLOmExprLink expr = CSLOmExprLink::build(lineNumber, fileName, CSLOmIdentifier::cast(name)->getName());
          expr->addID(CSLOmIdentifier::cast(params->at(0)->doEval()->getChild(ID)));
          (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setModuleName(expr);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        RefCSLOmExprLink expr = CSLOmExprLink::build(lineNumber, fileName, CSLOmIdentifier::cast(name)->getName());
        expr->addID(CSLOmIdentifier::cast(params->at(0)->doEval()->getChild(ID)));
        (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setModuleName(expr);
      }
      break;
    case TYPE_MEMORY_MAP_PAGE:
      (CSLOmMemoryMapPage::cast(scopeParent))->setUnitName(params->at(0));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector, state data or memory map page");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdVSDSetInstanceName class
// ********************************************************************************

void CSLOmCmdVSDSetInstanceName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetInstanceName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, ONE, "set_instance_name", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_instance_name", lineNumber, fileName, canContinue)) {
      if(!params->at(0)->isExprLink()) {
        args.push_back(*CSLOmIdentifier::cast(params->at(0)->getChild(ID))->getName());
        args.push_back("expresion link");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    } 
  }

  return canContinue;
}
void CSLOmCmdVSDSetInstanceName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmStateDataInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setInstanceName(CSLOmExprLink::cast(params->at(0)));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        (CSLOmStateDataInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setInstanceName(CSLOmExprLink::cast(params->at(0)));
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdVSDSetDirection class
// ********************************************************************************
ECSLOmPortDirection CSLOmCmdVSDSetDirection::m_direction = DIR_UNDEFINED;
void CSLOmCmdVSDSetDirection::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDSetDirection::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  checkParamSize(params, ZERO, ZERO, "set_direction", lineNumber, fileName, canContinue);
  if(m_direction <= DIR_UNDEFINED || m_direction >= DIR_MAX) {
    args.push_back("set_direction");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    canContinue = FALSE;
  }

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isStateData, &CSLOmBase::isVector};
  checkParentType(f, ONE+ONE, scopeParent, scope, "state data, vector", lineNumber, fileName, canContinue);
  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isVector()) {
      RefCSLOmExprLink moduleName = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->getModuleName();
      //the vector does not have a unit associated (set_unit_name)
      if(!moduleName.get()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_UNIT_NOT_SET, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
      }
      RefCSLOmBase module = moduleName->doEval();
      ASSERT(module.get(), "module should not be null");
      if(module->isUnitDecl()) {
        if( !(module->isFifo() || module->isRegisterFile() || module->isRegister())) {
          RefTVec_RefCSLOmPortDecl ports = CSLOmUnitDecl::cast(module)->getPortListFull();
          if(!ports.get()) {
            args.push_back(*getScopeValue(module));
            addErr(NSWarningErr::DEE_CSC_DSGN_NO_PORTS, args, lineNumber, fileName);
            canContinue = FALSE;
          }
          else if(canContinue) {
            //check that the unit has ports with the direction the same as the direction to be set
            //the ports must not have attribute clock or reset
            ECSLOmPortDirection dir = getDirectionParam();
            TVec_RefCSLOmPortDecl_const_iter it;
            TBool hasPortsWithCorrectDirection = FALSE;
            for(it = ports->begin(); it < ports->end(); ++it) {
              if(CSLOmPortDecl::cast(*it)->getPortDirection() == dir) {
                ECSLOmSignalAttr attr = CSLOmPortDecl::cast(*it)->getAttr();
                if(!(attr == ATTR_RST || attr == ATTR_CLK)) {
                  hasPortsWithCorrectDirection = TRUE;
                }
              }
            }
            if(!hasPortsWithCorrectDirection) {
              args.push_back(*getScopeValue(module));
              addErr(NSWarningErr::DEE_CSC_DSGN_NO_PORTS_CORRECT_DIR, args, lineNumber, fileName);
              canContinue = FALSE;
            }
          }
        }
      }
      else {
        args.push_back(*CSLOmIdentifier::cast(module->getChild(ID))->getName());
        args.push_back("unit declaration");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
 
  

  return canContinue;
}

void CSLOmCmdVSDSetDirection::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector() || (*it)->isStateData()) {
          (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setDirection(m_direction);
        }
      }
      break;  
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector() || scopeParent->isStateData()) {
        CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setDirection(m_direction);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector or state data");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

void CSLOmCmdVSDSetDirection::setDirectionParam(ECSLOmPortDirection param) {
  m_direction = param;
}
ECSLOmPortDirection CSLOmCmdVSDSetDirection::getDirectionParam() {
  return m_direction;
}


// ********************************************************************************
// CSLOmCmdVSDExcludeOnly class
// ********************************************************************************
RefTVec_TInt CSLOmCmdVSDExcludeOnly::portPositions = RefTVec_TInt(new TVec_TInt);
void CSLOmCmdVSDExcludeOnly::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDExcludeOnly::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector};
  if(checkParentType(f, ONE, scopeParent, scope, "vector", lineNumber, fileName, canContinue)) {
    RefCSLOmVectorInfo vector = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo());
    if(vector->getDirection() == DIR_UNDEFINED) {
      canContinue = FALSE;
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_DIRECTION_NOT_SET, args, lineNumber, fileName);
      return FALSE;
    }
  }
  else {
    return FALSE;
  }

  //the command must receive at least one argument: a port, an interface or a list of ports/interfaces
  RefTVec_RefCSLOmExprLink allPorts = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getAllPorts();
  RefTVec_RefCSLOmPortDecl excludeOnlyPorts = RefTVec_RefCSLOmPortDecl(new TVec_RefCSLOmPortDecl);
  if(params->size() >= 1) {
    for(int i = 0; i < params->size(); i++) {
      RefCSLOmExpr expr = params->at(i);
      if(expr->isExprLink()) {
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(expr);
        //get the DUT (the unit set through the set_module_name command)
        RefCSLOmExprLink moduleName = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getModuleName();
        RefCSLOmBase unit = moduleName->doEval();
        if(unit->isUnitDecl()) {
          //check if the parameter has the dut as first hid
          RefString firstHid = exprLink->getHidName(0);
          RefString unitName = CSLOmIdentifier::cast(CSLOmUnitDecl::cast(unit)->getChild(ID))->getName();
          if((*firstHid).compare(*unitName) != 0) {
            //adding the name of the unit as the scope for the argument received
            exprLink->addScopeItem(unitName);
          }
        }
        
        RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
        newParams->push_back(exprLink);
        if(!checkArgumentForNull(newParams, i + ONE, "exclusion_list", lineNumber, fileName, canContinue)) {
          continue;
          //return FALSE;
        }
        RefCSLOmBase baseExpr = exprLink->doEval();      
        TIsPredicate f2[] = {&CSLOmBase::isPort, &CSLOmBase::isInterface};
        if(checkArgumentType(baseExpr, f2, 2, "port or interface", lineNumber, fileName, canContinue)) {
          //get all the ports from the argument received and put them in excludeOnlyPorts vector
          ECSLOmPortDirection dir = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getDirection();
          if(baseExpr->isPort()) {
            RefCSLOmPortDecl port = CSLOmPortDecl::cast(baseExpr);
            ECSLOmSignalAttr attr = port->getAttr();
            //the port has to have the required direction
            if(port->getPortDirection() != dir) {
              string dirString = "";
              if(dir == INPUT) {
                dirString = "input";
              }
              else if(dir == OUTPUT) {
                dirString = "output";
              }
              args.push_back(*getScopeValue(port));
              args.push_back(dirString);
              addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_DIR, args, lineNumber, fileName);
              canContinue = FALSE;
              return FALSE;
            }
            else if(attr == ATTR_CLK) {
              //ports with reset or clock attribute cannot be included
              args.push_back(*getScopeValue(port));
              addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
              canContinue = FALSE;
              return FALSE;
            }
            excludeOnlyPorts->push_back(port);
          }
          else if(baseExpr->isInterface()) {
            RefTVec_RefCSLOmPortDecl ifcPorts = CSLOmInterface::cast(baseExpr)->getPorts();
            TVec_RefCSLOmPortDecl_const_iter it;
            for(it = ifcPorts->begin(); it < ifcPorts->end(); ++it) {
              RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);
              ECSLOmSignalAttr attr = port->getAttr();
              //the port has to have the required direction
              if(port->getPortDirection() != dir) {
                args.push_back(*getScopeValue(port));
                addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_DIR, args, lineNumber, fileName);
                canContinue = FALSE;
              }
              else if(attr == ATTR_CLK) {
                //ports with reset or clock attribute cannot be included
                args.push_back(*getScopeValue(port));
                addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
                canContinue = FALSE;
              }
            }
            for(int j = 0; j < ifcPorts->size(); j++) {
              excludeOnlyPorts ->push_back(ifcPorts->at(j));
            }
          }
          else if(baseExpr->isList()) {
            RefTVec_RefCSLOmBase objs;
            TVec_RefCSLOmBase_const_iter it;
            objs = (CSLOmList::cast(scopeParent))->getObjects();
            for (it = objs->begin(); it < objs->end(); ++it) {
              if((*it)->isPort()) {
                RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);
                ECSLOmSignalAttr attr = port->getAttr();
                //the port has to have the required direction
                if(port->getPortDirection() != dir) {
                  string dirString = "";
                  if(dir == INPUT) {
                    dirString = "input";
                  }
                  else if(dir ==OUTPUT) {
                    dirString = "output";
                  }
                  args.push_back(*getScopeValue(port));
                  args.push_back(dirString);
                  addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_DIR, args, lineNumber, fileName);
                  canContinue = FALSE;
                  return FALSE;
                }
                else if(attr == ATTR_CLK) {
                  //ports with reset or clock attribute cannot be included
                  args.push_back(*getScopeValue(port));
                  addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
                  canContinue = FALSE;
                  return FALSE;
                }
                excludeOnlyPorts->push_back(CSLOmPortDecl::cast(*it));
              }    
              else if((*it)->isInterface()) {
                RefTVec_RefCSLOmPortDecl ports = CSLOmInterface::cast(baseExpr)->getPorts();
                for(TUInt i = 0; i < ports->size(); i++) {
                  excludeOnlyPorts->push_back(CSLOmPortDecl::cast(ports->at(i)));
                }
              }
            }
          }
        }
        
        //creating the vector of port positions
        //also checking that not all the ports with the current direction are excluded
        if(excludeOnlyPorts->size() == allPorts->size()) {
          addErr(NSWarningErr::DEE_CSC_PORT_NOT_EXCLUDE_ALL_PORTS, args, lineNumber, fileName);
        canContinue = FALSE;
        }
        else {
          TBool portNotFound = TRUE;
          for(TUInt i = 0; i < allPorts->size(); i++) {
            RefCSLOmPortDecl port = CSLOmPortDecl::cast(allPorts->at(i)->doEval());
            if((port->getAttr() != ATTR_CLK) && (port->getPortDirection() == CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getDirection())) {
              portNotFound = TRUE;
              for(TUInt j = 0; j < excludeOnlyPorts->size(); j++) {
                if(excludeOnlyPorts->at(j).get() == CSLOmPortDecl::cast(allPorts->at(i)->doEval()).get()) {
                  portNotFound = FALSE;
                  break;
                }
              }
              if(portNotFound) {
                //a port from the unit was not found in the exclusion list
                break;
              }
            }
          }
          if(portNotFound) {
            for(TUInt i = 0; i < excludeOnlyPorts->size(); i++) {
              for(TUInt j = 0; j < allPorts->size(); j++) {
                if(excludeOnlyPorts->at(i).get() == CSLOmPortDecl::cast(allPorts->at(j)->doEval()).get()) {
                  portPositions->push_back(j);
                  break;
                }
              }
            }
          }
          else {
            addErr(NSWarningErr::DEE_CSC_PORT_NOT_EXCLUDE_ALL_PORTS, args, lineNumber, fileName);
            canContinue = FALSE;
            return FALSE;
          }
        }
      }
    }
  }
  //there are no parameters received
  else {
    args.push_back("exclusion_list");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_WRONG_ARG_NR, args, lineNumber, fileName);
    canContinue = FALSE;
    return FALSE;
  }
   
  return canContinue;
}
void CSLOmCmdVSDExcludeOnly::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector()) {
          (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->excludePorts(portPositions);
        }
      }
      break;  
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector()) {
        CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->excludePorts(portPositions);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdVSDIncludeOnly class
// ********************************************************************************
RefTVec_TInt CSLOmCmdVSDIncludeOnly::portPositions = RefTVec_TInt(new TVec_TInt);
void CSLOmCmdVSDIncludeOnly::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdVSDIncludeOnly::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector};
  if(checkParentType(f, ONE, scopeParent, scope, "vector", lineNumber, fileName, canContinue)) {
    RefCSLOmVectorInfo vector = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo());
    if(vector->getDirection() == DIR_UNDEFINED) {
      canContinue = FALSE;
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_DIRECTION_NOT_SET, args, lineNumber, fileName);
      return FALSE;
    }
    //check that the command hasn't been already called
    if(vector->getIncludeOnlyUsed()) {
      canContinue = FALSE;
      args.push_back("include only");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      return FALSE;
    }
  }
  else { //parentScope is not of correct type
    return FALSE;
  }

  //the command can receive at least one argument: a port, an interface or a list of ports/interfaces
  if(params->size() > 0) {
    RefTVec_RefCSLOmExprLink allPorts;
    RefTVec_RefCSLOmPortDecl includeOnlyPorts = RefTVec_RefCSLOmPortDecl(new TVec_RefCSLOmPortDecl());;

    for(int i=0; i < params->size(); i++) {
      RefCSLOmExpr expr = params->at(i);
      if(expr->isExprLink()) {
        RefCSLOmExprLink exprLink = CSLOmExprLink::cast(expr);
        //get the DUT (the unit set through the set_module_name command)
        RefCSLOmExprLink moduleName = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getModuleName();
        RefCSLOmBase unit = moduleName->doEval();
        if(unit->isUnitDecl()) {
          RefString firstHid = exprLink->getHidName(0);
          RefString unitName = CSLOmIdentifier::cast(CSLOmUnitDecl::cast(unit)->getChild(ID))->getName();
          if((*firstHid).compare(*unitName) != 0) {
            //adding the name of the unit as the scope for the argument received
            exprLink->addScopeItem(unitName);
          }
        }
        else {
          //the DUT is not a unit(this should never happen)
          canContinue = FALSE;
          return FALSE;
        }
        RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
        newParams->push_back(exprLink);
        if(!checkArgumentForNull(newParams, i + ONE, "include_only", lineNumber, fileName, canContinue)) {
          continue;
          //return FALSE;
        }
        RefCSLOmBase baseExpr = exprLink->doEval();
        TIsPredicate f2[] = {&CSLOmBase::isPort, &CSLOmBase::isInterface};
        if(checkArgumentType(baseExpr, f2, 2, "port or interface", lineNumber, fileName, canContinue)) {
          allPorts = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getAllPorts();
          ECSLOmPortDirection dir = CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getDirection();
          
          if(baseExpr->isPort()) {
            RefCSLOmPortDecl port = CSLOmPortDecl::cast(baseExpr);
            ECSLOmSignalAttr attr = port->getAttr();
            //check that the port has the right direction
            if(port->getPortDirection() != dir) {
              string dirString = "";
              if(dir == INPUT) {
                dirString = "input";
              }
              else if(dir == OUTPUT) {
                dirString = "output";
              }
              args.push_back(*getScopeValue(port));
              args.push_back(dirString);
              addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_DIR, args, lineNumber, fileName);
              canContinue = FALSE;
              return canContinue;
            }
            else if(attr == ATTR_CLK) {
              //ports with reset or clock attribute cannot be included
              args.push_back(*getScopeValue(port));
              addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
              canContinue = FALSE;
              return FALSE;
            }
            includeOnlyPorts->push_back(CSLOmPortDecl::cast(baseExpr));
          }
          else if(baseExpr->isInterface()) {
            RefTVec_RefCSLOmPortDecl ifcPorts = CSLOmInterface::cast(baseExpr)->getPorts();
            TVec_RefCSLOmPortDecl_const_iter it;
            for(it = ifcPorts->begin(); it < ifcPorts->end(); ++it) {
              RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);
              ECSLOmSignalAttr attr = port->getAttr();
              //check that the port has the right direction
              if(port->getPortDirection() != dir) {
                string dirString = "";
                if(dir == INPUT) {
                  dirString = "input";
                }
                else if(dir ==OUTPUT) {
                  dirString = "output";
                }
                args.push_back(*getScopeValue(port));
                args.push_back(dirString);
                addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_DIR, args, lineNumber, fileName);
                canContinue = FALSE;
                return canContinue;
              }
              else if(attr == ATTR_CLK) {
                //ports with reset or clock attribute cannot be included
                args.push_back(*getScopeValue(port));
                addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
                canContinue = FALSE;
                return FALSE;
              }
            }
            for(int j = 0; j < ifcPorts->size(); j++) {
              includeOnlyPorts->push_back(ifcPorts->at(j));
            }
          }
          else if(baseExpr->isList()) {
            RefTVec_RefCSLOmBase objs;
            TVec_RefCSLOmBase_const_iter it;
            objs = (CSLOmList::cast(scopeParent))->getObjects();
            for (it = objs->begin(); it < objs->end(); ++it) {
              if((*it)->isPort()) {
                RefCSLOmPortDecl port = CSLOmPortDecl::cast(*it);
                ECSLOmSignalAttr attr = port->getAttr();
                //check that the port has the right direction
                if(port->getPortDirection() != dir) {
                                    string dirString = "";
                  if(dir == INPUT) {
                    dirString = "input";
                  }
                  else if(dir ==OUTPUT) {
                    dirString = "output";
                  }
                  args.push_back(*getScopeValue(port));
                  args.push_back(dirString);
                  addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_DIR, args, lineNumber, fileName);
                  canContinue = FALSE;
                  return canContinue;
                }
                else if(attr == ATTR_CLK) {
                  //ports with reset or clock attribute cannot be included
                  args.push_back(*getScopeValue(port));
                  addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
                  canContinue = FALSE;
                  return FALSE;
                }
                includeOnlyPorts->push_back(CSLOmPortDecl::cast(*it));
              }
              else if((*it)->isInterface()) {
                RefTVec_RefCSLOmPortDecl ports = CSLOmInterface::cast(baseExpr)->getPorts();
                for(TUInt i = 0; i < ports->size(); i++) {
                  includeOnlyPorts->push_back(CSLOmPortDecl::cast(ports->at(i)));
                }
              }
            }
          }
        }
        
        //reseting the port positions
        portPositions->clear();

        for(TUInt i = 0; i < includeOnlyPorts->size(); i++) {
          for(TUInt j = 0; j < allPorts->size(); j++) {
            if(includeOnlyPorts->at(i).get() == CSLOmPortDecl::cast(allPorts->at(j)->doEval()).get()) {
              portPositions->push_back(j);
              break;
            }
          }
        }
      }
    }
  }
  //no arguments received
  else {
    args.push_back("include_only");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_WRONG_ARG_NR, args, lineNumber, fileName);
    canContinue = FALSE;
    return FALSE;
  }
 
  return canContinue;
}
void CSLOmCmdVSDIncludeOnly::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isVector()) {
          (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->includeOnlyPorts(portPositions);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isVector()) {
        CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->includeOnlyPorts(portPositions);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("vector");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}



//CSLOmTBInfo stuff:

// ********************************************************************************
// CSLOmCmdTBAddLogic class
// ********************************************************************************

CSLOmTBInfo::ETBOperType CSLOmCmdTBAddLogic::m_operType=CSLOmTBInfo::TB_OPER_UNDEF;
CSLOmTBInfo::ETBWaveType CSLOmCmdTBAddLogic::m_waveType=CSLOmTBInfo::TB_WAVE_UNDEF;
CSLOmTBInfo::ETBTimeBase CSLOmCmdTBAddLogic::m_timeBase=CSLOmTBInfo::TB_TIMEBASE_UNDEF;
CSLOmTBInfo::ETBReportType CSLOmCmdTBAddLogic::m_reportType=CSLOmTBInfo::TB_REPORT_UNDEF;

void CSLOmCmdTBAddLogic::setOperType(CSLOmTBInfo::ETBOperType incOperType) {
  m_operType=incOperType;
}
void CSLOmCmdTBAddLogic::setWaveType(CSLOmTBInfo::ETBWaveType incWaveType) {
  m_waveType=incWaveType;
}
void CSLOmCmdTBAddLogic::setTimeBase(CSLOmTBInfo::ETBTimeBase incTimeBase) {
  m_timeBase=incTimeBase;
}
void CSLOmCmdTBAddLogic::setReportType(CSLOmTBInfo::ETBReportType incReportType) {
  m_reportType=incReportType;
}
   
CSLOmTBInfo::ETBOperType CSLOmCmdTBAddLogic::getOperType() {
  return m_operType;
}
CSLOmTBInfo::ETBWaveType CSLOmCmdTBAddLogic::getWaveType() {
  return m_waveType;
}
CSLOmTBInfo::ETBTimeBase CSLOmCmdTBAddLogic::getTimeBase() {
  return m_timeBase;
}
CSLOmTBInfo::ETBReportType CSLOmCmdTBAddLogic::getReportType() {
  return m_reportType;
}

void CSLOmCmdTBAddLogic::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdTBAddLogic::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isTestBench};
  checkParentType(f, ONE, scopeParent, scope, "testbench", lineNumber, fileName, canContinue);
  
  switch (getOperType()) {
    case CSLOmTBInfo::TB_OPER_SIM_TIMEOUT_COUNTER:
      if(checkParamSize(params, ONE, ONE, "add_logic", lineNumber, fileName, canContinue)) {
        if(checkArgumentForNull(params, 2, "add_logic", lineNumber, fileName, canContinue)) {
          RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
          TIsPredicate f2[] = {&CSLOmBase::isNumber};
          if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
            checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
          }
        } 
      }
      break;
    case CSLOmTBInfo::TB_OPER_STALL_GENERATION:
      if(checkParamSize(params, ONE, 100, "add_logic", lineNumber, fileName, canContinue)) {
        TIsPredicate f2[] = {&CSLOmBase::isExprLink};
        RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
        for(TUInt i = 0; i < params->size(); ++i) {
          checkArgumentType(params->at(i), f2, ONE, "add_logic", lineNumber, fileName, canContinue);
          newParams->pop_back();
          newParams->push_back(params->at(i));
          checkArgumentForNull(newParams, i + 2, "add_logic", lineNumber, fileName, canContinue);
        }
      }
      break;
    case CSLOmTBInfo::TB_OPER_CLOCK:
      if(checkParamSize(params, 2, 2, "add_logic", lineNumber, fileName, canContinue)) {
        if(checkArgumentForNull(params, 2, "add_logic", lineNumber, fileName, canContinue)) {
          RefCSLOmBase baseExpr1 = params->at(0)->doEval();
          RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE);
          TIsPredicate f2[] = {&CSLOmBase::isSignal};
          TIsPredicate f3[] = {&CSLOmBase::isNumber};
          if(checkArgumentType(baseExpr1, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
            //Part select not allowed
            RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
            if(exprLink->hasBitRange()) {
              args.push_back("add_logic");
              addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
              canContinue = FALSE;
            }
            RefCSLOmSignal sig = CSLOmSignal::cast(baseExpr1);
            if(sig->getSignalAttr() != ATTR_CLK) {
              args.push_back(*getScopeValue(sig));
              args.push_back("signal with clock attribute");
              addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
              canContinue = FALSE;
            }
            if(sig->getSignalType() != SIGNAL_REG) {
              args.push_back(*getScopeValue(sig));
              args.push_back("reg signal");
              addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
              canContinue = FALSE;
            }
          }
          if(checkArgumentType(baseExpr2, f3, ONE, "number", lineNumber, fileName, canContinue)) {
            checkNumber(baseExpr2, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
          }
        }
      }
      break;
    case CSLOmTBInfo::TB_OPER_GENERATE_WAVES:
      if(checkParamSize(params, ONE, ONE, "add_logic", lineNumber, fileName, canContinue)) {
        //the first parameter must be a string
        RefCSLOmBase baseExpr = params->at(0)->doEval();
        TIsPredicate f[] = {&CSLOmBase::isString};
        if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
          RefCSLOmString str = CSLOmString::cast(baseExpr);
          if(str->isEmpty() || str->hasWhiteSpace()) {
            addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
            canContinue = FALSE;
          }
        }

        //the rest of the parameters, if they exist, must be instances
        /*   RefCSLOmExpr expr = params->at(0);
        for(TUInt i = 1; i < params->size();++i) {
          expr = params->at(i);
          RefTVec_RefCSLOmExpr expr1 = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
          expr1->push_back(expr);
          if(checkArgumentForNull(expr1, i + ONE, "add_logic", lineNumber, fileName, canContinue)) {
            RefCSLOmBase baseExpr = expr->doEval();
            if(!baseExpr->isInstance()) {
              args.push_back(*getScopeValue(baseExpr));
              args.push_back("instance");
              addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
              canContinue = FALSE;
            }
          }
          }*/
      } 
      break;
    case CSLOmTBInfo::TB_OPER_GENERATE_REPORT:
      if(checkParamSize(params, ZERO, ONE, "add_logic", lineNumber, fileName, canContinue)) {
        if(params->size() == ONE) {
          if(getReportType() < CSLOmTBInfo::TB_REPORT_COLUMS || getReportType() > CSLOmTBInfo::TB_REPORT_ROWS) {
            //TODO: add correct error message
            args.push_back("add_logic");
            addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
            canContinue = FALSE;
          }
        }
      }
      break;
    default:
      canContinue = FALSE;
      break;
  }

   

  return canContinue;
}
void CSLOmCmdTBAddLogic::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmExprLink outgoingExpr = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink());
  RefTVec_RefCSLOmExprLink outgoingExpr2 = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
  
  switch (getOperType()) {
    case CSLOmTBInfo::TB_OPER_SIM_TIMEOUT_COUNTER:
      (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setSimTimeoutCounter(CSLOmExpr::cast(params->at(0)));
      break;
    case CSLOmTBInfo::TB_OPER_STALL_GENERATION:
      for(TUInt i=0; i<params->size();++i) {
        outgoingExpr->push_back(CSLOmExprLink::cast(params->at(i)));
      } 
      (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setStallGeneration(outgoingExpr);
      break;
    case CSLOmTBInfo::TB_OPER_CLOCK:    
      (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setClock(CSLOmSignal::cast(params->at(0)->doEval()),
                                                                                     CSLOmExpr::cast(params->at(1)->doEval()),getTimeBase());      
      break;
    case CSLOmTBInfo::TB_OPER_GENERATE_WAVES:
      for(TUInt i = 1; i < params->size(); ++i) {
        outgoingExpr->push_back(CSLOmExprLink::cast(params->at(i)));
      }
      if(params->size()==1) {
        (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setGenerateWaves(CSLOmString::cast(params->at(0)->doEval())->getValue(),getWaveType());
      }
      else{
        (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setGenerateWaves(CSLOmString::cast(params->at(0)->doEval())->getValue(),getWaveType(),
                                                                                               outgoingExpr2);
      }
      break;
    case CSLOmTBInfo::TB_OPER_GENERATE_REPORT:
      (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setGenerateReport(getReportType());
      break;
    default:
      break;
  }
}

// ********************************************************************************
// CSLOmCmdTBAddVerilogFilename class
// ********************************************************************************
void CSLOmCmdTBAddVerilogFilename::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdTBAddVerilogFilename::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //only 1 param = string
  checkParamSize(params, ONE, ONE,"add_verilog_file_name", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isTestBench};
  checkParentType(f, ONE, scopeParent, scope, "testbench", lineNumber, fileName, canContinue);
 
  if(checkArgumentForNotNull(params, params->size(), "add_verilog_file_name", scopeParent, lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    TIsPredicate f[] = {&CSLOmBase::isString};
    if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
      RefCSLOmString str = CSLOmString::cast(baseExpr);
      if(str->isEmpty() || str->hasWhiteSpace()) {
        addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}
void CSLOmCmdTBAddVerilogFilename::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isTestBench()) {
          (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo()))->setVerilogFilename(CSLOmString::cast(params->at(0))->getValue());
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isTestBench()) {
        (CSLOmTBInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setVerilogFilename(CSLOmString::cast(params->at(0))->getValue());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("test bench");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdTBSetInstanceName class
// ********************************************************************************
void CSLOmCmdTBSetInstanceName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdTBSetInstanceName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isTestBench};
  checkParentType(f, ONE, scopeParent, scope, "test bench", lineNumber, fileName, canContinue);
 
  return canContinue;
}

void CSLOmCmdTBSetInstanceName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if((*it)->isTestBench()) {

        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isTestBench()) {

      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("testbench");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}



// ********************************************************************************
// CSLOmCmdAddLogic class
// ********************************************************************************
CSLOmRegDeclInfo::ERegDeclOperations CSLOmCmdAddLogic::m_regOperType = CSLOmRegDeclInfo::REG_OPER_UNDEF;
CSLOmRegDeclInfo::ERegDeclCntDir CSLOmCmdAddLogic::m_cntDir = CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UNDEF;
void CSLOmCmdAddLogic::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdAddLogic::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isRegister};
  if(!checkParentType(f, ONE, scopeParent, scope, "register", lineNumber, fileName, canContinue)) {
    return FALSE;
  }
  RefCSLOmRegDeclInfo reg = CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo());
  switch(getRegOperType()) {
    case CSLOmRegDeclInfo::REG_OPER_NEG_OUTPUT:
      checkParamSize(params, ZERO, ZERO,"add_logic", lineNumber, fileName, canContinue);
      break;
    case CSLOmRegDeclInfo::REG_OPER_SERIAL_INPUT:
      checkParamSize(params, ZERO, ZERO, "add_logic", lineNumber, fileName, canContinue);
      break;
    case CSLOmRegDeclInfo::REG_OPER_SERIAL_OUTPUT:
      checkParamSize(params, ZERO, ZERO, "add_logic", lineNumber, fileName, canContinue);
      break;
    case CSLOmRegDeclInfo::REG_OPER_GRAY_OUTPUT:
      checkParamSize(params, ZERO, ZERO, "add_logic", lineNumber, fileName, canContinue);
      if(CSLOmRegDeclInfo::cast((CSLOmUnitDecl::cast(parent)->getUnitInfo()))->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_COUNTER) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("counter");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_REG_RESET:
      checkParamSize(params, ZERO, ZERO, "add_logic", lineNumber, fileName, canContinue);
      break;
    case CSLOmRegDeclInfo::REG_OPER_REG_SET:
      checkParamSize(params, ZERO, ZERO, "add_logic", lineNumber, fileName, canContinue);
      break;
    case CSLOmRegDeclInfo::REG_OPER_LOAD:
      if(checkParamSize(params, ZERO, ZERO, "add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_COUNTER) {
          args.push_back(*getScopeValue(parent));
          args.push_back("counter");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_INIT:
      if(checkParamSize(params, ZERO, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_REGISTER) {
          args.push_back(*getScopeValue(parent));
          args.push_back("register");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        if(params->size() == ONE) {
          /*   RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
          TIsPredicate f2[] = {&CSLOmBase::isNumber};
          if(checkArgumentType(baseExpr, f2, 1, "number", lineNumber, fileName, canContinue)) {
            checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
            } */
        }
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_SET:
      if(checkParamSize(params, ZERO, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_REGISTER) {
          args.push_back(*getScopeValue(parent));
          args.push_back("counter");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        if(params->size() == ONE) {
          /*   RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
          TIsPredicate f2[] = {&CSLOmBase::isNumber};
          if(checkArgumentType(baseExpr, f2, 1, "number", lineNumber, fileName, canContinue)) {
            checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
            } */
        }
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_RESET:
      if(checkParamSize(params, ZERO, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->isSetResetValue()) {
          args.push_back("reset value");
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        if(params->size() == ONE) {
          /*  RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
          TIsPredicate f2[] = {&CSLOmBase::isNumber};
          if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
            checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
            } */
        }
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_CLEAR:
      if(checkParamSize(params, ZERO, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_REGISTER) {
          args.push_back(*getScopeValue(parent));
          args.push_back("register");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        if(params->size() == ONE) {
          /*    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
          TIsPredicate f2[] = {&CSLOmBase::isNumber};
          if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
            checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
            }*/ 
        }
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_COUNT_AMMOUNT:
      if(checkParamSize(params, ONE, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        /* RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
        TIsPredicate f2[] = {&CSLOmBase::isNumber};
        //the count amount cannot be 0 nor negative
        if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {*/
          if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_COUNTER) {
            args.push_back(*getScopeValue(parent));
            args.push_back("counter");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
            canContinue = FALSE;
            }
          if(reg->isSetCountAmmout()) {
            args.push_back("count amount");
            args.push_back(*getScopeValue(scopeParent));
            addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
            canContinue = FALSE;
            // }
          // checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
        } 
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_STOP_VALUE:
      if(checkParamSize(params, ONE, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_COUNTER) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("counter");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        /*  RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
        TIsPredicate f2[] = {&CSLOmBase::isNumber};
        if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
          checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue);
          } */
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_START_VALUE:
      if(checkParamSize(params, ONE, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_COUNTER) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("counter");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        if(reg->isSetStartValue()) {
          args.push_back("start value");
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        RefCSLOmBase baseExpr = params->at(0);
        /*       TIsPredicate f2[] = {&CSLOmBase::isNumber};
        if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
          if(checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue)) {
            if(reg->isSetEndValue()) {
              RefCSLOmNumber start = CSLOmNumber::cast(baseExpr);
              RefCSLOmNumber end = reg->getEndValue();
              if((start->getValue() < end->getValue()) && (reg->getCntDir()!=CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP)) {
                args.push_back("bigger");
                addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, lineNumber, fileName);
                canContinue = FALSE;
              }
              else if((start->getValue() > end->getValue()) && (reg->getCntDir()!=CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN)) {
                args.push_back("smaller");
                addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, lineNumber, fileName);
                canContinue = FALSE;
              }
            }
          }
          }*/ 
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_END_VALUE:
      if(checkParamSize(params, ONE, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType() != NSCSLOm::CSLOmRegDeclInfo::REG_DECL_COUNTER) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("counter");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        if(reg->isSetEndValue()) {
          args.push_back("end value");
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        RefCSLOmBase baseExpr = params->at(0);
        TIsPredicate f2[] = {&CSLOmBase::isNumber};
        /*        if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
          if(checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_logic", lineNumber, fileName, canContinue)) {
            if(reg->isSetStartValue()) {
              RefCSLOmNumber start = reg->getStartValue();
              RefCSLOmNumber end = CSLOmNumber::cast(baseExpr);
              if((start->getValue() < end->getValue()) && (reg->getCntDir() != CSLOmRegDeclInfo::REG_DECL_CNT_DIR_UP)) {
                args.push_back("bigger");
                addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, lineNumber, fileName);
                canContinue = FALSE;
              }
              else if((start->getValue() > end->getValue()) && (reg->getCntDir() != CSLOmRegDeclInfo::REG_DECL_CNT_DIR_DOWN)) {
                args.push_back("smaller");
                addErr(NSWarningErr::CSE_CSC_FUNC_START_END_VALUES, args, lineNumber, fileName);
                canContinue = FALSE;
              }
            }
          }
          }*/ 
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_DIR_CONTROL:
      if(checkParamSize(params, ONE, ONE,"add_logic", lineNumber, fileName, canContinue)) {
        if(reg->getType()!=NSCSLOm::CSLOmRegDeclInfo::REG_DECL_COUNTER) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("counter");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        RefCSLOmBase baseExpr = params->at(0)->doEval();
        TIsPredicate f2[] = {&CSLOmBase::isSignal};
        if(checkArgumentType(baseExpr, f2, ONE, "signal", lineNumber, fileName, canContinue)) {
          //Part select not allowed
          RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
          if(exprLink->hasBitRange()) {
            args.push_back("add_logic");
            addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
            canContinue = FALSE;
          }
        }
        if(reg->isSetDirControl()) {
          args.push_back("direction control");
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
      break;
    case CSLOmRegDeclInfo::REG_OPER_COUNT_DIRECTION:
      if(reg->getType() != CSLOmRegDeclInfo::REG_DECL_COUNTER) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("counter");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_INCORRECT_REGISTER_TYPE, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if(reg->getAlreadySetCntDir()) {
        args.push_back("count direction");
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      break;
    default:
      ASSERT(FAIL, "no such enum");
      break;
  }

  return canContinue;
}
void CSLOmCmdAddLogic::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr outgoingExpr;

  switch(getRegOperType()) {
    case CSLOmRegDeclInfo::REG_OPER_NEG_OUTPUT:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_SERIAL_INPUT:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_SERIAL_OUTPUT:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_REG_RESET:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_REG_SET:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_LOAD:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_GRAY_OUTPUT:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_INIT:
      if(params->size() == ONE) {
        outgoingExpr = CSLOmExpr::cast(params->at(0));
      }
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_SET:
      if(params->size() == ONE) {
        outgoingExpr = CSLOmExpr::cast(params->at(0));
      }
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_RESET:
      if(params->size() == ONE) {
        outgoingExpr = CSLOmExpr::cast(params->at(0));
      }
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_CLEAR:
      if(params->size() == ONE) {
        outgoingExpr = CSLOmExpr::cast(params->at(0));
      }
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_COUNT_AMMOUNT:
      outgoingExpr = CSLOmExpr::cast(params->at(0));
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_STOP_VALUE:
      outgoingExpr = CSLOmExpr::cast(params->at(0));
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_START_VALUE:
      outgoingExpr = CSLOmExpr::cast(params->at(0));
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_END_VALUE:
      outgoingExpr = CSLOmExpr::cast(params->at(0));
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_DIR_CONTROL:
      outgoingExpr = CSLOmExpr::cast(params->at(0)->doEval());
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addLogic(getRegOperType(), outgoingExpr);
      break;
    case CSLOmRegDeclInfo::REG_OPER_COUNT_DIRECTION:
      CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setCntDir(getRegCntDir());
      break;
    case CSLOmRegDeclInfo::REG_OPER_UNDEF:
    case CSLOmRegDeclInfo::REG_OPER_MAX:
    default: ASSERT(FAIL, "THIS SHOULD NOT HAPPEN"); break;
  }
}

void CSLOmCmdAddLogic::setRegOperType(CSLOmRegDeclInfo::ERegDeclOperations operType) {
  m_regOperType = operType;
}
CSLOmRegDeclInfo::ERegDeclOperations CSLOmCmdAddLogic::getRegOperType() {
  return m_regOperType;
}
void CSLOmCmdAddLogic::setRegCntDir(CSLOmRegDeclInfo::ERegDeclCntDir cnt_dir) {
  m_cntDir = cnt_dir;
}
CSLOmRegDeclInfo::ERegDeclCntDir CSLOmCmdAddLogic::getRegCntDir() {
  return m_cntDir;
}




///
//Register File
///


// ********************************************************************************
// CSLOmCmdRFSetConstValue class
// ********************************************************************************
void CSLOmCmdRFSetConstValue::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdRFSetConstValue::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //only 1 param = number
  if(checkParamSize(params, ONE, ONE, "set_const_value", lineNumber, fileName, canContinue)) {
    RefCSLOmExpr expr = params->at(0);
    if(checkArgumentForNull(params, ONE, "set_const_value", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = expr->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue);
    }
  }
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isRegisterFile};
  if(checkParentType(f, ONE, scopeParent, scope, "register file", lineNumber, fileName, canContinue)) {
    RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
    TVec_RefCSLOmBase_const_iter it;
    if(scopeParent->isList()) {
      objs = CSLOmList::cast(scopeParent)->getObjects();
    }
    else {
      objs->push_back(scopeParent);
    }
    for(it = objs->begin(); it < objs->end(); ++it) {
      if((*it)->isRegisterFile()) {
        RefCSLOmRegisterFileInfo reg = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo());
        if(reg->getSetConstValue()) {
          args.push_back("const value");
          args.push_back(*getScopeValue(*it));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }
 
  return canContinue;
}
void CSLOmCmdRFSetConstValue::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr constValue = CSLOmExpr::cast(params->at(0)->doEval());
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setConstValue(constValue);
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setConstValue(constValue);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("register file");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}



// ********************************************************************************
// CSLOmCmdRFSetField class
// ********************************************************************************
void CSLOmCmdRFSetField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}
TBool CSLOmCmdRFSetField::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //the command receives two arguments: a field and a number
  if(checkParamSize(params, ONE+ONE, ONE+ONE,"set_field", lineNumber, fileName, canContinue)) {
    RefCSLOmExpr expr = params->at(0);
    RefCSLOmExpr expr1 = params->at(1);
    if(checkArgumentForNull(params, ONE, "set_field", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = expr->doEval();
      RefCSLOmBase baseExpr1 = expr1->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isField};
      checkArgumentType(baseExpr, f2, ONE, "field", lineNumber, fileName, canContinue);
      TIsPredicate f3[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr1, f3, ONE, "number", lineNumber, fileName, canContinue)) {
        RefCSLOmNumber no = CSLOmNumber::cast(baseExpr1);
        checkNumber(no, NO_DO_NOT_CHECK_VALUE, ZERO, NO_DO_NOT_CHECK_XZ, TRUE, "set_field", lineNumber, fileName, canContinue);
      }
    }
  }
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isRegisterFile};
  checkParentType(f, ONE, scopeParent, scope, "register file", lineNumber, fileName, canContinue);
 
  return canContinue;
}
void CSLOmCmdRFSetField::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmField field = CSLOmField::cast(params->at(0)->doEval());
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(1)->doEval(TRUE));
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setField(field, no);
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setField(field, no);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("register file");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}





// ********************************************************************************
// CSLOmCmdRFSetGroupName class
// ********************************************************************************
void CSLOmCmdRFSetGroupName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}
TBool CSLOmCmdRFSetGroupName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isRegisterFile};
  if(checkParentType(f, ONE, scopeParent, scope, "register file", lineNumber, fileName, canContinue)) {
    RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
    TVec_RefCSLOmBase_const_iter it;
    if(scopeParent->isList()) {
      objs = CSLOmList::cast(scopeParent)->getObjects();
    }
    else {
      objs->push_back(scopeParent);
    }

    for(it = objs->begin(); it < objs->end(); ++it) {
      //check that the register file hasn't its group name already set
      if((*it)->isRegisterFile()) {
        RefCSLOmRegisterFileInfo reg = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo());
        if(reg->getSetGroupName()) {
          args.push_back("group name");
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_ATTR_ALREADY_SET, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }
 
  //only 1 param = string
  if(checkParamSize(params, ONE, ONE,"set_group_name", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNotNull(params, params->size(), "set_group_name", scopeParent, lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f[] = {&CSLOmBase::isString};
      if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
        RefCSLOmString str = CSLOmString::cast(baseExpr);
        if(str->isEmpty() || str->hasWhiteSpace()) {
          addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }

  return canContinue;
  }

void CSLOmCmdRFSetGroupName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefString name = CSLOmString::cast(params->at(0)->doEval())->getValue();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setGroupName(name);
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setGroupName(name);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("register file");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}




 // ********************************************************************************
// CSLOmCmdSetPortName class
// ********************************************************************************
std::string CSLOmCmdSetPortName::m_message = "";
EPortNames CSLOmCmdSetPortName::m_portName = PN_UNDEFINED;
void CSLOmCmdSetPortName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}
TBool CSLOmCmdSetPortName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isRegisterFile, &CSLOmBase::isFifo};
  checkParentType(f, ONE+ONE, scopeParent, scope, "register file or fifo", lineNumber, fileName, canContinue);
  
  //only 1 param of type string
  if(checkParamSize(params, ONE, ONE, getMessage(), lineNumber, fileName, canContinue)) {
    if(checkArgumentForNotNull(params, params->size(), getMessage(), scopeParent, lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f[] = {&CSLOmBase::isString};
      if(checkArgumentType(baseExpr, f, ONE, "string", lineNumber, fileName, canContinue)) {
        RefCSLOmString str = CSLOmString::cast(baseExpr);
        if(str->isEmpty() || str->hasWhiteSpace()) {
          addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }
  //since we use both the scopeParent and the argument in the next checks, if one of them is not correct, the function is stopped
  if(!canContinue) {
    return canContinue;
  }

  //if another port's name has been set, check that its name is different from the name to be set for this port
  RefString name = CSLOmString::cast(params->at(0)->doEval())->getValue();
  TBool isRF = TRUE;
  RefCSLOmPortDecl port;
  EPortNames portName = getPortName();
  RefTMap_ERFPortNames_RefCSLOmPortDecl portMap = RefTMap_ERFPortNames_RefCSLOmPortDecl(new TMap_ERFPortNames_RefCSLOmPortDecl());
  TMap_ERFPortNames_RefCSLOmPortDecl::iterator it;
  RefTMap_EFifoPortNames_RefCSLOmPortDecl portMap2 = RefTMap_EFifoPortNames_RefCSLOmPortDecl(new TMap_EFifoPortNames_RefCSLOmPortDecl());
  TMap_EFifoPortNames_RefCSLOmPortDecl::iterator it2;
  if(scopeParent->isRegisterFile()) {
    portMap = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getPortMap();
  }
  else {
    isRF = FALSE;
    portMap2 = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getPortMap();
  }
  
  if(PN_CLOCK != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_CLOCK);
      port = it->second;
      RefString clockName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*clockName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else {
      //if the fifo is asynch, it won't have a clock port
      if(CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getSetAsynch()) {
        it2 = portMap2->find(FIFO_PN_CLOCK);
        port = it2->second;
        RefString clockName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
        if(*clockName == *name) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back(m_message);
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }

  }
  if(PN_RESET != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_RESET);
      port = it->second;
      RefString resetName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*resetName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else {
      if(CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getAddPortSynchReset()) {
        it2 = portMap2->find(FIFO_PN_SYNCH_RESET);
        port = it2->second;
        RefString resetName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
        if(*resetName == *name) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back(m_message);
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }
  if(PN_WR_ADDR != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_WR_ADDR);
      port = it->second;
      RefString wrAddrName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*wrAddrName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  if(PN_RD_ADDR != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_RD_ADDR);
      port = it->second;
      RefString rdAddrName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*rdAddrName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  if(PN_DATA_IN != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_DATA_IN);
      port = it->second;
    }
    else {
      it2 = portMap2->find(FIFO_PN_DATA_IN);
      port = it2->second;
    }
    RefString dataInName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
    if(*dataInName == *name) {
      args.push_back(*getScopeValue(scopeParent));
      args.push_back(m_message);
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  if(PN_DATA_OUT != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_DATA_OUT);
      port = it->second;
    }
    else {
      it2 = portMap2->find(FIFO_PN_DATA_OUT);
      port = it2->second;
    }
    RefString rdDataName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
    if(*rdDataName == *name) {
      args.push_back(*getScopeValue(scopeParent));
      args.push_back(m_message);
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  if(PN_RD_EN != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_RD_EN);
      port = it->second;
      RefString rdEnName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*rdEnName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  if(PN_WR_EN != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_WR_EN);
      port = it->second;
      RefString wrEnName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*wrEnName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  if(PN_VALID != portName) {
    if(isRF) {
      it = portMap->find(RF_PN_VALID);
      port = it->second;  
    }
    else {
      it2 = portMap2->find(FIFO_PN_VALID);
      port = it2->second;
    }
    RefString validName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
    if(*validName == *name) {
      args.push_back(*getScopeValue(scopeParent));
      args.push_back(m_message);
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  if(PN_WR_CLOCK != portName) {
    //only an asynch fifo has this kind of port
    if(!isRF) {
      if(CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getAddPortWrClock()) {
        it2 = portMap2->find(FIFO_PN_WR_CLOCK);
        port = it2->second;
        RefString wrClockName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
        if(*wrClockName == *name) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back(m_message);
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }
  if(PN_RD_CLOCK != portName) {
    //only a asynch fifo has this kind of port
    if(!isRF) {
      if(CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getAddPortRdClock()) {
        it2 = portMap2->find(FIFO_PN_RD_CLOCK);
        port = it2->second;
        RefString rdClockName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
        if(*rdClockName == *name) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("rd_clock");
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }
  if(PN_PUSH != portName) {
    if(!isRF) {
      it2 = portMap2->find(FIFO_PN_PUSH);
      port = it2->second;
      RefString pushName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*pushName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  if(PN_POP != portName) {
    if(!isRF) {
      it2 = portMap2->find(FIFO_PN_POP);
      port = it2->second;
      RefString popName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*popName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  if(PN_FULL != portName) {
    if(!isRF) {
      it2 = portMap2->find(FIFO_PN_FULL);
      port = it2->second;
      RefString fullName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*fullName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  if(PN_EMPTY != portName) {
    if(!isRF) {
      it2 = portMap2->find(FIFO_PN_EMPTY);
      port = it2->second;
      RefString emptyName = CSLOmIdentifier::cast(port->getChild(ID))->getName();
      if(*emptyName == *name) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back(m_message);
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DUP_PORT_NAME, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  //these ports are not available for both types of fifo
  if(scopeParent->isFifo()) {
    switch(portName) {
      case PN_WR_CLOCK:
        if(!CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getAddPortWrClock()) {
          args.push_back("wr_clock");
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_NO_SUCH_PORT, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        break;
      case PN_RD_CLOCK:
        if(!CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getAddPortRdClock()) {
          args.push_back("rd_clock");
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_NO_SUCH_PORT, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        break;
      case PN_VALID:        break;
        //in case there is a async fifo, it will not have a clock port
      case PN_CLOCK:
        if(CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getSetAsynch()) {
          args.push_back("clock");          
          args.push_back(*getScopeValue(scopeParent));
          addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_NO_SUCH_PORT, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        break;
      case PN_RESET:
      case PN_DATA_IN:
      case PN_DATA_OUT:
      case PN_PUSH:
      case PN_POP:
      case PN_FULL:
      case PN_EMPTY:
      case PN_RD_ADDR:
      case PN_WR_ADDR:
      case PN_RD_EN:
      case PN_WR_EN:
      case PN_UNDEFINED: break;
      default: ASSERT(FAIL, "THIS SHOULD NOT HAPPEN"); break;
    }
  }


  return canContinue;
}
void CSLOmCmdSetPortName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefString name = CSLOmString::cast(params->at(0)->doEval())->getValue();
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  
  switch (scopeParent->getType()) {
    case TYPE_DECL_UNIT:
      if(scopeParent->isRegisterFile()) {
        switch(getPortName()) {
          case PN_RESET:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortReset(name);
            break;
          case PN_CLOCK:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortClock(name);          
            break;
          case PN_WR_ADDR:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortWrAddr(name);
            break;
          case PN_RD_ADDR:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortRdAddr(name);
            break;
          case PN_WR_EN:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortWrEn(name);
            break;
          case PN_RD_EN:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortRdEn(name);
            break;
          case PN_VALID:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortValid(name);
            break;
          case PN_DATA_IN:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortDataIn(name);
            break;
          case PN_DATA_OUT:
            CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortDataOut(name);
            break;
          default:
            //TODO: register file does not support setting name for this kind of port
            cslomHasErrors = TRUE;
            break;
        }
      }
      else if(scopeParent->isFifo()) {
        switch(getPortName()) {
          case PN_CLOCK:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortClock(name);          
            break;
          case PN_RD_CLOCK:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortRdClock(name);
            break;
          case PN_WR_CLOCK:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortWrClock(name);
            break;
          case PN_VALID:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortValid(name);
            break;
          case PN_DATA_IN:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortDataIn(name);
            break;
          case PN_DATA_OUT:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortDataOut(name);
            break;
          case PN_PUSH:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortPush(name);
            break;
          case PN_POP:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortPop(name);
            break;
          case PN_FULL:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortFull(name);
            break;
          case PN_EMPTY:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortEmpty(name);
            break;
          case PN_RESET:
            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortSynchReset(name);
            break;
          default:
            //TODO: fifo does not support setting name for this kind of port
            cslomHasErrors = TRUE;
            break;
        }
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("register file or FIFO");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("register file or FIFO");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
      }
  setPort(PN_UNDEFINED);
}
void CSLOmCmdSetPortName::setPort(EPortNames name) {
  m_portName = name;
  switch(name) {
    case PN_RESET:
      m_message = "set_reset_name";
      break;
    case PN_CLOCK:
      m_message = "set_clock_name";
      break;
    case PN_WR_ADDR:
      m_message = "set_wr_addr_name";
      break;
    case PN_RD_ADDR:
      m_message = "set_rd_addr_name";
      break;
    case PN_WR_EN:
      m_message = "set_wr_en_name";
      break;
    case PN_RD_EN:
      m_message = "set_rd_en_name";
      break;
    case PN_VALID:
      m_message = "set_valid_name";
      break;
    case PN_DATA_IN:
      m_message = "set_wr_data_name";
      break;
    case PN_DATA_OUT:
      m_message = "set_rd_data_name";
      break;
    case PN_WR_CLOCK:
      m_message = "set_wr_clock_name";
      break;
    case PN_RD_CLOCK:
      m_message = "set_rd_clock_name";
      break;
    case PN_PUSH:
      m_message = "set_push_name";
      break;
    case PN_POP:
      m_message = "set_pop_name";
      break;
    case PN_FULL:
      m_message = "set_full_name";
      break;
    case PN_EMPTY:
      m_message = "set_empty_name";
      break;
    default:
      m_message = "";
      break;
      }
}
EPortNames CSLOmCmdSetPortName::getPortName() {
  return m_portName;
}
std::string CSLOmCmdSetPortName::getMessage() {
  return m_message;
}




} //namespace NSCSLOm
                                                  
