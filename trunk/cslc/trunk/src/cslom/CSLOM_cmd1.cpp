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
// Unpublished rights reserved under the Copyright Laws of the United States.
//----------------------------------------------------------------------

// Author BogdanZ && AndreiS && MihaelaP

#include "CSLOM.h"
#include "CSLOM_cmd.h"
#include <algorithm>
#include <iterator>
#include <vector>
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../support/ErrorAPI.h"
#include <string>

/*
 *a flag that becomes true if at least one error was encoutered. if the flag is true, the compiler will stop, that is, the adaptor will not be called.
 */
extern TBool cslomHasErrors;

namespace NSCSLOm {



/*
 *decoder stuff
 */
// ********************************************************************************
// CSLOmCmdDecSetDecoder class
// ********************************************************************************

void CSLOmCmdDecSetDecoder::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

/*
 *General order of checks done in almost every class:
 *First of all we have some member functions in CSLOmSetCommand that are used to do redundant checks. Almost all of them return TBool and throw errors if needed.
 *Another thing you must be aware of is that in many cases, theese member functions cannot be used for lists. In the case of lists, cheks need to be done "by hand".  
 *As you may have noticed in CSLOM_cmd.h, in the CSLOmSetCommand class the factoring functions have comments added to them, explaining what they do.
 *The first 2 classes of this file will be commented thoroughly as follows.
 */
TBool CSLOmCmdDecSetDecoder::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  //This is a flag that is used to signal if something is not right, besides throwing the error for the end user.
  //Every check method must return canContinue, and if that is false, execute is no longer called. Every build function from cmd is done that way.
  TBool canContinue = TRUE; 

  //Getting the scope parent of the command (the object that called this command). In case the scopeParent is null (this can happen when the scopeParent is the design)
  //all the other checks will not be made (because there are casts made and almost all of them use scopeParent) and the function will return FALSE.
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName,canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  //Checking the type of the scopeParent. f is an array of CSLOmBase::isX functions that is given as argument to checkParentType function.
  //There is no need to stop the other checks (arguments can still be checked).
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isField};
  checkParentType(f, PARENT_TYPE_SIZE_DECSETDECODER, scopeParent, scope, "signal or field", lineNumber, fileName, canContinue);
  
  //For each posible type the scopeParent can have, there must be made the right checks. They differ from class to class, and from type to type.
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
      if(CSLOmSignal::cast(*it)->isDecoder()) {
        args.push_back(*CSLOmSignal::cast(*it)->getName());
        addErr(NSWarningErr::CSE_CSC_SIG_CSE_CSC_SIG_ALREADY_DECODER, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isField()) {
      if(CSLOmField::cast(*it)->isDecoder()) {
        args.push_back(*CSLOmField::cast(*it)->getName());
        addErr(NSWarningErr::CSE_CSC_SIG_CSE_CSC_SIG_ALREADY_DECODER, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  
  // This command receives 0, 1 or 2 parameters. The function checkParamSize verifies that the number of parameters is the correct one. The two values (upper and lower) are 
  // declared in src/support/ConstInts.h.
  // The first parameter is the name of the output, and the 2nd one is the name of the unit(module).
  // If the correct number of arguments has been received, the parameters are checked if they are (not) null. In this case, both must be null meaning they were not 
  //declared previously. 
  if(checkParamSize(params, PARAM_SIZE_CMDDECSETDECODER_LOWER, PARAM_SIZE_CMDDECSETDECODER_UPPER, "gen_decoder", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNotNull(params,params->size(),"gen_decoder",scopeParent, lineNumber, fileName, canContinue)) {
      //Here are made the checks for the parameters (if they are of the correct type and have legal values). In this case, the parameters should be of type exprLink.
      if(params->size() >= 1) {
        if(checkArgumentForNull(params, ONE, "gen_decoder", lineNumber, fileName, canContinue)) {
          RefCSLOmBase baseExpr = params->at(0)->doEval();
          TIsPredicate f2[] = {&CSLOmBase::isUnitDecl};
          checkArgumentType(baseExpr, f2, ONE, "unit decl", lineNumber, fileName, canContinue);
        }
      }
      if (params->size() == 2) {
        RefCSLOmBase baseExpr2 = params->at(1)->doEval();
        TIsPredicate f3[] = {&CSLOmBase::isExprLink};
        checkArgumentType(baseExpr2, f3, ONE, "expresion link", lineNumber, fileName, canContinue);
      }
    }
  }

  return canContinue;
}

void CSLOmCmdDecSetDecoder::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isSignal()) {
            (CSLOmSignal::cast(*it))->setAsDecoder();
            if(params->size() >= 1) {
              (CSLOmSignal::cast(*it))->setDecOutput(CSLOmExprLink::cast(params->at(0))->getName());
            }
            if(params->size() == 2) {
              (CSLOmSignal::cast(*it))->setDecUnit(CSLOmExprLink::cast(params->at(1))->getName());
            }
          }
          else  if ((*it)->isField()) {
            (CSLOmField::cast(*it))->setAsDecoder();
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of signals or fields");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
            cslomHasErrors = TRUE;
          }
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        CSLOmSignal::cast(scopeParent)->setAsDecoder();
        if(params->size() >= 1) {
          (CSLOmSignal::cast(scopeParent))->setDecOutput(CSLOmExprLink::cast(params->at(0))->getName());
        }
        if(params->size() == 2) {
          (CSLOmSignal::cast(scopeParent))->setDecUnit(CSLOmExprLink::cast(params->at(1))->getName());
        }
      }
      break;
    case TYPE_BIT_RANGE:
      if (scopeParent->isField()) {
        CSLOmField::cast(scopeParent)->setAsDecoder();
      }
      break;
        
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal or field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

/*
 *fifo commands
 */


// ********************************************************************************
// CSLOmCmdFifoAddProgrammableDepth class
// ********************************************************************************
void CSLOmCmdFifoAddProgrammableDepth::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddProgrammableDepth::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  //only 1 param that must be a number
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDPROGRAMMABLEDEPTH, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue);

  //we don't want to return false when a param is not of the expected type, instead we want to check other params (if any) and throw
  //error messages for each of them(if that's the case). 
  if(checkParamSize(params, PARAM_SIZE_CMDFIFOADDPROGRAMMABLEDEPTH_LOWER, PARAM_SIZE_CMDFIFOADDPROGRAMMABLEDEPTH_UPPER, "programmable_depth", lineNumber, 
                    fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "programmable_depth", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "programable_depth", lineNumber, fileName, canContinue);
      }
    } 
  }
  return canContinue;
}

void CSLOmCmdFifoAddProgrammableDepth::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("programmable_depth"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortProgrammableDepth(params->at(0), s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortProgrammableDepth(params->at(0), s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdFifoSetPhysicalImpType class
// ********************************************************************************

CSLOmFifoInfo::EImpType CSLOmCmdFifoSetPhysicalImpType::m_impType = CSLOmFifoInfo::IMP_UNDEF;

void CSLOmCmdFifoSetPhysicalImpType::setImpType(CSLOmFifoInfo::EImpType type) {
  ASSERT(type > CSLOmFifoInfo::IMP_UNDEF && type < CSLOmFifoInfo::IMP_MAX, "illegal value for enum");
  m_impType = type;
}

CSLOmFifoInfo::EImpType CSLOmCmdFifoSetPhysicalImpType::getImpType() {
  return m_impType;
}

void CSLOmCmdFifoSetPhysicalImpType::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");


  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoSetPhysicalImpType::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOSETPHYSICALIMPTYPE_LOWER, PARAM_SIZE_CMDFIFOSETPHYSICALIMPTYPE_UPPER, "set_physical_implementation", lineNumber, 
                 fileName, canContinue);
 
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOSETPHYSICALIMPTYPE, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  if(m_impType <= CSLOmFifoInfo::IMP_UNDEF || m_impType >= CSLOmFifoInfo::IMP_MAX) {
    args.push_back("set_physical_implementation");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    canContinue = FALSE;
  } 
  
  return canContinue;
}

void CSLOmCmdFifoSetPhysicalImpType::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;


  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setImpType(m_impType);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setImpType(m_impType);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdFifoAddPrioBypass class
// ********************************************************************************
void CSLOmCmdFifoAddPrioBypass::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");


  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddPrioBypass::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  checkParamSize(params, PARAM_SIZE_CMDFIFOADDPRIOBYPASS_LOWER, PARAM_SIZE_CMDFIFOADDPRIOBYPASS_UPPER, "priority_bypass", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDPRIOBYPASS, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
    
  return canContinue;
}

void CSLOmCmdFifoAddPrioBypass::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString bypass = RefString(new std::string("priority_bypass"));
  RefString select = RefString(new std::string("priority_select"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortPriorityBypass(bypass);
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortPrioritySelect(select);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortPriorityBypass(bypass);
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortPrioritySelect(select);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdFifoSetAsynch class
// ********************************************************************************
void CSLOmCmdFifoSetAsynch::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");


  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoSetAsynch::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOSETASYNCH_LOWER, PARAM_SIZE_CMDFIFOSETASYNCH_UPPER, "asynch_fifo", lineNumber, fileName, canContinue);
 
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }

  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOSETASYNCH, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
    
  return canContinue;
}

void CSLOmCmdFifoSetAsynch::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setAsynch();
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setAsynch();
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoSetDepthExtend class
// ********************************************************************************
void CSLOmCmdFifoSetDepthExtend::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoSetDepthExtend::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  //only 1 param that must be a number


  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOSETDEPTHEXTEND, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFOSETDEPTHEXTEND_LOWER, PARAM_SIZE_CMDFIFOSETDEPTHEXTEND_UPPER, "depth_extend", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "depth_extend", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32 
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "depth_extend", lineNumber, fileName, canContinue);
      }
    }
  }  
  return canContinue;
}
void CSLOmCmdFifoSetDepthExtend::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;


  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setDepthExtend(params->at(0));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setDepthExtend(params->at(0));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoSetWidthExtend class
// ********************************************************************************
void CSLOmCmdFifoSetWidthExtend::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoSetWidthExtend::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a number


  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOSETWIDTHEXTEND, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFOSETWIDTHEXTEND_LOWER, PARAM_SIZE_CMDFIFOSETWIDTHEXTEND_UPPER, "width_extend", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "width_extend", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "width_extend", lineNumber, fileName, canContinue);
      }
    }
  }
  return canContinue;
}

void CSLOmCmdFifoSetWidthExtend::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setWidthExtend(params->at(0));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setWidthExtend(params->at(0));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoSetWrHold class
// ********************************************************************************
void CSLOmCmdFifoSetWrHold::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoSetWrHold::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a number


  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  } 
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOSETWRHOLD, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFOSETWRHOLD_LOWER, PARAM_SIZE_CMDFIFOSETWRHOLD_UPPER, "wr_hold", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "wr_hold", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(!checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "wr_hold", lineNumber, fileName, canContinue);
      }
    }
  }
  return canContinue;
}

void CSLOmCmdFifoSetWrHold::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setWrHold(params->at(0));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setWrHold(params->at(0));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdFifoParallelOutput class
// ********************************************************************************
void CSLOmCmdFifoParallelOutput::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoParallelOutput::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
 
  checkParamSize(params, PARAM_SIZE_CMDFIFOPARALLELOUTPUT_LOWER, PARAM_SIZE_CMDFIFOPARALLELOUTPUT_UPPER, "parallel_output", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOPARALLELOUTPUT, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;
}

void CSLOmCmdFifoParallelOutput::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setParallelOutput();
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setParallelOutput();
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoParallelInput class
// ********************************************************************************
void CSLOmCmdFifoParallelInput::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoParallelInput::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOPARALLELINPUT_LOWER, PARAM_SIZE_CMDFIFOPARALLELINPUT_UPPER, "parallel_input", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOPARALLELINPUT, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;
}

void CSLOmCmdFifoParallelInput::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->setParallelInput();
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->setParallelInput();
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoRdWords class
// ********************************************************************************
void CSLOmCmdFifoRdWords::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoRdWords::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //2 params that must be expressions
 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFORDWORDS, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFORDWORDS_LOWER, PARAM_SIZE_CMDFIFORDWORDS_UPPER, "rd_words", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "rd_words", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(); 
      RefCSLOmBase baseExpr2 = params->at(1)->doEval();   
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(!checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "rd_words", lineNumber, fileName, canContinue);
      }
      if(!checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr2, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "rd_words", lineNumber, fileName, canContinue);
      }
    }
  }
  return canContinue;
}

void CSLOmCmdFifoRdWords::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->rdWords(params->at(0), params->at(1));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->rdWords(params->at(0), params->at(1));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoWrWords class
// ********************************************************************************
void CSLOmCmdFifoWrWords::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoWrWords::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //2 params that must be expressions

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOWRWORDS, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFOWRWORDS_LOWER, PARAM_SIZE_CMDFIFOWRWORDS_UPPER, "wr_words", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "wr_words", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(); 
      RefCSLOmBase baseExpr2 = params->at(1)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(!checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "wr_words", lineNumber, fileName, canContinue);
      }
      if(!checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr2, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "wr_words", lineNumber, fileName, canContinue);
      }
    }
  }
  return canContinue;
}

void CSLOmCmdFifoWrWords::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->wrWords(params->at(0), params->at(1));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->wrWords(params->at(0), params->at(1));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddSramRd class
// ********************************************************************************
void CSLOmCmdFifoAddSramRd::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddSramRd::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
 
  checkParamSize(params, PARAM_SIZE_CMDFIFOADDSRAMRD_LOWER, PARAM_SIZE_CMDFIFOADDSRAMRD_UPPER, "sram_rd", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDSRAMRD, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;
}

