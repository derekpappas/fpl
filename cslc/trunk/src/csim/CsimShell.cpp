//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007 Fastpath Logic
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

#include "CsimShell.h"

namespace NSCsimLib {


TBool less_RefString::operator() (const RefString& s1, const RefString& s2) const {
  ASSERT(s1.get(), "null string 1");
  ASSERT(s2.get(), "null string 2");

  return s1->compare(*s2) < ZERO;
}



RefCsimShell                 CsimShell::m_shell = RefCsimShell();

CsimShell::RefTMap_RefString_TCmdFunc   CsimShell::m_cmdMap(new CsimShell::TMap_RefString_TCmdFunc);

CsimShell::RefTMap_RefString_EShellCmdOption  CsimShell::m_cmdOptionMap(new CsimShell::TMap_RefString_EShellCmdOption);

CsimShell::RefTMap_RefString_EExprOperType CsimShell::m_opMap(new CsimShell::TMap_RefString_EExprOperType);


RefString  CsimShell::m_numberAllowedChars(new std::string("0123456789"));

RefString  CsimShell::m_identifierAllowedChars(new std::string("_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789."));

RefString  CsimShell::m_operatorAllowedChars(new std::string("()*/%+-<>=!"));



CsimShell::CsimShell() : m_simulator(CsimSimulator::getInstance()), m_cmdLine(new CsimCmdLine()), m_quitFlag(FALSE), m_topUnit(m_simulator->getRootUnit()), 
                         m_currentUnit(m_topUnit), m_breakExprVec(new TVec_RefCsimCmdLineExpr), m_breakExprNoVec(new TVec_TInt), 
                         m_breakExprStrVec(new TVec_RefString), m_breakShell(FALSE), m_watchExprVec(new TVec_RefCsimCmdLineExprId) { initialize(); }



void CsimShell::initialize() {
  ASSERT(CsimShell::m_cmdMap.get(), "Shell - This should not be");

  //command map initialization
  (*CsimShell::m_cmdMap)[RefString(new std::string("run"))] = &CsimShell::runCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("set"))] = &CsimShell::setCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("print"))] = &CsimShell::printCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("break"))] = &CsimShell::breakCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("watch"))] = &CsimShell::watchCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("ls"))] = &CsimShell::lsCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("cd"))] = &CsimShell::cdCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("load"))] = &CsimShell::loadCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("gen-vector"))] = &CsimShell::genVectorCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("gen-archstate"))] = &CsimShell::genArchstateCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("help"))] = &CsimShell::helpCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("quit"))] = &CsimShell::quitCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("continue"))] = &CsimShell::continueCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("disable"))] = &CsimShell::disableCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("enable"))] = &CsimShell::enableCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("pwd"))] = &CsimShell::pwdCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("stopwatch"))] = &CsimShell::stopwatchCmd;
  (*CsimShell::m_cmdMap)[RefString(new std::string("version"))] = &CsimShell::versionCmd;

  //help map initialization
  //TO DO

  //operator map initialization
  (*CsimShell::m_opMap)[RefString(new std::string("("))] = EXPR_OPER_TYPE_LPAREN;
  (*CsimShell::m_opMap)[RefString(new std::string(")"))] = EXPR_OPER_TYPE_RPAREN;
  //  (*CsimShell::m_opMap)[RefString(new std::string("-"))] = EXPR_OPER_TYPE_UNARY_MINUS;
  //  (*CsimShell::m_opMap)[RefString(new std::string("+"))] = EXPR_OPER_TYPE_UNARY_PLUS;
  (*CsimShell::m_opMap)[RefString(new std::string("*"))] = EXPR_OPER_TYPE_MULTIPLY;
  (*CsimShell::m_opMap)[RefString(new std::string("/"))] = EXPR_OPER_TYPE_DIVIDE;
  (*CsimShell::m_opMap)[RefString(new std::string("%"))] = EXPR_OPER_TYPE_MODULUS;
  (*CsimShell::m_opMap)[RefString(new std::string("+"))] = EXPR_OPER_TYPE_PLUS;
  (*CsimShell::m_opMap)[RefString(new std::string("-"))] = EXPR_OPER_TYPE_MINUS;
  (*CsimShell::m_opMap)[RefString(new std::string("<"))] = EXPR_OPER_TYPE_COMPARE_LT;
  (*CsimShell::m_opMap)[RefString(new std::string("<="))] = EXPR_OPER_TYPE_COMPARE_LTE;
  (*CsimShell::m_opMap)[RefString(new std::string(">"))] = EXPR_OPER_TYPE_COMPARE_GT;
  (*CsimShell::m_opMap)[RefString(new std::string(">="))] = EXPR_OPER_TYPE_COMPARE_GTE;
  (*CsimShell::m_opMap)[RefString(new std::string("=="))] = EXPR_OPER_TYPE_COMPARE_EQT;
  (*CsimShell::m_opMap)[RefString(new std::string("!="))] = EXPR_OPER_TYPE_COMPARE_NEQT;
  (*CsimShell::m_opMap)[RefString(new std::string("="))] = EXPR_OPER_TYPE_ASSIGN;

  //command option map initialization
  (*CsimShell::m_cmdOptionMap)[RefString(new std::string("fanout"))] = CMD_OPTION_FANOUT; 
  (*CsimShell::m_cmdOptionMap)[RefString(new std::string("val_hex"))] = CMD_OPTION_VAL_HEX; 
  (*CsimShell::m_cmdOptionMap)[RefString(new std::string("val_bin"))] = CMD_OPTION_VAL_BIN;
  (*CsimShell::m_cmdOptionMap)[RefString(new std::string("connections"))] = CMD_OPTION_CONNECTIONS; 
  (*CsimShell::m_cmdOptionMap)[RefString(new std::string("clock"))] = CMD_OPTION_CLOCK; 
  (*CsimShell::m_cmdOptionMap)[RefString(new std::string("reg"))] = CMD_OPTION_FANOUT; 
}

RefCsimShell  CsimShell::getInstance() {

  if (!CsimShell::m_shell.get()) { CsimShell::m_shell = RefCsimShell(new CsimShell()); }
  
  return CsimShell::m_shell;
}

//************************************************************************************



RefTVec_RefString CsimShell::getCurrentPath() {

  RefTVec_RefString retVec(new TVec_RefString);

  RefCsimUnit tempUnit = m_currentUnit;

  while (tempUnit.get()) {
    retVec->insert(retVec->begin(), tempUnit->getInstanceName());
    tempUnit = tempUnit->getParent();
  }

  return retVec;
}




RefTVec_RefString  CsimShell::getIdPath(RefString id) {
  ASSERT(id.get(), "this shouldn't be");
  ASSERT(!id->empty(), "why are you calling this function? YOU want to convert NOTHING to NOTHING....");

  RefTVec_RefString retVec(new TVec_RefString);

  TString::iterator it = id->begin();

  if (id->at(0) == '.') {
    ++it;
    RefTVec_RefString currentPath = getCurrentPath();
    for (TVec_RefString::iterator it = currentPath->begin(); it != currentPath->end(); ++it) { retVec->push_back(*it); }
  }

  RefString temp(new std::string);

  for ( ; it != id->end(); ++it) {
    if (*it != '.') {
      TChar* ch = new TChar[2];
      ch[1] = '\0';
      *ch = (*it);
      temp->append(ch);
    }
    else {
      retVec->push_back(RefString(new std::string(*temp)));
      temp->clear();
    }
  }

  retVec->push_back(temp);

  return retVec;
}




