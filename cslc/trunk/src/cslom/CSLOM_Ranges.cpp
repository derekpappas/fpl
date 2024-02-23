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

const std::string BR_CONSTRUCT("csl_bitrange constructor");
const std::string MDBR_CONSTRUCT("csl_multi_dim_bitrange constructor");
const std::string FLD_CONSTRUCT("csl_field constructor");
const std::string FLD_CONSTRUCT_WIDTH("csl_field constructor: width smaller or equal with zero");

// ********************************************************************************
// CSLOmBaseRange class
// ********************************************************************************
CSLOmBaseRange::CSLOmBaseRange(TLineNumberType lineNumber,RefString fileName, ECSLOmBitRangeType brType) :
  CSLOmBase(TYPE_BIT_RANGE, lineNumber,fileName),
  m_brType(brType) {}

RefCSLOmBaseRange CSLOmBaseRange::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmBaseRange();
  }
  else {
    ASSERT(object->isBitRange() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmBaseRange>(object);
  }
}

RefCSLOmExprLink CSLOmBaseRange::getBitRangeLink() const {
  ASSERT(getID().get(),"bitRange has no id");
  RefCSLOmExprLink bitRangeLink = CSLOmExprLink::build(m_lineNumber,m_fileName, getID()->getName());
  bitRangeLink->addID(getID());
  return bitRangeLink;
}

// ********************************************************************************
// CSLOmSimpleBitRange class
// ********************************************************************************
TULong CSLOmSimpleBitRange::m_anonymousCounter=ZERO;

CSLOmSimpleBitRange::CSLOmSimpleBitRange(TLineNumberType lineNumber,RefString fileName, TBool isDefault, TBool isField) :
  CSLOmBaseRange(lineNumber,fileName, BR_SIMPLE),
  m_isDefault(isDefault),
  m_isField(isField),
  m_isAnonymous(TRUE),
  m_hasSetWidth(FALSE),
  m_className(new string("")){}

RefCSLOmSimpleBitRange CSLOmSimpleBitRange::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmSimpleBitRange();
  }
  else {
    ASSERT(object->isBitRange() && CSLOmBaseRange::cast(object)->getBrType() == BR_SIMPLE, "type check on cast failure");
    return boost::static_pointer_cast<CSLOmSimpleBitRange>(object);
  }
}

RefCSLOmSimpleBitRange CSLOmSimpleBitRange::allocate(TLineNumberType lineNumber,RefString fileName, RefCSLOmBase parent, const RefString& name) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(name.get(), "null name received");

  CSLOmSimpleBitRange* bitRange;
  try {
    bitRange = new CSLOmSimpleBitRange(lineNumber,fileName, TRUE);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmSimpleBitRange refBitRange(bitRange);
  bitRange->m_weakRef = boost::weak_ptr<CSLOmBase>( refBitRange);
  bitRange->setParent(parent);
  
  if (name->empty()) {
    RefString name1 = RefString(new std::string("*CSLBitRange_"));
    name1->append(*(ltos(m_anonymousCounter)));
    m_anonymousCounter++;
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refBitRange, CSLOmIdentifier::ID_BIT_RANGE, name1);
    bitRange->m_isAnonymous = TRUE;
  }
  else {
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refBitRange, CSLOmIdentifier::ID_BIT_RANGE, name);
    bitRange->m_isAnonymous = FALSE;
  }

  RefCSLOmNumber offset = CSLOmNum32::build(lineNumber,fileName, ZERO);
  offset->setParent(refBitRange);
  RefCSLOmNumber lower = CSLOmNum32::build(lineNumber,fileName, ZERO);
  lower->setParent(refBitRange);                      
  RefCSLOmNumber upper = CSLOmNum32::build(lineNumber,fileName, ZERO);
  upper->setParent(refBitRange);
  
  return refBitRange;
}


 
RefCSLOmSimpleBitRange CSLOmSimpleBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmSimpleBitRange simpleBitRange, TBool dontChange) {
  ASSERT(parent.get(), "null parent received");

  CSLOmSimpleBitRange* bitRange;
  try {
    bitRange = new CSLOmSimpleBitRange(lineNumber,fileName, TRUE);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmSimpleBitRange refBitRange(bitRange);
  bitRange->m_weakRef = boost::weak_ptr<CSLOmBase>( refBitRange);
  bitRange->setParent(parent);
  
  RefCSLOmString name = CSLOmString::build(lineNumber,fileName, RefString(new std::string("I'm invisible! Ah? I'm not?")));
  name->setParent(refBitRange);

  RefCSLOmExpr offset = simpleBitRange->getOffset()->dupp();
  offset->setParent(refBitRange);
  RefCSLOmExpr upper = simpleBitRange->getUpper()->dupp();
  RefCSLOmExpr lower = simpleBitRange->getLower()->dupp();
  RefCSLOmBase upVal = upper->doEval(TRUE);
  RefCSLOmBase lowVal = lower->doEval(TRUE);
  refBitRange->m_hasSetWidth = simpleBitRange->m_hasSetWidth;
  if(!dontChange) {
    if (upVal.get() && lowVal.get()) {
      if (upVal->isNumber() && lowVal->isNumber()) {
        if (CSLOmNumber::cast(upVal)->getValue() < CSLOmNumber::cast(lowVal)->getValue()) {
          lower->setParent(refBitRange);
          upper->setParent(refBitRange);                                 
          return refBitRange;
        }
      }
    }
  }
  upper->setParent(refBitRange);                                 
  lower->setParent(refBitRange);

  bitRange->m_isDefault = TRUE;
  bitRange->setSimpleBitRangeClassName(simpleBitRange->getSimpleBitRangeClassName());
  return refBitRange;
}

 
RefCSLOmSimpleBitRange CSLOmSimpleBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr widthOrBitRange) {

//   if(widthOrBitRange.get()) {
//     RefCSLOmBase eval = widthOrBitRange->doEval(TRUE);
//     if (eval.get() && eval->isNumber() && CSLOmNumber::cast(eval)->getValue() <= 0 ) {
//       args.push_back(BR_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmSimpleBitRange();
//     }
//     else if (!eval.get() || (!eval->isSimpleBitRange() && !eval->isNumber())) {
//       args.push_back(BR_CONSTRUCT);
//       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmSimpleBitRange();
//     }
//   }
  
  RefCSLOmSimpleBitRange br = allocate(lineNumber,fileName, parent, name);

  if(widthOrBitRange.get()) {
    if (widthOrBitRange->isExprLink()) {
      RefCSLOmBase eval = widthOrBitRange->doEval(TRUE);
      if (eval.get() && eval->isSimpleBitRange()) {
        br->setBitRange(CSLOmSimpleBitRange::cast(eval));
      }
      else if (eval.get() && (eval->isNumber() || eval->isParameter())) {
        br->setWidth(widthOrBitRange);
	br->setSimpleBitRangeClassName(name);
      }
      else {
        args.push_back(BR_CONSTRUCT);
        addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
        cslomHasErrors = TRUE;
        return RefCSLOmSimpleBitRange();
      }
    }
    else {
      br->setWidth(widthOrBitRange);
      br->setSimpleBitRangeClassName(name);
    }
  }
  return br;
}

RefCSLOmSimpleBitRange CSLOmSimpleBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmSimpleBitRange simpleBitRange) {
  ASSERT(simpleBitRange.get(),"null bitRange received");
  
  RefCSLOmSimpleBitRange br = allocate(lineNumber,fileName, parent, name);

  br->setBitRange(simpleBitRange);
  br->m_hasSetWidth = simpleBitRange->m_hasSetWidth;
  return br;
}