void CSLOmCmdFifoAddSramRd::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefString rdData = RefString(new std::string("sram_rd_data"));
  RefString rdAddr = RefString(new std::string("sram_rd_addr"));
  RefString rdEn = RefString(new std::string("sram_rd_en"));

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortSramRdData(rdData);
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortSramRdEn  (rdEn);
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortSramRdAddr(rdAddr);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortSramRdData(rdData);
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortSramRdEn  (rdEn);
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortSramRdAddr(rdAddr);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddSramWr class
// ********************************************************************************
void CSLOmCmdFifoAddSramWr::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddSramWr::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOADDSRAMWR_LOWER, PARAM_SIZE_CMDFIFOADDSRAMWR_UPPER, "sram_wr", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDSRAMWR, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;
}

void CSLOmCmdFifoAddSramWr::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString wrData = RefString(new std::string("sram_wr_data"));
  RefString wrAddr = RefString(new std::string("sram_wr_addr"));
  RefString wrEn = RefString(new std::string("sram_wr_en"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortSramWrData(wrData);
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortSramWrEn  (wrEn);
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortSramWrAddr(wrAddr);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortSramWrData(wrData);
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortSramWrEn  (wrEn);
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortSramWrAddr(wrAddr);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddPushback class
// ********************************************************************************
void CSLOmCmdFifoAddPushback::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  // ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddPushback::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  checkParamSize(params, PARAM_SIZE_CMDFIFOADDPUSHBACK_LOWER, PARAM_SIZE_CMDFIFOADDPUSHBACK_UPPER, "pushback", lineNumber, fileName, canContinue); 
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDPUSHBACK, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;
}

void CSLOmCmdFifoAddPushback::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("pushback"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortPushback(s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortPushback(s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoFlowThrough class
// ********************************************************************************
void CSLOmCmdFifoFlowThrough::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoFlowThrough::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a number


  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOFLOWTHROUGH, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFOFLOWTHROUGH_LOWER, PARAM_SIZE_CMDFIFOFLOWTHROUGH_UPPER, "flow_through", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "flow_through", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "flow_through", lineNumber, fileName, canContinue);
      }
    }
  }
  return canContinue;
}

void CSLOmCmdFifoFlowThrough::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->flowThrough(params->at(0));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->flowThrough(params->at(0));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}