//id's can have the following form:
// .a.b.c = represents (current_unit)=>a=>b=>c
// a.b.c  = represents (top_unit)=>a=>b=>c
RefCsimCmdLineExprId CsimShell::isId(RefString id, EShellCmdOption type) {
  ASSERT(id.get(), "null ref received");
  ASSERT(canItBeIdentifier(id), "this should not happen");


  RefCsimCmdLineExprId retVal;

  if (id->empty()) { return retVal; }
  else {

    TBool wasFound = FALSE;

    if (!wasFound && (type == EShellCmdOption(EXPR_ID_TYPE_CLOCK))) {
      //search clock with that name

      RefCsimClock clock = m_simulator->getClockByName(id);

      if (!clock.get()) {
        return retVal;
      }
      else {
        RefTVec_RefString idPath = getIdPath(id);
        retVal = CsimCmdLineExprIdClock::build(idPath, clock);
        wasFound = TRUE;
        ASSERT(id.get(), "this should not be");
      }
    }

    //search for object with that name
    if (!wasFound && type != EShellCmdOption(EXPR_ID_TYPE_CLOCK)) {

      RefTVec_RefString idPath = getIdPath(id);

      ASSERT(!idPath->empty(), "this should not be");
      RefCsimUnit tempUnit = m_topUnit;
      if ((idPath->at(0))->compare(*(tempUnit->getInstanceName()))) { return retVal; }
      TVec_RefString::iterator it = idPath->begin() + 1;
      for (TUInt i = 0; 
           i < idPath->size() - 2 && it != idPath->end();
           ++i, ++it) {
	RefCsimUnit tmp = tempUnit->getChildByName(*it);
        if (!tmp.get()) { return retVal; }
        else { tempUnit = tmp; }
      }


      if (!wasFound && (type == EShellCmdOption(EXPR_ID_TYPE_UNDEF) || type == EShellCmdOption(EXPR_ID_TYPE_SIGNAL))) {
        //search for signal with that name

	if(it != idPath->end()) {
        RefCsimSignalBase sig = tempUnit->getSignalByName(*it);
        if (sig.get()) {
          retVal = CsimCmdLineExprIdSignal::build(idPath, sig);
          wasFound = TRUE;
 	}
	}
      }

      if (!wasFound && (type == EShellCmdOption(EXPR_ID_TYPE_UNDEF) || type == EShellCmdOption(EXPR_ID_TYPE_UNIT))) {
        //search for unit with that name
	if(it != idPath->end()) {
        RefCsimUnit unit = tempUnit->getChildByName(*it);
        if (unit.get()) {
          retVal = CsimCmdLineExprIdUnit::build(idPath, unit);
          wasFound = TRUE;
        }
	}
      }

    }
    
  }

  return retVal;

}


TBool CsimShell::isNum(RefString num) {
  ASSERT(num.get(), "null ref received");

  RefString whiteSpaces = RefString(new std::string("\n\t\v\b\f\r\a"));

  RefString allowedChars = RefString(new std::string("0123456789"));

  TString_iter it = num->begin();

  while (whiteSpaces->find(*it) != std::string::npos) { ++it; }//jump over white spaces

  while (it != num->end()) {//check characters
    if (allowedChars->find(*it) == std::string::npos) { return FALSE; }
    ++it;
  }

  return TRUE;
}

EExprOperType CsimShell::isOp(RefString op) {
  ASSERT(op.get(), "null ref received");

  EExprOperType retVal = EXPR_OPER_TYPE_UNDEF;

  TMap_RefString_EExprOperType::iterator it = m_opMap->find(op);

  if (it != m_opMap->end()) { retVal = it->second; }

  return retVal;

}


EShellCmdOption CsimShell::isCmdOption(RefString str) {
  ASSERT(str.get(), "received null ref");

  EShellCmdOption retVal = CMD_OPTION_UNDEF;

  RefString temp(new std::string(str->substr(2)));

  TMap_RefString_EShellCmdOption::iterator it = m_cmdOptionMap->find(temp);

  if (it != m_cmdOptionMap->end()) { retVal = it->second; }

  return retVal;
}



TInt CsimShell::getIntFromStr(RefString num) {
  ASSERT(num.get(), "null number received");
  ASSERT(!num->empty(), "empty number received");

  TInt retVal = 0;

  RefStringstream s(new std::stringstream);

  (*s) << *num;

  (*s) >> retVal;

  return retVal;
}


TBool CsimShell::containsOnlyAllowedChars(RefString str) {

  TBool retVal = TRUE;

  std::string::iterator it = str->begin();

  while (it != str->end() && retVal == TRUE) {
    if (m_numberAllowedChars->find(*it) == std::string::npos
        && m_identifierAllowedChars->find(*it) == std::string::npos
        && m_operatorAllowedChars->find(*it) == std::string::npos) {

      retVal = FALSE;
    }

    ++it;
  }

  return retVal;
}


TBool  CsimShell::canItBeCmdOption(RefString str) {
  ASSERT(str.get(), "null ref received");

  TBool retVal = TRUE;

  std::string::iterator it = str->begin();

  if (*(it++) != '-') { return FALSE; }
  else if (it != str->end()) {
    if (*(it++) != '-') { return FALSE; }
  }
  else { return FALSE; }

  if (it == str->end()) { return FALSE; }

  while (it != str->end()) { if (m_identifierAllowedChars->find(*it) == std::string::npos) { return FALSE; } ++it; }

  return retVal;
}



TBool CsimShell::canItBeOp(RefString str) {

  TBool retVal = TRUE;

  std::string::iterator it = str->begin();

  while (it != str->end() && retVal == TRUE) {
    if (m_operatorAllowedChars->find(*it) == std::string::npos) { retVal = FALSE; }

    ++it;
  }

  return retVal;
}



TBool CsimShell::canItBeNumber(RefString str) {

  TBool retVal = TRUE;

  std::string::iterator it = str->begin();

  while(it != str->end() && retVal == TRUE) {
    if (m_numberAllowedChars->find(*it) == std::string::npos) { retVal = FALSE; }

    ++it;
  }

  return retVal;

}


TBool CsimShell::canItBeIdentifier(RefString str) {

  TBool retVal = TRUE;

  std::string::iterator it = str->begin();

  while (it != str->end() && retVal == TRUE) {
    if (m_identifierAllowedChars->find(*it) == std::string::npos) { retVal = FALSE; }

    ++it;
  }

  return retVal;
}



