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


#include "CsimCmdLineExprOper.h"


namespace NSCsimLib {


CsimCmdLineExprOper::CsimCmdLineExprOper(EExprOperType type) : CsimCmdLineExpr(EXPR_TYPE_OPER), m_operType(type) {}


RefCsimCmdLineExprOper CsimCmdLineExprOper::build(EExprOperType type) {
  ASSERT(EXPR_OPER_TYPE_UNDEF < type && EXPR_OPER_TYPE_MAX > type, "EXPR OPER - undefined type");

  CsimCmdLineExprOper* oper;

  try {
    oper = new CsimCmdLineExprOper(type);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "EXPR OPER - new operator failed");
  }

  RefCsimCmdLineExprOper refOper = RefCsimCmdLineExprOper(oper);
  oper->m_weakRef = WeakRefCsimCmdLineExprOper(refOper);

  return refOper;
}


TLongLong CsimCmdLineExprOper::doEval() {
  if (isParen())                   { return ((getChildren()->at(0))->doEval()); }
  else if (isLParen())             { ASSERT(FAIL, "trying to call doEval() on left parenthesis"); }
  else if (isRParen())             { ASSERT(FAIL, "trying to call doEval() on right parenthesis"); }
  //  else if (isUnaryMinus())         { return ( - (getChildren()->at(0))->doEval()); }
  //  else if (isUnaryPlus())          { return ( + (getChildren()->at(0))->doEval()); }
  else if (isMultiply())           { return (getChildren()->at(0))->doEval() * (getChildren()->at(1))->doEval(); }
  else if (isDivide())             { return (getChildren()->at(0))->doEval() / (getChildren()->at(1))->doEval(); }
  else if (isModulus())            { return (getChildren()->at(0))->doEval() % (getChildren()->at(1))->doEval(); }
  else if (isPlus())               { 
    if (hasMaxNoOfChildren()) {
      return (getChildren()->at(0))->doEval() + (getChildren()->at(1))->doEval();
    }
    else {
      return ( + (getChildren()->at(0))->doEval());
    }
  }
  else if (isMinus())              { 
    if (hasMaxNoOfChildren()) {
      return (getChildren()->at(0))->doEval() - (getChildren()->at(1))->doEval(); 
    }
    else {
      return ( - (getChildren()->at(0))->doEval());
    }
  }
  else if (isLT())                 { return (getChildren()->at(0))->doEval() < (getChildren()->at(1))->doEval(); }
  else if (isLTE())                { return (getChildren()->at(0))->doEval() <= (getChildren()->at(1))->doEval(); }
  else if (isGT())                 { return (getChildren()->at(0))->doEval() > (getChildren()->at(1))->doEval(); }
  else if (isGTE())                { return (getChildren()->at(0))->doEval() >= (getChildren()->at(1))->doEval(); }
  else if (isEQ())                 { return (getChildren()->at(0))->doEval() == (getChildren()->at(1))->doEval(); }
  else if (isNEQ())                { return (getChildren()->at(0))->doEval() != (getChildren()->at(1))->doEval(); }
  else if (isAssign())             { return 0; }

  return 0;
}


EExprOperType CsimCmdLineExprOper::getOperType() { return m_operType; }


TBool         CsimCmdLineExprOper::isLParen()      { return m_operType == EXPR_OPER_TYPE_LPAREN; }


TBool         CsimCmdLineExprOper::isRParen()      { return m_operType == EXPR_OPER_TYPE_RPAREN; }


//TBool         CsimCmdLineExprOper::isUnaryMinus()  { return m_operType == EXPR_OPER_TYPE_UNARY_MINUS; }


//TBool         CsimCmdLineExprOper::isUnaryPlus()   { return m_operType == EXPR_OPER_TYPE_UNARY_PLUS; }


TBool         CsimCmdLineExprOper::isMultiply()    { return m_operType == EXPR_OPER_TYPE_MULTIPLY; }


TBool         CsimCmdLineExprOper::isDivide()      { return m_operType == EXPR_OPER_TYPE_DIVIDE; }


TBool         CsimCmdLineExprOper::isModulus()     { return m_operType == EXPR_OPER_TYPE_MODULUS; }


TBool         CsimCmdLineExprOper::isPlus()        { return m_operType == EXPR_OPER_TYPE_PLUS; }


TBool         CsimCmdLineExprOper::isMinus()       { return m_operType == EXPR_OPER_TYPE_MINUS; }


TBool         CsimCmdLineExprOper::isLT()          { return m_operType == EXPR_OPER_TYPE_COMPARE_LT; }


TBool         CsimCmdLineExprOper::isLTE()         { return m_operType == EXPR_OPER_TYPE_COMPARE_LTE; }


TBool         CsimCmdLineExprOper::isGT()          { return m_operType == EXPR_OPER_TYPE_COMPARE_GT; }


TBool         CsimCmdLineExprOper::isGTE()         { return m_operType == EXPR_OPER_TYPE_COMPARE_GTE; }


TBool         CsimCmdLineExprOper::isEQ()          { return m_operType == EXPR_OPER_TYPE_COMPARE_EQT; }


TBool         CsimCmdLineExprOper::isNEQ()         { return m_operType == EXPR_OPER_TYPE_COMPARE_NEQT; }


TBool         CsimCmdLineExprOper::isAssign()      { return m_operType == EXPR_OPER_TYPE_ASSIGN; }

TBool         CsimCmdLineExprOper::isParen()       { return m_operType == EXPR_OPER_TYPE_PAREN; }


EExprOperArity CsimCmdLineExprOper::getOperArity() { 
  if (isLParen() || isRParen()) { return EXPR_OPER_ARITY_UNDEF; }
  else if (isParen()) { return EXPR_OPER_ARITY_UNARY_AND_BINARY; }
  //  else if (isUnaryMinus() || isUnaryPlus()) { return EXPR_OPER_ARITY_UNARY; }

  return EXPR_OPER_ARITY_BINARY;
}

TBool          CsimCmdLineExprOper::hasMaxNoOfChildren() {
  EExprOperArity arity = getOperArity();
  TUInt  childrenSize = getChildren()->size();
  ASSERT(arity > EXPR_OPER_ARITY_UNDEF && arity < EXPR_OPER_ARITY_MAX, "this should not be");
  if (arity == EXPR_OPER_ARITY_UNARY) { if (childrenSize >= 1) { return TRUE; } }
  else if (arity == EXPR_OPER_ARITY_BINARY || arity == EXPR_OPER_ARITY_UNARY_AND_BINARY) { if (childrenSize >= 2) { return TRUE; } }
  else if (arity == EXPR_OPER_ARITY_TERNARY) { if (childrenSize >= 3) { return TRUE; } }

  return FALSE;
}


}



//END OF FILE