// ********************************************************************************
// CSLOmCmdFifoAddStall class
// ********************************************************************************
void CSLOmCmdFifoAddStall::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddStall::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  checkParamSize(params, PARAM_SIZE_CMDFIFOADDSTALL_LOWER, PARAM_SIZE_CMDFIFOADDSTALL_UPPER,"stall", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDSTALL, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddStall::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("stall"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortStall(s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortStall(s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
} 

// ********************************************************************************
// CSLOmCmdFifoAddStallRdSide class
// ********************************************************************************
void CSLOmCmdFifoAddStallRdSide::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddStallRdSide::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOADDSTALLRDSIDE_LOWER, PARAM_SIZE_CMDFIFOADDSTALLRDSIDE_UPPER,"stall_rd_side", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDSTALLRDSIDE, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddStallRdSide::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("stall_rd_side"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortStallRdSide(s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortStallRdSide(s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddStallWrSide class
// ********************************************************************************
void CSLOmCmdFifoAddStallWrSide::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddStallWrSide::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOADDSTALLWRSIDE_LOWER, PARAM_SIZE_CMDFIFOADDSTALLWRSIDE_UPPER,"stall_wr_side", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDSTALLWRSIDE, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddStallWrSide::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("stall_wr_side"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortStallWrSide(s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortStallWrSide(s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddWrRelease class
// ********************************************************************************
void CSLOmCmdFifoAddWrRelease::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddWrRelease::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOADDWRRELEASE_LOWER, PARAM_SIZE_CMDFIFOADDWRRELEASE_UPPER,"wr_release", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDWRRELEASE, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddWrRelease::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortWrRelease(RefString(new std::string("wr_release")));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortWrRelease(RefString(new std::string("wr_release")));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddAlmostEmpty class
// ********************************************************************************
void CSLOmCmdFifoAddAlmostEmpty::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddAlmostEmpty::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a number
  

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDALMOSTEMPTY, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFOADDALMOSTEMPTY_LOWER, PARAM_SIZE_CMDFIFOADDALMOSTEMPTY_UPPER, "almost_empty", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "almost_empty", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE); //has to take one argument
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "almost_empty", lineNumber, fileName, canContinue);
      }
    }
  }
  return canContinue;  
}

void CSLOmCmdFifoAddAlmostEmpty::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("almost_empty"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortAlmostEmpty(params->at(0), s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortAlmostEmpty(params->at(0), s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddAlmostFull class
// ********************************************************************************
void CSLOmCmdFifoAddAlmostFull::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddAlmostFull::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a number
  

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDALMOSTFULL, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);

  if(checkParamSize(params, PARAM_SIZE_CMDFIFOADDALMOSTFULL_LOWER, PARAM_SIZE_CMDFIFOADDALMOSTFULL_UPPER, "almost_full", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "almost_full", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE); //has to take one argument
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "almost_full", lineNumber, fileName, canContinue);
      }
    }
  }
  return canContinue;  
}

void CSLOmCmdFifoAddAlmostFull::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("almost_full"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortAlmostFull(params->at(0), s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortAlmostFull(params->at(0), s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddOutWrAddr class
// ********************************************************************************
void CSLOmCmdFifoAddOutWrAddr::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddOutWrAddr::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  checkParamSize(params, PARAM_SIZE_CMDFIFOADDOUTWRADDR_LOWER, PARAM_SIZE_CMDFIFOADDOUTWRADDR_UPPER,"output_wr_addr", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDOUTWRADDR, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddOutWrAddr::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          //            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortWrAddress(RefString(new std::string("wr_addr")));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      //        CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortWrAddress(RefString(new std::string("wr_addr")));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddOutRdAddr class
// ********************************************************************************
void CSLOmCmdFifoAddOutRdAddr::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddOutRdAddr::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  checkParamSize(params, PARAM_SIZE_CMDFIFOADDOUTRDADDR_LOWER, PARAM_SIZE_CMDFIFOADDOUTRDADDR_UPPER,"output_rd_addr", lineNumber, fileName, canContinue);
 
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDOUTRDADDR, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddOutRdAddr::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          //            CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortRdAddress(RefString(new std::string("rd_addr")));
        }
      }
      break;
    case TYPE_DECL_UNIT:
      //        CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortRdAddress(RefString(new std::string("rd_addr")));
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddCredit class
// ********************************************************************************
void CSLOmCmdFifoAddCredit::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddCredit::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOADDCREDIT_LOWER, PARAM_SIZE_CMDFIFOADDCREDIT_UPPER, "output_rd_addr", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDCREDIT, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddCredit::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("credit"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortCredit(s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortCredit(s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddRdCredit class
// ********************************************************************************
void CSLOmCmdFifoAddRdCredit::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddRdCredit::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOADDRDCREDIT_LOWER, PARAM_SIZE_CMDFIFOADDRDCREDIT_UPPER,"rd_credit", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDRDCREDIT, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddRdCredit::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("rd_credit"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortRdCredit(s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortRdCredit(s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdFifoAddWrCredit class
// ********************************************************************************
void CSLOmCmdFifoAddWrCredit::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdFifoAddWrCredit::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  checkParamSize(params, PARAM_SIZE_CMDFIFOADDWRCREDIT_LOWER, PARAM_SIZE_CMDFIFOADDWRCREDIT_UPPER,"wr_credit", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isFifo};
  checkParentType(f, PARENT_TYPE_SIZE_FIFOADDWRCREDIT, scopeParent, scope, "fifo", lineNumber, fileName, canContinue);
  
  return canContinue;  
}

void CSLOmCmdFifoAddWrCredit::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefString s = RefString(new std::string("wr_credit"));

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      if(objs.get()) {
        for (it = objs->begin(); it < objs->end(); ++it) {
          CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(*it)->getUnitInfo())->addPortWrCredit(s);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->addPortWrCredit(s);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("fifo");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }

}


// ********************************************************************************
// CSLOmCmdEnumAddPair class
// ********************************************************************************
void CSLOmCmdEnumAddPair::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdEnumAddPair::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  //1 or 2 params. The first one is an expression that must not evaluate, meaning it must not be found
  //in the current scope. The second must be a numeric expression(a number or another enum item) and is optional.
  

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isEnum};
  checkParentType(f, PARENT_TYPE_SIZE_ENUMADDPAIR, scopeParent, scope, "enum", lineNumber, fileName, canContinue);

  RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr (new TVec_RefCSLOmExpr);
  
  if(checkParamSize(params, PARAM_SIZE_CMDENUMADDPAIR_LOWER, PARAM_SIZE_CMDENUMADDPAIR_UPPER,"csl_enum", lineNumber, fileName, canContinue)) {
    newParams->push_back(params->at(0));
    checkArgumentForNotNull(newParams, newParams->size(), "csl_enum", scopeParent, lineNumber, fileName, canContinue);
    if(params->size() == PARAM_SIZE_CMDENUMADDPAIR_UPPER) {
      newParams->clear();
      newParams->push_back(params->at(1));
      if(checkArgumentForNull(newParams, 2, "csl_enum", lineNumber, fileName, canContinue)) {
        RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE);
        TIsPredicate f[] = {&CSLOmBase::isNumber, &CSLOmBase::isEnumItem};
        if(checkArgumentType(baseExpr2, f, ONE+ONE, "enum item or number", lineNumber, fileName, canContinue)) {
          if(baseExpr2->isNumber()) {
            //ckeck if the number doesn't have xz and that it is an INT32
            checkNumber(baseExpr2, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, FALSE, "csl_enum", lineNumber, fileName, canContinue);
          }
        }
      }
    }
  }
  
  return canContinue;
}

void  CSLOmCmdEnumAddPair::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmNumber itemValue;
  if(params->size() == 2) {
    RefCSLOmBase baseExpr = params->at(1)->doEval(TRUE);
    if(baseExpr->isNumber()) {
      //      itemValue = CSLOmNum32::build(lineNumber, fileName, CSLOmNumber::cast(baseExpr)->getValue());
      itemValue = CSLOmNumber::cast(baseExpr);
    }
  }

  switch (scopeParent->getType()) {
    case TYPE_ENUM:
      if (params->size() == 2) {
        CSLOmEnum::cast(scopeParent)->addPair(CSLOmExprLink::cast(params->at(0))->getName(), itemValue);
      }
      else {
        CSLOmEnum::cast(scopeParent)->addPair(CSLOmExprLink::cast(params->at(0))->getName());
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("enum");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      break;
  }
}


// ********************************************************************************
// CSLOmCmdPosition class
// ********************************************************************************

void  CSLOmCmdSetPosition::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetPosition::check  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
 
  //exactly 2 params, the first must be a field, and the second must be a number
  if(checkParamSize(params, PARAM_SIZE_CMDSETPOSITION_LOWER, PARAM_SIZE_CMDSETPOSITION_UPPER,"set_position", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_position", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr1 = params->at(0)->doEval();
      RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE);
      //checks for first parameter
      TIsPredicate f2[] = {&CSLOmBase::isField};
      checkArgumentType(baseExpr1, f2, ONE, "field", lineNumber, fileName, canContinue);
      //for second parameter
      TIsPredicate f3[] = {&CSLOmBase::isNumber};
      if (checkArgumentType(baseExpr2, f3, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
        checkNumber(baseExpr2, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "set_position", lineNumber, fileName, canContinue);
      }
    }
  } 
   
  TIsPredicate f[] = {&CSLOmBase::isField};
  if(checkParentType(f, PARENT_TYPE_SIZE_ENUMADDPAIR, scopeParent, scope, "field", lineNumber, fileName, canContinue)) {
    RefCSLOmField parentField = CSLOmField::cast(scopeParent);
    RefCSLOmField childField = CSLOmField::cast(params->at(0)->doEval());
    if(parentField->isDefault()) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_SET_WIDTH, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    if(parentField->isIsaElement()) {
      RefCSLOmIsaElement elem = CSLOmIsaElement::cast(parentField);
      if(elem->getIsaType() != CSLOmIsaElement::ISA_ELEM_FORMAT && elem->getIsaType() != CSLOmIsaElement::ISA_ELEM_INSTR) {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("csl_isa_element of type instr_format or instr");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        return FALSE;
      }
    }
    //the parent field(the field that calls the command) must be hierarchical
    if(parentField->isHierarchical()) {
      //the field to be set should be from the parent field
      if(childField->getParent() != parentField) {
        args.push_back(*getScopeValue(childField));
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_IN_SCOPE, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the field to be set shouldn't have been already given a position
      else if(parentField->isSetPosition(childField)) {
        args.push_back(*getScopeValue(childField));
        addErr(NSWarningErr::CSE_CSC_PARM_FIELD_HAS_POSITION, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the positions the field would occupy should be empty
      else if(parentField->posOverlap(childField, CSLOmNumber::cast(params->at(1)->doEval()))) {
        addErr(NSWarningErr::CSE_CSC_FUNC_FIELD_OVERLAPPING, args, lineNumber, fileName);
        canContinue=FALSE;
      }
    } 
    else{
      //field is not hierarchical
      args.push_back(*parentField->getName());
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_HIERARCHICAL, args, lineNumber, fileName);
      canContinue = FALSE;   
    }    
     
  }  
  return canContinue;
}

void  CSLOmCmdSetPosition::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase fieldObj = params->at(0)->doEval();
  RefCSLOmExpr position = CSLOmExpr::cast(params->at(1)->doEval(TRUE));

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isField()) {
          if(fieldObj->isField()) {
            CSLOmField::cast(*it)->setFieldPosition(CSLOmField::cast(fieldObj), position);
          } 
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of fields");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_BIT_RANGE:
      if(fieldObj->isField()) {
        (CSLOmField::cast(scopeParent))->setFieldPosition(CSLOmField::cast(fieldObj), position);
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetNext class
// ********************************************************************************

void  CSLOmCmdSetNext::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetNext::check  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//WILL BECOME FALSE IF AN ERROR IS FOUND

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }

  //this command has exactly 2 arguments, that must both be fields.
  if(checkParamSize(params, PARAM_SIZE_CMDSETNEXT_LOWER, PARAM_SIZE_CMDSETNEXT_UPPER, "set_next", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_next", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr1 = params->at(0)->doEval();
      RefCSLOmBase baseExpr2 = params->at(1)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isField};
      checkArgumentType(baseExpr1, f2, ONE, "field", lineNumber, fileName, canContinue);
      checkArgumentType(baseExpr2, f2, ONE, "field", lineNumber, fileName, canContinue);
    }
  }

  TIsPredicate f[] = {&CSLOmBase::isField};
  if(checkParentType(f, PARENT_TYPE_SIZE_ENUMADDPAIR, scopeParent, scope, "field", lineNumber, fileName, canContinue)) {
    RefCSLOmField parentField = CSLOmField::cast(scopeParent);
    RefCSLOmField nextField = CSLOmField::cast(params->at(1)->doEval());
    RefCSLOmField refField = CSLOmField::cast(params->at(0)->doEval());
    if(parentField->isHierarchical()) {
      //the reference field should be from the parent field
      if(refField->getParent() != parentField) {
        args.push_back(*getScopeValue(refField));
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_IN_SCOPE, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the field to be set should be from the parent field
      else if(nextField->getParent() != parentField) {
        args.push_back(*getScopeValue(nextField));
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_IN_SCOPE, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the field to be set as next shouldn't have been already given a position
      else if(parentField->isSetPosition(nextField)) {
        args.push_back(*getScopeValue(nextField));
        addErr(NSWarningErr::CSE_CSC_PARM_FIELD_HAS_POSITION, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the reference field should have a position set
      else if(!parentField->isSetPosition(refField)) {
        args.push_back(*getScopeValue(refField));
        addErr(NSWarningErr::CSE_CSC_PARM_FIELD_NO_POSITION, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the position the nextField would ocupy should be free(empty)
      else if(parentField->nextOverlap(refField, nextField)) {
        addErr(NSWarningErr::CSE_CSC_FUNC_FIELD_OVERLAPPING, args, lineNumber, fileName);
        canContinue=FALSE;
      }
    } 
    else{
      //field is not hierarchical
      args.push_back(*parentField->getName());
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_HIERARCHICAL, args, lineNumber, fileName);
      canContinue = FALSE;   
    }    
    
  }
  
  return canContinue;
}



void  CSLOmCmdSetNext::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefCSLOmBase fieldObj1 = params->at(0)->doEval();
  RefCSLOmBase fieldObj2 = params->at(1)->doEval();

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isField()) {
          if(fieldObj1->isField() && fieldObj2->isField()) {
            CSLOmField::cast(*it)->setNextField(CSLOmField::cast(fieldObj1), CSLOmField::cast(fieldObj2));
          } 
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of fields");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_BIT_RANGE:
      if(fieldObj1->isField() && fieldObj2->isField()) {
        (CSLOmField::cast(scopeParent))->setNextField(CSLOmField::cast(fieldObj1), CSLOmField::cast(fieldObj2));
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetPrevious class
// ********************************************************************************

void  CSLOmCmdSetPrevious::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetPrevious::check  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //exactly 2 params that must be both fields

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }

  if(checkParamSize(params, PARAM_SIZE_CMDSETPREVIOUS_LOWER, PARAM_SIZE_CMDSETPREVIOUS_UPPER,"set_previous", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_previous", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr1 = params->at(0)->doEval();
      RefCSLOmBase baseExpr2 = params->at(1)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isField};
      checkArgumentType(baseExpr1, f2, ONE, "field", lineNumber, fileName, canContinue);
      checkArgumentType(baseExpr2, f2, ONE, "field", lineNumber, fileName, canContinue);
    }
  }

  TIsPredicate f[] = {&CSLOmBase::isField};
  if(checkParentType(f, PARENT_TYPE_SIZE_ENUMADDPAIR, scopeParent, scope, "set_previous", lineNumber, fileName, canContinue)) {
    RefCSLOmField parentField = CSLOmField::cast(scopeParent);
    RefCSLOmField previousField = CSLOmField::cast(params->at(1)->doEval());
    RefCSLOmField referenceField = CSLOmField::cast(params->at(0)->doEval());
    if(parentField->isHierarchical()) {
      //the reference field to be set should be from the parent field
      if(referenceField->getParent() != parentField) {
        args.push_back(*getScopeValue(referenceField));
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_IN_SCOPE, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the field to be set should be from the parent field
      else if(previousField->getParent() != parentField) {
        args.push_back(*getScopeValue(previousField));
        args.push_back(*getScopeValue(scopeParent));
        addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_IN_SCOPE, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the field to be set as next shouldn't have been already given a position
      else if(parentField->isSetPosition(previousField)) {
        args.push_back(*getScopeValue(previousField));
        addErr(NSWarningErr::CSE_CSC_PARM_FIELD_HAS_POSITION, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      //the first field should have been already given a position
      else if(!parentField->isSetPosition(referenceField)) {
        args.push_back(*getScopeValue(referenceField));
        addErr(NSWarningErr::CSE_CSC_PARM_FIELD_NO_POSITION, args, lineNumber, fileName);
        canContinue=FALSE;
      }
      else if(parentField->prevOverlap(referenceField, previousField)) {
        addErr(NSWarningErr::CSE_CSC_FUNC_FIELD_OVERLAPPING, args, lineNumber, fileName);
        canContinue=FALSE;
      }
    } 
    else{
      //field is not hierarchical
      args.push_back(*parentField->getName());
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_NOT_HIERARCHICAL, args, lineNumber, fileName);
      canContinue = FALSE;   
    }    
     
  }  
  return canContinue;

}

void  CSLOmCmdSetPrevious::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefCSLOmBase fieldObj1 = params->at(0)->doEval();
  RefCSLOmBase fieldObj2 = params->at(1)->doEval();

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isField()) {
          if(fieldObj1->isField() && fieldObj2->isField()) {
            CSLOmField::cast(*it)->setPreviousField(CSLOmField::cast(fieldObj1), CSLOmField::cast(fieldObj2));
          } 
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of fields");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_BIT_RANGE:
      if(fieldObj1->isField() && fieldObj2->isField()) {
        (CSLOmField::cast(scopeParent))->setPreviousField(CSLOmField::cast(fieldObj1), CSLOmField::cast(fieldObj2));
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}


// ********************************************************************************
// CSLOmCmdAddAllowedRange class
// ********************************************************************************

void  CSLOmCmdAddAllowedRange::build  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdAddAllowedRange::check  (TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //exactly 2 params that must be both numbers

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }

  if(checkParamSize(params, PARAM_SIZE_CMDSETPREVIOUS_LOWER, PARAM_SIZE_CMDSETPREVIOUS_UPPER,"add_allowed_range", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "add_allowed_range", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr1 = params->at(0)->doEval(TRUE);
      RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE);
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr1, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number doesn't have xz and that it is an INT32
        checkNumber(baseExpr1, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "add_allowed_range", lineNumber, fileName, canContinue);
      }
      if(checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number doesn't have xz and that it is an INT32
        checkNumber(baseExpr2, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "add_allowed_range", lineNumber, fileName, canContinue);
      }
    }
  }

  TIsPredicate f[] = {&CSLOmBase::isField};
  checkParentType(f, PARENT_TYPE_SIZE_ENUMADDPAIR, scopeParent, scope, "add_allowed_range", lineNumber, fileName, canContinue);
  
  return canContinue;

}

void  CSLOmCmdAddAllowedRange::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr low = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefCSLOmExpr up = CSLOmExpr::cast(params->at(1)->doEval(TRUE));

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isField()) {
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
        CSLOmField::cast(scopeParent)->addAllowedRange(low, up);
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("field");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("field");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}


// ********************************************************************************
// CSLOmCmdAddAddressRange class
// ********************************************************************************
TBool CSLOmCmdAddAddressRange::m_switchValues = FALSE;
void CSLOmCmdAddAddressRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }  
}

TBool CSLOmCmdAddAddressRange::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //exactly 2 parameters that must be both numbers
  if(checkParamSize(params, PARAM_SIZE_CMDADDADDRESSRANGE_LOWER, PARAM_SIZE_CMDADDADDRESSRANGE_UPPER,"add_address_range", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "add_address_range", lineNumber, fileName, canContinue)) {

      RefCSLOmBase baseExpr1 = params->at(0)->doEval(TRUE);
      RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE);

      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr1, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number doesn't have xz and that it is an INT32
        checkNumber(baseExpr1, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "add_address_range", lineNumber, fileName, canContinue);
      }
      if(checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        //ckeck if the number doesn't have xz and that it is an INT32
        if(checkNumber(baseExpr2, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "add_address_range", lineNumber, fileName, canContinue)) {
          if(canContinue) {
            RefCSLOmNumber lower = CSLOmNumber::cast(baseExpr1);
            RefCSLOmNumber upper = CSLOmNumber::cast(baseExpr2);
            if(lower->getValue() > upper->getValue()) {
              addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_LOWER_UPPER, args, lineNumber, fileName);
              m_switchValues = TRUE;
            }
          }
        }
      }
    }
  }
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  if(checkParentType(f, PARENT_TYPE_SIZE_ADDADDRESSRANGE, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue)) {
    if(canContinue) {
      RefCSLOmNumber lowerBound = CSLOmMemoryMapPage::cast(scopeParent)->getLowerBound();
      RefCSLOmNumber upperBound = CSLOmMemoryMapPage::cast(scopeParent)->getUpperBound();
      RefCSLOmNumber lower = CSLOmNumber::cast(params->at(0)->doEval());
      RefCSLOmNumber upper = CSLOmNumber::cast(params->at(1)->doEval());
      if(!(lowerBound->getValue() == -1 && upperBound->getValue() == ZERO)) {
        //if the new lower bound is inside the old range, it means it will overlap
        if((lower->getValue() >= lowerBound->getValue()) && (lower->getValue() <= upperBound->getValue())) {
          args.push_back(intToString(lower->getValue()));
          addErr(NSWarningErr::CSE_CSC_CHRS_ILL_VAL_CHRS_CSC, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        //if the upper bound is inside the old range, it means that it will overlap
        if((upper->getValue() >= lowerBound->getValue()) && (upper->getValue() <= upperBound->getValue())) {
          args.push_back(intToString(upper->getValue()));
          addErr(NSWarningErr::CSE_CSC_CHRS_ILL_VAL_CHRS_CSC, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }

  return canContinue;
}

void CSLOmCmdAddAddressRange::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmNumber upperIndex;
  RefCSLOmNumber lowerIndex;
  if(m_switchValues) {
    upperIndex = CSLOmNumber::cast(params->at(0)->doEval(TRUE));
    lowerIndex = CSLOmNumber::cast(params->at(1)->doEval(TRUE));
  }
  else {
    lowerIndex = CSLOmNumber::cast(params->at(0)->doEval(TRUE));
    upperIndex = CSLOmNumber::cast(params->at(1)->doEval(TRUE));
  }

  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  if (scopeParent.get()) {
    switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isSignal()) {
            RefCSLOmExpr uppIndex = CSLOmSignal::cast(*it)->getUpperIndex();
            RefCSLOmNumber upperIndex = CSLOmNumber::cast(upperIndex->doEval());
            if(upperIndex->getValue() != ZERO) {
              args.push_back(*CSLOmSignal::cast(*it)->getName());
              addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, lineNumber, fileName);
              }
            (CSLOmMemoryMapPage::cast(*it))->addAddressRange(lowerIndex, upperIndex);
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of memory map pages");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          }
        }
        break;
      case TYPE_MEMORY_MAP_PAGE:
        (CSLOmMemoryMapPage::cast(scopeParent))->addAddressRange(lowerIndex, upperIndex);
        break;
      default:
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("memory map page");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        break;
    }
  }
  else {
    args.push_back(*getScopeValue(scopeParent));
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber, fileName);
  }
}

// ********************************************************************************
// CSLOmCmdSetAddressIncrement class
// ********************************************************************************

void CSLOmCmdSetAddressIncrement::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetAddressIncrement::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  TBool hasAddressRange = FALSE;

  //only 1 param that must be a number 
  checkParamSize(params, PARAM_SIZE_CMDSETADDRESSINCREMENT_LOWER, PARAM_SIZE_CMDSETADDRESSINCREMENT_UPPER,"set_address_increment", lineNumber, fileName, canContinue);
   
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  if(checkParentType(f, PARENT_TYPE_SIZE_SETADDRESSINCREMENT, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue)) {
    //check that the parent has an address range set
    RefCSLOmMemoryMapPage page = CSLOmMemoryMapPage::cast(scopeParent);
    RefCSLOmNumber lower = page->getLowerBound();
    RefCSLOmNumber upper = page->getUpperBound();
    hasAddressRange = TRUE;
    if((lower->getValue() == -1) && (upper->getValue() == ZERO)) {
      args.push_back("set_address_increment");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      canContinue=FALSE;
      hasAddressRange = FALSE;
    }
  }

  if(checkArgumentForNull(params, ONE, "set_address_increment", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE); 
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //ckeck if the number doesn't have xz and that it is an INT32
      if(checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_address_increment", lineNumber, fileName, canContinue)) {
        if(hasAddressRange) {
          //check that address increment is not bigger than the address range of the page
          RefCSLOmMemoryMapPage page = CSLOmMemoryMapPage::cast(scopeParent);
          RefCSLOmNumber lower = page->getLowerBound();
          RefCSLOmNumber upper = page->getUpperBound();
          RefCSLOmNumber increment = CSLOmNumber::cast(baseExpr);
          if(increment->getValue() > (upper->getValue()-lower->getValue())) {
            args.push_back("set_address_increment");
            addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
            canContinue=FALSE;
          }
        }
      }
    }
  }

  return canContinue;

}