RefTVec_RefCsimCmdLineExpr CsimShell::getExprVec(TVec_RefString::iterator& it, TVec_RefString::iterator end) {
  //  ASSERT(exprVec.get(), "null string received");
  //  ASSERT();

  

//  for (TVec_RefString::iterator itera = it; itera != end; ++itera) {
//    DCERR("*** : " << *(*itera));
//  }

  RefTVec_RefCsimCmdLineExpr retVec(new TVec_RefCsimCmdLineExpr);

  if (it == end) { return retVec; }

  while (it != end && !canItBeCmdOption(*it)) {
    if (canItBeOp(*it)) {
      EExprOperType op = isOp(*it);
      if (op != EXPR_OPER_TYPE_UNDEF) { retVec->push_back(CsimCmdLineExprOper::build(op)); }
      else {
        //error
      }
    }
    else if (canItBeNumber(*it)) {
      retVec->push_back(CsimCmdLineExprNum::build(getIntFromStr(*it)));
    }
    else if (canItBeIdentifier(*it)) {
      //      DCERR("Should build identifier '" << *(*it) << "'");
      RefCsimCmdLineExpr id = isId(*it);
      if (!id.get()) {
        RefString out(new std::string("Identifier '"));
        out->append(*(*it));
        out->append("' was not found.");
        print(out);
        return RefTVec_RefCsimCmdLineExpr(new TVec_RefCsimCmdLineExpr);
      }
      retVec->push_back(id);
    }
    else {
      if (containsOnlyAllowedChars(*it)) {
        //this means that probably the expression is not separated by spaces , ex: a+b
        //        DCERR("dismember expression");
        std::string::iterator iter = (*it)->begin();
        for(TUInt i = 0; i < (*it)->size(); ++i, ++iter) ;
        RefString temp(new std::string);
        temp->append((*it)->begin(), iter);
        while (!canItBeOp(temp) && !canItBeNumber(temp) && !canItBeIdentifier(temp)) {
          temp->clear();

          --iter;
          temp->append((*it)->begin(), iter);
        }
        
        if (canItBeOp(temp)) {
          EExprOperType op = isOp(temp);
          if (op != EXPR_OPER_TYPE_UNDEF) { retVec->push_back(CsimCmdLineExprOper::build(op)); }
          else {
            //error
          }
        }
        else if (canItBeNumber(temp)) {
          retVec->push_back(CsimCmdLineExprNum::build(getIntFromStr(temp)));
        }
        else if (canItBeIdentifier(temp)) {
          //          DCERR("Should build identifier '" << *(temp) << "'");
          RefCsimCmdLineExpr id = isId(*it);
          if (!id.get()) {
            RefString out(new std::string("Identifier '"));
            out->append(*(*it));
            out->append("' was not found.");
            print(out);
            return RefTVec_RefCsimCmdLineExpr(new TVec_RefCsimCmdLineExpr);
          }
          retVec->push_back(id);
        }
        else {
          //error
        }

        RefTVec_RefString tempStrVec(new TVec_RefString);
        RefString temp2(new std::string);
        temp2->append(iter , (*it)->end());
        tempStrVec->push_back(temp2);
        TVec_RefString::iterator tmpIt = tempStrVec->begin();
        RefTVec_RefCsimCmdLineExpr tempVec = getExprVec(tmpIt, tempStrVec->end());
        for (TVec_RefCsimCmdLineExpr::iterator tempIterator = tempVec->begin(); tempIterator != tempVec->end(); ++tempIterator) {
          retVec->push_back(*tempIterator);
        }
        
      }
      else {
        //        DCERR("Error : malformed expression near '" << *(*it) << "'");
        RefString out(new std::string("Error : malformed expression near '"));
        out->append(*(*it));
        out->append("'");
        return RefTVec_RefCsimCmdLineExpr(new TVec_RefCsimCmdLineExpr);
      }
    }
    ++it;
  }

  return retVec;
}



RefTVec_RefString CsimShell::getStringVec(RefString str) {
  ASSERT(str.get(), "CSIM SHELL - null ref received");
  

  RefTVec_RefString retVec(new TVec_RefString);

  RefStringstream ss(new std::stringstream);

  RefString temp(new std::string);

  (*ss) << (*str);

  (*ss) >> (*temp);

  while (!temp->empty()) {

    retVec->push_back(temp);

    temp = RefString(new std::string);

    (*ss) >> (*temp);
  }

  return retVec;

}



//***********************************************************************************


void CsimShell::start(RefString fileName) {
  if (fileName.get()) {
    CsimSimulator::getInstance()->sortExecs(fileName);
  }

  while (!m_quitFlag) {
    RefString cmd = m_cmdLine->getNextCmd();

    if (!cmd.get()) { return; }


    RefStringstream ss(new std::stringstream);

    (*ss) << (*cmd);

    (*ss) >> (*cmd);

    //    TMap_RefString_TCmdFunc::iterator it = CsimShell::m_cmdMap->find(cmd);

    /*********************************************/

    ASSERT(cmd.get(), "CSIM SHELL - this should not happen");
    ASSERT(cmd->size(), "CSIM SHELL - this should not happen");

    TMap_RefString_TCmdFunc::iterator it = CsimShell::m_cmdMap->end();

    TBool foundCmd = FALSE;

    TBool moreThanOneCmdFound = FALSE;

    for (TMap_RefString_TCmdFunc::iterator i = CsimShell::m_cmdMap->begin(); 
         i != CsimShell::m_cmdMap->end(); ++i) {
      if ((i->first)->find(*cmd, 0) == 0) {
        if (!foundCmd) { foundCmd = TRUE; it = i; }
        else { if (!moreThanOneCmdFound) { moreThanOneCmdFound = TRUE; } }
      }
    }

    if (!moreThanOneCmdFound) {
      if (foundCmd) {
        ASSERT(it != CsimShell::m_cmdMap->end(), "CSIM SHELL - this should not happen");
        RefString args(new std::string);
        std::getline(*ss, *args);
        //        args = checkFormatString(args);
        RefTVec_RefString argsVec = getStringVec(args);
        ASSERT(argsVec.get(), "oups");
        //        for (TVec_RefString::iterator iter = argsVec->begin(); iter!= argsVec->end(); ++iter) { DCERR(*(*iter)); }
        (this->*(it->second))(argsVec);
      }
      else {
        RefString output = RefString(new std::string("ERROR: unknown command '"));
        output->append(*cmd);
        output->append("'");
        print(output);
      }
    }
    else {
      RefString output = RefString(new std::string("ERROR: ambiguous command '"));
        output->append(*cmd);
        output->append("'");
        print(output);
    }

    /****************************************************/

//    if (CsimShell::m_cmdMap->end() == it) {
//      RefString output = RefString(new std::string("ERROR: unknown command '"));
//      output->append(*cmd);
//      output->append("'");
//      print(output);
//    }
//    else {
//      RefString args(new std::string);
//      std::getline(*ss, *args);
//      //      formatizeString(args);
//      args = checkFormatString(args);
//      RefTVec_RefCsimCmdLineExpr exprVec = getExprVec(args);
//      (this->*(it->second))(exprVec);
//    }
  }

  if (!m_breakShell) {
    m_quitFlag = FALSE;
  }
}