RefCSLOmSimpleBitRange CSLOmSimpleBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr up, RefCSLOmExpr low) {
  ASSERT(low.get(), "null low received"); 
  ASSERT(up.get(), "null up received");
  
  RefCSLOmSimpleBitRange br = allocate(lineNumber,fileName, parent, name);

//   RefCSLOmBase evalLow = low->doEval(TRUE); 
//   RefCSLOmBase evalUp = up->doEval(TRUE); 

//   if(!evalLow.get() || !evalLow->isNumber()) {
//     args.push_back(BR_CONSTRUCT);
//     addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//     cslomHasErrors = TRUE;
//     return RefCSLOmSimpleBitRange();
//   }
//   if(!evalUp.get() || !evalUp->isNumber()) {
//     args.push_back(BR_CONSTRUCT);
//     addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//     cslomHasErrors = TRUE;
//     return RefCSLOmSimpleBitRange();
//   }

//   if (CSLOmNumber::cast(evalUp)->getValue() < CSLOmNumber::cast(evalLow)->getValue()) {
//     DCERR("This should be a warning because someone said that they want a warning if the lower is greater then the upper.")
//   }

  br->setRange(low ,up);
  br->setSimpleBitRangeClassName(name);

  return br;
}

void CSLOmSimpleBitRange::setOffset(RefCSLOmExpr offset) {
  ASSERT(offset.get(), "null param received");

  RefCSLOmExpr copy = offset->dupp();
  setChild(BR_OFFSET, copy);
}

void CSLOmSimpleBitRange::setWidth(RefCSLOmExpr width) {
  ASSERT(width.get(), "null param received");

  //for design checker
  m_mandatoryCounter++;

  RefCSLOmNumber low = CSLOmNum32::build(m_lineNumber,m_fileName, ZERO);
  RefCSLOmExpr up = CSLOmExprOp::build(m_lineNumber,m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, width, CSLOmNum32::build(m_lineNumber, m_fileName, ONE));

  setChild(BR_LOWER, low);
  setChild(BR_UPPER, up);  
  m_isDefault = FALSE;
  m_hasSetWidth=TRUE;
}

void CSLOmSimpleBitRange::setRange(RefCSLOmExpr low, RefCSLOmExpr up) {
  ASSERT(low.get(),"null low received");
  ASSERT(up.get(),"null up received");
  ASSERT(m_isDefault, "cannot set for non default value");

//   RefCSLOmBase evalLow = low->doEval(TRUE);
//   RefCSLOmBase evalUp = up->doEval(TRUE);

//   ASSERT(evalLow.get(), "low cannot be evaled");
//   ASSERT(evalUp.get(), "up cannot be evaled");
//   ASSERT(evalLow->isNumber(), "low is not a number");
//   ASSERT(evalUp->isNumber(), "up is not a number");
  
//   RefCSLOmNumber copyLow = CSLOmNum32::build(m_lineNumber,m_fileName, CSLOmNum32::cast(evalLow)->getValue());
//   RefCSLOmNumber copyUp  = CSLOmNum32::build(m_lineNumber,m_fileName, CSLOmNum32::cast(evalUp)->getValue());

//   if (copyLow->getValue() > copyUp->getValue()) {
//     setChild(BR_UPPER, copyLow);
//     setChild(BR_LOWER, copyUp);  
//   }
//   else {
//     setChild(BR_LOWER, copyLow);
//     setChild(BR_UPPER, copyUp);  
//   }
  setChild(BR_LOWER, low->dupp());
  setChild(BR_UPPER, up->dupp());  
  m_isDefault = FALSE;
}

const RefString CSLOmSimpleBitRange::getSimpleBitRangeClassName() const {
  return m_className;
}

void CSLOmSimpleBitRange::setSimpleBitRangeClassName(RefString name) {
  m_className = name;
}

void CSLOmSimpleBitRange::setBitRange(RefCSLOmExpr br) {
  ASSERT(br.get(), "null expr received");

  RefCSLOmBase eval = br->doEval();

  ASSERT(eval.get(), "br cannot be evaled");
  ASSERT(eval->isSimpleBitRange(), "br cannot be evaled");

  setBitRange(CSLOmSimpleBitRange::cast(eval));
}

void CSLOmSimpleBitRange::setBitRange(RefCSLOmSimpleBitRange br) {
  ASSERT(br.get(), "null bitRange received");

  setOffset(br->getOffset());
  setRange(br->getLower(), br->getUpper());
  m_hasSetWidth = br->m_hasSetWidth;
  setSimpleBitRangeClassName(br->getSimpleBitRangeClassName());
}

RefCSLOmExpr CSLOmSimpleBitRange::getOffset() const {
  return CSLOmExpr::cast(getChild(BR_OFFSET));
}

RefCSLOmExpr CSLOmSimpleBitRange::getWidth() const {

  if (isField() && CSLOmField::cast(getThis())->isHierarchical()) {
    CSLOmField::cast(getThis())->updateHierWidth();
  }
  RefCSLOmExpr low = CSLOmExpr::cast(getChild(BR_LOWER));
  RefCSLOmExpr up = CSLOmExpr::cast(getChild(BR_UPPER));

  if(m_hasSetWidth){
    return CSLOmExpr::cast(up->getChild(0));
  }
  else{
    RefCSLOmExpr width = CSLOmExprOp::build(m_lineNumber,m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, up->dupp(), low->dupp());
    width = CSLOmExprOp::build(m_lineNumber,m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS, width, CSLOmNum32::build(m_lineNumber, m_fileName, ONE));
    return width;
  }
}

RefCSLOmExpr CSLOmSimpleBitRange::getLower() const {
  return CSLOmExpr::cast(getChild(BR_LOWER));
}

RefCSLOmExpr CSLOmSimpleBitRange::getUpper() const {
  return CSLOmExpr::cast(getChild(BR_UPPER));
}

void CSLOmSimpleBitRange::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmMultiDimBitRange class
// ********************************************************************************
TULong CSLOmMultiDimBitRange::m_anonymousCounter=ZERO;

CSLOmMultiDimBitRange::CSLOmMultiDimBitRange(TLineNumberType lineNumber, RefString fileName) :
  CSLOmBaseRange(lineNumber,fileName, BR_MULTI_DIM),
  m_isAnonymous(FALSE) {}

RefCSLOmMultiDimBitRange CSLOmMultiDimBitRange::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmMultiDimBitRange();
  }
  else {
    ASSERT(object->isMultiDimBitRange() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmMultiDimBitRange>(object);
  }
}

RefCSLOmMultiDimBitRange CSLOmMultiDimBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr noOfDimsOrBr) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(name.get(), "null name received");
  ASSERT(noOfDimsOrBr.get(), "null name received");

//   RefCSLOmBase eval = noOfDimsOrBr->doEval(TRUE);

//   if (!eval.get() || (!eval->isNumber() && !eval->isMultiDimBitRange())) { // check if the param can pe evaluated and if so check that it is a number(no of dims) or a br
//     args.push_back(MDBR_CONSTRUCT);
//     addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//     cslomHasErrors = TRUE;
//     return RefCSLOmMultiDimBitRange();
//   }