void CSLOmCmdSetAddressIncrement::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmNumber addrInc = CSLOmNumber::cast(params->at(0)->doEval(TRUE));//evaluating the argument once more; it should return the value from cache
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
 
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  if (scopeParent.get()) {
    switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isMemoryMapLocationPage()) {
            (CSLOmMemoryMapPage::cast((*it)->getParent()))->setAddressIncrement(addrInc);
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of memory map pages");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
          }
        }
        break;
      case TYPE_MEMORY_MAP_PAGE:
        (CSLOmMemoryMapPage::cast(scopeParent))->setAddressIncrement(addrInc);
        break;
      default://another object has been received; this stage should never be reached if all the right checks have been made in the check method
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("memory map page");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        break;
    }
  }
  else {//ALSO, YOU SHOULD NEVER GET HERE, BUT IF YOU DO, IT'S BAD
    args.push_back(*getScopeValue(scopeParent));
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber, fileName);//NULL COMMAND SCOPE
  }

}

// ********************************************************************************
// CSLOmCmdSetNextAddress class
// ********************************************************************************

void CSLOmCmdSetNextAddress::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetNextAddress::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a number
  checkParamSize(params, PARAM_SIZE_CMDSETNEXTADDRESS_LOWER, PARAM_SIZE_CMDSETNEXTADDRESS_UPPER,"set_next_address", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  checkParentType(f, PARENT_TYPE_SIZE_SETNEXTADDRESS, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue);

  if(checkArgumentForNull(params, ONE, "set_next_address", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
      if(checkNumber(baseExpr, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_next_address", lineNumber, fileName, canContinue)) {
        if(scopeParent->isMemoryMapLocationPage()) {
          RefCSLOmMemoryMapPage page = CSLOmMemoryMapPage::cast(scopeParent);
          //check that the parent has an address range set
          RefCSLOmNumber lower = page->getLowerBound();
          RefCSLOmNumber upper = page->getUpperBound();
          RefCSLOmNumber value = CSLOmNumber::cast(baseExpr);
          if((lower->getValue() == -1) && (upper->getValue() == ZERO)) {
            args.push_back("set_next_address");
            addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
            canContinue=FALSE;
          }
          //check that the value of the nest address is inside the address range 
          else if((lower->getValue() > value->getValue()) || (value->getValue() > upper->getValue())) {
            args.push_back("set_next_address");
            addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
            canContinue=FALSE;
          }
          else {
            RefCSLOmAddressRange tempRange = CSLOmAddressRange::build(lineNumber, fileName,value->getValue(),value->getValue()+1);
            if(!page->isFree(tempRange) || page->isReserved(tempRange) || page->isIllegal(tempRange)) {
              args.push_back("set_next_address");
              addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
              canContinue=FALSE;
            }
          }
        }
      } 
    }
  }
  //}
  return canContinue;
  
}

void CSLOmCmdSetNextAddress::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr nextAddress = CSLOmExpr::cast(params->at(0)->doEval(TRUE));//evaluating the argument once more; it should return the value from cache
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
 
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  if (scopeParent.get()) {
    switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isMemoryMapLocationPage()) {
            (CSLOmMemoryMapPage::cast(*it))->setNextAddress(CSLOmNumber::cast(nextAddress));
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of memory map pages");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
          }
        }
        break;
      case TYPE_MEMORY_MAP_PAGE:
        (CSLOmMemoryMapPage::cast(scopeParent))->setNextAddress(CSLOmNumber::cast(nextAddress));
        break;
      default: 
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("memory map page");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        break;
    }
  }
  else {//if all the right checks are made in the check method, this case should never happen
    args.push_back(*getScopeValue(scopeParent));
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber, fileName);//NULL COMMAND SCOPE
  }

}

// ********************************************************************************
// CSLOmCmdAddReservedRange class
// ********************************************************************************

void CSLOmCmdAddReservedRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdAddReservedRange::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  TBool hasAddressRange = FALSE;
  TBool lowerValue = TRUE;

  //exactly 2 params that must be both numbers
  checkParamSize(params, PARAM_SIZE_CMDADDRESERVEDRANGE_LOWER, PARAM_SIZE_CMDADDRESERVEDRANGE_UPPER,"add_reserved_address_range", lineNumber, fileName, canContinue);
    
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  if(checkParentType(f, PARENT_TYPE_SIZE_ADDRESERVEDRANGE, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue)) {
    //check that the parent has an address range set
    RefCSLOmMemoryMapPage page = CSLOmMemoryMapPage::cast(scopeParent);
    RefCSLOmNumber lower = page->getLowerBound();
    RefCSLOmNumber upper = page->getUpperBound();
    hasAddressRange = TRUE;
    if((lower->getValue() == -1) && (upper->getValue() == ZERO)) {
      args.push_back("add_reserved_address_range");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      canContinue=FALSE;
      hasAddressRange = FALSE;
    }
  }

  if(checkArgumentForNull(params, ONE, "add_reserved_address_range", lineNumber, fileName, canContinue)) {

    RefCSLOmBase baseExpr1 = params->at(0)->doEval(TRUE); 
    RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE); 
    
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr1, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
      if(checkNumber(baseExpr1, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_reserved_address_range", lineNumber, fileName, canContinue)) {
        if(hasAddressRange) {
          RefCSLOmMemoryMapPage page = CSLOmMemoryMapPage::cast(scopeParent);
          RefCSLOmNumber lower = page->getLowerBound();
          RefCSLOmNumber upper = page->getUpperBound();
          RefCSLOmNumber value = CSLOmNumber::cast(baseExpr1);
          //check that the lower value of the reserved address range is inside the address range of the memory map page 
          if((lower->getValue() > value->getValue()) || (value->getValue() > upper->getValue())) {
            args.push_back("add_reserved_address_range");
            addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
            canContinue = FALSE;
            lowerValue = FALSE;
          }
        }
      }
    }
    if (checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
      if(checkNumber(baseExpr2, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_reserved_address_range", lineNumber, fileName, canContinue)) {
        if(hasAddressRange) {
          RefCSLOmMemoryMapPage page = CSLOmMemoryMapPage::cast(scopeParent);
          RefCSLOmNumber lower = page->getLowerBound();
          RefCSLOmNumber upper = page->getUpperBound();
          RefCSLOmNumber value = CSLOmNumber::cast(baseExpr2);
          //check that the upper value of the reserved address range is inside the address range  of the memory map
          if((lower->getValue() > value->getValue()) || (value->getValue() > upper->getValue())) {
            args.push_back("add_reserved_address_range");
            addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
            canContinue=FALSE;
          }
          //in case the lowerValue of the address range passed the tests, more checks are made
          else if(lowerValue) {
            //check that the address range that is to be set as reserved is free, not reserved and legal
            RefCSLOmAddressRange tempRange = CSLOmAddressRange::build(lineNumber, fileName, CSLOmNumber::cast(baseExpr1)->getValue(), value->getValue());
            if((!page->isFree(tempRange)) || page->isReserved(tempRange) || page->isIllegal(tempRange)) {
              args.push_back("add_reserved_address_range");
              addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
              canContinue=FALSE;
            }
          }
        }
      } 
    }
  }

  return canContinue;

}

void CSLOmCmdAddReservedRange::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmExpr lower = CSLOmExpr::cast(params->at(0)->doEval(TRUE));//evaluating the argument once more; it should return the value from cache
  RefCSLOmExpr upper = CSLOmExpr::cast(params->at(1)->doEval(TRUE));//evaluating the argument once more; it should return the value from cache
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  if (scopeParent.get()) {
    switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isMemoryMapLocationPage()) {
            (CSLOmMemoryMapPage::cast(*it))->addReservedRange(CSLOmNumber::cast(lower), CSLOmNumber::cast(upper));
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of memory map pages");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
          }
        }
        break;
      case TYPE_MEMORY_MAP_PAGE:
        (CSLOmMemoryMapPage::cast(scopeParent))->addReservedRange(CSLOmNumber::cast(lower), CSLOmNumber::cast(upper));
        break;
      default: 
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("memory map page");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        break;
    }
  }
  else {
    args.push_back(*getScopeValue(scopeParent));
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber, fileName);//NULL COMMAND SCOPE
  }

}

// ********************************************************************************
// CSLOmCmdAdd class
// ********************************************************************************

void CSLOmCmdAdd::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }  
}

TBool CSLOmCmdAdd::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//WILL BECOME FALSE IF AN ERROR IS FOUND

  //1 to 3 params like this:
  //CASE: 1 = must be a MemoryMapPage
  //CASE: 2 = the first one is an addressable object and the second one is a string
  //CASE: 3 = like in the 2 case, plus the 3rd is a number = base address
  if(!checkParamSize(params, PARAM_SIZE_CMDADD_LOWER, PARAM_SIZE_CMDADD_UPPER, "add", lineNumber, fileName, canContinue)) {
    return FALSE;
  }
    
  RefCSLOmExpr unitInfoNo;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  if(!checkParentType(f, PARENT_TYPE_SIZE_ADD, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue)) {
    return FALSE;
  }

  TInt paramsSize = params->size();

  if(1 == paramsSize) {        //in case we have 1 arg
    RefCSLOmExpr expr1 = params->at(0);
    RefCSLOmBase baseExpr1 = (expr1->doEval());
    RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
    newParams->push_back(expr1);
    if(!checkArgumentForNull(newParams, ONE, "add", lineNumber, fileName, canContinue)) {
      return FALSE;
    }
    TIsPredicate f2[] = {&CSLOmBase::isMemoryMapLocationPage};
    if (!checkArgumentType(baseExpr1, f2, ONE, "memory map page", lineNumber, fileName, canContinue)) {
      return FALSE;
    }
  }
  else if(2 <= paramsSize) { //in case we have 2 or 3 args
    RefCSLOmExpr expr1 = params->at(0);
    RefCSLOmExpr expr2 = params->at(1);
    
    RefTVec_RefCSLOmExpr newParams = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
    if (!CSLOmMemoryMapPage::cast(scopeParent)->isUnitNameSet()) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_UNIT_NOT_SET, args, lineNumber, fileName);
      canContinue=FALSE;
    }
    else {
      CSLOmExprLink::cast(expr1)->isInUnitScope(CSLOmMemoryMapPage::cast(scopeParent)->getUnitName());
      newParams->push_back(expr1);
      if(!checkArgumentForNull(newParams, ONE, "add", lineNumber, fileName, canContinue)) {
        return FALSE;
      }
      RefCSLOmBase baseExpr1 = expr1->doEval();
      ASSERT(baseExpr1.get(),"baseExpr should not be null at this time");
      TIsPredicate f2[] = {&CSLOmBase::isInstance};
      if(checkArgumentType(baseExpr1, f2, ONE, "instance", lineNumber, fileName, canContinue)) {
        //check to see if the memory map has free space to add the thing
  
        RefCSLOmUnitDecl unit = CSLOmUnitInstance::cast(baseExpr1)->getUnitDecl();

        if(unit->isFifo()) {
          RefCSLOmUnitInfo unitInfoExpr1 = unit->getUnitInfo();
          RefCSLOmFifoInfo fifoInfo = CSLOmFifoInfo::cast(unitInfoExpr1);
          unitInfoNo = fifoInfo->getDepth();
        }
        else if(unit->isRegisterFile()) {
          unitInfoNo = CSLOmRegisterFileInfo::cast(unit->getUnitInfo())->getDepth();
        }
        else if(unit->isRegister()) {
          unitInfoNo = CSLOmNum32::build(lineNumber, fileName,ONE);
        }
        else if(unit->isMemory()) {
          unitInfoNo = CSLOmMemoryInfo::cast(unit->getUnitInfo())->getDepth();
        }
        else {
          args.push_back(*getScopeValue(baseExpr1));
          args.push_back("addresable object");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
          canContinue = FALSE;
          return FALSE;
        }

        RefCSLOmMemoryMapPage memPageScope = CSLOmMemoryMapPage::cast(scopeParent);
        /* if(!memPageScope->hasFree(unitInfoNo->getValue())) {
          addErr(NSWarningErr::SEE_ALL_MEM_BAD_ALLOC, args, lineNumber, fileName);
          return FALSE; 
          }*/
      }
      else {
        return FALSE;
      }    
    }
    RefTVec_RefCSLOmExpr newParams2 = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
    newParams2->push_back(expr2);
    if(!checkArgumentForNotNull(newParams, newParams->size(), "add",scopeParent, lineNumber, fileName, canContinue)) {
      return FALSE;
    }


    if(expr2->isString()) {
      RefString name = CSLOmString::cast(expr2)->getValue();
      if(name.get()) {
        if(name->empty()) {
          addErr(NSWarningErr::CSE_CSC_STR_EMPTY_OR_WHITE_SPACE_STRING, args, lineNumber, fileName);
          return FALSE;
        }
      }//the name doesn't exist
      else {
        args.push_back("add");
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        return FALSE;
      }
    }//the parameter is not an expresion link
    else {
      args.push_back("add");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      return FALSE;
    }
    //if there are 3 arguments
    if(paramsSize == 3 && canContinue) {
      RefCSLOmExpr expr3 = params->at(2);
       
      RefTVec_RefCSLOmExpr newParams2 = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
      newParams2->push_back(params->at(2));
      if(!checkArgumentForNull(newParams, 3, "add", lineNumber, fileName, canContinue)) {
        return FALSE;
      }

      /*      RefCSLOmBase baseExpr3 = expr3->doEval(TRUE);
      TIsPredicate f3[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr3, f3, ONE, "number", lineNumber, fileName, canContinue)) {
        RefCSLOmNumber no = CSLOmNumber::cast(baseExpr3);
        checkNumber(no, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add", lineNumber, fileName, canContinue);
        RefCSLOmAddressRange tempAddr = CSLOmAddressRange::build(lineNumber, fileName, no->getValue(), no->getValue()+unitInfoNo->getValue()); 
        RefCSLOmMemoryMapPage memPageScope = CSLOmMemoryMapPage::cast(scopeParent);
        if(memPageScope->isIllegal(tempAddr) || memPageScope->isReserved(tempAddr) || (!memPageScope->isFree(tempAddr))) {
          args.push_back("add");
          addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        }*/
    }
  }

  return canContinue;
}