//**************************************************************
//run command
//**************************************************************
void CsimShell::runCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");

  //if no argument received
  if (args->empty()) { 
    RefString out(new std::string("run: Error: Expecting numeric expression as argument."));
    print(out);
    return;
  }

  if (m_breakShell) {
    RefString out = RefString(new std::string("run: Error : can't run the 'run' cmd while another 'run' command is running"));
    //  out->append(*args);

    print(out);
    return;
  }
  
  //argument parsing
  TVec_RefString::iterator it = args->begin();
  RefCsimCmdLineExprTree helper;

  RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());
  if (it != args->end()) {
    if (canItBeCmdOption(*it)) { 
      RefString out(new std::string("run: Error: Expecting numeric expression as argument."));
      print(out);
      return;
    }
    else {
      RefString out(new std::string("run: Error: Unknown command argument. Expecting numeric expression as argument."));
      print(out);
      return;
    }
  }
  else {
    ASSERT(!exprs->empty(), "this should not be");
    helper = CsimCmdLineExprTree::build(exprs);
    if (helper->isMalformed()) {
      RefString out(new std::string("run: Error: Malformed expression as argument. Expecting numeric expression as argument."));
      print(out);
      return;
    }
  }

  TLongLong noOfCycles = 0;

  //command execution
  if (!helper->isNumber() && !helper->isRelationalExpression()) {
    RefString out(new std::string("run: Error: Accepting only numeric and logical argument argument for now."));
    print(out);
    return;
  }
  else if (helper->isNumber()) {
    if (helper->doEval() <= 0) {
      RefString out(new std::string("run: Error: Numeric argument is not positive."));
      print(out);
      return;
    }
    else {
      noOfCycles = helper->doEval();
    }
  }
  else if (helper->isRelationalExpression()) {
    breakCmd(args);
    m_breakExprNoVec->at(m_breakExprNoVec->size() - 1) = 0;
    noOfCycles = -1;
  }

  TBool exit = FALSE;

  for (TULongLong i = 0; (TLongLong)i != noOfCycles && !exit; ++i) { 

    //check break exprs
    ASSERT(m_breakExprVec.get(), "this should not be");
    //    TVec_RefCsimCmdLineExpr::iterator it = m_breakExprVec->begin();
    TUInt it = 0;
    while (it < m_breakExprVec->size()) {
      if (m_breakExprVec->at(it)->doEval()) {
        if (m_breakExprNoVec->at(it)) {
          if (m_breakExprNoVec->at(it) > 0) {//else breakpoint is disabled
            if (!exit) {
              //              DCERR("break reached...");
              RefString out(new std::string("Break reached :"));
              print(out);
              m_breakShell = TRUE;
              start();
              //'continue' should set m_breakShell to false
              //if it doesn't that means the user has called 
              //'quit' command
              if (m_breakShell) { return; }
              m_quitFlag = FALSE;
              //            break;
            }
          }
        }
        else {
          //erase from breakExprVec
          TVec_RefCsimCmdLineExpr::iterator iter1 = m_breakExprVec->begin();
          for (TUInt i = 0; i < it; ++iter1, ++i) ;
          m_breakExprVec->erase(iter1);
          //erase from breakExprNoVec
          TVec_TInt::iterator iter2 = m_breakExprNoVec->begin();
          for (TUInt i = 0; i < it; ++iter2, ++i) ;
          m_breakExprNoVec->erase(iter2);
          //erase from breakExprStrVec
//          TVec_RefString::iterator iter3 = m_breakExprStrVec->begin();
//          for (TUInt i = 0; i < it; ++iter3, ++i) ;
//          m_breakExprStrVec->erase(iter3);
          if (!exit) { exit = TRUE; }
        }
      }
      ++it;
    }
    //cycle simulator
    m_simulator->cycle(); 

    //check watch exprs
    ASSERT(m_watchExprVec.get(), "this should not be");
    for (TVec_RefCsimCmdLineExprId::iterator it = m_watchExprVec->begin(); it != m_watchExprVec->end(); ++it) {
      if (boost::static_pointer_cast<CsimCmdLineExprIdSignal>(*it)->getObj()->wasModified()) {
        DCERR("watch reached...");
        m_breakShell = TRUE;
        start();
        //'continue' should set m_breakShell to false
        //if it doesn't that means the user has called 
        //'quit' command
        if (m_breakShell) { return; }
        m_quitFlag = FALSE;
        boost::static_pointer_cast<CsimCmdLineExprIdSignal>(*it)->getObj()->resetModified();
      }
    }
  }

  return;
}



//**************************************************************
//set command
//**************************************************************
void CsimShell::setCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  //if no argument received
  if (args->empty()) { 
    RefString out(new std::string("set: Error: Expecting expression as argument."));
    print(out);
    return; 
  }


  //argument parsing
  TVec_RefString::iterator it = args->begin();
  RefCsimCmdLineExprTree helper;

  RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());
  if (it != args->end()) {
    if (canItBeCmdOption(*it)) { 
      RefString out(new std::string("set: Error: Expecting expression as argument."));
      print(out);
      return;
    }
    else {
      RefString out(new std::string("set: Error: Unknown command argument."));
      print(out);
      return;
    }
  }
  else {
    ASSERT(!exprs->empty(), "this should not be");
    helper = CsimCmdLineExprTree::build(exprs);
    if (helper->isMalformed()) {
      RefString out(new std::string("set: Error: Malformed expression as argument."));
      print(out);
      return;
    }
  }


  //command execution
  if (!helper->isAssignment()) {
    RefString out(new std::string("set: Error: Accepting only assignment expression."));
    print(out);
    return;
  }
  else {
    RefCsimCmdLineExpr root = helper->getRootExpr();
    RefTVec_RefCsimCmdLineExpr children = root->getChildren();
    ASSERT(!children->empty(), "this should not be");
    RefCsimCmdLineExpr lvalue = children->at(0);
    if (!lvalue->isId()) {
      RefString out(new std::string("set: Error: lvalue must be identifier."));
      print(out);
      return;
    }
    else {
      RefString out(new std::string("set: to be continued..."));
      print(out);
      return;
    }
  }

  return;
}