//   if (eval->isNumber() && CSLOmNumber::cast(eval)->getValue() == ZERO) {
//     args.push_back(MDBR_CONSTRUCT);
//     addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//     cslomHasErrors = TRUE;
//     return RefCSLOmMultiDimBitRange();
//   }

  CSLOmMultiDimBitRange* bitRange;
  try {
    bitRange = new CSLOmMultiDimBitRange(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmMultiDimBitRange refBitRange(bitRange);
  bitRange->m_weakRef = boost::weak_ptr<CSLOmBase>( refBitRange);
  bitRange->setParent(parent);
  
  if (name->empty()) {
    RefString name1 = RefString(new std::string("*CSLMDBitRange_"));
    name1->append(*(ltos(m_anonymousCounter)));
    m_anonymousCounter++;
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refBitRange, CSLOmIdentifier::ID_BIT_RANGE, name1);
    bitRange->m_isAnonymous = TRUE;
  }
  else {
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refBitRange, CSLOmIdentifier::ID_BIT_RANGE, name);
    bitRange->m_isAnonymous = FALSE;
  }

  if (noOfDimsOrBr->isExprLink()) {
    RefCSLOmBase eval = noOfDimsOrBr->doEval(TRUE);
    if (eval.get() && (eval->isNumber() || eval->isParameter())) {
      bitRange->setNoOfDims(CSLOmExpr::cast(noOfDimsOrBr));
    } 
    else if (eval.get() && eval->isMultiDimBitRange()) {
      bitRange->copy(CSLOmMultiDimBitRange::cast(eval));
    }
    else {
      args.push_back(MDBR_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmMultiDimBitRange();
    }
  }
  else {
    bitRange->setNoOfDims(CSLOmExpr::cast(noOfDimsOrBr));
  }

  return refBitRange;
}

RefCSLOmMultiDimBitRange CSLOmMultiDimBitRange::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmMultiDimBitRange noOfDimsOrBr) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(name.get(), "null name received");
  ASSERT(noOfDimsOrBr.get(), "null name received");

  CSLOmMultiDimBitRange* bitRange;
  try {
    bitRange = new CSLOmMultiDimBitRange(lineNumber,fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmMultiDimBitRange refBitRange(bitRange);
  bitRange->m_weakRef = boost::weak_ptr<CSLOmBase>( refBitRange);
  bitRange->setParent(parent);
  
  if (name->empty()) {
    RefString name1 = RefString(new std::string("*CSLMDBitRange_"));
    name1->append(*(ltos(m_anonymousCounter)));
    m_anonymousCounter++;
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refBitRange, CSLOmIdentifier::ID_BIT_RANGE, name1);
    bitRange->m_isAnonymous = TRUE;
  }
  else {
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refBitRange, CSLOmIdentifier::ID_BIT_RANGE, name);
    bitRange->m_isAnonymous = FALSE;
  }

  bitRange->copy(noOfDimsOrBr);

  return refBitRange;
}

void CSLOmMultiDimBitRange::copy(RefCSLOmMultiDimBitRange br) {
  ASSERT(br.get(), "null br received");
  
  RefCSLOmExpr noOfDims = br->getNoOfDims()->dupp();
  noOfDims->setParent(getThis());
  RefTVec_RefCSLOmSimpleBitRange dims = br->getChildren<CSLOmSimpleBitRange>(TYPE_ALL_SIMPLE_BR);
  TVec_RefCSLOmSimpleBitRange::iterator it;
  for(it = dims->begin(); it < dims->end(); ++it) {
    RefCSLOmSimpleBitRange br = CSLOmSimpleBitRange::build(m_lineNumber,m_fileName, getThis(), RefString(new std::string("")), *it);
    br->m_isDefault = (*it)->isDefault();
  }
}

void CSLOmMultiDimBitRange::setNoOfDims(RefCSLOmExpr noOfDims) {
  ASSERT(noOfDims.get(), "null br received");
  
  RefCSLOmBase eval = noOfDims->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  RefCSLOmNumber copy = CSLOmNum32::build(m_lineNumber,m_fileName, CSLOmNumber::cast(eval)->getValue());
  copy->setParent(getThis());
  TUInt noDims = CSLOmNumber::cast(eval)->getValue();
  for(TUInt i = 0; i < noDims; ++i) {
    CSLOmSimpleBitRange::build(m_lineNumber,m_fileName, getThis(), RefString(new std::string("")));
  }
}