void CSLOmCmdAdd::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  TBool canContinue = TRUE;
  TInt paramsSize = params->size();
  RefCSLOmBase baseExpr1;
  RefCSLOmString addrObjName;
  RefCSLOmBase baseExpr3;
  RefCSLOmExpr baseAddrExpr;

  if(1 == paramsSize) {
    baseExpr1 = params->at(0)->doEval();
  } else if(2 == paramsSize) {
    baseExpr1 = params->at(0)->doEval();
    addrObjName = CSLOmString::cast(params->at(1));
  } else {
    baseExpr1 = params->at(0)->doEval();
    addrObjName = CSLOmString::cast(params->at(1));
    baseExpr3 = params->at(2)->doEval(TRUE);
    baseAddrExpr = CSLOmExpr::cast(baseExpr3);
    baseAddrExpr = CSLOmNum32::build(lineNumber, fileName, CSLOmNum32::cast(baseAddrExpr)->getValue());
  }


  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isMemoryMapLocationPage()) {
          if(1 == paramsSize) {
            (CSLOmMemoryMapPage::cast(*it))->add(CSLOmMemoryMapPage::cast(baseExpr1));
          } else if(2 == paramsSize) {
            (CSLOmMemoryMapPage::cast(*it))->add(baseExpr1, addrObjName->getValue());
          } else {
            (CSLOmMemoryMapPage::cast(*it))->add(baseExpr1, addrObjName->getValue(), CSLOmNum32::cast(baseAddrExpr));
          }
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of memory map pages");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
          canContinue = FALSE;
        }
      }
      break;
    case TYPE_MEMORY_MAP_PAGE:
      if(1 == paramsSize) {
        (CSLOmMemoryMapPage::cast(scopeParent))->add(CSLOmMemoryMapPage::cast(baseExpr1));
      } else if(2 == paramsSize) {
        (CSLOmMemoryMapPage::cast(scopeParent))->add(baseExpr1, addrObjName->getValue());
      } else {
        (CSLOmMemoryMapPage::cast(scopeParent))->add(baseExpr1, addrObjName->getValue(), CSLOmNum32::cast(baseAddrExpr));
      }          
      break;
    default: 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("list of memory map pages");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetDataWordWidth class
// ********************************************************************************

void CSLOmCmdSetDataWordWidth::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDataWordWidth::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;//WILL BECOME FALSE IF AN ERROR IS FOUND

  //only 1 param that must be a number
  checkParamSize(params, PARAM_SIZE_CMDSETDATAWORDWIDTH_LOWER, PARAM_SIZE_CMDSETDATAWORDWIDTH_UPPER, "set_data_word_width", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }

  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage, &CSLOmBase::isMemoryMap};
  checkParentType(f, PARENT_TYPE_SIZE_SETDATAWORDWIDTH, scopeParent, scope, "memory map page, memory map", lineNumber, fileName, canContinue);

  if(checkArgumentForNull(params, ONE, "set_data_word_width", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE); 
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
      checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_data_word_width", lineNumber, fileName, canContinue);
    }
  }

  return canContinue;

}

void CSLOmCmdSetDataWordWidth::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  TBool canContinue = TRUE;
  RefCSLOmExpr width = CSLOmExpr::cast(params->at(0)->doEval(TRUE));//evaluating the argument once more; it should return the value from cache
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  if (scopeParent.get()) {
    switch (scopeParent->getType()) {
      case TYPE_LIST:
        objs = (CSLOmList::cast(scopeParent))->getObjects();
        for (it = objs->begin(); it < objs->end(); ++it) {
          if ((*it)->isMemoryMapLocationPage()) {
            (CSLOmMemoryMapPage::cast(*it))->setDataWordWidth(CSLOmNumber::cast(width));
          }
          else if ((*it)->isMemoryMap()) {
            //(CSLOmMemoryMap::cast(*it))->setDataWordWidth(CSLOmNumber::cast(width));
          }
          else {
            args.push_back(*getScopeValue(scopeParent));
            args.push_back("list of memory map pages or memory maps");
            addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
            canContinue = FALSE;
          }
        }
        break;
      case TYPE_MEMORY_MAP:
        //(CSLOmMemoryMap::cast(scopeParent))->setDataWordWidth(CSLOmNumber::cast(width));
        break;
      case TYPE_MEMORY_MAP_PAGE:
        (CSLOmMemoryMapPage::cast(scopeParent))->setDataWordWidth(CSLOmNumber::cast(width));
        break;
      default: 
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("list of memory map pages or memory maps");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
        break;
    }
  }
  else {//ALSO, YOU SHOULD NEVER GET HERE, BUT IF YOU DO, IT'S BAD
    args.push_back(*getScopeValue(scopeParent));
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber, fileName);//NULL COMMAND SCOPE
    canContinue = FALSE;
  }

}

// ********************************************************************************
// CSLOmCmdSetAlignment class
// ********************************************************************************

void CSLOmCmdSetAlignment::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetAlignment::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a nubmer. IMPORTANT! that number must be a multiple of the data word width
  checkParamSize(params, PARAM_SIZE_CMDSETALIGNMENT_LOWER, PARAM_SIZE_CMDSETALIGNMENT_UPPER,"set_alignment", lineNumber, fileName, canContinue);
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  checkParentType(f, PARENT_TYPE_SIZE_SETALIGNMENT, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue);

  if(checkArgumentForNull(params, ONE, "set_alignment", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE); 
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
      checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_alignment", lineNumber, fileName, canContinue);
    }
  } 
  if(!canContinue) {
    return FALSE;
  }

  //then there's another check for the alignment to be a multiple of the data word width
  RefCSLOmNumber nr = CSLOmNumber::cast(params->at(0)->doEval());

  RefTVec_RefCSLOmBase objs = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  TVec_RefCSLOmBase_const_iter it;
  if(scopeParent->isList()) {
    objs = CSLOmList::cast(scopeParent)->getObjects();
  }
  else {
    objs->push_back(scopeParent);
  }

  for(it = objs->begin(); it < objs->end(); ++it) {
    if((*it)->isMemoryMapLocationPage()) {
      RefCSLOmNumber dataWordWidth = CSLOmMemoryMapPage::cast(*it)->getDataWordWidth();
      if(dataWordWidth->getValue() == 0) {
        args.push_back(*getScopeValue(*it));
        args.push_back("not null data word width");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      if((dataWordWidth->getValue()) % (nr->getValue()) != 0) {
        args.push_back(*getScopeValue(*it));
        args.push_back("data word with to be multiple of alignment value");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }
  return canContinue;

}

void CSLOmCmdSetAlignment::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr alignament = CSLOmExpr::cast(params->at(0)->doEval(TRUE));//evaluating the argument once more; it should return the value from cache

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isMemoryMapLocationPage()) {
          (CSLOmMemoryMapPage::cast(*it))->setAlignment(CSLOmNumber::cast(alignament));
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of memory map pages");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
          canContinue = FALSE;
        }
      }
      break;
    case TYPE_MEMORY_MAP_PAGE:
      (CSLOmMemoryMapPage::cast(scopeParent))->setAlignment(CSLOmNumber::cast(alignament));
      break;
    default: 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("memory map page");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      canContinue = FALSE;
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetEndianess class
// ********************************************************************************

CSLOmMemoryMapPage::Endianess CSLOmCmdSetEndianess::m_endianessType = CSLOmMemoryMapPage::ENDIAN_UNDEFINED;

void CSLOmCmdSetEndianess::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetEndianess::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  //0 or 1 params. If one param exists it must be within the ENDIAN_UNDEFINED and the ENDIAN_MAX values. 
  checkParamSize(params, PARAM_SIZE_CMDSETENDIANESS_LOWER, PARAM_SIZE_CMDSETENDIANESS_UPPER,"set_endianess", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  checkParentType(f, PARENT_TYPE_SIZE_SETENDIANESS, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue);
  
  if(getEndianessParam() <= CSLOmMemoryMapPage::ENDIAN_UNDEFINED || getEndianessParam() >= CSLOmMemoryMapPage::ENDIAN_MAX) {
    args.push_back("set_endianess");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    canContinue = FALSE;

  }
 
  return canContinue;

}

void CSLOmCmdSetEndianess::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isMemoryMapLocationPage()) {
          (CSLOmMemoryMapPage::cast(*it))->setEndianess(m_endianessType);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of memory map pages");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_MEMORY_MAP_PAGE:
      if (scopeParent->isMemoryMapLocationPage()) {
        (CSLOmMemoryMapPage::cast(scopeParent))->setEndianess(m_endianessType);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("memory map page");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

void CSLOmCmdSetEndianess::setEndianessParam(CSLOmMemoryMapPage::Endianess param) {
  m_endianessType = param;
}

CSLOmMemoryMapPage::Endianess CSLOmCmdSetEndianess::getEndianessParam() {
  return m_endianessType;
}

// ********************************************************************************
// CSLOmCmdSetSymbolMaxLength class
// ********************************************************************************

void CSLOmCmdSetSymbolMaxLength::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetSymbolMaxLength::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be a number.
  checkParamSize(params, PARAM_SIZE_CMDSETSYMBOLMAXLENGTH_LOWER, PARAM_SIZE_CMDSETSYMBOLMAXLENGTH_UPPER,"set_symbol_max_length", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  checkParentType(f, PARENT_TYPE_SIZE_SETSYMBOLMAXLENGTH, scopeParent, scope, "memory map page", lineNumber, fileName, canContinue);

  if(checkArgumentForNull(params, ONE, "set_symbol_max_length", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE); 
 
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if(checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
      //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
      checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_symbol_max_length", lineNumber, fileName, canContinue);
    }
  }

  return canContinue;

}

void CSLOmCmdSetSymbolMaxLength::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmExpr length = CSLOmExpr::cast(params->at(0)->doEval(TRUE));//evaluating the argument once more; it should return the value from cache
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isMemoryMapLocationPage()) {
          (CSLOmMemoryMapPage::cast(*it))->setSymbolMaxLength(CSLOmNumber::cast(length));
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of memory map pages");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
        }
      }
      break;
    case TYPE_MEMORY_MAP_PAGE:
      (CSLOmMemoryMapPage::cast(scopeParent))->setSymbolMaxLength(CSLOmNumber::cast(length));
      break;
    default: 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("memory map page, memory map page instance");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdAutoGenMemMap class
// ********************************************************************************

void CSLOmCmdAutoGenMemMap::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdAutoGenMemMap::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  TBool canContinue = TRUE;//WILL BECOME FALSE IF AN ERROR IS FOUND

  //THIS COMMAND TAKES ONLY ONE ARGUMENT, SO WE MAKE SURE WE DIDN'T GET MORE OR LESS
  checkParamSize(params, PARAM_SIZE_CMDAUTOGENMEMMAP_LOWER, PARAM_SIZE_CMDAUTOGENMEMMAP_UPPER,"auto_gen_mem_map", lineNumber, fileName, canContinue);  
 
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMap};
  checkParentType(f, PARENT_TYPE_SIZE_AUTOGENMEMMAP, scopeParent, scope, "memory map", lineNumber, fileName, canContinue);

  return canContinue;
}

void CSLOmCmdAutoGenMemMap::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
 
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isMemoryMap()) {
          //(CSLOmMemoryMap::cast(*it))->autoGenMemMap();
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of memory maps");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
        }
      }
      break;
    case TYPE_MEMORY_MAP:
      //(CSLOmMemoryMap::cast(scopeParent))->autoGenMemMap(); //add cast method to Mem Map class
      break;
    default: 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("list of memory maps");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetTopUnit class
// ********************************************************************************

void CSLOmCmdSetTopUnit::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetTopUnit::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;                     

  //only 1 param that must be a MemoryMapPage
  checkParamSize(params, PARAM_SIZE_CMDSETTOPUNIT_LOWER, PARAM_SIZE_CMDSETTOPUNIT_UPPER, "set_top_unit", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMap};
  checkParentType(f, PARENT_TYPE_SIZE_SETTOPUNIT, scopeParent, scope, "memory map", lineNumber, fileName, canContinue);

  if(checkArgumentForNull(params, ONE, "set_top_unit", lineNumber, fileName, canContinue)) {
    TIsPredicate f2[] = {&CSLOmBase::isUnitDecl};
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    checkArgumentType(baseExpr, f2, ONE, "unit decl", lineNumber, fileName, canContinue);
  }
  
  return canContinue;
}