//**************************************************************
//print command
//**************************************************************
void CsimShell::printCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null string received");

  if (args->empty()) {
    RefString out(new std::string("print: Error: expecting command arguments."));
    print(out);
    return;
  }


  //argument parsing
  TVec_RefString::iterator it = args->begin();
  RefCsimCmdLineExprId object;
  TUInt allowedCmdOptions = CMD_OPTION_VAL_HEX | CMD_OPTION_VAL_BIN |
    CMD_OPTION_CONNECTIONS | CMD_OPTION_FANOUT | CMD_OPTION_REG | 
    CMD_OPTION_CLOCK | CMD_OPTION_SIGNAL | CMD_OPTION_MEMORY;

  TUInt cmdObjectMask = EXPR_ID_TYPE_CLOCK | EXPR_ID_TYPE_SIGNAL | EXPR_ID_TYPE_MEM;
  TUInt receivedCmdOptions = 0;
  TUInt objectMask = 0;

  while (it != args->end()) {
    if (canItBeCmdOption(*it)) {
      EShellCmdOption cmdOption = isCmdOption(*it);
      if (cmdOption & allowedCmdOptions) {
        if (receivedCmdOptions & cmdOption) {
          RefString out(new std::string("print: Error: argument already given :'"));
          out->append(*(*it));
          out->append("'");
          print(out);
          return;
        }
        else {
          if (!(cmdOption & cmdObjectMask)) {
            receivedCmdOptions |= cmdOption;
          }
          else {
            if (!objectMask){
              objectMask |= cmdOption;
              ++it;
              if (it == args->end()) {
                RefString out(new std::string("print: Error: expecting identifier after '"));
                out->append(*(*it));
                out->append("'");
                print(out);
                return;
              }
              else {
                if (!canItBeIdentifier(*it)) {
                  RefString out(new std::string("print: Error: expecting identifier after '"));
                  out->append(*(*it));
                  out->append("'");
                  print(out);
                  return;
                }
                else {
                  RefCsimCmdLineExprId id = isId(*it, cmdOption);
                  if (!id.get()) {
                    RefString out(new std::string("print: Error: identifier '"));
                    out->append(*(*it));
                    out->append("' was not found");
                    print(out);
                    return;
                  }
                  else {
                    object = id;
                  }
                }
              }
            }
            else {
              RefString out(new std::string("print: Error: unexpected command option '"));
              out->append(*(*it));
              out->append("'");
              print(out);
              return;
            }
          }
        }
      }
      else {
        RefString out(new std::string("print: Error: command option not allowed '"));
        out->append(*(*it));
        out->append("'");
        print(out);
        return;
      }
    }
    else {
      if (canItBeNumber(*it) || canItBeOp(*it)) {
        RefString out(new std::string("print: Error: unexpected command argument '"));
        out->append(*(*it));
        out->append("'");
        print(out);
        return;
      }
      else {//identifier
        //assuming this is the object of the command
        //check if already set
        if (objectMask) {
          RefString out(new std::string("print: Error: unexpected command argument '"));
          out->append(*(*it));
          out->append("'. Command object already set.");
          print(out);
          return;
        }
        else {
          ASSERT(canItBeIdentifier(*it), "this should not be");
          RefCsimCmdLineExprId id = isId(*it);
          if (!id.get()) {
            RefString out(new std::string("print: Error : identifier '"));
            out->append(*(*it));
            out->append("' was not found");
            print(out);
            return;
          }
          else {
            EExprIdType idType = id->getIdType();
            if (idType & cmdObjectMask) {
              objectMask = idType;
              object = id;
            }
            else {
              RefString out(new std::string("print: Error: identifier type not implemented"));
              print(out);
              return;
            }
          }
        }
      }
    }

    ++it;
  }

  //if command called on clock
  if (objectMask & CMD_OPTION_CLOCK) {
    TUInt allowedOptionsForClock = CMD_OPTION_FANOUT | CMD_OPTION_REG;

    if (receivedCmdOptions & (~allowedOptionsForClock)) {
      RefString out(new std::string("print: Error: received command options that are not allowed for clock object."));
      print(out);
      return;
    }
    else {

      if (receivedCmdOptions & CMD_OPTION_FANOUT) {
        
        if (receivedCmdOptions & CMD_OPTION_REG) {
          RefString out(new std::string("print: Error: to be implemented."));
          print(out);
          return;

          RefTVec_RefCsimUnit connectedUnits = boost::static_pointer_cast<CsimCmdLineExprIdClock>(object)->getObj()->getConnectedUnits();
          RefTVec_RefString   connectedUnitsClockNames = boost::static_pointer_cast<CsimCmdLineExprIdClock>(object)->getObj()->getConnectedUnitsClockNames();

          for (TUInt i = 0; i < connectedUnits->size(); ++i) {
            //            DCERR("------------------------");
            //            RefCsimUnit tempUnit = connectedUnits->at(i);
//            DCERR("Unit name : " << *(tempUnit->getInstanceName()));
//            DCERR("Connected clock name : " << *(connectedUnitsClockNames->at(i)));
//            DCERR("*** Memories : ***");
            //get memories vector and print the memories
            //            DCERR("*** FlipFlop's : ***");
            //get the flipFlops vector and print the flipflops
            //            DCERR("------------------------");
            RefString out(new std::string("------------------------"));
            RefCsimUnit tempUnit = connectedUnits->at(i);
            out->append("\nUnit name : "); out->append(*(tempUnit->getInstanceName()));
            out->append("\nConnected clock name : "); out->append(*(connectedUnitsClockNames->at(i)));
            out->append("\n*** Memories : ***");
            out->append("\n*** FlipFlop's : ***");
            out->append("\n------------------------");
            print(out);
          }
        }
        else {
          RefTVec_RefCsimUnit connectedUnits = boost::static_pointer_cast<CsimCmdLineExprIdClock>(object)->getObj()->getConnectedUnits();
          RefTVec_RefString   connectedUnitsClockNames = boost::static_pointer_cast<CsimCmdLineExprIdClock>(object)->getObj()->getConnectedUnitsClockNames();

          for (TUInt i = 0; i < connectedUnits->size(); ++i) {
//            DCERR("------------------------");
//            RefCsimUnit tempUnit = connectedUnits->at(i);
//            DCERR("Unit name : " << *(tempUnit->getInstanceName()));
//            DCERR("Connected clock name : " << *(connectedUnitsClockNames->at(i)));
//            DCERR("*** Signals : ***");
//            RefTVec_RefCsimSignalBase signals = tempUnit->getSignals();
//            for (TVec_RefCsimSignalBase::iterator it = signals->begin(); it != signals->end(); ++it) {
//              DCERR(*(*it)->getName() << " = " << *(*(*it)));
//            }
//            DCERR("------------------------");
            RefString out(new std::string("------------------------"));
            RefCsimUnit tempUnit = connectedUnits->at(i);
            out->append("\nUnit name : "); out->append(*(tempUnit->getInstanceName()));
            out->append("\nConnected clock name : "); out->append(*(connectedUnitsClockNames->at(i)));
            out->append("\n*** Signals : ***");
            RefTVec_RefCsimSignalBase signals = tempUnit->getSignals();
            for (TVec_RefCsimSignalBase::iterator it = signals->begin(); it != signals->end(); ++it) {
              out->append("\n"); out->append(*(*it)->getName()); out->append(" = "); 
              RefStringstream sss(new std::stringstream);
              (*sss) << *(*(*it));
              out->append(sss->str());
            }
            out->append("\n------------------------");
            print(out);
          }
        }
      }
      else {
        RefString out(new std::string);
        if (((boost::static_pointer_cast<CsimCmdLineExprIdClock>(object))->getObj())->posEdge()) { out->append("posEdge"); }
        else { out->append("negEdge"); }
        print(out);
        return;
      }
    }
  }
  //if command called on signal
  else if (objectMask & CMD_OPTION_SIGNAL) {
    TUInt allowedOptionsForSignal = CMD_OPTION_CONNECTIONS;

    if (receivedCmdOptions & (~allowedOptionsForSignal)) {
      RefString out(new std::string("print: Error: received command options that are not allowed for signal object."));
      print(out);
      return;
    }
    else {

      if (receivedCmdOptions & CMD_OPTION_CONNECTIONS) {
        RefString out(new std::string("print: Error: to be implemented."));
        print(out);
        return;
      }
      else {
        RefStringstream s(new std::stringstream);

        (*s) << *((boost::static_pointer_cast<CsimCmdLineExprIdSignal>(object))->getObj());

        RefString out(new std::string);

        (*s) >> (*out);

        print(out);
        return;
      }
    }
  }
  //if command called on memory
  else if (objectMask & CMD_OPTION_MEMORY) {
    TUInt allowedOptionsForMemory = CMD_OPTION_VAL_HEX | CMD_OPTION_VAL_BIN;

    if (receivedCmdOptions & (~allowedOptionsForMemory)) {
      RefString out(new std::string("print: Error: received command options that are not allowed for memory object."));
      print(out);
      return;
    }
    //command doesn't accept val_hex and val_bin at the same time
    else if (receivedCmdOptions & CMD_OPTION_VAL_HEX && 
             receivedCmdOptions & CMD_OPTION_VAL_BIN) {
      RefString out(new std::string("print: Error: command accepts only one argument at a time, not both : '--val_hex' & '--val_bin'."));
      print(out);
      return;
    }
    else {//cmd arguments are ok
      
      TRadix radix;

      if (receivedCmdOptions & CMD_OPTION_VAL_HEX) { radix = T_HEX; }
      else { radix = T_BIN; }

      RefStringstream s(new std::stringstream);

      (boost::static_pointer_cast<CsimCmdLineExprIdMemory>(object)->getObj())->setRadix(radix);

      (*s) << (*boost::static_pointer_cast<CsimCmdLineExprIdMemory>(object)->getObj());

      RefString out(new std::string);
      (*s) >> (*out);
      print(out);
      return;
    }
  }
  else {
    RefString out(new std::string("print: Error: to be implemented."));
    print(out);
    return;
  }

  return;
}