void CSLOmMultiDimBitRange::setDimOffset(RefCSLOmExpr dim, RefCSLOmExpr offset) {
  ASSERT(dim.get(), "null br received");
  ASSERT(offset.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  ASSERT(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo, "dim does not exist");

  CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->setOffset(offset);
}

void CSLOmMultiDimBitRange::setDimWidth(RefCSLOmExpr dim, RefCSLOmExpr width) {
  ASSERT(dim.get(), "null br received");
  ASSERT(width.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  ASSERT(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo, "dim does not exist");

  CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->setWidth(width);
}

void CSLOmMultiDimBitRange::setDimRange(RefCSLOmExpr dim, RefCSLOmExpr low, RefCSLOmExpr up) {
  ASSERT(dim.get(), "null br received");
  ASSERT(low.get(), "null br received");
  ASSERT(up.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  ASSERT(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo, "dim does not exist");

  CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->setRange(low, up);
}

void CSLOmMultiDimBitRange::setDimBitRange(RefCSLOmExpr dim, RefCSLOmExpr br) {
  ASSERT(dim.get(), "null br received");
  ASSERT(br.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  ASSERT(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo, "dim does not exist");

  CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->setBitRange(br);
}

void CSLOmMultiDimBitRange::setDimBitRange(RefCSLOmExpr dim, RefCSLOmSimpleBitRange br) {
  ASSERT(dim.get(), "null br received");
  ASSERT(br.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  ASSERT(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo, "dim does not exist");

  CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->setBitRange(br);
}

RefCSLOmExpr CSLOmMultiDimBitRange::getNoOfDims() const {
  return CSLOmNumber::cast(getChild(NO_OF_DIMS));
}

RefCSLOmExpr CSLOmMultiDimBitRange::getDimOffset(RefCSLOmExpr dim) const {
  ASSERT(dim.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  if(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo) {
    return CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->getOffset();
  }
  else {
    return RefCSLOmNumber();
  }
}

RefCSLOmExpr CSLOmMultiDimBitRange::getDimWidth(RefCSLOmExpr dim) const {
  ASSERT(dim.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  if (CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo) {
    return CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->getWidth();
  }
  else {
    return RefCSLOmNumber();
  }
}

RefCSLOmExpr CSLOmMultiDimBitRange::getDimLower(RefCSLOmExpr dim) const {
  ASSERT(dim.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  if(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo) {
    return CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->getLower();
  }
  else {
    return RefCSLOmNumber();
  }
}

RefCSLOmExpr CSLOmMultiDimBitRange::getDimUpper(RefCSLOmExpr dim) const {
  ASSERT(dim.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  if(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo) {
    return CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM))->getUpper();
  }
  else {
    return RefCSLOmNumber();
  }

}

RefCSLOmSimpleBitRange CSLOmMultiDimBitRange::getDimBitRange(RefCSLOmExpr dim) const {
  ASSERT(dim.get(), "null br received");
  
  RefCSLOmBase eval = dim->doEval(TRUE);

  ASSERT(eval.get(), "cannot eval expr");
  ASSERT(eval->isNumber(), "param is not a number");

  TInt dimNo = CSLOmNumber::cast(eval)->getValue();
  
  if(CSLOmNumber::cast(getNoOfDims()->doEval())->getValue() > dimNo) {
    return CSLOmSimpleBitRange::cast(getChild(dimNo + FIRST_DIM));
  }
  else {
    return RefCSLOmSimpleBitRange();
  }
}

void CSLOmMultiDimBitRange::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmField class
// ********************************************************************************
CSLOmField::CSLOmField( TLineNumberType lineNumber, RefString fileName, ECSLOmFieldType type, ECSLOmFieldIsaType isIsa) : 
  CSLOmSimpleBitRange(lineNumber,fileName, FALSE, TRUE),
  m_scope(), 
  m_fieldType(FIELD_UNDEFINED),
  m_fieldPositions(),
  m_hasPositionsSet(FALSE),
  m_fieldIsaType(isIsa),
  m_isDecoder(FALSE),
  m_isInstance(FALSE),
  m_isUpdated(FALSE) {}

RefCSLOmField CSLOmField::cast(RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmField();
  } 
  else {
    ASSERT(object->isField(), "type check on cast failure");
    return boost::static_pointer_cast<CSLOmField>(object);
  }
}

RefCSLOmField CSLOmField::allocate( TLineNumberType    lineNumber,
                                    RefString          fileName,
                                    RefCSLOmBase       parent    ,
                                    const RefString&   name      ) {

  ASSERT(name.get(), "null name received");
  ASSERT(parent.get(), "null parent received");

  CSLOmField *field;
  try {
    field = new CSLOmField(lineNumber,fileName, FIELD_UNDEFINED);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmField refField(field);
  field->m_weakRef = boost::weak_ptr<CSLOmBase>( refField);
  if (parent->isField()) {
    RefCSLOmField hField = CSLOmField::cast(parent);
    if (hField->getFieldType() == FIELD_UNDEFINED) {
      hField->m_fieldType = FIELD_HIERARCHICAL;
      if (!hField->m_fieldPositions.get()) {
        hField->m_fieldPositions = RefTVec_RefCSLOmField(new TVec_RefCSLOmField);
      }
    }
    if (hField->getFieldType() != FIELD_HIERARCHICAL) {
      args.push_back(FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
    hField->m_isUpdated = FALSE;
  }
  field->setParent(parent);

  RefCSLOmIdentifier id;
  if (name->empty()) {
    RefString name1 = RefString(new std::string("*CSLField_"));
    name1->append(*(ltos(m_anonymousCounter)));
    m_anonymousCounter++;
    id = CSLOmIdentifier::build(lineNumber,fileName, refField, CSLOmIdentifier::ID_FIELD, name1);
    field->m_isAnonymous = TRUE;
  }
  else {
    id = CSLOmIdentifier::build(lineNumber,fileName, refField, CSLOmIdentifier::ID_FIELD, name);
    field->m_isAnonymous = FALSE;
  }

  field->m_scope = CSLOmScope::build(id);
  RefCSLOmNum32 offset = CSLOmNum32::build(lineNumber,fileName, 0);
  offset->setParent(refField);

  RefCSLOmNum32 lower = CSLOmNum32::build(lineNumber, fileName, 0);
  RefCSLOmNum32 upper = CSLOmNum32::build(lineNumber, fileName, 0);
  lower->setParent(refField);
  upper->setParent(refField);
  field->m_isDefault = TRUE;

  RefCSLOmContainer allowed = CSLOmContainer::build(lineNumber,fileName, TYPE_ADDRESS_RANGE);
  allowed->setParent(refField);

  return refField; 
}

 RefCSLOmField CSLOmField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name) {
   return allocate(lineNumber,fileName, parent, name);
}

RefCSLOmField CSLOmField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr widthOrBr, RefCSLOmExprLink enumItemOrEnum) {
  ASSERT(name.get(), "null name received");
  ASSERT(parent.get(), "null parent received");
  ASSERT(widthOrBr.get(), "null widthOrBr received");

  
  RefCSLOmBase brEval = widthOrBr->doEval(TRUE);
  if (brEval.get()) {
    if (!brEval->isNumber() && !brEval->isSimpleBitRange()) {
      args.push_back(FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
    else if (brEval->isNumber() && CSLOmNumber::cast(brEval)->getValue() <= ZERO) {
      args.push_back(FLD_CONSTRUCT_WIDTH);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
  }

  RefCSLOmField field = allocate(lineNumber,fileName, parent, name);

  if (widthOrBr->isExprLink()) {
    RefCSLOmBase brEval = widthOrBr->doEval(TRUE);
    if (brEval.get() && (brEval->isParameter() || brEval->isNumber())) {
      field->setWidth(CSLOmNumber::cast(widthOrBr));
    }
    else if (brEval.get() && brEval->isSimpleBitRange()){
      field->setBitRange(CSLOmSimpleBitRange::cast(brEval));
    }
    else {
      args.push_back(FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
  }
  else {
    field->setWidth(widthOrBr);
  }


  if (enumItemOrEnum.get()) {
    RefCSLOmBase evaled = enumItemOrEnum->doEval();
    if (!evaled.get()) {
      args.push_back(FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
    if (!evaled->isEnum()) {
      args.push_back(FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
    else {
      enumItemOrEnum->setParent(field);
      if (evaled->isEnum()) {
        field->m_fieldType = FIELD_ENUM;
      }
      else if (evaled->isEnumItem()){
        field->m_fieldType = FIELD_ENUM_ITEM;
      }
      else {
        ASSERT(FAIL, "this should not happen.. EVER")
      }
    }
  }
  return field;
}

RefCSLOmField CSLOmField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr low, RefCSLOmExpr up, RefCSLOmExprLink enumItemOrEnum) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(low.get(),"null low received");
  ASSERT(up.get(),"null up received");

  RefCSLOmField field = allocate(lineNumber,fileName, parent, name);
  field->setRange(low, up);
//   RefCSLOmBase lower = low->doEval(TRUE);
//   RefCSLOmBase upper = up->doEval(TRUE);
//   if ((lower->isExpr() && CSLOmExpr::cast(lower)->isNumber()) &&
//       (upper->isExpr() && CSLOmExpr::cast(upper)->isNumber())) {
//     field->setRange(CSLOmNumber::cast(lower), CSLOmNumber::cast(upper));
//   }
//   else {
//     args.push_back(FLD_CONSTRUCT);
//     addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
//     cslomHasErrors = TRUE;
//     return RefCSLOmField();
//   }

  if (enumItemOrEnum.get()) {
    RefCSLOmBase evaled = enumItemOrEnum->doEval();
    if (!evaled.get()) {
      args.push_back(FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
    if (!evaled->isEnum()) {
      args.push_back(FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmField();
    }
    else {
      enumItemOrEnum->setParent(field);
      if (evaled->isEnum()) {
        field->m_fieldType = FIELD_ENUM;
      }
      else if (evaled->isEnumItem()){
        field->m_fieldType = FIELD_ENUM_ITEM;
      }
      else {
        ASSERT(FAIL, "this should not happen.. EVER")
      }
    }
  }
  return field;

}

RefCSLOmField CSLOmField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmField sourceField) {
  ASSERT(name.get(), "null name received");
  ASSERT(parent.get(), "null parent received");
  ASSERT(sourceField.get(), "null field received");
  
  RefCSLOmField field = allocate(lineNumber,fileName, parent, name);
  RefCSLOmExpr offset;// = CSLOmNum32::build(lineNumber, fileName, ZERO);
  RefCSLOmExpr lower ;// = CSLOmNum32::build(lineNumber, fileName, ZERO);
  RefCSLOmExpr upper ;// = CSLOmNum32::build(lineNumber, fileName, ZERO);

  offset = sourceField->getOffset()->dupp(); 
  lower  = sourceField->getLower()->dupp(); 
  upper  = sourceField->getUpper()->dupp(); 
    
  field->setOffset(offset);
  field->setRange(lower, upper);

  if (sourceField->m_fieldType == FIELD_HIERARCHICAL) {
    RefTVec_RefCSLOmBase children = sourceField->getFields();
    if (children.get()) {
      TVec_RefCSLOmBase::iterator it;
      for(it = children->begin(); it < children->end(); ++it) {
        CSLOmField::build(sourceField->m_lineNumber,sourceField->m_fileName, field, CSLOmField::cast(*it)->getName(), CSLOmField::cast(*it));
      }
    }
  }
  else if (sourceField->m_fieldType == FIELD_ENUM) {
    RefCSLOmEnum en = CSLOmEnum::cast(sourceField->getEnum());
    RefCSLOmIdentifier id = CSLOmIdentifier::cast(en->getChild(ID));
    RefString name = id->getName();
    RefCSLOmExprLink expr = CSLOmExprLink::build(lineNumber,fileName, name);
    expr->setValue(sourceField->getEnum());
    expr->setParent(field);
    field->m_isInstance = TRUE;
  }
  else if (sourceField->m_fieldType == FIELD_ENUM_ITEM) {
    RefCSLOmExprLink expr = CSLOmExprLink::build(lineNumber,fileName, CSLOmExprLink::cast(sourceField->getChild(FIELD_POS_ENUM_ITEM))->getName());
    expr->setValue(sourceField->getEnumItem());
    expr->setParent(field);
  }
  else if (sourceField->m_fieldType == FIELD_VALUE) {
    field->setValue(CSLOmNumber::cast(sourceField->getValue()));
  }

  field->m_fieldType = sourceField->m_fieldType;

//   if (field->isHierarchical()) {
//     field->m_fieldPositions = RefTVec_RefCSLOmField(new TVec_RefCSLOmField);
//   }
  if (sourceField->getParent()->isField() && CSLOmField::cast(sourceField->getParent())->m_fieldType == FIELD_HIERARCHICAL && CSLOmField::cast(sourceField->getParent())->getFieldPosition(sourceField) != -1) {
    CSLOmField::cast(parent)->setFieldPosition(field, CSLOmNum32::build(lineNumber, fileName, CSLOmField::cast(sourceField->getParent())->getFieldPosition(sourceField)));
  }

  return field;
}

RefCSLOmScope CSLOmField::getAttachedScope() const {
  return m_scope;
}

void CSLOmField::updateHierWidth() {
  if (m_isDefault && !m_isUpdated) {
    RefTVec_RefCSLOmBase fields = getFields();
    if (fields.get()) {
      TUInt width = 0;
      for (TVec_RefCSLOmBase::iterator it = fields->begin(); it < fields->end(); ++it) {
        width += CSLOmNumber::cast(CSLOmField::cast(*it)->getWidth()->doEval())->getValue();
      }
      setWidth(CSLOmNum32::build(m_lineNumber,m_fileName, width));
      m_isDefault = TRUE;
      m_mandatoryCounter--;
    }
    m_isUpdated = TRUE;
  }
}

TBool CSLOmField::isAllowed(RefCSLOmNumber value) {
  ASSERT(value.get(),"NULL value");

  RefCSLOmBase container = CSLOmContainer::cast(getChild(FIELD_POS_RANGES));
  RefTVec_RefCSLOmBase refRangesVec = container->getChildrenAsBase();
  TVec_RefCSLOmBase_const_iter it;
  if (refRangesVec.get()) { 
    for( it = refRangesVec->begin(); it < refRangesVec->end(); ++it) {
      if( !( (CSLOmNumber::cast(CSLOmAddressRange::cast(*it)->getLower()->doEval()))->relationalLess( value )->getValue() == 1 &&
             (CSLOmNumber::cast(CSLOmAddressRange::cast(*it)->getUpper()->doEval()))->relationalGreater( value )->getValue() == 1 ) ) {
        return TRUE;
      }
    }
  }
  else {
    return TRUE;// if no value range is set then every value is allowed
  }
  return FALSE;
}

void CSLOmField::addAllowedRange(RefCSLOmExpr low, RefCSLOmExpr up) {
  ASSERT(low.get(), "null low received");
  ASSERT(up.get(), "null up received");

  RefCSLOmBase evalLow = low->doEval(TRUE);
  RefCSLOmBase evalUp = up->doEval(TRUE);

  ASSERT(evalLow.get(), "low cannot be evaled");
  ASSERT(evalUp.get(), "up cannot be evaled");

  ASSERT(evalLow->isNumber(), "low is NAN");
  ASSERT(evalUp->isNumber(), "up is NAN");
  
  RefCSLOmContainer allowed = CSLOmContainer::cast(getChild(FIELD_POS_RANGES));

  CSLOmAddressRange::build(m_lineNumber,m_fileName, allowed, CSLOmExpr::cast(evalLow), CSLOmExpr::cast(evalUp), CSLOmAddressRange::ADDR_VALID);
};

void CSLOmField::setValue(RefCSLOmExpr value) {
  ASSERT(value.get(), "NULL value");
  //  ASSERT(m_fieldType == FIELD_UNDEFINED,"field has to be undefined for set_value, this should be tested in cmd");

  if(!isAllowed(CSLOmNumber::cast(value->doEval()))) {
    ASSERT(FAIL,"value is not allowed, this should be tested in cmd");
  }
  else {
    RefCSLOmExpr val = value->dupp();
    val->setParent(getThis());
    m_fieldType = FIELD_VALUE;
  }
}

void CSLOmField::setEnum(RefCSLOmEnum enum_) {
  ASSERT(enum_.get(), "NULL enum_ !");
  ASSERT(m_fieldType == FIELD_UNDEFINED,"field has to be undefined for set_value, this should be tested in cmd");

  RefCSLOmExprLink expr = CSLOmExprLink::build(m_lineNumber,m_fileName, CSLOmIdentifier::cast(enum_->getChild(ID))->getName());
  expr->setParent(getThis());
  m_fieldType = FIELD_ENUM;
  if (m_isDefault) {
    setWidth(CSLOmNum32::build(m_lineNumber,m_fileName, enum_->getWidth()));
    m_isDefault = TRUE;
  }
}

void CSLOmField::setEnumItem(RefCSLOmIdentifier enumItem) {
  ASSERT(enumItem.get(), "NULL enumItem !");
  ASSERT(enumItem->isEnumItem(), "id is not a enumItem !");
  ASSERT(m_fieldType == FIELD_UNDEFINED || (m_fieldType == FIELD_ENUM && m_isInstance),"field has to be undefined for set_value, this should be tested in cmd");


  if( !isAllowed(CSLOmNumber::cast(enumItem->getPayload()))) {
    ASSERT(FAIL,"value is not allowed, this should be tested in cmd");
  }
  else {
    RefCSLOmExprLink expr = CSLOmExprLink::build(m_lineNumber,m_fileName, enumItem->getName());
    if (m_fieldType == FIELD_ENUM && m_isInstance) {
      setChild(FIELD_POS_ENUM_ITEM ,expr);
    }
    else {
      expr->setParent(getThis());
    }
    m_fieldType = FIELD_ENUM_ITEM;
  }
}

TBool CSLOmField::nextOverlap(RefCSLOmField field1, RefCSLOmField field2) {
  ASSERT(field1.get(), "null received");
  ASSERT(field2.get(), "null received");
 
  TInt pos = 0;
  TVec_RefCSLOmField::iterator it;
  for (it = m_fieldPositions->begin(); it < m_fieldPositions->end(); it++, pos++) {
    if ((*it) == field1) {
      pos -= CSLOmNumber::cast(field2->getWidth()->doEval())->getValue();
      return posOverlap(field2, CSLOmNum32::build(m_lineNumber,m_fileName, pos));
    }
  }

  return TRUE;
}

TBool CSLOmField::prevOverlap(RefCSLOmField field1, RefCSLOmField field2) {
  ASSERT(field1.get(), "null received");
  ASSERT(field2.get(), "null received");

  TInt pos = 0;
  TVec_RefCSLOmField::iterator it;
  for (it = m_fieldPositions->begin(); it < m_fieldPositions->end(); it++, pos++) {
    if ((*it) == field1) {
      pos += CSLOmNumber::cast(field1->getWidth()->doEval())->getValue();
      return posOverlap(field2, CSLOmNum32::build(m_lineNumber,m_fileName, pos));
    }
  }

  return TRUE;
}

TBool CSLOmField::posOverlap(RefCSLOmField field, RefCSLOmNumber pos) {
  ASSERT(field.get(), "null received");
  ASSERT(pos.get(), "null received");

  TInt p = pos->getValue();
  TInt w = CSLOmNumber::cast(field->getWidth()->doEval())->getValue();

  TInt low = CSLOmNumber::cast(getLower()->doEval())->getValue();
  TInt up =  CSLOmNumber::cast(getUpper()->doEval())->getValue();

  if (p < low) {
    return TRUE;
  }

  if (p+w-1 > up) {
    return TRUE;
  }

  if (m_fieldPositions->size() == 0) {
    return FALSE;
  }
  else {
    for (int i = p; i < p+w ; i++) {
      if (m_fieldPositions->at(i).get()) {
        return TRUE;
      }
    }
  }
  return FALSE;
}

TBool CSLOmField::isSetPosition(RefCSLOmField field) {
  ASSERT(field.get(),"null param received");

  for (TUInt count = 0; count < m_fieldPositions->size(); count++) {
    if (m_fieldPositions->at(count).get() == field.get()) {
      return TRUE;
    }
  }
  return FALSE;
}

TInt CSLOmField::getFieldPosition(RefCSLOmField field) {
  ASSERT(field.get(),"null param received");

  for (TUInt count = 0; count < m_fieldPositions->size(); count++) {
    if (m_fieldPositions->at(count).get() == field.get()) {
      return count;
    }
  }
  return -1;
}

void CSLOmField::setFieldPosition(RefCSLOmField field, RefCSLOmExpr position) {
  ASSERT(isHierarchical(), "field is not hierarchical or does not have any children");
  ASSERT(field.get(), "null field received");
  ASSERT(field->getParent() == getThis(), "this field is not in this field");
  ASSERT(position.get(), "null position received");
  ASSERT(m_fieldPositions.get(), "if the field is hierarchical this should not be null");
  
  TInt width = CSLOmNumber::cast(getWidth()->doEval())->getValue();
  if (m_fieldPositions->size() == 0) {
    for (TInt count = 0; count < width; ++count) {
      m_fieldPositions->push_back(RefCSLOmField());
    }
  }
  
  // the position of the setField is the value as the parameter + fields lower index + fields offset
  // i'm substracting the lower of this field so that the vector starts from ZERO always
  TInt lower = CSLOmNumber::cast(getLower()->doEval())->getValue();
  TInt upper = CSLOmNumber::cast(getUpper()->doEval())->getValue();
  TInt pos = CSLOmNumber::cast(position->doEval())->getValue();
  TInt fieldWidth = CSLOmNumber::cast(field->getWidth()->doEval())->getValue();

  ASSERT(lower <= pos && pos <= upper, "cmd forgot to test this");

  ASSERT(pos + fieldWidth - 1 <= lower + width - 1, "this does not fit in the great scheme of things, (cmd should give an error)");

  for (TInt count = pos; count < pos + fieldWidth; ++count) {
    ASSERT(!m_fieldPositions->at(count).get(), "cmd forgot to test this also");
    m_fieldPositions->at(count) = field;
  }
  m_hasPositionsSet = TRUE;
}

void CSLOmField::setPreviousField(RefCSLOmField fieldReference, RefCSLOmField fieldToSet) {
  ASSERT(isHierarchical(), "field is not hierarchical or does not have any children");
  ASSERT(fieldToSet.get(), "null field received");
  ASSERT(fieldReference.get(), "null field received");
  ASSERT(fieldReference->getParent() == getThis(), "this field is not in this field");
  ASSERT(fieldToSet->getParent() == getThis(), "this field is not in this field");
  ASSERT(m_fieldPositions.get(), "if the field is hierarchical this should not be null");

  TInt width = CSLOmNumber::cast(getWidth()->doEval())->getValue();
  if (m_fieldPositions->size() == 0) {
    for (TInt count = 0; count < width; ++count) {
      m_fieldPositions->push_back(RefCSLOmField());
    }
  }

  for (TInt count = ZERO; count < width; ++count) {
    ASSERT(m_fieldPositions->at(count) != fieldToSet, "cmd forgot to test this also");
  }
  
  TInt pos = ZERO;
  TBool found = FALSE;

  for (TInt count = ZERO; count < width; ++count) {
    ASSERT(m_fieldPositions->at(count) != fieldToSet, "cmd forgot to test this also");
    if (m_fieldPositions->at(count) == fieldReference) {
      found = TRUE;
    }
    else if (found == TRUE) {
      pos = count;
      break;
    }
  }

  ASSERT(found, "this needs to be checked in the cmd");

  TInt fieldWidth = CSLOmNumber::cast(fieldToSet->getWidth()->doEval())->getValue();

  ASSERT(pos + fieldWidth <= width, "this does not fit in the great scheme of things, (cmd should give an error)");

  for (TInt count = pos; count < pos + fieldWidth; ++count) {
    ASSERT(!m_fieldPositions->at(count).get(), "cmd forgot to test this also");
    m_fieldPositions->at(count) = fieldToSet;
  }
}

void CSLOmField::setNextField(RefCSLOmField fieldReference, RefCSLOmField fieldToSet) {
  ASSERT(isHierarchical(), "field is not hierarchical or does not have any children");
  ASSERT(fieldToSet.get(), "null field received");
  ASSERT(fieldReference.get(), "null field received");
  ASSERT(fieldReference->getParent() == getThis(), "this field is not in this field");
  ASSERT(fieldToSet->getParent() == getThis(), "this field is not in this field");
  ASSERT(m_fieldPositions.get(), "if the field is hierarchical this should not be null");

  TInt width = CSLOmNumber::cast(getWidth()->doEval())->getValue();
  if (m_fieldPositions->size() == 0) {
    for (TInt count = 0; count < width; ++count) {
      m_fieldPositions->push_back(RefCSLOmField());
    }
  }

  for (TInt count = ZERO; count < width; ++count) {
    ASSERT(m_fieldPositions->at(count).get() != fieldToSet.get(), "cmd forgot to test this also");
  }
  
  TInt pos = ZERO;
  TBool found = FALSE;

  for (TInt count = width - 1; count >= ZERO; --count) {
    if (m_fieldPositions->at(count).get() == fieldReference.get()) {
      found = TRUE;
    }
    if (found == TRUE) {
      pos = count;
      found = FALSE;
    }
    else {
      // DO NOTHING
    }
  }


  TInt fieldWidth = CSLOmNumber::cast(fieldToSet->getWidth()->doEval())->getValue();
  TInt low = CSLOmNumber::cast(getLower()->doEval())->getValue();

  ASSERT(pos - fieldWidth >= low, "this does not fit in the great scheme of things, (cmd should give an error)");

  for (TInt count = pos-1; count >= pos - fieldWidth; --count) {
    ASSERT(!m_fieldPositions->at(count).get(), "cmd forgot to test this also");
    m_fieldPositions->at(count) = fieldToSet;
  }
}

void CSLOmField::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmAddressRange class
// ********************************************************************************
TULong CSLOmAddressRange::m_anonymousCounter = ZERO;
CSLOmAddressRange::CSLOmAddressRange(TLineNumberType lineNumber, RefString fileName, EAddressRangeType type) : 
  CSLOmBase(TYPE_ADDRESS_RANGE, lineNumber,fileName),
  m_rangeType(type),
  m_isAnonymous(FALSE),
  m_accessRightsMask(ZERO)  {}

RefCSLOmAddressRange CSLOmAddressRange::cast(RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmAddressRange();
  }
  else {
    ASSERT(object->isAddressRange(), "type check on cast failure");
    return boost::static_pointer_cast<CSLOmAddressRange>(object);
  }
}

 RefCSLOmAddressRange CSLOmAddressRange::build(TLineNumberType   lineNumber, 
                                              RefString         fileName, 
                                              TInt              lower      , 
                                              TInt              upper      ) {

  CSLOmAddressRange* range;
  try {
    range = new CSLOmAddressRange(lineNumber,fileName, ADDR_VALID);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }
 
  RefCSLOmAddressRange refRange(range);
  range->m_weakRef = boost::weak_ptr<CSLOmBase>( refRange);

  RefCSLOmNumber offset = CSLOmNum32::build(lineNumber,fileName, ZERO);
  offset->setParent(refRange);

  RefCSLOmNumber sumLower = CSLOmNum32::build(lineNumber, fileName, lower);
  RefCSLOmNumber sumUpper = CSLOmNum32::build(lineNumber, fileName, upper);

  range->setRange(sumLower, sumUpper);

  return refRange;
}


RefCSLOmAddressRange CSLOmAddressRange::allocate(TLineNumberType   lineNumber,
                                                 RefString         fileName,
                                                 RefCSLOmBase      parent    ,
                                                 EAddressRangeType type      ,
                                                 const RefString&  name      ) {

  ASSERT(parent.get(), "received null parent"); 

  CSLOmAddressRange* range;
  try {
    range = new CSLOmAddressRange(lineNumber,fileName, type);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }
 
  RefCSLOmAddressRange refRange(range);
  range->m_weakRef = boost::weak_ptr<CSLOmBase>( refRange);

  range->setParent(parent);

  if (!name.get()) {
    RefString name1 = RefString(new std::string("*CSLAddressRange_"));
    name1->append(*(ltos(m_anonymousCounter)));
      
    m_anonymousCounter++;
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refRange, CSLOmIdentifier::ID_ADDRESS_RANGE, name1);
    range->m_isAnonymous = TRUE;
  }
  else {
    RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refRange, CSLOmIdentifier::ID_ADDRESS_RANGE, name);
    range->m_isAnonymous = FALSE;
  }

  RefCSLOmNumber offset = CSLOmNum32::build(lineNumber,fileName, ZERO);
  offset->setParent(refRange);

  return refRange;
}

void CSLOmAddressRange::addWidthAsRange(RefCSLOmExpr width) {
  ASSERT(width.get(), "null width number received ");

  RefCSLOmNumber zero = CSLOmNum32::build(m_lineNumber,m_fileName, ZERO);
  RefCSLOmExpr widthCopy = width->dupp();
  RefCSLOmNumber one  = CSLOmNum32::build(m_lineNumber,m_fileName, 1);

//   if (width->equals(ZERO)) {
//     addErr(NSWarningErr::CSE_CSC_NUM_NOT_ALLOWED_WIDTH0_NUM_CSCCS, args, width->getLineNumber());
//     cslomHasErrors = TRUE;
//     //throw NSBase::IllegalArgumentException("[CSLOmBitRange::addWidthAsRange()] cannot set width 0...");
//   }

  RefCSLOmExpr lower = zero;
  RefCSLOmExpr upper = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, widthCopy, one);

  lower->setParent(getThis());
  upper->setParent(getThis());
}

const TBool CSLOmAddressRange::hasWidthOrRange() const {
  TBool hasWOR = (getChildrenSize() == 4) || (!(getChild(0)->isID()) && (getChildrenSize() == 3));
  return hasWOR;
}

RefCSLOmAddressRange CSLOmAddressRange::build(TLineNumberType   lineNumber ,
                                              RefString         fileName,
                                              RefCSLOmBase      parent     , 
                                              RefCSLOmExpr      width      , 
                                              EAddressRangeType type       , 
                                              const RefString&  name       ) {
  ASSERT(parent.get(),"parent null");     
  ASSERT(width .get(),"width  null");       

  RefCSLOmAddressRange range = allocate(lineNumber,fileName, parent, type, name);
  RefCSLOmBase eval = width->doEval(TRUE);
  if (eval->isExpr() && CSLOmExpr::cast(eval)->isNumber()) {
    range->addWidthAsRange(CSLOmNumber::cast(eval));  
  }
  else { 
    DCERR("ERROR: please add warn/err support in range class in cslom"<<std::endl);
  }

  return range;
}

RefCSLOmAddressRange CSLOmAddressRange::build(TLineNumberType   lineNumber ,
                                              RefString         fileName,
                                              RefCSLOmBase      parent     , 
                                              RefCSLOmExpr      lower      , 
                                              RefCSLOmExpr      upper      , 
                                              EAddressRangeType type       , 
                                              const RefString&  name       ) {

  ASSERT(parent.get(),"parent null");     
  ASSERT(lower.get(),"width  null");       
  ASSERT(upper.get(),"type   null");     

  RefCSLOmAddressRange range = allocate(lineNumber,fileName, parent, type, name);

  RefCSLOmBase eval1 = lower->doEval(TRUE);
  if (!eval1->isExpr() || !CSLOmExpr::cast(eval1)->isNumber()) {
    DCERR("ERROR: please add warn/err support in range class in cslom"<<std::endl);
  }

  RefCSLOmBase eval2 = upper->doEval(TRUE);
  if (!eval2->isExpr() || !CSLOmExpr::cast(eval2)->isNumber()) {
    DCERR("ERROR: please add warn/err support in range class in cslom"<<std::endl);
  }

  RefCSLOmNumber sumLower = CSLOmNum32::build(eval1->getLineNumber(),eval1->getFileName(), ZERO);
  RefCSLOmNumber sumUpper = CSLOmNum32::build(eval2->getLineNumber(),eval2->getFileName(), ZERO);
  sumLower = sumLower->add(CSLOmNumber::cast(eval1));
  sumUpper = sumUpper->add(CSLOmNumber::cast(eval2));

  range->setRange(sumLower, sumUpper);
  
  return range;
}

void CSLOmAddressRange::setWidth(RefCSLOmExpr width) {
  ASSERT(width.get(),"null width received");
  if (!hasWidthOrRange()) {
    addWidthAsRange(width);
  }
  else {
    DCERR("ERROR: please add warn/err support in range class in cslom"<<std::endl);
  }
}

void CSLOmAddressRange::setRange(RefCSLOmExpr lower, RefCSLOmExpr upper) {
  ASSERT(lower.get(),"null width received");
  ASSERT(upper.get(),"null width received");
  ASSERT(!lower->getParent().get(),"null width received");
  ASSERT(!upper->getParent().get(),"null width received");

//   if (lower->relationalGreaterEqual(upper)->getValue() == 1) {
//     RefCSLOmNumber aux = lower;
//     lower = upper;
//     upper = aux;
//   }

  if (!hasWidthOrRange()) {
    lower->setParent(getThis());
    upper->setParent(getThis());
  }
  else {
    DCERR("ERROR: please add warn/err support in range class in cslom"<<std::endl);
  }
}

void CSLOmAddressRange::setOffset(RefCSLOmExpr offset) {
  ASSERT(offset.get(), "null offset received");
  
  RefCSLOmBase currentOffset = getChild(RANGE_OFFSET);

  ASSERT(currentOffset->isExpr(),"this should be an expr");
  ASSERT(CSLOmExpr::cast(currentOffset)->isNumber(),"this should be an expr");

  RefCSLOmNumber numOffset = CSLOmNumber::cast(currentOffset);
  numOffset->setValue( ( numOffset->add(CSLOmNumber::cast(offset->doEval())) )->getValue());
}

void CSLOmAddressRange::setType(EAddressRangeType type) {
  ASSERT(type > ADDR_UNDEFINED && type < ADDR_MAX ,"type outside of bounds");
  
  m_rangeType = type;
}

void CSLOmAddressRange::setAccessRights(RefCSLOmIdentifier group, EAccessRights access) {
  ASSERT(group.get(), "null group received");
  ASSERT(group->getIdType() == CSLOmIdentifier::ID_ENUM_ITEM,"group is not an enum item");
  ASSERT(group->getPayload().get(), "enum item does not have payload");
  ASSERT(group->getPayload()->isExpr(), "payload is not an expr");
  ASSERT(CSLOmExpr::cast(group->getPayload())->isNumber(), "payload is not a number");
  
  RefCSLOmNumber groupValue = CSLOmNumber::cast(group->getPayload());
  TUInt offset = groupValue->getValue();

  ASSERT(offset >= 0, "offset should not be negative");
  ASSERT(offset <= (sizeof(TULong)*4), "offset should not be bigger than length of the mask");

  m_accessRightsMask |= access<<(offset*2);
}

CSLOmAddressRange::EAccessRights CSLOmAddressRange::getAccessRights(RefCSLOmIdentifier group) const {
  ASSERT(group.get(), "null group received");
  ASSERT(group->getIdType() == CSLOmIdentifier::ID_ENUM_ITEM,"group is not an enum item");
  ASSERT(group->getPayload().get(), "enum item does not have payload");
  ASSERT(group->getPayload()->isExpr(), "payload is not an expr");
  ASSERT(CSLOmExpr::cast(group->getPayload())->isNumber(), "payload is not a number");
  
  RefCSLOmNumber groupValue = CSLOmNumber::cast(group->getPayload());
  TUInt offset = groupValue->getValue();

  ASSERT(offset >= 0, "offset should not be negative");
  ASSERT(offset <= (sizeof(TULong)*4), "offset should not be bigger than length of the mask");

  //cast the int value to the enum value
  //this should be tested after each call with an assert to not be an undefined value
  return (CSLOmAddressRange::EAccessRights)((m_accessRightsMask & ACC_RD_WR<<(offset*2))>>(offset*2));
}

RefCSLOmExpr CSLOmAddressRange::getLower() const {
  ASSERT(hasWidthOrRange(),"range should have lower set");

  if (getChild(ID)->isID()) {
    return CSLOmNumber::cast(getChild(RANGE_LOWER));
  }
  else {
    return CSLOmNumber::cast(getChild(RANGE_LOWER_WO_ID));
  }
}

RefCSLOmExpr CSLOmAddressRange::getUpper() const {
  ASSERT(hasWidthOrRange(),"range should have lower set");

  if (getChild(ID)->isID()) {
    return CSLOmNumber::cast(getChild(RANGE_UPPER));
  }
  else {
    return CSLOmNumber::cast(getChild(RANGE_UPPER_WO_ID));    
  }
}

RefCSLOmExpr CSLOmAddressRange::getWidth() const {
  ASSERT(hasWidthOrRange(),"range should have lower set");

  RefCSLOmExpr lower;
  RefCSLOmExpr upper;

  if (m_children->size() == 4) {
    lower = CSLOmExpr::cast(getChild(RANGE_LOWER));
    upper = CSLOmExpr::cast(getChild(RANGE_UPPER));
  }
  else if (m_children->size() == 3) {
    lower = CSLOmExpr::cast(getChild(RANGE_LOWER_WO_ID));
    upper = CSLOmExpr::cast(getChild(RANGE_UPPER_WO_ID));
  }
  else {
    ASSERT(FAIL, "no range set");
  }
  
  RefCSLOmExpr width = CSLOmExprOp::build(m_lineNumber,m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, upper, lower);
  width = CSLOmExprOp::build(m_lineNumber,m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS, width, CSLOmNum32::build(m_lineNumber, m_fileName, ONE));

  return width;
}

RefCSLOmExpr CSLOmAddressRange::getOffset() const {
  ASSERT(hasWidthOrRange(),"range should have lower set");

  return CSLOmNumber::cast(getChild(RANGE_OFFSET));
}

TBool CSLOmAddressRange::includes(RefCSLOmAddressRange range) const {
  ASSERT(range.get(), "NULL range received");
  ASSERT(range->hasWidthOrRange(), "range does not have low and up set");
  
  RefCSLOmNumber low1 = CSLOmNumber::cast(getLower()->doEval());
  RefCSLOmNumber low2 = CSLOmNumber::cast(range->getLower()->doEval());  
  RefCSLOmNumber up1 = CSLOmNumber::cast(getUpper()->doEval());  
  RefCSLOmNumber up2 =CSLOmNumber::cast(range->getUpper()->doEval());
  TUInt l1 = low1->getValue();
  TUInt l2 = low2->getValue();
  TUInt u1 = up1->getValue();
  TUInt u2 = up2->getValue();

  if ( l1 <= l2 && u1 >= u2 ) {
    return TRUE;
  }
  else {
    return FALSE;
  }
}


TBool CSLOmAddressRange::overlaps(RefCSLOmAddressRange range) const {
  ASSERT(range.get(), "NULL range received");
  ASSERT(range->hasWidthOrRange(), "range does not have low and up set");
  RefCSLOmExpr low1 = getLower();
  RefCSLOmExpr low2 = range->getLower();  
  RefCSLOmExpr up1 = getUpper();  
  RefCSLOmExpr up2 = range->getUpper();
  TUInt l1 = CSLOmNumber::cast(low1->doEval())->getValue();
  TUInt l2 = CSLOmNumber::cast(low2->doEval())->getValue();
  TUInt u1 = CSLOmNumber::cast(up1 ->doEval())->getValue();
  TUInt u2 = CSLOmNumber::cast(up2 ->doEval())->getValue();

  if ( (l1 <= l2 && u1 >= l2) || (l1 <= u2 && u1 >= u2) ) {
    return TRUE;
  }
  else {
    return FALSE;
  }
}

TBool CSLOmAddressRange::equals(RefCSLOmAddressRange range) const {
  ASSERT(range.get(), "NULL range received");
  ASSERT(range->hasWidthOrRange(), "range does not have low and up set");
  
  RefCSLOmExpr low1 = getLower();
  RefCSLOmExpr low2 = range->getLower();  
  RefCSLOmExpr up1 = getUpper();  
  RefCSLOmExpr up2 = range->getUpper();
  TUInt l1 = CSLOmNumber::cast(low1->doEval())->getValue();
  TUInt l2 = CSLOmNumber::cast(low2->doEval())->getValue();
  TUInt u1 = CSLOmNumber::cast(up1 ->doEval())->getValue();
  TUInt u2 = CSLOmNumber::cast(up2 ->doEval())->getValue();

  if ( l1 == l2 && u1 == u2 ) {
    return TRUE;
  }
  else {
    return FALSE;
  }
}

TPair_RefCSLOmAddressRange_RefCSLOmAddressRange CSLOmAddressRange::remove(RefCSLOmAddressRange range) {
  if (!overlaps(range)) {
    return std::make_pair(RefCSLOmAddressRange(), RefCSLOmAddressRange());
  }
  else {
    RefCSLOmNumber low1 = CSLOmNumber::cast(getLower()->doEval());
    RefCSLOmNumber low2 = CSLOmNumber::cast(range->getLower()->doEval());  
    RefCSLOmNumber up1 =  CSLOmNumber::cast(getUpper()->doEval());  
    RefCSLOmNumber up2 =  CSLOmNumber::cast(range->getUpper()->doEval());

    RefCSLOmNumber one = CSLOmNum32::build(m_lineNumber,m_fileName, ONE);

    RefCSLOmAddressRange addr1 = RefCSLOmAddressRange();;
    RefCSLOmAddressRange addr2 = RefCSLOmAddressRange();;
    if ( (low1->relationalLess(low2)->getValue()   == 1 &&
          up1->relationalGreater(low2)->getValue() == 1) ) {
        
      addr1 = CSLOmAddressRange::build(getLineNumber(), getFileName(), getParent(), low1, low2->substract(one), m_rangeType);
    }

    if ( (low1->relationalLess(up2)->getValue()    == 1 &&
          up1->relationalGreater(up2)->getValue()  == 1) ) {

      addr2 = CSLOmAddressRange::build(getLineNumber(),getFileName(), getParent(), up2->add(one), up1, m_rangeType);
    }
    
    return std::make_pair(addr1, addr2);
  }
}


void CSLOmAddressRange::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}



}