void CSLOmCmdSetTopUnit::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExprLink name  = CSLOmExprLink::cast(params->at(0));

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isMemoryMap()) {
          //(CSLOmMemoryMap::cast(*it))->setTopUnit(name->getName());
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit memory maps");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_MEMORY_MAP:
      //(CSLOmMemoryMap::cast(scopeParent))->setTopUnit(name->getName());
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("memory map");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdAddToMemoryMap class
// ********************************************************************************

void CSLOmCmdAddToMemoryMap::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdAddToMemoryMap::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //this command takes only 0, 1, 2 or 3 arguments; the check verifies that there are no more than 3
  checkParamSize(params, PARAM_SIZE_CMDADDTOMEMORYMAP_LOWER, PARAM_SIZE_CMDADDTOMEMORYMAP_UPPER, "add_to_memory_map", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isAddressable};
  checkParentType(f, PARENT_TYPE_SIZE_ADDTOMEMORYMAP, scopeParent, scope, "addressable object", lineNumber, fileName, canContinue);

  TInt size = params->size();
  if(size == -1) {
    //when there's only one argument, it is the address where the object should be added in the memory map
    if(checkArgumentForNull(params, ONE, "add_to_memory_map", lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
      TIsPredicate f[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr, f, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr, NO_GREATER_THAN_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "add_to_memory_map", lineNumber, fileName, canContinue);
      }
    }
    
  }
  else if(size == 2) {
    RefCSLOmBase eval = params->at(1)->doEval();
    if (!eval.get()) {
      args.push_back("add_to_memory_map");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    else if (!eval->isEnumItem()) {
      args.push_back("add_to_memory_map");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    //the first argument 
    //the second argument are the access rights
  }
  else if(size == 3) {
    
  }

  return canContinue;
}

void CSLOmCmdAddToMemoryMap::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isAddressable()) {
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("addressable object");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
        }
      }
      break;
    case TYPE_DECL_UNIT:
      if(scopeParent->isRegisterFile()) {
      }
      else if(scopeParent->isRegister()) {
      }
      else if(scopeParent->isFifo()) {
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
// CSLOmCmdSetAccessRights class
// ********************************************************************************

CSLOmAddressRange::EAccessRights CSLOmCmdSetAccessRights::m_accessRightsType = CSLOmAddressRange::ACC_NONE;

void  CSLOmCmdSetAccessRights::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }  
}

TBool CSLOmCmdSetAccessRights::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //2 or 3 params
  //number and expresion
  //number, number and expresion
  if(checkParamSize(params, PARAM_SIZE_CMDSETACCESSRIGHTS_LOWER, PARAM_SIZE_CMDSETACCESSRIGHTS_UPPER, "set_access_rights", lineNumber, fileName, canContinue)) {

    if(!checkArgumentForNull(params, ONE, "set_access_rights", lineNumber, fileName, canContinue)) {
      return FALSE;
    }
    RefCSLOmBase baseExpr = params->at(0)->doEval(TRUE);
    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue);
    if(params->size() == 2) {
      RefCSLOmBase baseExpr2 = params->at(1)->doEval();
      TIsPredicate f3[] = {&CSLOmBase::isExpr};
      checkArgumentType(baseExpr2, f3, ONE, "expression", lineNumber, fileName, canContinue);
    }
    else if(params->size() == 3) {
      RefCSLOmBase baseExpr2 = params->at(1)->doEval(TRUE);
      TIsPredicate f3[] = {&CSLOmBase::isNumber};
      checkArgumentType(baseExpr2, f3, ONE, "number", lineNumber, fileName, canContinue);
      RefCSLOmBase baseExpr3 = params->at(2)->doEval();
      TIsPredicate f4[] = {&CSLOmBase::isExpr};
      checkArgumentType(baseExpr2, f4, ONE, "expression", lineNumber, fileName, canContinue);
    }
  }

  //  RefCSLOmExprLink group  = CSLOmExprLink::cast(params->at(0));
  //
  //  if (group->isHID()) {
  //    args.push_back("set_access_rights");
  ////  addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
  //    canContinue = FALSE;
  //  }
  //  
  //  RefCSLOmIdentifier id1 = group->getLocalNameID();
  //  if (!id1.get()) {
  //    args.push_back(*group->getName());
  //    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber);
  ////    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, lineNumber, fileName);
  //    canContinue = FALSE;
  //    return canContinue;
  //  }
  //  ASSERT(id1->getParent().get(), "internal bug, identifier without parent found");
  //  if (!id1->getParent()->isEnum()) {
  //    args.push_back(*id1->getName());
  //    args.push_back("set_access_rights");
  //    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber);
  ////    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
  //    canContinue = FALSE;
  //  }
  //
  if(m_accessRightsType > CSLOmAddressRange::ACC_RD_WR || m_accessRightsType < CSLOmAddressRange::ACC_NONE) {
    args.push_back("set_access_rights");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    canContinue = FALSE;
  }

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMapLocationPage};
  checkParentType(f, PARENT_TYPE_SIZE_SETACCESSRIGHTS, scopeParent, scope, "set_acces_rights", lineNumber, fileName, canContinue);
  

  return canContinue;  
}

void  CSLOmCmdSetAccessRights::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_MEMORY_MAP_PAGE:
      if (params->size() == 2) {
        CSLOmMemoryMapPage::cast(scopeParent)->setAccessRights(CSLOmNumber::cast(params->at(0)->doEval(TRUE)), CSLOmNumber::cast(params->at(0)->doEval(TRUE)), 
                                                               CSLOmExprLink::cast(params->at(1)), m_accessRightsType);
      }
      else {
        CSLOmMemoryMapPage::cast(scopeParent)->setAccessRights(CSLOmNumber::cast(params->at(0)->doEval(TRUE)), CSLOmNumber::cast(params->at(1)->doEval(TRUE)), 
                                                               CSLOmExprLink::cast(params->at(2)), m_accessRightsType);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("memory map page");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
  setAccessRightsParam(CSLOmAddressRange::ACC_NONE);
  
}

void CSLOmCmdSetAccessRights::setAccessRightsParam(CSLOmAddressRange::EAccessRights param) {
  m_accessRightsType = param;
}

CSLOmAddressRange::EAccessRights CSLOmCmdSetAccessRights::getAccessRightsParam() {
  return m_accessRightsType;
}



// ********************************************************************************
// CSLOmCmdSetAccessRightsEnum class
// ********************************************************************************

void CSLOmCmdSetAccessRightsEnum::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetAccessRightsEnum::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be an Enum
  checkParamSize(params, PARAM_SIZE_CMDSETACCESSRIGHTSENUM_LOWER, PARAM_SIZE_CMDSETACCESSRIGHTSENUM_UPPER, "set_access_rights_enum", lineNumber, fileName, canContinue); 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMap};
  checkParentType(f, PARENT_TYPE_SIZE_SETACCESSRIGHTSENUM, scopeParent, scope, "memory map", lineNumber, fileName, canContinue);

  //evaluate parameters:

  if(checkArgumentForNull(params, ONE, "set_access_rights_enum", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseEnum = params->at(0)->doEval(); 

    TIsPredicate f2[] = {&CSLOmBase::isEnum};
    checkArgumentType(baseEnum, f2, ONE, "enum", lineNumber, fileName, canContinue);
  }

  return canContinue;

}

void CSLOmCmdSetAccessRightsEnum::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_MEMORY_MAP: 
      if (scopeParent->isMemoryMap()) { 
        //(CSLOmMemoryMap::cast(scopeParent))->setAccessRightsEnum(CSLOmEnum::cast(params->at(0)->doEval()));
      }
      else {
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("csl_memory_map");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      }
      break;
    default: 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("csl_memory_map");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetInstanceName class
// ********************************************************************************

void CSLOmCmdSetInstanceName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetInstanceName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //only 1 param that must be an expression link (name)
  checkParamSize(params, PARAM_SIZE_CMDSETINSTANCENAME_LOWER, PARAM_SIZE_CMDSETINSTANCENAME_UPPER, "set_instance_name", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMap};
  checkParentType(f, ONE, scopeParent, scope, "memory map", lineNumber, fileName, canContinue);
  
  RefCSLOmExprLink topUnitInstName  = CSLOmExprLink::cast(params->at(0));
  ASSERT(topUnitInstName.get(), "NULL topUnitInstName");
  
  return canContinue;
}

void CSLOmCmdSetInstanceName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
}

// ********************************************************************************
// CSLOmCmdSetPageNo class
// ********************************************************************************

void CSLOmCmdSetPageNo::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetPageNo::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  TBool canContinue = TRUE;//WILL BECOME FALSE IF AN ERROR IS FOUND

  checkParamSize(params, PARAM_SIZE_CMDSETPAGENO_LOWER, PARAM_SIZE_CMDSETPAGENO_UPPER, "set_page_no", lineNumber, fileName, canContinue);

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isMemoryMap};
  checkParentType(f, PARENT_TYPE_SIZE_SETPAGENO, scopeParent, scope, "memory map", lineNumber, fileName, canContinue);

  RefCSLOmExprLink pageName  = CSLOmExprLink::cast(params->at(0));

  if (pageName->isHID()) {
    args.push_back("set_page_no");
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    canContinue = FALSE;
  }

  if(checkArgumentForNull(params, 2, "set_page_no", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(1)->doEval(TRUE); 

    TIsPredicate f2[] = {&CSLOmBase::isNumber};
    if (checkArgumentType(baseExpr, f2, ONE, "number", lineNumber, fileName, canContinue)) {
    
      //ckeck if the number is not equal to 0, that it doesn't have xz and that it is an INT32
      checkNumber(baseExpr, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_page_no", lineNumber, fileName, canContinue);
    }
  }

  return canContinue;

}

void CSLOmCmdSetPageNo::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExprLink pageName  = CSLOmExprLink::cast(params->at(0));
  RefCSLOmExpr no = CSLOmExpr::cast(params->at(1)->doEval(TRUE));              //evaluating the argument once more; it should return the value from cache

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isMemoryMap()) {
          //implement it in CSLOM
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of memory maps");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
        }
      }
      break;
    case TYPE_MEMORY_MAP:
      break;
    default: 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("list of memory maps");//
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetAsmMnemonic class
// ********************************************************************************

void CSLOmCmdSetAsmMnemonic::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
 
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetAsmMnemonic::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isIsaField};
  checkParentType(f, ONE, scopeParent, scope, "isa_field",lineNumber, fileName, canContinue);

  //only 1 param that must be an expression link (name)
  if(checkParamSize(params, ONE, ONE, "set_mnemonic", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNotNull(params, params->size(), "set_mnemonic", scopeParent, lineNumber, fileName, canContinue)) {
      RefCSLOmBase baseExpr = params->at(0)->doEval();
      TIsPredicate f2[] = {&CSLOmBase::isString};
      if(checkArgumentType(baseExpr, f2, ONE, "string", lineNumber, fileName, canContinue)) {
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

void CSLOmCmdSetAsmMnemonic::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmExpr expr  = params->at(0);
 
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isIsaField()) {
          if(expr->isHybridORFuncCall()) {
            RefCSLOmBase base1 = expr->doEval();
            if(base1.get()) {
              RefCSLOmString exprL = CSLOmString::cast(base1);
               CSLOmIsaField::cast(*it)->setMnemonic(exprL->getValue());
            }
          }
          else {
            RefCSLOmString exprL = CSLOmString::cast(expr);
            CSLOmIsaField::cast(*it)->setMnemonic(exprL->getValue());
          }
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of isa fields");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);//wrong list type
        }
      }
      break;
    case TYPE_BIT_RANGE:
      if(expr->isHybridORFuncCall()) {
        RefCSLOmBase base1 = expr->doEval();
        if(base1.get()) {
          RefCSLOmString exprL = CSLOmString::cast(base1);
          (CSLOmIsaField::cast(scopeParent))->setMnemonic(exprL->getValue());
        }
      }
      else {
        RefCSLOmString exprL = CSLOmString::cast(expr);
        (CSLOmIsaField::cast(scopeParent))->setMnemonic(exprL->getValue());
      }

      break;
    default: 
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("list of memory maps");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }

  //  setMnemonic();
}

// ********************************************************************************
// CSLOmCmdSetDecoderName class
// ********************************************************************************

void CSLOmCmdSetDecoderName::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDecoderName::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  return FALSE;
}

void CSLOmCmdSetDecoderName::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

}

// ********************************************************************************
// CSLOmCmdSetDecoderOutNamePrefix class
// ********************************************************************************

void CSLOmCmdSetDecoderOutNamePrefix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDecoderOutNamePrefix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  return FALSE;
}

void CSLOmCmdSetDecoderOutNamePrefix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

}

// ********************************************************************************
// CSLOmCmdSetDecoderOutNameSuffix class
// ********************************************************************************

void CSLOmCmdSetDecoderOutNameSuffix::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDecoderOutNameSuffix::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  return FALSE;
}

void CSLOmCmdSetDecoderOutNameSuffix::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

}

// ********************************************************************************
// CSLOmCmdPrint class
// ********************************************************************************

void CSLOmCmdPrint::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "Received NULL parent");
  ASSERT(params.get(), "Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdPrint::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  return FALSE;
}

void CSLOmCmdPrint::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {

}

//multiDimBitRange stuff

// ********************************************************************************
// CSLOmCmdSetDimWidth class
// ********************************************************************************