//**************************************************************
//break command
//**************************************************************
void CsimShell::breakCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  if (args->empty()) {
    RefString out(new std::string("break: Error: expecting expression as command argument."));
    print(out);
    return;
  }

  TVec_RefString::iterator it = args->begin();

  RefCsimCmdLineExprTree helper;

  RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());

  if (it != args->end()) {
    if (canItBeCmdOption(*it)) {
      RefString out(new std::string("break: Error: command doesn't accept any options -> ('"));
      out->append(*(*it));
      out->append("')");
      print(out);
      return;
    }
    else {
      RefString out(new std::string("break: Error: unknown command argument -> ('"));
      out->append(*(*it));
      out->append("')");
      print(out);
      return;
    }
  }
  else {
    ASSERT(!exprs->empty(), "this should not be");
    helper = CsimCmdLineExprTree::build(exprs);
    if (helper->isMalformed()) {
      RefString out(new std::string("break: Error: Malformed expression as argument."));
      print(out);
      return;
    }
    else if (!helper->isRelationalExpression()) {
      RefString out(new std::string("break: Error: Only relational expressions allowed for now ( ex. 'a != 3', 'b<=1'...)."));
      print(out);
      return;
    }
  }

  
  if (helper->isRelationalExpression()) {
    ASSERT(m_breakExprVec.get(), "this should not be");
    m_breakExprVec->push_back(helper->getRootExpr());
    if (m_breakExprVec->size() == 1) { m_breakExprNoVec->push_back(1); }
    else {
      TInt no = 1;
      for (TVec_TInt::iterator it = m_breakExprNoVec->begin(); it != m_breakExprNoVec->end(); ++it) {
        TInt current = *it;
        if (current < 0) { current *= (-1);}
        if (current > no) { no = current; }
      }
      m_breakExprNoVec->push_back(++no);
    }
  }
  else {
    //later use
  }


  return;
}



//**************************************************************
//watch command
//**************************************************************
void CsimShell::watchCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");

  if (args->size() != 1) {
    RefString out = RefString(new std::string("watch: Error : watch command only accepts one argument(signal)"));
    print(out);
    return;
  }

  RefCsimCmdLineExprId obj;

  TVec_RefString::iterator it = args->begin();
  RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());
  if (it != args->end()) {
    RefString out = RefString(new std::string("watch: Error : watch command only accepts one identifier(signal)"));
    print(out);
    return;
  }
  else {
    RefCsimCmdLineExpr expr = exprs->at(0);
    if (!expr->isId()) {
      RefString out = RefString(new std::string("watch: Error : watch command only accepts one identifier(signal)"));
      print(out);
      return;
    }
    else {
      RefCsimCmdLineExprId id = boost::static_pointer_cast<CsimCmdLineExprId>(expr);
      if (!id->isSignal()) {
        RefString out = RefString(new std::string("watch: Error : watch command only accepts one signal"));
        print(out);
        return;
      }
      else {
        obj = id;
      }
    }
  }

  TBool add = TRUE;
  RefCsimCmdLineExprIdSignal sig = boost::static_pointer_cast<CsimCmdLineExprIdSignal>(obj);
  for (TVec_RefCsimCmdLineExprId::iterator it = m_watchExprVec->begin(); it != m_watchExprVec->end(); ++it) {
    if (sig->getObj() == boost::static_pointer_cast<CsimCmdLineExprIdSignal>(*it)->getObj()) {
      add = FALSE;
      break;
    }
  }

  if (add) {
    m_watchExprVec->push_back(obj);
    sig->getObj()->startTestingModified();
  }
}



//**************************************************************
//ls command
//**************************************************************
void CsimShell::lsCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  
  if (args->size() != 1) {
    RefString out = RefString(new std::string("ls: Error : command only accepts '*', '**', 'path.*' or 'path.**', where path ends in unit."));
    print(out);
    return;
  }

  RefTVec_RefCsimCmdLineExprId paths = RefTVec_RefCsimCmdLineExprId(new TVec_RefCsimCmdLineExprId);

  TVec_RefString::iterator it = args->begin();

  size_t pos = (*it)->find("**", 0);

  if (pos != std::string::npos) {
    (*it)->erase(pos - 1, 3);
    it = args->begin();

    if (!(*it)->empty()) {
      RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());

      if (exprs->empty()) {
        RefString out = RefString(new std::string("ls: Error : path not found."));
        print(out);
        return;
      }
      else {
        RefCsimCmdLineExpr expr = exprs->at(0);
        if (!expr->isId()) {
          RefString out = RefString(new std::string("ls: Error : command only accepts '*', '**', 'path.*' or 'path.**', where path ends in unit."));
          print(out);
          return;
        }
        else {
          RefCsimCmdLineExprId id = boost::static_pointer_cast<CsimCmdLineExprId>(expr);
          if (!id->isUnit()) {
            RefString out = RefString(new std::string("ls: Error : command only accepts '*', '**', 'path.*' or 'path.**', where path ends in unit."));
            print(out);
            return;
          }
          else {
            paths->push_back(id);
            RefTVec_RefCsimUnit children = boost::static_pointer_cast<CsimCmdLineExprIdUnit>(id)->getUnit()->getChildren();
            for (TVec_RefCsimUnit::iterator it = children->begin(); it != children->end(); ++it) {
              RefTVec_RefString idPath = id->getFullPathName();;
              idPath->push_back((*it)->getInstanceName());
              RefCsimCmdLineExprIdUnit child = CsimCmdLineExprIdUnit::build(idPath, *it);
              paths->push_back(child);
            }
          }
        }
      }
    }
    else {
      RefTVec_RefString currentPath = getCurrentPath();
      RefCsimCmdLineExprIdUnit id = CsimCmdLineExprIdUnit::build(currentPath, m_currentUnit);
      paths->push_back(id);
      RefTVec_RefCsimUnit children = id->getUnit()->getChildren();
      for (TVec_RefCsimUnit::iterator it = children->begin(); it != children->end(); ++it) {
        RefTVec_RefString idPath = currentPath;
        idPath->push_back((*it)->getInstanceName());
        RefCsimCmdLineExprIdUnit child = CsimCmdLineExprIdUnit::build(idPath, *it);
        paths->push_back(child);
      }
    }
  }
  else {

    size_t pos = (*it)->find("*", 0);
    if (pos != std::string::npos) {
      (*it)->erase(pos - 1, 2);
      it = args->begin();

      if (!(*it)->empty()) {
        RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());

        if (exprs->empty()) {
          RefString out = RefString(new std::string("ls: Error : path not found."));
          print(out);
          return;
        }
        else {
          RefCsimCmdLineExpr expr = exprs->at(0);
          if (!expr->isId()) {
            RefString out = RefString(new std::string("ls: Error : command only accepts '*', '**', 'path.*' or 'path.**', where path ends in unit."));
            print(out);
            return;
          }
          else {
            RefCsimCmdLineExprId id = boost::static_pointer_cast<CsimCmdLineExprId>(expr);
            if (!id->isUnit()) {
              RefString out = RefString(new std::string("ls: Error : command only accepts '*', '**', 'path.*' or 'path.**', where path ends in unit."));
              print(out);
              return;
            }
            else {
              paths->push_back(id);
            }
          }
        }
      }
      else {
        RefTVec_RefString currentPath = getCurrentPath();
        RefCsimCmdLineExprIdUnit id = CsimCmdLineExprIdUnit::build(currentPath, m_currentUnit);
        paths->push_back(id);
      }
    }
  }

  
  ASSERT(!paths->empty(), "this should not be");
  for (TVec_RefCsimCmdLineExprId::iterator it = paths->begin(); it != paths->end(); ++it) {
    RefCsimUnit temp = boost::static_pointer_cast<CsimCmdLineExprIdUnit>(*it)->getUnit();
//    DCERR("----------------------------------");
//    DCERR("Unit name : " << *temp->getInstanceName());
//    DCERR("*** Clocks : ***");
//    RefTVec_RefCsimClock clocks = temp->getClocks();
//    for (TVec_RefCsimClock::iterator iter1 = clocks->begin(); iter1 != clocks->end(); ++iter1) {
//      RefTVec_RefCsimUnit connectedUnits = (*iter1)->getConnectedUnits();
//      RefTVec_RefString   connectedUnitsClockNames = (*iter1)->getConnectedUnitsClockNames();
//      TUInt pos = 0;
//      for (TUInt i = 0; i < connectedUnits->size(); ++i) {
//        if (connectedUnits->at(i) == temp) {
//          pos = i;
//          break;
//        }
//      }
//      DCERR(*(connectedUnitsClockNames->at(pos)));
//    }
//    DCERR("*** Signals : ***");
//    RefTVec_RefCsimSignalBase signals = temp->getSignals();
//    for (TVec_RefCsimSignalBase::iterator it = signals->begin(); it != signals->end(); ++it) {
//      DCERR(*(*it)->getName());
//    }
//    DCERR("----------------------------------");
    RefString out(new std::string("----------------------------------"));
    out->append("\nUnit name : "); out->append(*temp->getInstanceName());
    out->append("\n*** Clocks : ***");
    RefTVec_RefCsimClock clocks = temp->getClocks();
    for (TVec_RefCsimClock::iterator iter1 = clocks->begin(); iter1 != clocks->end(); ++iter1) {
      RefTVec_RefCsimUnit connectedUnits = (*iter1)->getConnectedUnits();
      RefTVec_RefString   connectedUnitsClockNames = (*iter1)->getConnectedUnitsClockNames();
      TUInt pos = 0;
      for (TUInt i = 0; i < connectedUnits->size(); ++i) {
        if (connectedUnits->at(i) == temp) {
          pos = i;
          break;
        }
      }
      out->append("\n"); out->append(*(connectedUnitsClockNames->at(pos)));
    }
    out->append("*** Signals : ***");
    RefTVec_RefCsimSignalBase signals = temp->getSignals();
    for (TVec_RefCsimSignalBase::iterator it = signals->begin(); it != signals->end(); ++it) {
      out->append("\n"); out->append(*(*it)->getName());
    }
    out->append("----------------------------------");
    print(out);
  }
}



//**************************************************************
//cd command
//**************************************************************    
void CsimShell::cdCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  if (args->size() > 1) {
    RefString out = RefString(new std::string("cd: Error : command accepts at most one argument.Command can also be called without argument."));
    return;
  }

  RefCsimCmdLineExprId idToCD;

  if (!args->empty()) {
    TVec_RefString::iterator it = args->begin();
    RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());

    if (it != args->end()) {
      RefString out = RefString(new std::string("cd: Error : command only accepts path as argument."));
      print(out);
      return;
    }
    else if (exprs->empty()) {  
      //      RefString out = RefString(new std::string("cd: Error : command only accepts path as argument."));
      //      print(out);
      return;
    }
    else {
      RefCsimCmdLineExpr expr = exprs->at(0);
      if (!expr->isId()) {
        RefString out = RefString(new std::string("cd: Error : command only accepts path as argument."));
        print(out);
        return;
      }
      else {
        RefCsimCmdLineExprId id = boost::static_pointer_cast<CsimCmdLineExprId>(expr);
        if (!id->isUnit()) {
          RefString out = RefString(new std::string("cd: Error : path argument should end in unit."));
          print(out);
          return;
        }
        else {
          idToCD = id;
        }
      }
    }
  }

  if (idToCD.get()) {
    RefCsimCmdLineExprIdUnit path = boost::static_pointer_cast<CsimCmdLineExprIdUnit>(idToCD);
    m_currentUnit = path->getUnit();
  }
  else {
    m_currentUnit = m_topUnit;
  }

  return;
}



//**************************************************************
//load command
//**************************************************************
void CsimShell::loadCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  RefString out = RefString(new std::string("load: "));
  //  out->append(*args);

  print(out);
}



//**************************************************************
//gen_ector command
//**************************************************************
void CsimShell::genVectorCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  RefString out = RefString(new std::string("gen-vector: "));
  //  out->append(*args);

  print(out);
}


//**************************************************************
//gen_archstate command
//**************************************************************
void CsimShell::genArchstateCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  RefString out = RefString(new std::string("genArchstate: "));
  //  out->append(*args);

  print(out);
}



//**************************************************************
//help command
//**************************************************************
void CsimShell::helpCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  RefString out = RefString(new std::string("help: "));
  //  out->append(*args);

  print(out);
}



//**************************************************************
//quit command
//**************************************************************
void CsimShell::quitCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  RefString out = RefString(new std::string("quit: "));
  //  out->append(*args);

  print(out);

  m_quitFlag = TRUE;
}



//**************************************************************
//continue command
//**************************************************************
void CsimShell::continueCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");

  if (!args->empty()) { 
    RefString out(new std::string("continue : Warning : ignoring arguments"));
    print(out);
  }

  if (!m_breakShell) {
    RefString out = RefString(new std::string("continue: Error : command only used during breaks (like lunch...) "));
    //  out->append(*args);

    print(out);
    return;
  }
  else {
    m_quitFlag = TRUE;
    m_breakShell = FALSE;
  }
}