void  CSLOmCmdSetDimWidth::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimWidth::build()] Received NULL parent"  );
  ASSERT(params.get(), "[CSLOmCmdSetDimWidth::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDimWidth::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;
  
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal,&CSLOmBase::isMultiDimBitRange};
  if(!checkParentType(f, PARENT_TYPE_SIZE_SETDIMWIDTH, scopeParent, scope, "signal, multi dimensional bitrange", lineNumber, fileName, 
                      canContinue)) {
    return FALSE;
  }

  //The command has exactly 2 params that must both be numbers. The first one is the number or the dimension of the bitrange we want to modify, 
  //the 2nd one is the actual width.
  RefCSLOmBase baseExpr1;
  RefCSLOmBase baseExpr2;
  if(checkParamSize(params, PARAM_SIZE_CMDSETDIMWIDTH_LOWER, PARAM_SIZE_CMDSETDIMWIDTH_UPPER,"set_dim_width", lineNumber, fileName, canContinue)) {
   
    if(checkArgumentForNull(params, ONE, "set_dim_width", lineNumber, fileName, canContinue)) {
      baseExpr1 = params->at(0)->doEval(TRUE);
      baseExpr2 = params->at(1)->doEval(TRUE);
 
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr1, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr1, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_width", lineNumber, fileName, canContinue);
      }
      if(checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        if(baseExpr2->isNumber()) {
          checkNumber(baseExpr2, NO_NOT_EQUAL_TO_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_width", lineNumber, fileName, canContinue);
        }
      }
    }
    if(!canContinue) {
      //one of the arguments is null so further checks cannot be made
      return FALSE;
    }
  }

  RefCSLOmNumber nr = CSLOmNumber::cast(baseExpr1);
  
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
      /*RefCSLOmExprLink exprLink = CSLOmExprLink::cast(*it);
        if(exprLink->hasBitRange()) {
        canContinue = FALSE;
        }
      */
      RefCSLOmBaseRange br = CSLOmSignal::cast(*it)->getBitRange();
      if(!br->isMultiDimBitRange()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_NOT_MULTIDIM_OBJECT, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
      }
      RefCSLOmMultiDimBitRange mbr = CSLOmMultiDimBitRange::cast(br);
      RefCSLOmExpr noDims = mbr->getNoOfDims();
      if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
      }
      if(!mbr->dimIsDefault(nr->getValue())) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
      }
    }
    else if((*it)->isMultiDimBitRange()) {
      RefCSLOmExpr noDims = CSLOmMultiDimBitRange::cast(*it)->getNoOfDims();
      if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
      }
      else if(!CSLOmMultiDimBitRange::cast(*it)->dimIsDefault(nr->getValue())) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
      }

    }
  }

  return canContinue;
}

void CSLOmCmdSetDimWidth::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr dim = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefCSLOmExpr width = CSLOmExpr::cast(params->at(1)->doEval(TRUE));
    
  RefCSLOmExpr dimNo = CSLOmNum32::build(lineNumber, fileName, CSLOmNum32::cast(dim)->getValue());
  RefCSLOmExpr widthNo = CSLOmNum32::build(lineNumber, fileName, CSLOmNum32::cast(width)->getValue());

  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setDimensionWidth(dimNo, widthNo);
        }
        else if ((*it)->isMultiDimBitRange()) {
          (CSLOmMultiDimBitRange::cast(*it))->setDimWidth(dim, width);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/bitranges");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setDimensionWidth(dimNo, widthNo);
      }
      break;
    case TYPE_BIT_RANGE:
      (CSLOmMultiDimBitRange::cast(scopeParent))->setDimWidth(dim, width);
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal or bitrange");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetDimBitRange class
// ********************************************************************************

void  CSLOmCmdSetDimBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimBitRange::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimBitRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDimBitRange::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isMultiDimBitRange};
  checkParentType(f, PARENT_TYPE_SIZE_SETDIMBITRANGE, scopeParent, scope, "signal or bitrange", lineNumber, fileName, canContinue);

  //2 params, number and (multi dimensional) bitrange
  RefCSLOmBase baseExpr1;
  RefCSLOmBase expr2;
  if(checkParamSize(params, PARAM_SIZE_CMDSETDIMBITRANGE_LOWER, PARAM_SIZE_CMDSETDIMBITRANGE_UPPER,"set_dim_bitrange", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_dim_bitrange", lineNumber, fileName, canContinue)) {
      baseExpr1 = params->at(0)->doEval(TRUE);
      expr2 = params->at(1)->doEval();

      //the first parameter is the dimension, so it should be a number
      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr1, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr1, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_bitrange", lineNumber, fileName, canContinue);
      }
      //the second parameter is the bitrange
      TIsPredicate f3[] = {&CSLOmBase::isSimpleBitRange};
      checkArgumentType(expr2, f3, ONE, "number", lineNumber, fileName, canContinue);
    }
    else {
      return FALSE;
    }
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
    if((*it)->isSignal()) {
      //Part select not allowed
      /*RefCSLOmExprLink exprLink = CSLOmExprLink::cast(*it);
        if(exprLink->hasBitRange()) {
        canContinue = FALSE;
        }
      */
      RefCSLOmBaseRange br = CSLOmSignal::cast(*it)->getBitRange();
      if(!br->isMultiDimBitRange()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_NOT_MULTIDIM_OBJECT, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;  
      }
      RefCSLOmMultiDimBitRange mbr = CSLOmMultiDimBitRange::cast(br);
      RefCSLOmNumber nr = CSLOmNumber::cast(baseExpr1);
      RefCSLOmExpr noDims = mbr->getNoOfDims();
      if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {                           
        //the dimension(first parameter) should be smaller than the total number of dimensions
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      else {
        RefCSLOmSimpleBitRange sbr = mbr->getDimBitRange(nr);
        if(!sbr->isDefault()) {
          args.push_back("set_dim_bitrange");
          addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
    else if((*it)->isMultiDimBitRange()) {
      RefCSLOmNumber nr = CSLOmNumber::cast(baseExpr1);
      RefCSLOmMultiDimBitRange mbr = CSLOmMultiDimBitRange::cast(*it);
      RefCSLOmExpr noDims = mbr->getNoOfDims();
      if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
      }
      else {
        RefCSLOmSimpleBitRange sbr = mbr->getDimBitRange(nr);
        if(!sbr->isDefault()) {
          args.push_back("set_dim_bitrange");
          addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetDimBitRange::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr dim = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefCSLOmBase evalBitRange = params->at(1)->doEval();
  if(evalBitRange.get()) {
    ASSERT(evalBitRange->getType() == TYPE_BIT_RANGE, "SHOULD BE OF TYPE BITRANGE");
  }
  else { 
    return;
  }
  RefCSLOmSimpleBitRange bitRange = CSLOmSimpleBitRange::cast(evalBitRange);
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setDimBitRange(dim, bitRange);
        }
        else if ((*it)->isMultiDimBitRange()) {
          (CSLOmMultiDimBitRange::cast(*it))->setDimBitRange(dim, bitRange);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/bitranges");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setDimBitRange(dim, bitRange);
      }
      break;
    case TYPE_BIT_RANGE:
      if(scopeParent->isBitRange()) {
        (CSLOmMultiDimBitRange::cast(scopeParent))->setDimBitRange(dim, bitRange);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal or bitrange");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetDimOffset class
// ********************************************************************************

void  CSLOmCmdSetDimOffset::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimOffset::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimOffset::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDimOffset::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //2 params that must be numbers
  RefCSLOmBase baseExpr1;
  RefCSLOmBase baseExpr2;
  if(checkParamSize(params, PARAM_SIZE_CMDSETDIMOFFSET_LOWER, PARAM_SIZE_CMDSETDIMOFFSET_UPPER,"set_dim_offset", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_dim_offset", lineNumber, fileName, canContinue)) {
    
      //check if the parameters have the correct type
      baseExpr1 = params->at(0)->doEval(TRUE);
      baseExpr2 = params->at(1)->doEval(TRUE);

      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr1, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr1, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_offset", lineNumber, fileName, canContinue);
      }
      if(checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr2, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_offset", lineNumber, fileName, canContinue);
      }
    } 
  } 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isMultiDimBitRange};
  checkParentType(f, PARENT_TYPE_SIZE_SETDIMOFFSET, scopeParent, scope, "signal or multi dimensional bitrange",lineNumber, fileName, canContinue);
  
  //because the arguments received are used in casts and in checks, if one of the checks above failed, we shouldn't continue
  if(!canContinue) {
    return canContinue;
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
    if((*it)->isSignal()) {
      //Part select not allowed
      /*RefCSLOmExprLink exprLink = CSLOmExprLink::cast(*it);
        if(exprLink->hasBitRange()) {
        canContinue = FALSE;
        }
      */
      RefCSLOmBaseRange br = CSLOmSignal::cast(*it)->getBitRange();
      if(!br->isMultiDimBitRange()) {
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_NOT_MULTIDIM_OBJECT, args, lineNumber, fileName);
        canContinue = FALSE;
        return canContinue;
      }
      if(baseExpr1->isNumber()) {
        RefCSLOmMultiDimBitRange mbr = CSLOmMultiDimBitRange::cast(br);
        RefCSLOmNumber nr = CSLOmNumber::cast(baseExpr1);
        RefCSLOmExpr noDims = mbr->getNoOfDims();
        if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {
          args.push_back(intToString(nr->getValue()));
          addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
          canContinue = FALSE;
        }
      }
    }
    else if((*it)->isMultiDimBitRange()) {
      RefCSLOmMultiDimBitRange mbr = CSLOmMultiDimBitRange::cast(*it);
      RefCSLOmNumber nr = CSLOmNumber::cast(baseExpr1);
      RefCSLOmExpr noDims = mbr->getNoOfDims();
      if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {
        args.push_back(intToString(nr->getValue()));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetDimOffset::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr dim = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefCSLOmExpr offsetDim = CSLOmExpr::cast(params->at(1)->doEval(TRUE));
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setDimOffset(dim, offsetDim);
        }
        else if ((*it)->isMultiDimBitRange()) {
          (CSLOmMultiDimBitRange::cast(*it))->setDimOffset(dim, offsetDim);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/bitranges");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setDimOffset(dim, offsetDim);
      }
      break;
    case TYPE_BIT_RANGE:
      if(scopeParent->isMultiDimBitRange()) {
        (CSLOmMultiDimBitRange::cast(scopeParent))->setDimOffset(dim, offsetDim);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal or bitrange");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
}

// ********************************************************************************
// CSLOmCmdSetDimRange class
// ********************************************************************************

void  CSLOmCmdSetDimRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimRange::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetDimRange::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  //3 params, all numbers
  RefCSLOmBase baseExpr1;
  RefCSLOmBase baseExpr2;
  RefCSLOmBase baseExpr3;
  if( checkParamSize(params, PARAM_SIZE_CMDSETDIMRANGE_LOWER, PARAM_SIZE_CMDSETDIMRANGE_UPPER,"set_dim_range", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "set_dim_range", lineNumber, fileName, canContinue)) {
      baseExpr1 = params->at(0)->doEval(TRUE);
      baseExpr2 = params->at(1)->doEval(TRUE);
      baseExpr3 = params->at(2)->doEval(TRUE);

      TIsPredicate f2[] = {&CSLOmBase::isNumber};
      if(checkArgumentType(baseExpr1, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr1, NO_GREATER_THAN_VALUE, -1, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_range", lineNumber, fileName, canContinue);
      }
      if(checkArgumentType(baseExpr2, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr2, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_range", lineNumber, fileName, canContinue);
      }
      if(checkArgumentType(baseExpr3, f2, ONE, "number", lineNumber, fileName, canContinue)) {
        checkNumber(baseExpr3, NO_DO_NOT_CHECK_VALUE, ZERO, NO_CHECK_FOR_NOT_XZ, TRUE, "set_dim_range", lineNumber, fileName, canContinue);
      }
    }
  }

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isSignal, &CSLOmBase::isBitRange};
  checkParentType(f, PARENT_TYPE_SIZE_SETDIMRANGE, scopeParent, scope, "signal or bitrange", lineNumber, fileName, canContinue);

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
      /*RefCSLOmExprLink exprLink = CSLOmExprLink::cast(*it);
        if(exprLink->hasBitRange()) {
        canContinue = FALSE;
        }
      */
      RefCSLOmBaseRange br = CSLOmSignal::cast(*it)->getBitRange();
      RefCSLOmNumber nr = CSLOmNumber::cast(baseExpr1);
      if(!br->isMultiDimBitRange()) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        return FALSE;
      }
      RefCSLOmMultiDimBitRange mbr = CSLOmMultiDimBitRange::cast(br);
      RefCSLOmExpr noDims = mbr->getNoOfDims();
      if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
    else if((*it)->isMultiDimBitRange()) {
      RefCSLOmMultiDimBitRange br = CSLOmMultiDimBitRange::cast(*it);
      RefCSLOmNumber nr = CSLOmNumber::cast(baseExpr1);
      RefCSLOmExpr noDims = br->getNoOfDims();
      if(nr->getValue() >= CSLOmNumber::cast(noDims->doEval())->getValue()) {
        args.push_back(intToString(nr->getValue()));
        args.push_back(*getScopeValue(*it));
        addErr(NSWarningErr::DEE_CSC_DMSN_DEE_CSC_DMSN_ILLEGAL_DIM, args, lineNumber, fileName);
        canContinue = FALSE;
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetDimRange::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmExpr dim = CSLOmExpr::cast(params->at(0)->doEval(TRUE));
  RefCSLOmExpr lowerIndex = CSLOmExpr::cast(params->at(1)->doEval(TRUE));
  RefCSLOmExpr upperIndex = CSLOmExpr::cast(params->at(2)->doEval(TRUE));

  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isSignal()) {
          (CSLOmSignal::cast(*it))->setDimRange(dim, lowerIndex, upperIndex);
        }
        else if ((*it)->isBitRange()) {
          (CSLOmMultiDimBitRange::cast(*it))->setDimRange(dim, lowerIndex, upperIndex);
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of signals/bitranges");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if (scopeParent->isSignal()) {
        (CSLOmSignal::cast(scopeParent))->setDimRange(dim, lowerIndex, upperIndex);
      }
      break;
      
    case TYPE_BIT_RANGE:
      if(scopeParent->isMultiDimBitRange()) {
        (CSLOmMultiDimBitRange::cast(scopeParent))->setDimRange(dim, lowerIndex, upperIndex);
      }
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("signal or bitrange");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
  
}

//to be commented

// ********************************************************************************
// CSLOmCmdVSDSetAddPortSigIfc class
// ********************************************************************************
void CSLOmCmdVSDSetAddPortSigIfc::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}
TBool CSLOmCmdVSDSetAddPortSigIfc::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue=TRUE;

  //1 or more params 

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isVector};
  checkParentType(f, ONE, scopeParent, scope, "vector", lineNumber, fileName, canContinue);

  if(checkParamSize(params, ONE, 10000, "vector", lineNumber, fileName, canContinue)) {
    if(checkArgumentForNull(params, ONE, "vector", lineNumber, fileName, canContinue)) {
      TIsPredicate f2[] = {&CSLOmBase::isExprLink};
      TIsPredicate f3[] = {&CSLOmBase::isPort, &CSLOmBase::isInterface, &CSLOmBase::isSignal, &CSLOmBase::isSignalGroup};
      for(TUInt i = 0; i < params->size(); ++i) {
        RefCSLOmBase baseExpr = params->at(0);
        if(checkArgumentType(baseExpr, f2, ONE, "expresion link", lineNumber, fileName, canContinue)) {
          RefCSLOmBase baseExprEvaled = params->at(0)->doEval();
          if(checkArgumentType(baseExprEvaled, f3, 4, "port, interface, signal or signal group", lineNumber, fileName, canContinue)) {
      // if((CSLOmConnectable::cast(baseExprEvaled)->getParentUnit()).get()==(CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo())->getModuleName()).get()) {
            //                 args.push_back(*getScopeValue(scopeParent));
            //                 args.push_back(TBV_OR_TBVLIST);
            ////               addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
            //                 cslomHasErrors = TRUE;
            //               }
          }
        }
      } 
    }
  }
  return canContinue;
}
void CSLOmCmdVSDSetAddPortSigIfc::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber,fileName);
  RefCSLOmBase baseExprEvaled = params->at(0)->doEval();
  
  //  switch (scopeParent->getType()) {
  //     case TYPE_DECL_UNIT:
  //       for(int i=0; i<params->size(); ++i) {
  //         if(baseExprEvaled->isSignal()) {
  //           (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setAddToSignals(params->at(i));
  //         }
  //         else if(baseExprEvaled->isSignalGroup()) {
  //           (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setSG(params->at(i));
  //         }
  //         else if(baseExprEvaled->isPort()) {
  //           (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setAddToPorts(params->at(i));
  //         }
  //         else if(baseExprEvaled->isInterface()) {
  //           (CSLOmVectorInfo::cast(CSLOmUnitDecl::cast(scopeParent)->getUnitInfo()))->setIfc(params->at(i));
  //         }
  //       }
  //       break;
  //     default:
  //       args.push_back(*getScopeValue(scopeParent));
  //       args.push_back(UD_OR_UD_LIST);
  ////     addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
  //       cslomHasErrors = TRUE;
  //       break;
  // }
}