//**************************************************************
//disable command
//**************************************************************
void CsimShell::disableCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");

  if (args->size() > 1) { 
    RefString out(new std::string("disable : Error : command accepts at most one argument. You can also call command with no argument."));
    print(out);
    return;
  }

  TInt breakToDis = 0;

  if (!args->empty()) { 
      //argument parsing
    TVec_RefString::iterator it = args->begin();

    RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());
    if (it != args->end()) {
      RefString out(new std::string("disable : Error : command accepts only numeric argument."));
      print(out);
      return;
    }
    else {
      RefCsimCmdLineExpr temp = (*exprs->begin());
      if (!temp->isNum()) {
        RefString out(new std::string("disable : Error : command accepts only numeric argument."));
        print(out);
        return;
      }
      else {
        breakToDis = boost::static_pointer_cast<CsimCmdLineExprNum>(temp)->doEval();
        if (breakToDis <= 0) {
          RefString out(new std::string("disable : Error : please supply valid breakpoint number."));
          print(out);
          return;
        }
      }
    }
  }

  TBool wasFound = FALSE;

  for (TVec_TInt::iterator it = m_breakExprNoVec->begin(); it != m_breakExprNoVec->end(); ++it) {

    if (!breakToDis) {
      if (*it > 0) {
        *it *= (-1);
      }
    }
    else if (*it > 0 && *it == breakToDis) {
      *it *= (-1);
      wasFound = TRUE;
      break;
    }
  }

  if (breakToDis && !wasFound) {
    RefString out(new std::string("disable : Error : please supply valid breakpoint number."));
    print(out);
    return;
  }
}



//**************************************************************
//enable command
//**************************************************************
void CsimShell::enableCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");

  if (args->size() > 1) { 
    RefString out(new std::string("enable : Error : command accepts at most one argument. You can also call command with no argument."));
    print(out);
    return;
  }

  TInt breakToEn = 0;

  if (!args->empty()) { 
      //argument parsing
    TVec_RefString::iterator it = args->begin();

    RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());
    if (it != args->end()) {
      RefString out(new std::string("enable : Error : command accepts only numeric argument."));
      print(out);
      return;
    }
    else {
      RefCsimCmdLineExpr temp = (*exprs->begin());
      if (!temp->isNum()) {
        RefString out(new std::string("enable : Error : command accepts only numeric argument."));
        print(out);
        return;
      }
      else {
        breakToEn = boost::static_pointer_cast<CsimCmdLineExprNum>(temp)->doEval();
        if (breakToEn <= 0) {
          RefString out(new std::string("enable : Error : please supply valid breakpoint number."));
          print(out);
          return;
        }
      }
    }
  }

  TBool wasFound = FALSE;

  for (TVec_TInt::iterator it = m_breakExprNoVec->begin(); it != m_breakExprNoVec->end(); ++it) {

    if (!breakToEn) {
      if (*it < 0) {
        *it *= (-1);
      }
    }
    else if (*it < 0 && (-1) * (*it) == breakToEn) {
      *it *= (-1);
      wasFound = TRUE;
      break;
    }
  }

  if (breakToEn && !wasFound) {
    RefString out(new std::string("enable : Error : please supply valid breakpoint number."));
    print(out);
    return;
  }
}



//**************************************************************
//pwd command
//**************************************************************
void CsimShell::pwdCmd(RefTVec_RefString args) {
    ASSERT(args.get(), "SHELL - null ref received");

    if (!args->empty()) {
      RefString out(new std::string("pwd : Error : command does not accept arguments."));
      print(out);
      return;
    }

    RefTVec_RefString currentPath = getCurrentPath();
    ASSERT(currentPath.get(), "this should not be");
    ASSERT(!currentPath->empty(), "this should not be");
    
    RefString path = RefString(new std::string);

    for (TVec_RefString::iterator it = currentPath->begin(); it != currentPath->end(); ++it) {
      path->append(std::string(*(*it)));
      if (it + 1 != currentPath->end()) { path->append("."); }
    }
    
    //    DCERR(*path);
    RefString out(new std::string(*path));
    print(out);

    return;
}



//**************************************************************
//stopwatch command
//**************************************************************
void CsimShell::stopwatchCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");

  if (args->size() > 1) {
    RefString out(new std::string("stopwatch : Error : command accepts at most one argument. Command can also be called without argument."));
    print(out);
    return;
  }

  RefCsimCmdLineExprId obj;
  TInt i = 0;

  if (!args->empty()) {

    TVec_RefString::iterator it = args->begin();
    RefTVec_RefCsimCmdLineExpr exprs = getExprVec(it, args->end());
    if (it != args->end()) {
      RefString out = RefString(new std::string("stopwatch: Error : command only accepts one identifier or number"));
      print(out);
      return;
    }
    else {
      RefCsimCmdLineExpr expr = exprs->at(0);
      if (!expr->isId() && !expr->isNum()) {
        RefString out = RefString(new std::string("stopwatch: Error : command only accepts one identifier or number"));
        print(out);
        return;
      }
      else {
        if (expr->isId()) {
          RefCsimCmdLineExprId id = boost::static_pointer_cast<CsimCmdLineExprId>(expr);
          if (!id->isSignal()) {
            RefString out = RefString(new std::string("watch: Error : watch command only accepts one signal"));
            print(out);
            return;
          }
          else {
            obj = id;
          }
        }
        else if (expr->isNum()){
          i = expr->doEval();
        }
      }
    }
  }


  if (!args->empty()) {
    if (obj.get()) {
      RefCsimCmdLineExprIdSignal sig = boost::static_pointer_cast<CsimCmdLineExprIdSignal>(obj);
      for (TVec_RefCsimCmdLineExprId::iterator it = m_watchExprVec->begin(); it != m_watchExprVec->end(); ++it) {
        if (sig->getObj() == boost::static_pointer_cast<CsimCmdLineExprIdSignal>(*it)->getObj()) {
          m_watchExprVec->erase(it);
          sig->getObj()->stopTestingModified();
          it = m_watchExprVec->begin() -1;
        }
      }
    }
    else {
      TVec_RefCsimCmdLineExprId::iterator it = m_watchExprVec->begin();
      for (TInt ii = 0; it != m_watchExprVec->end() && ii < i - 1; ++it, ++ii) ;
      m_watchExprVec->erase(it);
      boost::static_pointer_cast<CsimCmdLineExprIdSignal>(*it)->getObj()->stopTestingModified();
    }
  }
  else {
    
    for (TVec_RefCsimCmdLineExprId::iterator it = m_watchExprVec->begin(); it != m_watchExprVec->end(); ++it) {
      m_watchExprVec->erase(it);
      it = m_watchExprVec->begin() -1;
      boost::static_pointer_cast<CsimCmdLineExprIdSignal>(*it)->getObj()->stopTestingModified();
    }
  }
    //  m_watchExprVec->push_back(obj);
}




void CsimShell::print(RefString& output) {
  ASSERT(output.get(), "SHELL - null string received");
  ASSERT(!output->empty(), "SHELL - empty string received");

  m_cmdLine->print(output);
}





void CsimShell::versionCmd(RefTVec_RefString args) {
  ASSERT(args.get(), "SHELL - null ref received");
  
  RefString out = RefString(new std::string("version: 0-beta-'"));
  out->append(__DATE__);
  out->append("'");

  print(out);
}

};

//END OF FILE