////////////////
//Interconnect//
///////////////


// ********************************************************************************
// CSLOmCmdNoGenRTL class
// ********************************************************************************

void  CSLOmCmdNoGenRTL::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimRange::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdNoGenRTL::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  if(checkParentType(f, PARENT_TYPE_SIZE_NOGENRTL, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue)) {
    if(CSLOmUnitDecl::cast(scopeParent)->isSetDoNotGenerateRTL()) {
      args.push_back("do_not_gen_rtl");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    //TODO: change error message
    if(CSLOmUnitDecl::cast(scopeParent)->isSetGenerateUniqueRTL()) {
      args.push_back("gen_unique_rtl_modules");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }

  checkParamSize(params, ZERO, ZERO, "do_not_gen_rtl", lineNumber, fileName, canContinue);

  return canContinue;
}

void CSLOmCmdNoGenRTL::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          CSLOmUnitDecl::cast(*it)->doNotGenerateRTL();
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmUnitDecl::cast(scopeParent)->doNotGenerateRTL();
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
  
}



// ********************************************************************************
// CSLOmCmdGenUniqueRTLModules class
// ********************************************************************************

void  CSLOmCmdGenUniqueRTLModules::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimRange::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdGenUniqueRTLModules::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  if(checkParentType(f, PARENT_TYPE_SIZE_GENUNIQUERTLMODULES, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue)) {
    if(CSLOmUnitDecl::cast(scopeParent)->isSetGenerateUniqueRTL()) {
      args.push_back("gen_unique_rtl_modules");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_WARNING_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
    if(CSLOmUnitDecl::cast(scopeParent)->isSetDoNotGenerateRTL()) {
      args.push_back("do_not_gen_rtl");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }

  checkParamSize(params, ZERO, ZERO, "gen_unique_rtl_modules", lineNumber, fileName, canContinue);

  return canContinue;
}

void CSLOmCmdGenUniqueRTLModules::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          CSLOmUnitDecl::cast(*it)->generateUniqueRTL();
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmUnitDecl::cast(scopeParent)->generateUniqueRTL();
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
  
}


// ********************************************************************************
// CSLOmCmdRegisterIOS class
// ********************************************************************************

void  CSLOmCmdRegisterIOS::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimRange::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdRegisterIOS::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  checkParentType(f, PARENT_TYPE_SIZE_REGISTERIOS, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue);

  checkParamSize(params, ONE, 4, "register_ios", lineNumber, fileName, canContinue);

  /*       In order for this to work all connectivity elements involved need to have a clock associated to
           them with the set_clock() method (because each port in the unit's interface can be clocked by a dif-
           ferent clock line) otherwise this will result in an error.
  */

  return canContinue;
}

void CSLOmCmdRegisterIOS::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {

        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
  
}


// ********************************************************************************
// CSLOmCmdSetClock class
// ********************************************************************************

void  CSLOmCmdSetClock::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimRange::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdSetClock::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl, &CSLOmBase::isPort, &CSLOmBase::isSignal, &CSLOmBase::isSignalGroup, &CSLOmBase::isInterface};
  checkParentType(f, PARENT_TYPE_SIZE_SETCLOCK, scopeParent, scope, "unit declaration, port, signal signal group or interface", lineNumber, fileName, canContinue);

  if(scopeParent->isUnitDecl()) {
    if(CSLOmUnitDecl::cast(scopeParent)->wasAssociatedClockSet() == TRUE) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSA_DSGN_SET_CLOCK_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  else if(scopeParent->isPort()) {
    //Part select not allowed
    RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
    if(exprLink->hasBitRange()) {
      canContinue = FALSE;
    }
    
    if(CSLOmPortDecl::cast(scopeParent)->wasAssociatedClockSet() == TRUE) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSA_DSGN_SET_CLOCK_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  else if(scopeParent->isSignal()) {
    //Part select not allowed
    RefCSLOmExprLink exprLink = CSLOmExprLink::cast(scope);
    if(exprLink->hasBitRange()) {
      canContinue = FALSE;
    }
    
    if(CSLOmSignal::cast(scopeParent)->wasAssociatedClockSet() == TRUE) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSA_DSGN_SET_CLOCK_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  else if(scopeParent->isSignalGroup()) {
    if(CSLOmGroupSignal::cast(scopeParent)->wasAssociatedClockSet() == TRUE) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSA_DSGN_SET_CLOCK_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }
  else if(scopeParent->isInterface()) {
    if(CSLOmInterface::cast(scopeParent)->wasAssociatedClockSet() == TRUE) {
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSA_DSGN_SET_CLOCK_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }


  if(checkParamSize(params, ONE, ONE, "set_clock", lineNumber, fileName, canContinue)) {
    RefCSLOmBase baseExpr = params->at(0)->doEval();
    if (checkArgumentForNull(params, ONE, "set_clock", lineNumber, fileName, canContinue)) {
      TIsPredicate f2[] = {&CSLOmBase::isPort, &CSLOmBase::isSignal};
      if(checkArgumentType(baseExpr, f2, 2, "port or signal", lineNumber, fileName, canContinue)) {
        if(*getScopeValue(scopeParent) == *getScopeValue(baseExpr)) {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back(*getScopeValue(baseExpr));
          addErr(NSWarningErr::DEE_CSC_DSGN_SET_ITSELF_AS_CLOCK, args, lineNumber, fileName);
          canContinue = FALSE;
        }
        //the attribute of the signal/port must be clock
        ECSLOmSignalAttr attr;
        if(baseExpr->isPort()) {
          attr = CSLOmPortDecl::cast(baseExpr)->getAttr();
          if(attr != ATTR_CLK) {
            canContinue = FALSE;
            args.push_back(*getScopeValue(baseExpr));
            addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
          }
          //Part select not allowed
          RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
          if(exprLink->hasBitRange()) {
            args.push_back("set_clock");
            addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
            canContinue = FALSE;
          }
        }
        else {
          attr = CSLOmSignal::cast(baseExpr)->getSignalAttr();
          if(attr != ATTR_CLK) {
            canContinue = FALSE;
            args.push_back(*getScopeValue(baseExpr));
            addErr(NSWarningErr::DEE_CSC_DSGN_PORT_WRONG_ATTR, args, lineNumber, fileName);
          }
          //Part select not allowed
          RefCSLOmExprLink exprLink = CSLOmExprLink::cast(params->at(0));
          if(exprLink->hasBitRange()) {
            args.push_back("set_clock");
            addErr(NSWarningErr::DEE_CSC_DSGN_PART_SELECT_NOT_ALLOWED, args, lineNumber, fileName);
            canContinue = FALSE;
          }
        }
      }
    }
  }

  return canContinue;
}

void CSLOmCmdSetClock::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  RefCSLOmBase clock = params->at(0)->doEval();

  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {

        }
        else if((*it)->isPort()) {
          CSLOmPortDecl::cast(*it)->associateClock(CSLOmConnectable::cast(clock));
        }
        else if((*it)->isSignalGroup()) {
          CSLOmGroupSignal::cast(*it)->associateClock(CSLOmConnectable::cast(clock));
        }
        else if((*it)->isSignal()) {
          CSLOmSignal::cast(*it)->associateClock(CSLOmConnectable::cast(clock));
        }
        else if((*it)->isInterface()) {
          CSLOmInterface::cast(*it)->associateClock(CSLOmConnectable::cast(clock));
        }
        else {
          cslomHasErrors = TRUE;
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations/ports/signals/signal groups/interfaces");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_CONNECTABLE:
      if(scopeParent->isPort()) {
          CSLOmPortDecl::cast(scopeParent)->associateClock(CSLOmConnectable::cast(clock));
      }
      else if(scopeParent->isSignal()) {
          CSLOmSignal::cast(scopeParent)->associateClock(CSLOmConnectable::cast(clock));
      }
      else if(scopeParent->isSignalGroup()) {
        CSLOmGroupSignal::cast(scopeParent)->associateClock(CSLOmConnectable::cast(clock));
      }
      else if(scopeParent->isInterface()) {
          CSLOmInterface::cast(scopeParent)->associateClock(CSLOmConnectable::cast(clock));
      }
      else {
        cslomHasErrors = TRUE;
        args.push_back(*getScopeValue(scopeParent));
        args.push_back("unit declaration, port, signal, signal group or interface");
        addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      }
      break;
    case TYPE_DECL_UNIT:
          CSLOmUnitDecl::cast(scopeParent)->associateClock(CSLOmConnectable::cast(clock));
      break;
    default:
      cslomHasErrors = TRUE;
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration, port, signal, signal group or inteface");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
  
}



// ********************************************************************************
// CSLOmCmdDoNotGenCPP class
// ********************************************************************************

void  CSLOmCmdDoNotGenCPP::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  ASSERT(parent.get(), "[CSLOmCmdSetDimRange::build()] Received NULL parent");
  ASSERT(params.get(), "[CSLOmCmdSetDimRange::build()] Received no parameters");

  if(check(lineNumber, fileName, parent, scope, params)) {
    execute(lineNumber, fileName, parent, scope, params);
  }
  else {
    cslomHasErrors = TRUE;
  }
}

TBool CSLOmCmdDoNotGenCPP::check(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  TBool canContinue = TRUE;

  RefCSLOmBase scopeParent = checkParentScope(scope,lineNumber, fileName, canContinue);
  if(!scopeParent.get()) {
    return FALSE;
  }
  TIsPredicate f[] = {&CSLOmBase::isUnitDecl};
  if(checkParentType(f, PARENT_TYPE_SIZE_DONOTGENCPP, scopeParent, scope, "unit declaration", lineNumber, fileName, canContinue)) {
    if(CSLOmUnitDecl::cast(scopeParent)->isSetDoNotGenerateCPP()) {
      args.push_back("do_not_gen_cpp");
      args.push_back(*getScopeValue(scopeParent));
      addErr(NSWarningErr::DEE_CSC_DSGN_WARNING_COMMAND_ALREADY_CALLED, args, lineNumber, fileName);
      canContinue = FALSE;
    }
  }

  checkParamSize(params, ZERO, ZERO, "do_not_gen_cpp", lineNumber, fileName, canContinue);

  return canContinue;
}

void CSLOmCmdDoNotGenCPP::execute(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExprLink scope, RefTVec_RefCSLOmExpr params) {
  RefTVec_RefCSLOmBase objs;
  TVec_RefCSLOmBase_const_iter it;
  RefCSLOmBase scopeParent = checkParentScope(scope, lineNumber, fileName);
  
  switch (scopeParent->getType()) {
    case TYPE_LIST:
      objs = (CSLOmList::cast(scopeParent))->getObjects();
      for (it = objs->begin(); it < objs->end(); ++it) {
        if ((*it)->isUnitDecl()) {
          CSLOmUnitDecl::cast(*it)->doNotGenerateCPP();
        }
        else {
          args.push_back(*getScopeValue(scopeParent));
          args.push_back("list of unit declarations");
          addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
        }
      }
      break;
    case TYPE_DECL_UNIT:
      CSLOmUnitDecl::cast(scopeParent)->doNotGenerateCPP();
      break;
    default:
      args.push_back(*getScopeValue(scopeParent));
      args.push_back("unit declaration");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, lineNumber, fileName);
      break;
  }
  
}


}

