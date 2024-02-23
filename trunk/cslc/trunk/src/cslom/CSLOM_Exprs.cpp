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
#include <sstream>
#include "../support/CommonSupport.h"

/**
 * Bit that tells the cslc if errors appeared in the CSLOM
 */
extern TBool cslomHasErrors;
extern TBool m_arHasErrors;
extern TBool checkerHasErrors;


namespace NSCSLOm {

// ********************************************************************************
// CSLOmExpr class
// ********************************************************************************
CSLOmExpr::CSLOmExpr(TLineNumberType lineNumber, RefString fileName, EExprType exprType) : 
  CSLOmBase(TYPE_EXPR, lineNumber, fileName), 
  m_exprType(exprType),
  m_width(-1),
  m_isEvaluated(FALSE) { }

RefCSLOmExpr CSLOmExpr::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmExpr();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmExpr>(object);
  }
}

RefCSLOmNumber CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance inst, RefTMap_RefCSLOmUnitInstance_RefCSLOmBase values) {
  RefCSLOmNumber val;
  if (values->find(inst) != values->end()) {
    val = CSLOmNumber::cast(values->find(inst)->second);
  }
  else {
    val = CSLOmNumber::cast(values->find(RefCSLOmUnitInstance())->second);
  }
  return val;
}

CSLOmExpr::EExprType CSLOmExpr::getExprType() const { return m_exprType; }

TBool CSLOmExpr::canBeLvalue() const {
  TBool temp = isExprLink();
  return temp;
}


const RefTVec_RefCSLOmExpr CSLOmExpr::getExprs() const {
  return getChildren<CSLOmExpr>(TYPE_EXPR);
}

TBool CSLOmExpr::isPrimary() const {
  return
    isNumber() ||
    isRealNumber() ||
    isExprLink() ||
    isConcat() ||
    isMultiConcat() ||
    isFunctionCall() ||
    isMintypmax();
}

// ********************************************************************************
// CSLOmString class
// ********************************************************************************
CSLOmString::CSLOmString(TLineNumberType lineNumber, RefString fileName) :
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_STRING) {}

RefCSLOmString CSLOmString::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmString();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    RefCSLOmExpr obj = CSLOmExpr::cast(object);
    ASSERT(obj->isString() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmString>(object);
  }
}

RefCSLOmString CSLOmString::build(TLineNumberType lineNumber, RefString fileName, RefString value) {
  ASSERT(value.get(), "null value received");
  
  CSLOmString* str;
  try {
    str = new CSLOmString(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmString refStr = RefCSLOmString(str);
  str->m_weakRef = boost::weak_ptr<CSLOmBase>(refStr);
  str->m_value = value;

  return refStr;
}

void CSLOmString::append(RefString appendValue) {
  m_value->append(*appendValue);
}

TUInt CSLOmString::length() {
  return m_value->length();
}

RefString CSLOmString::getValue() {
  return m_value;
}

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmString::doParamEval(RefCSLOmBase evalFor) {
  return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
}

RefCSLOmExpr CSLOmString::dupp() {
  return build(m_lineNumber, m_fileName, m_value);
}

void CSLOmString::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
}

// ********************************************************************************
// CSLOmExprLink class
// ********************************************************************************
RefTVec_RefCSLOmExprLink CSLOmExprLink::exprLinks = RefTVec_RefCSLOmExprLink();

CSLOmExprLink::CSLOmExprLink(TLineNumberType lineNumber, RefString fileName) 
  : CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_HID), 
    m_state(HID_ITEM), 
    m_partSelectDir(PS_DIR_UNDEFINED),
    m_names(RefTVec_RefString(new TVec_RefString())), 
    m_ids() { }

RefCSLOmExpr CSLOmExprLink::dupp() {
  RefCSLOmExprLink temp = CSLOmExprLink::build(m_lineNumber,m_fileName, m_names->back());
  TVec_RefString::reverse_iterator it = m_names->rbegin();
  it++;
  for (; it < m_names->rend(); ++it) {
    temp->addScopeItem(*it);
  }
  if (hasBitRange()) {
    temp->setBitRange(getBitRange());
  }
  return temp;
}

RefCSLOmExprLink CSLOmExprLink::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmExprLink();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    RefCSLOmExpr obj = CSLOmExpr::cast(object);
    ASSERT(obj->isExprLink() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmExprLink>(object);
  }
}

RefCSLOmExprLink CSLOmExprLink::build(TLineNumberType lineNumber, RefString fileName, const RefString& name) {
  CSLOmExprLink* exprLink;
  try {
    exprLink = new CSLOmExprLink(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmExprLink refExprLink(exprLink);
  exprLink->m_weakRef = boost::weak_ptr<CSLOmBase>( refExprLink);
  exprLink->addHidItem(name);
  if(!exprLinks.get()) {
    exprLinks = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink());
  }
  exprLinks->push_back(refExprLink); // add to global expr links in order to be resolved at linking phase
  return refExprLink;
}

void CSLOmExprLink::addHidItem(const RefString& name) {
  ASSERT(m_state == HID_ITEM, "Expr is not a hid");
  checkIdName(name, this->getLineNumber(), getFileName());
  ASSERT(name->length(), "invalid name");

  m_names->push_back(name);
}

void CSLOmExprLink::addScopeItem(const RefString& name) {
  ASSERT(m_state == HID_ITEM, "Expr is not a hid");
  checkIdName(name, this->getLineNumber(), getFileName());
  ASSERT(name->length(), "invalid name");

  m_names->insert(m_names->begin(),name);
}

RefCSLOmExprLink CSLOmExprLink::getFullPathLink() {
  TBool foundName = FALSE;

  RefTVec_RefString namePath = CSLOmScopeBlock::getNamePath();
  RefTVec_RefCSLOmScope scopePath = CSLOmScopeBlock::getScopePath();
  
  RefCSLOmExprLink fullPathExpr = CSLOmExprLink::build(getLineNumber(), getFileName(), getName());
  fullPathExpr->setValue(m_value.lock());
  
  TVec_RefString::const_iterator it;
  TVec_RefString::reverse_iterator rit;
  // copy the current Expr link to the full path EL
  for(rit = m_names->rbegin()+1; rit < m_names->rend(); ++rit) {
    fullPathExpr->addScopeItem(*rit);
  }
  // search for the nearest scope in the scopeBlock hierarchy that contains the evaluation object
  TVec_RefString::reverse_iterator revNameIter;
  TVec_RefCSLOmScope::reverse_iterator revScopeIter;
  for (revScopeIter = scopePath->rbegin(), revNameIter = namePath->rbegin();
       revScopeIter < scopePath->rend()  , revNameIter < namePath->rend();
       ++revScopeIter, ++revNameIter) {
    if (!(*revNameIter)->compare(*(getHidName(ZERO)))) {
      foundName = TRUE;
      ++revNameIter;
      break;
    }
    else if ((*revScopeIter)->lookupLocal(getHidName(ZERO)).get()) {
      foundName = TRUE;
      break;
    }

  }
  if (foundName) {
    while (revNameIter < namePath->rend()-1) {
      fullPathExpr->addScopeItem(*revNameIter);
      ++revNameIter;
    }
  }
  else {
    ASSERT(FAIL, "object cannot be found, this should already be tested");
  }
  if (hasBitRange()) {
    fullPathExpr->setBitRange(getBitRange());
  }

  return fullPathExpr;
}

TInt CSLOmExprLink::getWidth(){
  ASSERT(isResolved(),"do eval before getting the width");
  
  RefCSLOmBase object=getThis()->doEval();

  if(object.get()){
    if(m_width==-1){
      m_width=0;

      // if(object->isNumber()){
      //   m_width=CSLOmNumber::cast(object)->getWidth();
      // }
      // else {
      //     if(hasBitRange()){// DEP FIX - m_width should be moved out of the if else branches
      //       RefTMap_RefCSLOmUnitInstance_RefCSLOmBase params=getBitRange()->getWidth()->doParamEval(object);
      //     }
      //   }
      //   m_width=CSLOmNumber::cast(params->find(RefCSLOmUnitInstance())->second)->getValue();
      // }

      if(hasBitRange()){// DEP FIX - m_width should be moved out of the if else branches
        RefTMap_RefCSLOmUnitInstance_RefCSLOmBase params=getBitRange()->getWidth()->doParamEval(object);
        m_width=CSLOmNumber::cast(params->find(RefCSLOmUnitInstance())->second)->getValue();
        //m_width=CSLOmNumber::cast(getBitRange()->getWidth()->doEval())->getValue();
      }else if(object->isPort()){
        RefTMap_RefCSLOmUnitInstance_RefCSLOmBase params=CSLOmPortDecl::cast(object)->getWidth()->doParamEval(object);
        m_width=CSLOmNumber::cast(params->find(RefCSLOmUnitInstance())->second)->getValue();
        //m_width=CSLOmNumber::cast(CSLOmPortDecl::cast(object)->getWidth()->doEval())->getValue();
      }
      else if(object->isSignal()){
        RefTMap_RefCSLOmUnitInstance_RefCSLOmBase params=CSLOmSignal::cast(object)->getWidth()->doParamEval(object);
        m_width=CSLOmNumber::cast(params->find(RefCSLOmUnitInstance())->second)->getValue();
          //m_width=CSLOmNumber::cast(CSLOmSignal::cast(object)->getWidth()->doParamEval())->getValue();
      }
      else if(object->isInterface()){
        RefTMap_RefCSLOmUnitInstance_RefCSLOmBase params=CSLOmInterface::cast(object)->getWidth()->doParamEval(object);
        m_width=CSLOmNumber::cast(params->find(RefCSLOmUnitInstance())->second)->getValue();
        //m_width=CSLOmNumber::cast(CSLOmInterface::cast(object)->getWidth()->doEval())->getValue();
      }
      else if(object->isSignalGroup()){
        RefTMap_RefCSLOmUnitInstance_RefCSLOmBase params=CSLOmGroupSignal::cast(object)->getWidth()->doParamEval(object);
        m_width=CSLOmNumber::cast(params->find(RefCSLOmUnitInstance())->second)->getValue();
        //m_width=CSLOmNumber::cast(CSLOmGroupSignal::cast(object)->getWidth()->doEval())->getValue();
      }
      else if(object->isNumber()){
        m_width=CSLOmNumber::cast(object)->getWidth();
      }
    }
    return m_width;
  }
  return -1;
}

TBool CSLOmExprLink::isHID() const {
  ASSERT(m_names.get(), "invalid ExprLink, missing names");

  return m_names->size() > 1;
}

const RefString CSLOmExprLink::getName() const {
  ASSERT(m_names.get(),"[CSLOmExprLink::getName() const] illegal state for this method call");
  //  if(!m_names.get()) {
  //    //args.push_back("");
  //    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
  //    //cslomHasErrors = TRUE;
  //    throw NSBase::IllegalStateException("[CSLOmExprLink::getName() const] illegal state for this method call", m_lineNumber);
  //  } NOT USER ERROR
  return m_names->back();
}

TBool CSLOmExprLink::isConst() const {
  RefCSLOmBase value = getThis()->doEval(TRUE);
  return value.get() && value->isNumber();
}

TBool CSLOmExprLink::isResolved() const {
  return ZERO != m_ids.get();
}

void CSLOmExprLink::setBitRange(RefCSLOmSimpleBitRange bitRange) {
  ASSERT(bitRange.get(), "null bitRange received");
  doEval();
  if (m_value.lock().get() && (m_value.lock()->isPort() || m_value.lock()->isSignal())) {
    RefCSLOmSimpleBitRange br = CSLOmSimpleBitRange::build(bitRange->getLineNumber(), bitRange->getFileName(), getThis(), bitRange, TRUE);
  }
  else if (m_value.lock().get()){
    addErr(NSWarningErr::CSE_CSC_EXPR_PART_SELECT_TYPE, args, m_lineNumber, m_fileName);
    cslomHasErrors = TRUE;
  }
  else {
    RefCSLOmSimpleBitRange br = CSLOmSimpleBitRange::build(bitRange->getLineNumber(), bitRange->getFileName(), getThis(), bitRange, TRUE);
  }
}

void CSLOmExprLink::updateBr() {
  if (m_partSelectDir == PS_DIR_ASC) {
    RefCSLOmSimpleBitRange br = getBitRange();
    RefCSLOmExpr up = br->getUpper();
    RefCSLOmExpr low = br->getLower();
    RefCSLOmExpr newLow = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS, up, low);
    RefCSLOmExpr newVal = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, newLow, CSLOmNum32::build(m_lineNumber, m_fileName, 1));
    br->setRange(up, newVal);
  }
  else if (m_partSelectDir == PS_DIR_DESC) {
    RefCSLOmSimpleBitRange br = getBitRange();
    RefCSLOmExpr up = br->getUpper()->dupp();
    RefCSLOmExpr low = br->getLower()->dupp();
//     RefCSLOmBase evalFor = doEval();
//     if (!evalFor.get()) {
//       args.push_back(*(m_names->back()));
//       args.push_back(*(CSLOmScopeBlock::getCurrentScope()->getID()->getName()));
//       addErr(NSWarningErr::DEE_CSC_SCOP_DEE_CSC_SCOP_CANNOT_FIND_OBJECT, args, getLineNumber(), getFileName());
//       cslomHasErrors = TRUE;
//     }
//     RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval1 = up->doParamEval(evalFor);
//     RefTMap_RefCSLOmUnitInstance_RefCSLOmBase eval2 = low->doParamEval(evalFor);

    RefCSLOmExpr newLow = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS, up, low);
    RefCSLOmExpr newVal = CSLOmExprOp::build(m_lineNumber, m_fileName, CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS, newLow, CSLOmNum32::build(m_lineNumber, m_fileName, 1));
    br->setRange(newVal, up);
  }
}

const RefCSLOmSimpleBitRange CSLOmExprLink::getBitRange() const {
  return CSLOmSimpleBitRange::cast(getChild(EXPR_LINK_BR));
}

const RefCSLOmBase CSLOmExprLink::getBitRangeAsBase() const {
  return getChild(EXPR_LINK_BR);
}

void CSLOmExprLink::setValue(RefCSLOmBase object) const {
  m_value = object;
}

const RefCSLOmBase CSLOmExprLink::getValue() const {
  return m_value.lock();
}

void CSLOmExprLink::setEvalType(ECSLOmType object) const {
  m_evalType = object;
}

const ECSLOmType CSLOmExprLink::getEvalType() const {
  return m_evalType;
}

RefTVec_RefCSLOmExprLink CSLOmExprLink::isPatternIn(RefCSLOmExprLink expr, RefCSLOmScope scope) {
  RefCSLOmIdentifier id = scope->lookupDownward(expr->m_names);
  RefTVec_RefCSLOmExprLink temp = RefTVec_RefCSLOmExprLink();
  if (id.get()) {
    RefCSLOmExprLink newExpr = CSLOmExprLink::cast(expr->dupp());
    newExpr->setValue(id->getParent());
    newExpr->addID(id);
    temp = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
    temp->push_back(newExpr);
  }
  else {
    RefTVec_RefCSLOmBase children = scope->getID()->getParent()->getChildrenAsBase();
    for (TVec_RefCSLOmBase::iterator it = children->begin(); it < children->end(); it++) {
      if ((*it)->isScopeHolder()) {
        RefCSLOmScope scope = CSLOmBase::getAttachedScope((*it).get());
        RefTVec_RefCSLOmExprLink aux = isPatternIn(expr, scope);
        if (aux.get()) {
          if (!temp.get()) {
            temp = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink);
          }
          for (TVec_RefCSLOmExprLink::iterator it = aux->begin(); it < aux->end(); it++) {
            if (!(scope->getID()->getParent()->isInterface() && CSLOmInterface::cast(scope->getID()->getParent())->isDefaultIfc())) {
              (*it)->addScopeItem(scope->getID()->getName());
            }
            temp->push_back(*it);
          }
        }
      }
    }
  }
  return temp;
}

TBool CSLOmExprLink::isInUnitScope(RefCSLOmUnitDecl unit) {
  ASSERT(unit.get(), "this should not be null");
  
  RefCSLOmScope cScope = unit->getAttachedScope();
  RefTVec_RefString names = getHidNames();
  TVec_RefString::iterator it = names->begin();
  RefCSLOmIdentifier id;
  for (; it < names->end(); ++it) {
    id = cScope->lookupLocal(*it);
    if (!id.get()) {
      return FALSE;
    }
    if (id->isToScopeID()) {
      cScope = id->toScope();
    }
    else if (it+1 < names->end()) {
      return FALSE;
    }
  }
  if (id.get()) {
    if (!isResolved()) {
      addID(id);
      if (id->isEnumItem()) {
        setValue(id);
      }
      else {
        setValue(id->getParent());
      }
      m_evalType = m_value.lock()->getType();
    }
    return TRUE;
  }
  else {
    return FALSE;
  }
}

RefCSLOmIdentifier CSLOmExprLink::toID() const {
  ASSERT(isResolved(),"[CSLOmExprLink::toID() const] illegal state for this method call");
  //  if(!isResolved()) {
  //    //args.push_back("");
  //    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
  //    //cslomHasErrors = TRUE;
  //    throw NSBase::IllegalStateException("[CSLOmExprLink::toID() const] illegal state for this method call", m_lineNumber);
  //  } NOT USER ERROR
  return m_ids->back();
}

const RefTVec_RefString CSLOmExprLink::getHidNames() const {
  ASSERT(m_names.get(), "[CSLOmExprLink::getHidNames() const] illegal ExprLink");
  //  if(!m_names.get()) {
  //    //args.push_back("");
  //    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
  //    //cslomHasErrors = TRUE;
  //    throw NSBase::IllegalStateException("[CSLOmExprLink::getHidNames() const] illegal ExprLink", m_lineNumber);
  //  } NOT USER ERROR
  return m_names;
}

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmExprLink::doParamEval(RefCSLOmBase evalFor) {
  ASSERT(evalFor.get(),"invalid argument for param eval");
  RefCSLOmBase normalEval = doEval();
  if (!normalEval.get() || normalEval->isParameter()) {
    if (m_names->size() > 1) {
      return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
    }
    else {
      RefCSLOmScope parentScope = evalFor->getParentScope();
      if (parentScope->getHolderObject()->isInterface() && CSLOmInterface::cast(parentScope->getHolderObject())->isDefaultIfc()) {
        parentScope = parentScope->getHolderObject()->getParentScope();
      }
      RefCSLOmIdentifier id = parentScope->lookupLocal(m_names->back());
      if (!id.get()) {
        args.push_back(*CSLOmIdentifier::cast(evalFor->getChild(ID))->getName());
        addErr(NSWarningErr::CSE_CSB_EXPR_PARAMETER_USED_OTHER_SCOPE, args, m_lineNumber, m_fileName);
        m_arHasErrors = TRUE;
        checkerHasErrors = TRUE;
        return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
      }
      RefCSLOmBase paramBase = id->getParent();
      if (!paramBase->isParameter()) {
        return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
      }
      RefTMap_RefCSLOmUnitInstance_RefCSLOmBase temp = RefTMap_RefCSLOmUnitInstance_RefCSLOmBase(new TMap_RefCSLOmUnitInstance_RefCSLOmBase);
      RefCSLOmParameter param = CSLOmParameter::cast(paramBase);
      RefTVec_WeakCSLOmUnitInstance instances = param->getUnitInstances();
      if (instances.get()) {
        for (TVec_WeakCSLOmUnitInstance::iterator iter = instances->begin(); iter < instances->end(); iter++) {
          RefTVec_RefCSLOmBase params = (*iter).lock()->getParameters();
          for (TVec_RefCSLOmBase::iterator it = params->begin(); it < params->end(); it++) {
            if (CSLOmExprLink::cast(CSLOmParameter::cast(*it)->getIDAsBase())->getValue().get() == param.get()) {
              RefTMap_RefCSLOmUnitInstance_RefCSLOmBase aux = CSLOmParameter::cast(*it)->getValueAsExpr()->doParamEval(evalFor);
              RefCSLOmNumber val = getValueForInstance((*iter).lock(), aux);
              temp->insert(std::make_pair((*iter).lock(), val));
              break;
            }
          }
        }
      }
      RefTMap_RefCSLOmUnitInstance_RefCSLOmBase aux = CSLOmParameter::cast(param)->getValueAsExpr()->doParamEval(evalFor);
      RefCSLOmNumber val = getValueForInstance(RefCSLOmUnitInstance(), aux);
      temp->insert(std::make_pair(RefCSLOmUnitInstance(), val));
      return temp;
    }
  }
  else if(doEval(TRUE)->isNumber()) {        
    RefTMap_RefCSLOmUnitInstance_RefCSLOmBase temp = RefTMap_RefCSLOmUnitInstance_RefCSLOmBase(new TMap_RefCSLOmUnitInstance_RefCSLOmBase);
    temp->insert(std::make_pair(RefCSLOmUnitInstance(), doEval(TRUE)));
    return temp;
  }
  else {
    return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
  }
}

RefCSLOmBase CSLOmExprLink::doEval(TBool convertEnumItem) {
  if (m_value.lock().get()) {
    if (convertEnumItem && m_value.lock()->isEnumItem()) {
      RefCSLOmBase payload=CSLOmIdentifier::cast(m_value.lock())->getPayload();
      m_width=CSLOmNumber::cast(payload)->getValue();
      return payload;
    }
    else {
      return m_value.lock();
    }
  }
  RefCSLOmIdentifier localNameId = getLocalNameID();
  if(localNameId.get()) {
    if (localNameId->isEnumItem()) {
      m_value = boost::weak_ptr<CSLOmBase>(localNameId);
    }
    else {
      m_value = boost::weak_ptr<CSLOmBase>(localNameId->getParent());
    }
    m_evalType = m_value.lock()->getType();

    if (convertEnumItem && m_value.lock()->isEnumItem()) {
      RefCSLOmBase payload=CSLOmIdentifier::cast(m_value.lock())->getPayload();
      m_width=CSLOmNumber::cast(payload)->getValue();
      return payload;
    }
    else {
      RefCSLOmBase evaledObj=m_value.lock();
      return evaledObj;
    }

  } 
  else {
    m_ids = RefTVec_RefCSLOmIdentifier();
    return RefCSLOmBase();
  }
}

RefCSLOmIdentifier CSLOmExprLink::getLocalNameID() const {
  RefCSLOmScope parentScope;
  RefCSLOmScope parentScopeAux;

  if (isResolved()) { // if Expr is already resolved we return the cached value for the expr
    return toID();
  }
  else {
    if (!m_ids.get()) {
      m_ids = RefTVec_RefCSLOmIdentifier(new TVec_RefCSLOmIdentifier);
    } // m_ids hold the identifiers of all names that appear in the ExprLink(used for caching the evaluation value)
    parentScope = CSLOmScopeBlock::getCurrentScope();
    parentScopeAux = CSLOmScopeBlock::getCurrentScope();
    if (!m_names.get()) {
      if (parentScope->isDesignScope()) {
        return RefCSLOmIdentifier();
      } // if ExprLink does not have any names and the current scope is the scope of the design the method returns null object
      else {
        return parentScope->getID();
      } // if the EL does not have any names and the current scope is not the design(has ID) it returns the ID of the scopeholdre object
    }
    else {
      // branch: EL has one or more names
      RefCSLOmIdentifier id;
      TVec_RefString::const_iterator iter;
      if (!parentScope.get()) {
        return id;
      } // if parentScope does not exist we return null object(the calling function must test that the return value is null or not)
      // THIS MIGHT BE A BUG : TEST
      else if ((!parentScope->isDesignScope()) && (m_names->size() == 1) && (parentScope->getID()->getName() == getHidName(ZERO))){
        m_ids->push_back(parentScope->getID());
        return parentScope->getID();
      } // if parentScope does exist and is not design scope, has only 1 name and the name is that of the scope then we return the scope holder object
      else if (parentScope->isDesignScope() && getHidNames()->size() == 1 ) {
        RefCSLOmIdentifier id = parentScope->lookupLocal(getHidName(ZERO));
        if (id.get()) {
          m_ids->push_back(id);
        }
        return id;
        // if the EL has one name and the parentScope is the design scope we look the ID in the scope and we return the id(if id does not exist we return null)
      }
      else {

        while (!parentScope->isDesignScope() && 
               parentScope->getID()->getName() != getHidNames()->front() &&
               !parentScope->lookupLocal(getHidNames()->front()).get()) {
          parentScope = parentScope->getID()->getParent()->getParentScope();
          ASSERT(parentScope.get(), "null scope found");
        }
        // we search up the scope tree for an identifier with the same name with the first name of the HID
        // we search for the ids with the names from the EL from the found scope down the scope tree
        if(m_names->size() == 1) {
          id = parentScopeAux->lookupLocal(m_names->at(ZERO));
          if(!id.get()) {
            id = parentScope->lookupLocal(m_names->at(ZERO));
          }
          if(id.get()) {
            m_ids->push_back(id);
          }

          if (!id.get()) {

            return id;
          }
        }
        else {
          if (!parentScope->isDesignScope()) {
            if (parentScope->getID()->getName() == getHidNames()->front()) {
              m_ids->push_back(parentScope->getID());
            }    
          }
          for (iter = (parentScope->isDesignScope() || (parentScope->getID()->getName() != getHidNames()->front())?(getHidNames()->begin()):(getHidNames()->begin()+1) ); 
               iter < getHidNames()->end(); ++iter) {
            id = parentScope->lookupLocal(*iter);
            if(id.get()) {
              m_ids->push_back(id);
            }

            if (!id.get()) {

              return id;
            }
            ASSERT(id.get(), "null id found");

            if (iter+1 < getHidNames()->end()) {
              if (id->isToScopeID()) {
                parentScope=id->toScope();
              }
              else {
                return RefCSLOmIdentifier();
              }
            }
          }   
        }
        return id;
      }
    }
  }
}


void CSLOmExprLink::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

const TBool CSLOmExprLink::isEvaluated() const {
  return m_isEvaluated;
}



// ********************************************************************************
// CSLOmExprOp class
// ********************************************************************************
CSLOmExprOp::CSLOmExprOp(TLineNumberType lineNumber, RefString fileName, EOpType opType, TBool isConst) : 
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_OP), 
  m_opType(opType), 
  m_isConst(isConst) {}

RefTVec_RefCSLOmExpr CSLOmExprOp::getExprs(){
  RefTVec_RefCSLOmExpr temp = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  
  RefTVec_RefCSLOmBase children  = getExprsAsBase();

  for (TVec_RefCSLOmBase::iterator it = children->begin(); it < children->end(); it++) {
    RefTVec_RefCSLOmExpr aux = CSLOmExpr::cast(*it)->getExprs();
    for (TVec_RefCSLOmExpr::iterator iter = aux->begin(); iter < aux->end(); iter++) {
      temp->push_back(*iter);
    }
  }
  return temp;
}

RefCSLOmExprOp CSLOmExprOp::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmExprOp();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmExprOp>(object);
  }
}

RefCSLOmExprOp CSLOmExprOp::build(TLineNumberType lineNumber, RefString fileName, EOpType opType, RefCSLOmExpr expr1, RefCSLOmExpr expr2, RefCSLOmExpr expr3) {
  ASSERT(expr1.get(), "invalid build parameters");
  TBool isConst = expr1->isConst();
  switch(opType & OP_MASK) {
    case OP_UNARY_MASK:
      // ASSERT(expr1->isPrimary(), "expr1 should be primary for unary operators"); // for unary operators, according to grammar rules, expr must be a primary
      ASSERT(!(expr2.get()), "expr2 should be null for unary operators");
      ASSERT(!(expr3.get()), "expr3 should be null for unary operators");
      break;
    case OP_BINARY_MASK:
      ASSERT(expr2.get(), "expr2 should not be null for binary operators");
      ASSERT(!(expr3.get()), "expr3 should be null for binary operators");
      isConst = isConst && expr2->isConst();
      break;
    case OP_TERNARY_MASK:
      ASSERT(expr2.get(), "expr2 should not be null for ternary operators");
      ASSERT(expr3.get(), "expr3 should not be null for ternary operators");
      isConst = isConst && expr2->isConst() && expr3->isConst();
      break;
    default:
      throw NSBase::IllegalStateException("[CSLOmExprOp::build()] invalid arguments...", lineNumber);
  }

  CSLOmExprOp* exprOp;
  try {
    exprOp = new CSLOmExprOp(lineNumber,fileName, opType, isConst);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmExprOp refExprOp(exprOp);
  exprOp->m_weakRef = boost::weak_ptr<CSLOmBase>( refExprOp);
  expr1->dupp()->setParent(refExprOp); // self registration
  switch(opType & OP_MASK) {
    case OP_UNARY_MASK:
      break;
    case OP_BINARY_MASK:
      expr2->setParent(refExprOp); // self registration
      break;
    case OP_TERNARY_MASK:
      expr2->setParent(refExprOp); // self registration
      expr3->setParent(refExprOp); // self registration
      break;
    default:
      throw NSBase::IllegalStateException("[CSLOmExprOp::build()] bug detected...", lineNumber);
  }
  return refExprOp;
}

TInt CSLOmExprOp::getWidth(){
  //  ASSERT(m_isEvaluated,"evaluate before getting width");
  RefTVec_RefCSLOmBase exprs=getExprsAsBase();
  ASSERT(exprs.get(),"expressions inside exprOp must not be null");
  
  if(isUnary()){
    RefCSLOmExpr expr=CSLOmExpr::cast(exprs->at(0));
    m_width=expr->getWidth();
  }
  else if(isBinary()){
    RefCSLOmExpr expr1=CSLOmExpr::cast(exprs->at(0));
    RefCSLOmExpr expr2=CSLOmExpr::cast(exprs->at(1));
    if(expr1->getWidth()>=expr2->getWidth()){
      m_width=expr1->getWidth();
    }
    else{
      m_width=expr2->getWidth();
    }
  }
  else if(isTernary()){
    RefCSLOmExpr expr1=CSLOmExpr::cast(exprs->at(0));
    RefCSLOmExpr expr2=CSLOmExpr::cast(exprs->at(1));
    RefCSLOmExpr expr3=CSLOmExpr::cast(exprs->at(2));

    if(expr2->getWidth()>=expr3->getWidth()){
      m_width=expr2->getWidth();
    }
    else{
      m_width=expr3->getWidth();
    }
  }
  
  return m_width;
}

TBool CSLOmExprOp::isConst() const {
  if (isUnary()) {
    return getExpr1()->isConst(); 
  }
  else if (isBinary()) {
    return getExpr1()->isConst() && getExpr2()->isConst(); 
  }
  else if (isTernary()) {
    return getExpr1()->isConst() && getExpr2()->isConst() && getExpr3()->isConst(); 
  }
}

CSLOmExprOp::EOpType CSLOmExprOp::getOpType() const {
  return m_opType;
}
//tcodo
// TODO add const ints EXPR1 = 0 and API functions for 
const RefCSLOmExpr CSLOmExprOp::getExpr1() const {
  RefCSLOmBase exprOpAsBase = getChild(EXPR0);
  RefCSLOmExprOp exprOp = cast(exprOpAsBase);
  return exprOp;//boost::static_pointer_cast<CSLOmExprOp>(getChild(0));
}

const RefCSLOmExpr CSLOmExprOp::getExpr2() const {
  ASSERT(!(m_opType & OP_UNARY_MASK),"[CSLOmExprOp::getExpr2()] illegal state for this method call.");
  //  if(m_opType & OP_UNARY_MASK) {
  //    //args.push_back("");
  //    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
  //    //cslomHasErrors = TRUE;
  //    throw NSBase::IllegalStateException("[CSLOmExprOp::getExpr2()] illegal state for this method call.", m_lineNumber);
  //  } NOT USER ERROR
  RefCSLOmBase exprOpAsBase = getChild(EXPR1);
  RefCSLOmExprOp exprOp = cast(exprOpAsBase);
  return exprOp;//boost::static_pointer_cast<CSLOmExprOp>(getChild(1));
}

const RefCSLOmExpr CSLOmExprOp::getExpr3() const {
  ASSERT(!(m_opType & OP_UNARY_MASK || m_opType & OP_BINARY_MASK),"[CSLOmExprOp::getExpr3()] illegal state for this method call.");
  //  if(m_opType & OP_UNARY_MASK || m_opType & OP_BINARY_MASK) {
  //    //args.push_back("");
  //    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
  //    //cslomHasErrors = TRUE;
  //    throw NSBase::IllegalStateException("[CSLOmExprOp::getExpr3()] illegal state for this method call.", m_lineNumber);
  //  } NOT USER ERROR
  RefCSLOmBase exprOpAsBase = getChild(EXPR2);
  RefCSLOmExprOp exprOp = cast(exprOpAsBase);
  return exprOp;//boost::static_pointer_cast<CSLOmExprOp>(getChild(2));
}

TBool CSLOmExprOp::isUnary() const {
  return m_opType & OP_UNARY_MASK;
}

TBool CSLOmExprOp::isBinary() const {
  return m_opType & OP_BINARY_MASK;
}

TBool CSLOmExprOp::isTernary() const {
  return m_opType & OP_TERNARY_MASK;
}

void CSLOmExprOp::setValue(RefCSLOmNumber number) const {
  m_value = number;
}

const RefCSLOmNumber CSLOmExprOp::getValue() const {
  return m_value;
}

RefCSLOmNumber CSLOmExprOp::evalChildExpr(TInt index) {
  RefCSLOmBase exprAsBase = getChild(index);
  RefCSLOmExpr expr = CSLOmExpr::cast(exprAsBase);
  RefCSLOmBase evalValue = expr->doEval(TRUE);
  if (!evalValue.get()) {
    return RefCSLOmNumber();
  }
  if (evalValue->isEnumItem()) {
    return CSLOmNumber::cast(CSLOmIdentifier::cast(evalValue)->getPayload());
  }
  if (!evalValue->isExpr()) {
    return RefCSLOmNumber();
  }
  ASSERT(CSLOmExpr::cast(evalValue)->isNumber(),"Eval type check failed!");
  return CSLOmNumber::cast(evalValue);
}
RefCSLOmNumber CSLOmExprOp::runOperation(RefCSLOmNumber evalVal0, RefCSLOmNumber evalVal1, RefCSLOmNumber evalVal2) {
  RefCSLOmNumber result;
  switch(m_opType) {
    case CSLOmExprOp::OP_UNARY_ARITHMETIC_PLUS          : result = evalVal0->plus();                                break;
    case CSLOmExprOp::OP_UNARY_ARITHMETIC_MINUS         : result = evalVal0->minus();                               break;
    case CSLOmExprOp::OP_UNARY_LOGIC_NOT                : result = evalVal0->logicNot();                            break;
    case CSLOmExprOp::OP_UNARY_BITWISE_NOT              : result = evalVal0->bitwiseNot();                          break;
    case CSLOmExprOp::OP_UNARY_REDUCTION_AND            : result = evalVal0->reductionAnd();                        break;
    case CSLOmExprOp::OP_UNARY_REDUCTION_NAND           : result = evalVal0->reductionNand();                       break;
    case CSLOmExprOp::OP_UNARY_REDUCTION_OR             : result = evalVal0->reductionOr();                         break;
    case CSLOmExprOp::OP_UNARY_REDUCTION_NOR            : result = evalVal0->reductionNor();                        break;
    case CSLOmExprOp::OP_UNARY_REDUCTION_XOR            : result = evalVal0->reductionXor();                        break;
    case CSLOmExprOp::OP_UNARY_REDUCTION_XNOR           : result = evalVal0->reductionXnor();                       break;
    case CSLOmExprOp::OP_UNARY_LOG_2                    : result = CSLOmNum32::build(m_lineNumber, m_fileName, (TInt)(::ceil(::log2(evalVal0->getValue())))); break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_PLUS         : result = evalVal0->add(evalVal1);                         break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_MINUS        : result = evalVal0->substract(evalVal1);                   break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_MULTIPLY     : result = evalVal0->multiply(evalVal1);                    break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_DIV          : result = evalVal0->divide(evalVal1);                      break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_MOD          : result = evalVal0->modulo(evalVal1);                      break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_POW          : result = evalVal0->power(evalVal1);                       break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_LEFT   : result = evalVal0->shiftLeft(evalVal1);                   break;
    case CSLOmExprOp::OP_BINARY_ARITHMETIC_SHIFT_RIGHT  : result = evalVal0->shiftRight(evalVal1);                  break;
    case CSLOmExprOp::OP_BINARY_EQUALITY_EQ             : result = evalVal0->equality(evalVal1);                    break;
    case CSLOmExprOp::OP_BINARY_EQUALITY_NOT_EQ         : result = evalVal0->notEquality(evalVal1);                 break;
    case CSLOmExprOp::OP_BINARY_IDENTITY_EQ_CASE        : result = evalVal0->equalityEqualCase(evalVal1);           break;
    case CSLOmExprOp::OP_BINARY_IDENTITY_NOT_EQ_CASE    : result = evalVal0->equalityNotEqualCase(evalVal1);        break;
    case CSLOmExprOp::OP_BINARY_LOGIC_AND               : result = evalVal0->logicAnd(evalVal1);                    break;
    case CSLOmExprOp::OP_BINARY_LOGIC_OR                : result = evalVal0->logicOr(evalVal1);                     break;
    case CSLOmExprOp::OP_BINARY_RELATIONAL_LESS         : result = evalVal0->relationalLess(evalVal1);              break;
    case CSLOmExprOp::OP_BINARY_RELATIONAL_LESS_EQUAL   : result = evalVal0->relationalLessEqual(evalVal1);         break;
    case CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER      : result = evalVal0->relationalGreater(evalVal1);           break;
    case CSLOmExprOp::OP_BINARY_RELATIONAL_GREATER_EQUAL: result = evalVal0->relationalGreaterEqual(evalVal1);      break;
    case CSLOmExprOp::OP_BINARY_BITWISE_AND             : result = evalVal0->bitwiseAnd(evalVal1);                  break;
    case CSLOmExprOp::OP_BINARY_BITWISE_NAND            : result = evalVal0->bitwiseNand(evalVal1);                 break;
    case CSLOmExprOp::OP_BINARY_BITWISE_OR              : result = evalVal0->bitwiseOr(evalVal1);                   break;
    case CSLOmExprOp::OP_BINARY_BITWISE_NOR             : result = evalVal0->bitwiseNor(evalVal1);                  break;
    case CSLOmExprOp::OP_BINARY_BITWISE_XOR             : result = evalVal0->bitwiseXor(evalVal1);                  break;
    case CSLOmExprOp::OP_BINARY_BITWISE_XNOR            : result = evalVal0->bitwiseXnor(evalVal1);                 break;
    case CSLOmExprOp::OP_BINARY_SHIFT_LEFT              : result = evalVal0->binaryShiftLeft(evalVal1);             break;
    case CSLOmExprOp::OP_BINARY_SHIFT_RIGHT             : result = evalVal0->binaryShiftRight(evalVal1);            break;
    case CSLOmExprOp::OP_TERNARY_COND                   : result = evalVal0->ternaryCondition(evalVal1,evalVal2);   break;    
    default:   ASSERT(FAIL, "Undefined Operation"); 
  }
  return result;
}

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmExprOp::doParamEval(RefCSLOmBase evalFor) {

  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase temp = RefTMap_RefCSLOmUnitInstance_RefCSLOmBase(new TMap_RefCSLOmUnitInstance_RefCSLOmBase);

  if(getThis()->isConst()) {
    temp->insert(std::make_pair(RefCSLOmUnitInstance(), doEval(TRUE)));
    return temp;
  }

  RefCSLOmScope parentScope = evalFor->getParentScope();
  while (!parentScope->getHolderObject()->isInterface() && !parentScope->getHolderObject()->isSignalGroup() && !parentScope->getHolderObject()->isUnitDecl()) {
    parentScope = parentScope->getHolderObject()->getParentScope();
  }

  if (parentScope->getHolderObject()->isInterface() && CSLOmInterface::cast(parentScope->getHolderObject())->isDefaultIfc()) {
    parentScope = parentScope->getHolderObject()->getParentScope();
  }

  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase evalValue0, evalValue1, evalValue2;
  
  if(isUnary()) {
    evalValue0 = CSLOmExpr::cast(getChild(EXPR0))->doParamEval(evalFor);
    if (!evalValue0.get()) {
      return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
    }
  } 
  else if (isBinary()) {
    evalValue0 = CSLOmExpr::cast(getChild(EXPR0))->doParamEval(evalFor);
    evalValue1 = CSLOmExpr::cast(getChild(EXPR1))->doParamEval(evalFor);
    if (!evalValue0.get() || !evalValue1.get()) {
      return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
    }
  } 
  else if (getThis()->isTernary()) {
    evalValue0 = CSLOmExpr::cast(getChild(EXPR0))->doParamEval(evalFor);
    evalValue1 = CSLOmExpr::cast(getChild(EXPR1))->doParamEval(evalFor);
    evalValue2 = CSLOmExpr::cast(getChild(EXPR2))->doParamEval(evalFor);
    if (!evalValue0.get() || !evalValue1.get() || !evalValue2.get()) {
      return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
    }
  }

  if (parentScope->getHolderObject()->isSignalGroup() || (parentScope->getHolderObject()->isInterface() && !CSLOmInterface::cast(parentScope->getHolderObject())->isDefaultIfc())) {
    RefCSLOmNumber evalVal0, evalVal1, evalVal2; 
    if(isUnary()) {
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
    } 
    else if (isBinary()) {
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
      evalVal1 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue1);
    } 
    else if (getThis()->isTernary()) {
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
      evalVal1 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue1);
      evalVal2 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue2);
    }
    temp->insert(std::make_pair(RefCSLOmUnitInstance(), runOperation(evalVal0,evalVal1,evalVal2)));
    return temp;
  }

  RefCSLOmUnitDecl unit = CSLOmUnitDecl::cast(parentScope->getHolderObject());
  RefTVec_WeakCSLOmUnitInstance instances = unit->getInstances();
  if (instances.get() && instances->size() >= 1) {
    for(TVec_WeakCSLOmUnitInstance::iterator it = instances->begin(); it < instances->end(); it++) {
      RefCSLOmNumber evalVal0, evalVal1, evalVal2;
      if(isUnary()) {
        evalVal0 = CSLOmExpr::getValueForInstance((*it).lock(), evalValue0);
      } 
      else if (isBinary()) {
        evalVal0 = CSLOmExpr::getValueForInstance((*it).lock(), evalValue0);
        evalVal1 = CSLOmExpr::getValueForInstance((*it).lock(), evalValue1);
      } 
      else if (getThis()->isTernary()) {
        evalVal0 = CSLOmExpr::getValueForInstance((*it).lock(), evalValue0);
        evalVal1 = CSLOmExpr::getValueForInstance((*it).lock(), evalValue1);
        evalVal2 = CSLOmExpr::getValueForInstance((*it).lock(), evalValue2);
      }
      RefCSLOmNumber result;
      result = runOperation(evalVal0,evalVal1,evalVal2);
      temp->insert(std::make_pair((*it).lock(), result));
    }
    RefCSLOmNumber evalVal0, evalVal1, evalVal2;
    if(isUnary()) {
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
    }                                           
    else if (isBinary()) {                      
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
      evalVal1 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue1);
    }                                           
    else if (getThis()->isTernary()) {          
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
      evalVal1 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue1);
      evalVal2 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue2);
    }
    RefCSLOmNumber result;
    result = runOperation(evalVal0,evalVal1,evalVal2);
    temp->insert(std::make_pair(RefCSLOmUnitInstance(), result));

  }
  else {
    RefCSLOmNumber evalVal0, evalVal1, evalVal2;
    if(isUnary()) {
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
    } 
    else if (isBinary()) {
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
      evalVal1 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue1);
    } 
    else if (getThis()->isTernary()) {
      evalVal0 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue0);
      evalVal1 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue1);
      evalVal2 = CSLOmExpr::getValueForInstance(RefCSLOmUnitInstance(), evalValue2);
    }
    temp->insert(std::make_pair(RefCSLOmUnitInstance(), runOperation(evalVal0,evalVal1,evalVal2)));
  }
  return temp;
}
  
RefCSLOmBase CSLOmExprOp::doEval(TBool convertEnumItem) {

  RefCSLOmNumber evalValue0, evalValue1, evalValue2;

  if(m_isEvaluated) {
    return m_cachedEval;
  }
  else if(isUnary()) {
    evalValue0 = CSLOmNum32::cast(evalChildExpr(EXPR0));
    if (!evalValue0.get()) {
      return RefCSLOmBase();
    }
  } 
  else if (isBinary()) {
    evalValue0 = CSLOmNum32::cast(evalChildExpr(EXPR0));
    evalValue1 = CSLOmNum32::cast(evalChildExpr(EXPR1));
    if (!evalValue0.get() || !evalValue1.get()) {
      return RefCSLOmBase();
    }
  } 
  else if (getThis()->isTernary()) {
    evalValue0 = CSLOmNum32::cast(evalChildExpr(EXPR0));
    evalValue1 = CSLOmNum32::cast(evalChildExpr(EXPR1));
    evalValue2 = CSLOmNum32::cast(evalChildExpr(EXPR2));
    if (!evalValue0.get() || !evalValue1.get() || !evalValue2.get()) {
      return RefCSLOmBase();
    }
  }
  m_cachedEval = runOperation(evalValue0,evalValue1,evalValue2);
  m_isEvaluated = TRUE;
  return m_cachedEval;
}

void CSLOmExprOp::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

const TBool CSLOmExprOp::isEvaluated() const {
  return m_isEvaluated;
}

RefCSLOmExpr CSLOmExprOp::dupp() {
  return build(m_lineNumber, m_fileName, m_opType, getExpr1()->dupp(), (isBinary() || isTernary()) ? getExpr2()->dupp() : RefCSLOmExpr(), isTernary() ? getExpr3()->dupp(): RefCSLOmExpr());
}

// ********************************************************************************
// CSLOmExprConcat class
// ********************************************************************************
CSLOmExprConcat::CSLOmExprConcat(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_CONCAT), 
  m_isConst(TRUE){}

RefTVec_RefCSLOmExpr CSLOmExprConcat::getExprs(){
  RefTVec_RefCSLOmExpr temp = RefTVec_RefCSLOmExpr(new TVec_RefCSLOmExpr);
  
  RefTVec_RefCSLOmBase children  = getExprsAsBase();

  for (TVec_RefCSLOmBase::iterator it = children->begin(); it < children->end(); it++) {
    RefTVec_RefCSLOmExpr aux = CSLOmExpr::cast(*it)->getExprs();
    for (TVec_RefCSLOmExpr::iterator iter = aux->begin(); iter < aux->end(); iter++) {
      temp->push_back(*iter);
    }
  }
  return temp;
}

RefCSLOmExprConcat CSLOmExprConcat::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmExprConcat();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmExprConcat>(object);
  }
}

RefCSLOmExprConcat CSLOmExprConcat::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmExpr expr) {
  CSLOmExprConcat* exprConcat;
  try {
    exprConcat = new CSLOmExprConcat(lineNumber,fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmExprConcat refExprConcat(exprConcat);
  exprConcat->m_weakRef = boost::weak_ptr<CSLOmBase>( refExprConcat);
  exprConcat->addExpr(expr);
  return refExprConcat;
}

TBool CSLOmExprConcat::isConst() const {
  return m_isConst;
}

void CSLOmExprConcat::addExpr(RefCSLOmExpr expr) {
  ASSERT(expr.get(), "null expr received");
  expr->setParent(getThis()); // self registration
  m_isConst &= expr->isConst();
}

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmExprConcat::doParamEval(RefCSLOmBase evalFor) {
  return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();
}

RefCSLOmBase CSLOmExprConcat::doEval(TBool convertEnumItem) {
  RefTVec_RefCSLOmBase exprInConcat=getExprsAsBase();
  ASSERT(exprInConcat.get(),"exprs in a concat should not be null");
  for(TVec_RefCSLOmBase::iterator i=exprInConcat->begin(); i!=exprInConcat->end(); i++) {
    CSLOmExpr::cast(*i)->doEval();
  }
  m_isEvaluated=TRUE;
  return RefCSLOmExpr();
}

TInt CSLOmExprConcat::getWidth(){
  ASSERT(m_isEvaluated,"evaluate before getting the width");
  RefTVec_RefCSLOmBase exprInConcat=getExprsAsBase();
  ASSERT(exprInConcat.get(),"exprs in a concat should not be null");

  if(m_width==-1){
    m_width=0;
    for(TVec_RefCSLOmBase::iterator i=exprInConcat->begin(); i<exprInConcat->end(); i++) {
      RefCSLOmExpr expr=CSLOmExpr::cast((*i));
      TInt tempSize=expr->getWidth();
      if(tempSize!=-1){
        m_width+=tempSize;
      }
      else{
        return -1;
      }
    }
  }
  return m_width;
}

void CSLOmExprConcat::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis()); // print out the opening curly brace
}

const TBool CSLOmExprConcat::isEvaluated() const {
  return m_isEvaluated;
}

RefCSLOmExpr CSLOmExprConcat::dupp() {
  RefCSLOmExprConcat expr = build(m_lineNumber, m_fileName, CSLOmExpr::cast(getChild(0))->dupp());
  for (TInt i = 1; i < getChildrenSize() ; ++i) {
    expr->addExpr(CSLOmExpr::cast(getChild(i))->dupp());
  }
  return expr;
}

// ********************************************************************************
// CSLOmExprMultiConcat class
// ********************************************************************************
CSLOmExprMultiConcat::CSLOmExprMultiConcat(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_MULTI_CONCAT) {}

RefTVec_RefCSLOmExpr CSLOmExprMultiConcat::getExprs() {
  return CSLOmExpr::cast(getChild(EXPR1))->getExprs();
}

RefCSLOmExprMultiConcat CSLOmExprMultiConcat::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmExprMultiConcat();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmExprMultiConcat>(object);
  }
}

RefCSLOmExprMultiConcat CSLOmExprMultiConcat::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmExpr expr, RefCSLOmExprConcat exprConcat) {
  ASSERT(expr.get(), "null expr received");
  ASSERT(exprConcat.get(), "null exprConcat received");
  ASSERT(expr->isConst(), "expr should be const");

  CSLOmExprMultiConcat* exprMultiConcat;
  try {
    exprMultiConcat = new CSLOmExprMultiConcat(lineNumber,fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmExprMultiConcat refExprMultiConcat(exprMultiConcat);
  exprMultiConcat->m_weakRef = boost::weak_ptr<CSLOmBase>( refExprMultiConcat);
  expr->setParent(refExprMultiConcat); // self registration
  exprConcat->setParent(refExprMultiConcat); // self registration
  return refExprMultiConcat;
}

TBool CSLOmExprMultiConcat::isConst() const {
  // TODO
  return TRUE;
}

RefCSLOmExpr CSLOmExprMultiConcat::getExpr() const {
  RefCSLOmBase exprAsBase = getChild(EXPR0);
  RefCSLOmExpr expr = CSLOmExpr::cast(exprAsBase);
  return expr;//boost::static_pointer_cast<CSLOmExpr>(getChild(0));
}

RefCSLOmExprConcat CSLOmExprMultiConcat::getExprConcat() const {
  RefCSLOmBase exprConcatAsBase = getChild(CONCAT_EXPR);
  RefCSLOmExprConcat exprConcat = CSLOmExprConcat::cast(exprConcatAsBase);
  return exprConcat;//boost::static_pointer_cast<CSLOmExprConcat>(getChild(1));
}

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmExprMultiConcat::doParamEval(RefCSLOmBase evalFor) {
  return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();                                  
}

RefCSLOmBase CSLOmExprMultiConcat::doEval(TBool convertEnumItem) {
  RefCSLOmExpr expr=getExpr();
  RefCSLOmExprConcat concat=getExprConcat();
  ASSERT(expr.get(),"expr in a multi concat should not be null");
  ASSERT(concat.get(),"concat expr in a multi concat should not be null");
  expr->doEval();
  concat->doEval();

  m_isEvaluated=TRUE;
  return RefCSLOmExpr();
}

TInt CSLOmExprMultiConcat::getWidth(){  
  ASSERT(m_isEvaluated,"evaluate first before getting the width");
  RefCSLOmExpr expr=getExpr();
  RefCSLOmExprConcat concat=getExprConcat();
  ASSERT(expr.get(),"expr in a multi concat should not be null");
  ASSERT(concat.get(),"concat expr in a multi concat should not be null");
  ASSERT(expr->isNumber(),"expr in a multi concat should be a number");

  if(m_width==-1){
    RefCSLOmNumber exprNum=CSLOmNumber::cast(expr);
    m_width=exprNum->getValue()*concat->getWidth();
  }
  return m_width;
}

void CSLOmExprMultiConcat::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

const TBool CSLOmExprMultiConcat::isEvaluated() const {
  return m_isEvaluated;
}

RefCSLOmExpr CSLOmExprMultiConcat::dupp() {
  return build(m_lineNumber, m_fileName, getExpr()->dupp(), CSLOmExprConcat::cast(getExprConcat()->dupp()));
}

// ********************************************************************************
// CSLOmExprHybridOrFuncCall class
// ********************************************************************************
CSLOmExprHybridOrFuncCall::CSLOmExprHybridOrFuncCall(TLineNumberType lineNumber, RefString fileName) : 
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_HYBRID_OR_FUNC_CALL) {}

RefCSLOmExprHybridOrFuncCall CSLOmExprHybridOrFuncCall::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmExprHybridOrFuncCall();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmExprHybridOrFuncCall>(object);
  }
}

RefCSLOmExprHybridOrFuncCall CSLOmExprHybridOrFuncCall::build( TLineNumberType lineNumber, RefString fileName, RefCSLOmExprFuncSignature functionSignature) {
  ASSERT(functionSignature.get(), "null functionSignature received");
  CSLOmExprHybridOrFuncCall *exprHybridOrFuncCall = new CSLOmExprHybridOrFuncCall(lineNumber,fileName);
  RefCSLOmExprHybridOrFuncCall refExprHybridOrFuncCall(exprHybridOrFuncCall) ;
  exprHybridOrFuncCall->m_weakRef = boost::weak_ptr<CSLOmBase>( refExprHybridOrFuncCall);
  exprHybridOrFuncCall->addFunctionSignature(functionSignature);
  return refExprHybridOrFuncCall;
}

RefCSLOmExprHybridOrFuncCall CSLOmExprHybridOrFuncCall::build( TLineNumberType lineNumber, RefString fileName, RefCSLOmExprLink objectName) {
  ASSERT(objectName.get(), "null objectName received");
  CSLOmExprHybridOrFuncCall *exprHybridOrFuncCall = new CSLOmExprHybridOrFuncCall(lineNumber,fileName);
  RefCSLOmExprHybridOrFuncCall refExprHybridOrFuncCall(exprHybridOrFuncCall) ;
  exprHybridOrFuncCall->m_weakRef = boost::weak_ptr<CSLOmBase>( refExprHybridOrFuncCall);
  exprHybridOrFuncCall->addObjectName(objectName);
  return refExprHybridOrFuncCall;
}

void CSLOmExprHybridOrFuncCall::addObjectName( RefCSLOmExprLink objectName) {
  ASSERT(objectName.get(), "null objectName received");
  objectName->setParent(getThis()); //self registration
}

void CSLOmExprHybridOrFuncCall::addFunctionSignature(RefCSLOmExprFuncSignature functionSignature) {
  ASSERT(functionSignature.get(), "null functionSignature received");
  functionSignature->setParent(getThis()); //self registration
}

const RefTVec_RefCSLOmExprLink CSLOmExprHybridOrFuncCall::getObjectNames() const{
  if(!getChildrenVec().get()) {
  
    throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:getObjectNames()] illegal state for this method call.", m_lineNumber);
  }
  RefTVec_RefCSLOmExprLink vec = RefTVec_RefCSLOmExprLink(new TVec_RefCSLOmExprLink());
  RefCSLOmExpr expr;
  for(TUInt i = 0; i < getChildrenVec()->size(); ++i) {
    expr = CSLOmExpr::cast(getChild(i));
    if(expr->isExprLink())
      vec->push_back(CSLOmExprLink::cast(getChild(i)));
  }
  return vec;
}

const RefTVec_RefCSLOmBase CSLOmExprHybridOrFuncCall::getObjectNamesAsBase() const{
  if(!getChildrenVec().get()) {
    throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:getObjectNames()] illegal state for this method call.", m_lineNumber);
  }
  RefTVec_RefCSLOmBase vec = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  RefCSLOmExpr expr;
  for(TUInt i = 0; i < getChildrenVec()->size(); ++i) {
    expr = CSLOmExpr::cast(getChild(i));
    if(expr->isExprLink())
      vec->push_back(getChild(i));
  }
  return vec;
}

const RefTVec_RefCSLOmExprFuncSignature CSLOmExprHybridOrFuncCall::getFunctionSignatures() const {
  if(!getChildrenVec().get()) {
    throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:getFunctionNames()] illegal state for this method call.", m_lineNumber);
  }
  RefTVec_RefCSLOmExprFuncSignature vec = RefTVec_RefCSLOmExprFuncSignature(new TVec_RefCSLOmExprFuncSignature());
  RefCSLOmExpr expr;
  for(TUInt i = 0; i < getChildrenVec()->size(); ++i) {
    expr = CSLOmExpr::cast(getChild(i));
    if(expr->isFuncSignature())
      vec->push_back(CSLOmExprFuncSignature::cast(getChild(i)));
  }
  return vec;
}

const RefTVec_RefCSLOmBase CSLOmExprHybridOrFuncCall::getFunctionSignaturesAsBase() const {
  if(!getChildrenVec().get()) {
    throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:getFunctionNames()] illegal state for this method call.", m_lineNumber);
  }
  RefTVec_RefCSLOmBase vec = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase());
  RefCSLOmExpr expr;
  for(TUInt i = 0; i < getChildrenVec()->size(); ++i) {
    expr = CSLOmExpr::cast(getChild(i));
    if(expr->isFuncSignature())
      vec->push_back(getChild(i));
  }
  return vec;
}

TBool CSLOmExprHybridOrFuncCall::isConst() const {
  return TRUE;
}

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmExprHybridOrFuncCall::doParamEval(RefCSLOmBase evalFor) {
  return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();  
}

RefCSLOmBase CSLOmExprHybridOrFuncCall::doEval(TBool convertEnumItem) {
  RefTVec_RefCSLOmExpr exprs = getExprs();
  RefCSLOmBase nextScope = RefCSLOmBase();
  TVec_RefCSLOmExpr::iterator iter = exprs->begin();
  if((*iter)->isFuncSignature()) {
    CSLOmExprFuncSignature::cast(*iter)->setScope(CSLOmScopeBlock::getCurrentScope()->getHolderObject());
    nextScope = (*iter)->doEval();
  } else if ((*iter)->isExprLink()) {
    nextScope = (*iter)->doEval();
  } else {
    args.push_back("expression");
    args.push_back("...");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, (*iter)->getLineNumber(), (*iter)->getFileName());
    cslomHasErrors = TRUE;
    return RefCSLOmBase();
    //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] Unsupported Expression.", m_lineNumber);
  }
  if(nextScope.get() == NULL) {
    args.push_back("get function return type");
    args.push_back("not null");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, (*iter)->getLineNumber(), (*iter)->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] the next scope is empty", m_lineNumber);
    return RefCSLOmBase();
  }
  ++iter;
  
  for(;iter < exprs->end(); iter++) {
    if((*iter)->isFuncSignature()) {
      CSLOmExprFuncSignature::cast(*iter)->setScope(nextScope);
      nextScope = (*iter)->doEval();
    } else if ((*iter)->isExprLink()) {
      CSLOmScopeBlock::enterScope(CSLOmBase::getAttachedScope(nextScope.get()));
      nextScope = CSLOmBase::getAttachedScope(nextScope.get())->lookupLocal(CSLOmExprLink::cast(*iter)->getName())->getParent();
      CSLOmScopeBlock::exitScope();
    } else {
      args.push_back("expression");
      args.push_back("...");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, (*iter)->getLineNumber(), (*iter)->getFileName());
      cslomHasErrors = TRUE;
      return RefCSLOmBase();
      //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] Unsupported Expression.", m_lineNumber);
    }
    if(nextScope.get() == NULL) {
      args.push_back("get function return type");
      args.push_back("not null");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, (*iter)->getLineNumber(), (*iter)->getFileName());
      cslomHasErrors = TRUE;
      //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] the next scope is empty", m_lineNumber);
      return RefCSLOmBase();
    }
  }

  if(nextScope.get() != NULL) {
    return nextScope;
  } else {
    return RefCSLOmBase();
  }
}

TInt CSLOmExprHybridOrFuncCall::doEnumEval(ECSLOmEnumType enumType) {
  RefTVec_RefCSLOmExpr exprs = getExprs();
  RefCSLOmBase nextScope = RefCSLOmBase();
  TVec_RefCSLOmExpr::iterator iter = exprs->begin();

  if((*iter)->isFuncSignature()) {
    CSLOmExprFuncSignature::cast(*iter)->setScope(CSLOmScopeBlock::getCurrentScope()->getHolderObject());
    nextScope = (*iter)->doEval();
  } else if ((*iter)->isExprLink()) {
    nextScope = (*iter)->doEval();
  } else {
    args.push_back("expression");
    args.push_back("...");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, (*iter)->getLineNumber(), (*iter)->getFileName());
    cslomHasErrors = TRUE;
    return -1;
    //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] Unsupported Expression.", m_lineNumber);
  }
  if(nextScope.get() == NULL) {
    args.push_back("get function return type");
    args.push_back("not null");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, (*iter)->getLineNumber(), (*iter)->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] the next scope is empty", m_lineNumber);
    return -1;
  }
  ++iter;
  
  for(;iter < exprs->end()-1; iter++) {
    if((*iter)->isFuncSignature()) {
      CSLOmExprFuncSignature::cast(*iter)->setScope(nextScope);
      nextScope = (*iter)->doEval();
    } else if ((*iter)->isExprLink()) {
      CSLOmScopeBlock::enterScope(CSLOmBase::getAttachedScope(nextScope.get()));
      nextScope = (*iter)->doEval();
      CSLOmScopeBlock::exitScope();
    } else {
      args.push_back("expression");
      args.push_back("...");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber(), getThis()->getFileName());
      cslomHasErrors = TRUE;
      return -1;
      //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] Unsupported Expression.", m_lineNumber);
    }
    if(nextScope.get() == NULL) {
      args.push_back("get function return type");
      args.push_back("not null");
      addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, (*iter)->getLineNumber(), (*iter)->getFileName());
      cslomHasErrors = TRUE;
      //throw NSBase::IllegalStateException("[CSLOmExprHybridOrFuncCall:doEval()] the next scope is empty", m_lineNumber);
      return -1;
    }
  }

  //set for last item
  if((*iter)->isFuncSignature()) {
    CSLOmExprFuncSignature::cast(*iter)->setScope(nextScope);
    return CSLOmExprFuncSignature::cast(*iter)->doEnumEval(enumType);
  } else {
    ASSERT(FAIL,"Enum evaluation failed, last expression in HybridExpr is not a get function");
    return -1;
  }
}

void CSLOmExprHybridOrFuncCall::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(CSLOmExprHybridOrFuncCall::cast(getThis()));
}

const TBool CSLOmExprHybridOrFuncCall::isEvaluated() const {
  return m_isEvaluated;
}

RefCSLOmExpr CSLOmExprHybridOrFuncCall::dupp() {
  RefCSLOmExpr expr;
  if(getChild(0)->isExprLink()) {
    expr = build(m_lineNumber, m_fileName, CSLOmExprLink::cast(CSLOmExpr::cast(getChild(0))->dupp()));
  }
  else {
    expr = build(m_lineNumber, m_fileName, CSLOmExprFuncSignature::cast(CSLOmExpr::cast(getChild(0))->dupp()));
  }
  for (TInt i = 1; i < getChildrenSize() ; ++i) {
    CSLOmExpr::cast(getChild(i))->dupp()->setParent(expr);
  }
  return expr;
}

// ********************************************************************************
// CSLOmExprFuncSignature class
// ********************************************************************************
CSLOmExprFuncSignature::CSLOmExprFuncSignature(TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName) : 
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_FUNC_SIGNATURE), 
  m_funcName(funcName) {}

RefCSLOmExprFuncSignature CSLOmExprFuncSignature::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmExprFuncSignature();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmExprFuncSignature>(object);
  }
}

CSLOmExprFuncSignature::CSLOmExprFuncSignature(TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName, ECSLOmPortDirection portDirection) :
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_FUNC_SIGNATURE), 
  m_funcName(funcName), 
  m_portDirection(portDirection) {}

RefCSLOmExprFuncSignature CSLOmExprFuncSignature::build(TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName, RefCSLOmListExpr funcParams) {
  CSLOmExprFuncSignature *funcSignature;
  try {
    funcSignature = new CSLOmExprFuncSignature(lineNumber,fileName, funcName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmExprFuncSignature refFuncSignature(funcSignature);
  funcSignature->m_weakRef = boost::weak_ptr<CSLOmBase>( refFuncSignature);
  if(funcParams.get()) {
    funcParams->setParent(refFuncSignature);
  }
  return refFuncSignature;
}

RefCSLOmExprFuncSignature CSLOmExprFuncSignature::build(TLineNumberType lineNumber, RefString fileName, ECSLOmFuncName funcName, ECSLOmPortDirection portDirection) {
  CSLOmExprFuncSignature *funcSignature;
  try {
    funcSignature = new CSLOmExprFuncSignature(lineNumber,fileName, funcName, portDirection);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmExprFuncSignature refFuncSignature(funcSignature);
  funcSignature->m_weakRef = boost::weak_ptr<CSLOmBase>( refFuncSignature);
  return refFuncSignature;
}

const ECSLOmFuncName CSLOmExprFuncSignature::getFuncName () const {
  return m_funcName;
}

const RefCSLOmListExpr CSLOmExprFuncSignature::getFunctionParams() const {
  if(m_funcName == GET_INTERFACE) {
    
    throw NSBase::IllegalStateException("[CSLOmFunctionSignature:getFunctionParams()] illegal state for this method call.", m_lineNumber);
  }
  else {
    RefCSLOmBase funcParamsAsBase = getChild(FUNCTION_PARAMS);
    RefCSLOmListExpr funcParams = CSLOmListExpr::cast(funcParamsAsBase);
    return  funcParams;//CSLOmListExpr::cast(getChild(0));
  }
}

const ECSLOmPortDirection CSLOmExprFuncSignature::getPortDirection() const {
  if(m_funcName != GET_INTERFACE) {
    throw NSBase::IllegalStateException("[CSLOmFunctionSignature:getFunctionParams()] illegal state for this method call.", m_lineNumber);
  }
  else
    return m_portDirection;
}

TBool CSLOmExprFuncSignature::isConst() const { 
  return TRUE;
}

//get_functions definitions for each csl object

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmExprFuncSignature::doParamEval(RefCSLOmBase evalFor) {
  return RefTMap_RefCSLOmUnitInstance_RefCSLOmBase();  
}

RefCSLOmBase CSLOmExprFuncSignature::doEval(TBool convertEnumItem) { 
  RefTVec_RefCSLOmBase items;

  // ************************************************************
  // DEP FIX - factor - if it is an ID then get the parent- everything after CSLOmPortDecl::cast(m_scope->getParent()) is the same in the if and else branches
  // should be
  // if (m_scope->isID()) {
  //   scope = m_scope->getParent();
  // else {
  //   scope = CSLOmPortDecl::cast(m_scope);
  // }
  //
  // switch(){
  // if(scope->isSignal()) {
  //   m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getWidth();
  //   return m_cachedEval;
  // }
  // repeat for each branch below-make the code maintainable
  // ************************************************************

  switch(m_funcName) {
    
    //returns the width of the csl object
    case  GET_WIDTH                 : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getWidth();
            return m_cachedEval;
          } 
          else if (m_scope->getParent()->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope->getParent())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isRegisterFile()) {
            m_cachedEval = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope->getParent())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isAddressRange()) {
            m_cachedEval = CSLOmAddressRange::cast(m_scope->getParent())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isFifo()) {
            m_cachedEval = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isRegister()) {
            ASSERT(FAIL, "this command has not been implemented for csl_register");
            // m_cachedEval = CSLOmRegisterInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getWidth();
            // return m_cachedEval;
          }
          else if (m_scope->getParent()->isMemory()) {
            ASSERT(FAIL, "this command has not been implemented for csl_memory");            
            // m_cachedEval = CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getWidth();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getWidth();
            return m_cachedEval;
          } 
          else if (m_scope->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope)->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->isRegisterFile()) {
            m_cachedEval = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope)->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->isAddressRange()) {
            m_cachedEval = CSLOmAddressRange::cast(m_scope)->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->isFifo()) {
            m_cachedEval = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getWidth();
            return m_cachedEval;
          }
          else if (m_scope->isRegister()) {
            ASSERT(FAIL, "this command has not been implemented for csl_register");
            // m_cachedEval = CSLOmRegisterInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getWidth();
            // return m_cachedEval;
          }
          else if (m_scope->isMemory()) {
            ASSERT(FAIL, "this command has not been implemented for csl_memory");
            // m_cachedEval = CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getWidth();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the depth of the csl object
    case  GET_DEPTH                 : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if (m_scope->getParent()->isRegisterFile()) {// DEP FIX - factor - if it is an ID then get the parent- everything after CSLOmPortDecl::cast(m_scope->getParent()) is the same in the if and else branches
            m_cachedEval = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getDepth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isFifo()) {
            m_cachedEval = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getDepth();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isMemory()) {
            ASSERT(FAIL, "this command has not been implemented for csl_memory");
            // m_cachedEval = CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getDepth();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();            
          }          
        }
        else {
          if (m_scope->isRegisterFile()) {
            m_cachedEval = CSLOmRegisterFileInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getDepth();
            return m_cachedEval;
          }
          else if (m_scope->isFifo()) {
            m_cachedEval = CSLOmFifoInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getDepth();
            return m_cachedEval;
          }
          else if (m_scope->isMemory()) {
            ASSERT(FAIL, "this command has not been implemented for csl_memory");            
            // m_cachedEval = CSLOmMemoryInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getDepth();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }          
        }
      }
      break;

    //returns the local prefix of the csl_signal in a csl_unit
    case  GET_SIGNAL_PREFIX_LOCAL   : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isUnitDecl()) {
            ASSERT(FAIL, "this command has not been implemented for csl_unit");            
            // m_cachedEval = CSLOmExprLink::build(m_lineNumber,CSLOmUnitDecl::cast(m_scope->getParent())->getSignalPrefixLocal());
            // return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isUnitDecl()) {
            ASSERT(FAIL, "this command has not been implemented for csl_unit");            
            // m_cachedEval = CSLOmExprLink::build(m_lineNumber,CSLOmUnitDecl::cast(m_scope)->getSignalPrefixLocal());
            // return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;
      
    //returns the prefix of the csl_signal in a csl_unit
    case  GET_SIGNAL_PREFIX         : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isUnitDecl()) {
            ASSERT(FAIL, "this command has not been implemented for csl_unit");                        
            // m_cachedEval = CSLOmExprLink::build(m_lineNumber,CSLOmUnitDecl::cast(m_scope->getParent())->getSignalPrefix());
            // return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isUnitDecl()) {
            ASSERT(FAIL, "this command has not been implemented for csl_unit");            
            // m_cachedEval = CSLOmExprLink::build(m_lineNumber,CSLOmUnitDecl::cast(m_scope)->getSignalPrefix());
            // return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the prefix of the csl_unit
    case  GET_UNIT_PREFIX           :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isUnitDecl()) {
            m_cachedEval = CSLOmExprLink::build(m_lineNumber,m_fileName,CSLOmUnitDecl::cast(m_scope->getParent())->getUnitPrefix());
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isUnitDecl()) {
            m_cachedEval = CSLOmExprLink::build(m_lineNumber,m_fileName,CSLOmUnitDecl::cast(m_scope)->getUnitPrefix());
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the ID of the csl_unit
    case  GET_ID                    :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isUnitDecl()) {
            m_cachedEval = CSLOmUnitDecl::cast(m_scope->getParent())->getUnitNumericID();
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isUnitDecl()) {
            m_cachedEval = CSLOmUnitDecl::cast(m_scope)->getUnitNumericID();
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the attributes of the csl_register
    case  GET_ATTRIBUTES            : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if (m_scope->getParent()->isRegister()) {
            ASSERT(FAIL, "this command has not been implemented for csl_register");
            // m_cachedEval = CSLOmRegisterInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getAttributes();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }          
        }
        else {
          if (m_scope->isRegister()) {
            ASSERT(FAIL, "this command has not been implemented for csl_register");
            // m_cachedEval = CSLOmRegisterInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getAttributes();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }          
        }
      }
      break;

    //returns the width of a dimension for multiple dimension csl objects
    case  GET_DIM_WIDTH             : 
      items = CSLOmListExpr::cast(getChild(FUNCTION_PARAMS))->getItemsAsBase();
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getDimensionWidth(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getDimWidth(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope->getParent())->getDimWidth(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getDimensionWidth(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if(m_scope->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getDimWidth(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope)->getDimWidth(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the upper index of the csl object
    case  GET_UPPER_INDEX           : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getUpperIndex();
            return m_cachedEval;
          }
          else if(m_scope->getParent()->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope->getParent())->getUpper();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getUpper();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope->getParent())->getUpper();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isAddressRange()) {
            ASSERT(FAIL, "this command has not been implemented for AddressRange");
            // m_cachedEval = CSLOmAddressRange::cast(m_scope->getParent())->getUpperIndex();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getUpperIndex();
            return m_cachedEval;
          }
          else if(m_scope->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope)->getUpper();
            return m_cachedEval;
          }
          else if (m_scope->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getUpper();
            return m_cachedEval;
          }
          else if (m_scope->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope)->getUpper();
            return m_cachedEval;
          }
          else if (m_scope->isAddressRange()) {
            ASSERT(FAIL, "this command has not been implemented for AddressRange");
            // m_cachedEval = CSLOmAddressRange::cast(m_scope)->getUpperIndex();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the upper index of a dimension for multiple dimension csl objects
    case  GET_DIM_UPPER_INDEX       : 
      items = CSLOmListExpr::cast(getChild(FUNCTION_PARAMS))->getItemsAsBase();
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getDimUpperIndex(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getDimUpper(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope->getParent())->getDimUpper(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }          
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getDimUpperIndex(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if(m_scope->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getDimUpper(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope)->getDimUpper(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the lower index of the csl object
    case  GET_LOWER_INDEX           : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getLowerIndex();
            return m_cachedEval;
          }
          else if(m_scope->getParent()->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope->getParent())->getLower();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getLower();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope->getParent())->getLower();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isAddressRange()) {
            ASSERT(FAIL, "this command has not been implemented for AddressRange");
            // m_cachedEval = CSLOmAddressRange::cast(m_scope->getParent())->getLowerIndex();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getLowerIndex();
            return m_cachedEval;
          }
          else if(m_scope->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope)->getLower();
            return m_cachedEval;
          }
          else if (m_scope->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getLower();
            return m_cachedEval;
          }
          else if (m_scope->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope)->getLower();
            return m_cachedEval;
          }
          else if (m_scope->isAddressRange()) {
            ASSERT(FAIL, "this command has not been implemented for AddressRange");
            // m_cachedEval = CSLOmAddressRange::cast(m_scope)->getLowerIndex();
            // return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the lower index of a dimension for multiple dimension csl objects
    case  GET_DIM_LOWER_INDEX       : 
      items = CSLOmListExpr::cast(getChild(FUNCTION_PARAMS))->getItemsAsBase();
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {// DEP FIX - factor - if it is an ID then get the parent- everything after CSLOmPortDecl::cast(m_scope->getParent()) is the same in the if and else branches
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getDimLowerIndex(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getDimLower(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope->getParent())->getDimLower(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }          
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getDimLowerIndex(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if(m_scope->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getDimLower(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope)->getDimLower(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the bitrange of the csl object
    case  GET_BITRANGE              : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getBitRangeAsBase();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmPortDecl::cast(m_scope->getParent())->getBitRange();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope->getParent())->getBitRange();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getBitRangeAsBase();
            return m_cachedEval;
          }
          else if (m_scope->isPort()) {
            m_cachedEval = CSLOmPortDecl::cast(m_scope)->getBitRange();
            return m_cachedEval;
          }
          else if (m_scope->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope)->getBitRange();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the bitrange of a dimension for multiple dimension csl objects
    case  GET_DIM_BITRANGE          : 
      items = CSLOmListExpr::cast(getChild(FUNCTION_PARAMS))->getItemsAsBase();
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmSignal::cast(m_scope->getParent())->getDimBitRange(CSLOmExpr::cast(items->at(ZERO))));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getDimBitRange(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope->getParent())->getDimBitRange(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }          
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getDimBitRange(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if(m_scope->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getDimBitRange(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope)->getDimBitRange(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the offset of the csl object
    case  GET_OFFSET                : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope->getParent())->getOffset();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope->getParent())->getOffset();
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getOffset();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmSignal::cast(m_scope)->getOffset();
            return m_cachedEval;
          }
          else if (m_scope->isSimpleBitRange()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(m_scope)->getOffset();
            return m_cachedEval;
          }
          else if (m_scope->isPort()) {
            m_cachedEval = CSLOmSimpleBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getOffset();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the offset of a dimension for multiple dimension csl objects
    case  GET_DIM_OFFSET            :       
      items = CSLOmListExpr::cast(getChild(FUNCTION_PARAMS))->getItemsAsBase();
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmExpr::cast(CSLOmSignal::cast(m_scope->getParent())->getDimOffset(CSLOmExpr::cast(items->at(ZERO))));
            return m_cachedEval;
          } 
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope->getParent())->getBitRange())->getDimOffset(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isMultiDimBitRange()) {
              m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope->getParent())->getDimOffset(CSLOmExpr::cast(items->at(ZERO)));
              return m_cachedEval;
          }          
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmExpr::cast(CSLOmSignal::cast(m_scope)->getDimOffset(CSLOmExpr::cast(items->at(ZERO))));
            return m_cachedEval;
          }
          else if(m_scope->isPort()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(CSLOmPortDecl::cast(m_scope)->getBitRange())->getDimOffset(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->isMultiDimBitRange()) {
            m_cachedEval = CSLOmMultiDimBitRange::cast(m_scope)->getDimOffset(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the number of dimensions for multiple dimension csl objects
    /*case  GET_NUMBER_OF_DIMENSIONS            :       
      items = CSLOmListExpr::cast(getChild(FUNCTION_PARAMS))->getItemsAsBase();
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEval = CSLOmExpr::cast(CSLOmSignal::cast(m_scope->getParent())->getNumberOfDimensions(CSLOmExpr::cast(items->at(ZERO))));
            return m_cachedEval;
          } 
          else if (m_scope->getParent()->isPort()) {
            m_cachedEval = CSLOmPortDecl::cast(m_scope->getParent())->getBitRange()->getNumberOfDimensions(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          }
          else if (m_scope->getParent()->isBitRange()) {
            if (CSLOmBitRange::cast(m_scope->getParent())->isMultiDimensional()) {
              m_cachedEval = CSLOmBitRange::cast(m_scope->getParent())->getNumberOfDimensions(CSLOmExpr::cast(items->at(ZERO)));
              return m_cachedEval;
            }
            else {
              return RefCSLOmBase();
            }
          }          
          else {
          return RefCSLOmBase();
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEval = CSLOmExpr::cast(CSLOmSignal::cast(m_scope)->getNumberOfDimensions(CSLOmExpr::cast(items->at(ZERO))));
            return m_cachedEval;
          }
          else if(m_scope->isPort()) {
            m_cachedEval = CSLOmPortDecl::cast(m_scope)->getBitRange()->getNumberOfDimensions(CSLOmExpr::cast(items->at(ZERO)));
            return m_cachedEval;
          } 
          else if (m_scope->isBitRange()) {
            if (CSLOmBitRange::cast(m_scope)->isMultiDimensional()) {
              m_cachedEval = CSLOmBitRange::cast(m_scope)->getNumberOfDimensions(CSLOmExpr::cast(items->at(ZERO)));
              return m_cachedEval;
            }
            else {
              return RefCSLOmBase();
            }
          } 
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

    //returns the csl_enum assigned to the csl_field
    case  GET_ENUM                  : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if (m_scope->getParent()->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope->getParent())->getEnum();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if (m_scope->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope)->getEnum();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the csl_enum assigned to the csl_field
    case  GET_VALUE                  : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if (m_scope->getParent()->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope->getParent())->getValue();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if (m_scope->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope)->getValue();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the value of the csl_field
    case  GET_ENUM_ITEM             : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if (m_scope->getParent()->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope->getParent())->getEnumItem();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else {
          if (m_scope->isField()) {
            m_cachedEval = CSLOmField::cast(m_scope)->getEnumItem();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the access rights for the csl_enum in a csl_memorymap
    case  GET_ACCESS_RIGHTS_ENUM    :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isMemoryMap()) {
            m_cachedEval = CSLOmMemoryMap::cast(m_scope->getParent())->getAccessRightsEnum();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isMemoryMap()) {
            m_cachedEval = CSLOmMemoryMap::cast(m_scope)->getAccessRightsEnum();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;
    
    //returns the address increment of a csl_memorymap_page
    case  GET_ADDR_INCREMENT        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope->getParent())->getAddressIncrement();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope)->getAddressIncrement();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the next address of a csl_memorymap_page
    case  GET_NEXT_ADDRESS        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope->getParent())->getNextAddress();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope)->getNextAddress();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the alignment of a csl_memorymap_page
    case  GET_ALIGMENT              :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope->getParent())->getAlignment();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope)->getAlignment();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the width of a data word of a csl_memorymap_page
    case  GET_DATA_WORD_WIDTH        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope->getParent())->getDataWordWidth();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope)->getDataWordWidth();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the length of a symbol assigned to a csl_memorymap_page
    case  GET_SYMBOL_LENGTH        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope->getParent())->getSymbolMaxLength();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isMemoryMapLocationPage()) {
            m_cachedEval = CSLOmMemoryMapPage::cast(m_scope)->getSymbolMaxLength();
            return m_cachedEval;
          }
          else {
            return RefCSLOmBase();
          }
        }
      }
      break;

    //returns the mnemonic of a csl_isaelement
      /*case  GET_ASM_MNEMONIC          :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isIsaElement()) {
            m_cachedEval = CSLOmIsaElement::cast(m_scope->getParent())->getMnemonic();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isIsaElement()) {
            m_cachedEval = CSLOmIsaElement::cast(m_scope)->getMnemonic();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

    //returns the mnemonic of a csl_isaelement
      /*case  GET_NAME          :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isIsaElement()) {
            m_cachedEval = CSLOmIsaElement::cast(m_scope->getParent())->getName();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isIsaElement()) {
            m_cachedEval = CSLOmIsaElement::cast(m_scope)->getName();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

    //returns the name of the file assigned to a csl_testbench
    /*case  GET_FILENAME        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getFilename();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getFilename();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

    //returns the value of a csl_signal assigned to a csl_testbench
    /*case  GET_SIGNAL_VALUE        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getSignalValue();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getSignalValue();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

    //returns the simulation timeout count assigned to a csl_testbench
    /*case  GET_SIMULATION_TIMEOUT_COUNT        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getSimulationTimeoutCount();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getSimulationTimeoutCount();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

    //returns the maximum count for errors assigned to a csl_testbench
    /*case  GET_MAX_ERROR_COUNT        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getMaxErrorCount();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getMaxErrorCount();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

    //returns the maximum number of states assigned to a csl_testbench
    /*case  GET_MAX_NUM_STATES        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getMaxNumStates();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getMaxNumStates();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/
    
    //returns the maximum number of vectors assigned to a csl_testbench
    /*case  GET_MAX_ERROR_COUNT        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getMaxNumVectors();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
        else{
          if(m_scope->isTestbenchDecl()) {
            m_cachedEval = CSLOmTestbenchInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getMaxNumVectors();
            return m_cachedEval;
          }
          else {
          return RefCSLOmBase();
          }
        }
      }
      break;*/

      /*case  GET_INTERFACE             : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isUnitDecl() ) {
            m_cachedEval = CSLOmInterface::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getDefaultInterfaceAsBase());
            return m_cachedEval;
          } else {
            DCERR( "CSLOmExprFuncSignature::doEval() get not supported for this scope" << std::endl);
          }
        }
        else {
          if(m_scope->isUnitDecl() ) {
            m_cachedEval = CSLOmInterface::cast(CSLOmUnitDecl::cast(m_scope)->getDefaultInterfaceAsBase());
            return m_cachedEval;
          } else {
            DCERR( "CSLOmExprFuncSignature::doEval() get not supported for this scope" << std::endl);
          }
        }
      }
      break;*/

    default                         : DCERR( "evaluation not implemented for this method" << std::endl);

  }
  return RefCSLOmExpr();
}

int CSLOmExprFuncSignature::doEnumEval(ECSLOmEnumType enumType) { 

  if (enumType != getEnumType()) {
    addErr(NSWarningErr::CSE_CSC_STMT_CSE_CSC_STMT_WRONG_EXPR_TYPE, args, getLineNumber(), getFileName());
    cslomHasErrors = TRUE;
    //add error with message: "wrong type expression"
    //addErr pls: "Type of the expression is not the expected one."
    return -1;
  }

  switch(m_funcName) {

    // returns the attributes of the object
    case  GET_ATTR                  : 
      if(m_scope.get()) {
        if(!m_scope->isID()) {
          if(m_scope->isSignal()) {
            m_cachedEnumEval = CSLOmSignal::cast(m_scope)->getSignalAttr();
            return m_cachedEnumEval;
          }
        }
        else {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEnumEval = CSLOmSignal::cast(m_scope->getParent())->getSignalAttr();
            return m_cachedEnumEval;
          }
        }
      }
      break;

    case  GET_RADIX                  : 
      if(m_scope.get()) {
        if(!m_scope->isID()) {
          if(m_scope->isVerifComp()) {
            m_cachedEnumEval = CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(m_scope)->getUnitInfo())->getRadix();
            return m_cachedEnumEval;
          }
        }
        else {
          if(m_scope->getParent()->isVerifComp()) {
            m_cachedEnumEval = CSLOmVerifCompInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getRadix();
            return m_cachedEnumEval;
          }
        }
      }
      break;

    // returns the types of the objects
    case  GET_TYPE                  : 
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isSignal()) {
            m_cachedEnumEval = CSLOmSignal::cast(m_scope->getParent())->getSignalType();
            return m_cachedEnumEval;
          }
          else if(m_scope->getParent()->isPort()) {
            m_cachedEnumEval = CSLOmPortDecl::cast(m_scope->getParent())->getPortType();
            return m_cachedEnumEval;
          }
          else if(m_scope->getParent()->isMemoryMap()) {
            m_cachedEnumEval = CSLOmMemoryMap::cast(m_scope->getParent())->getMemMapType();
            return m_cachedEnumEval;
          }
          else if(m_scope->getParent()->isRegister()) {
            m_cachedEnumEval = CSLOmRegDeclInfo::cast(CSLOmUnitDecl::cast(m_scope->getParent())->getUnitInfo())->getType();
              return m_cachedEnumEval;
          }
        }
        else {
          if(m_scope->isSignal()) {
            m_cachedEnumEval = CSLOmSignal::cast(m_scope)->getSignalType();
            return m_cachedEnumEval;
          }
          else if(m_scope->getParent()->isPort()) {
            m_cachedEnumEval = CSLOmPortDecl::cast(m_scope)->getPortType();
            return m_cachedEnumEval;
          }
          else if(m_scope->getParent()->isMemoryMap()) {
            m_cachedEnumEval = CSLOmMemoryMap::cast(m_scope)->getMemMapType();
            return m_cachedEnumEval;
          }
        }
      }
      break;


    //returns the endianess of a csl_memorymap_page
    case  GET_ENDIANESS        :
      if(m_scope.get()) {
        if(m_scope->isID()) {
          if(m_scope->getParent()->isMemoryMapLocationPage()) {
            m_cachedEnumEval = CSLOmMemoryMapPage::cast(m_scope->getParent())->getEndianess();
            return m_cachedEnumEval;
          }
          else {
            return -1;
          }
        }
        else{
          if(m_scope->isMemoryMapLocationPage()) {
            m_cachedEnumEval = CSLOmMemoryMapPage::cast(m_scope)->getEndianess();
            return m_cachedEnumEval;
          }
          else {
            return -1;
          }
        }
      }
      break;


    default                         : DCERR( "evaluation not implemented for this method" << std::endl);
  }

  return ZERO;
}

ECSLOmEnumType CSLOmExprFuncSignature::getEnumType() const {
  switch(m_funcName) {
    case GET_ATTR:      return ENUM_TYPE_ATTR;             break;
    case GET_TYPE:      return ENUM_TYPE_TYPE;             break;
    case GET_ENUM:      return ENUM_TYPE_ACCESS;           break;
    case GET_RADIX:     return ENUM_TYPE_VSD_RADIX;        break;
    default:            return ENUM_TYPE_BASE;
  }
}

void CSLOmExprFuncSignature::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(CSLOmExprFuncSignature::cast(getThis()));
}

const TBool CSLOmExprFuncSignature::isEvaluated() const {
  return m_isEvaluated;
}

RefCSLOmBase CSLOmExprFuncSignature::getScope() const {
  return m_scope;
}

void CSLOmExprFuncSignature::setScope(RefCSLOmBase scope) {
  m_scope = scope;
}

RefCSLOmExpr CSLOmExprFuncSignature::dupp() {
  RefCSLOmExpr expr = build(m_lineNumber, m_fileName, m_funcName, getChild(0).get() ? CSLOmListExpr::cast(CSLOmListExpr::cast(getChild(0))->dupp()) : RefCSLOmListExpr());
  CSLOmExprFuncSignature::cast(expr)->m_portDirection = m_portDirection;
  return expr;
}

// ********************************************************************************
// CSLOmNumber class
// ********************************************************************************
CSLOmNumber::CSLOmNumber(TLineNumberType lineNumber, RefString fileName, ENumBaseType numBaseType, const RefString& tokenString, const RefCVeriNum& veriNum) : 
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_NUMBER), 
  m_tokenString(tokenString),
  //  m_veriNum(veriNum),
  m_numBaseType(numBaseType),
  m_numType(NUM_UNDEFINED),
  m_overflow      (FALSE),
  m_hasXZ         (FALSE),
  m_isConst       (TRUE),
  m_isSigned      (TRUE),
  m_isEvaluated   (TRUE),
  m_isTrunkated   (FALSE),
  m_isRounded     (FALSE),
  m_width         (0),
  m_noOfBitsTrunk (0),
  m_noOfBitsRound (0) { }

RefCSLOmNumber CSLOmNumber::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmNumber();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    RefCSLOmExpr obj = boost::static_pointer_cast<CSLOmExpr>(object);
    ASSERT(obj->isNumber(), "type mismatch");
    return boost::static_pointer_cast<CSLOmNumber>(obj);
  }
}

CSLOmNumber::CSLOmNumber(TLineNumberType lineNumber, RefString fileName, ENumType numType, ENumBaseType numBaseType, TBool hasXZ) : 
  CSLOmExpr(lineNumber,fileName, CSLOmExpr::EXPR_NUMBER), 
  m_numBaseType(numBaseType),  
  m_numType(numType), 
  m_overflow(FALSE), 
  m_hasXZ(hasXZ), 
  m_isConst(TRUE), 
  m_isEvaluated(FALSE), 
  m_isTrunkated(FALSE), 
  m_isRounded(FALSE), 
  m_width(ZERO), 
  m_noOfBitsTrunk(ZERO), 
  m_noOfBitsRound(ZERO) { }

/**
 * This is the csl_number build method. According to csl_number specification we create a 
 * generic variable that becomes specific as we perform commands on the variable
 */
RefCSLOmNumber CSLOmNumber::build(TLineNumberType lineNumber, RefString fileName, ENumBaseType numBaseType, const RefString& tokenString, const RefString& lightString, TInt width, TBool hasXZ) {
  ASSERT(lightString.get(), "null lightString received");
  ASSERT(lightString->length(), "empty lightString received");

  RefCSLOmNumber num = CSLOmNum32::build(lineNumber,fileName, numBaseType, lightString, width);
  num->m_tokenString = tokenString;
  return num;
}

const CSLOmNumber::ENumType CSLOmNumber::getNumType() const {
  return m_numType;
}

const TBool CSLOmNumber::getOverflow() const {
  return m_overflow;
}

const TBool CSLOmNumber::hasXZ() const {
  return m_hasXZ;
}

TBool CSLOmNumber::isConst() const {
  return m_isConst;
}

const TBool CSLOmNumber::isEvaluated() const {
  return m_isEvaluated;
}

const TBool CSLOmNumber::isTrunkated() const {
  return m_isTrunkated;
}

const TBool CSLOmNumber::isRounded() const {
  return m_isRounded;
}

const TInt CSLOmNumber::getWidth() const {
  return m_width;
}

const TInt CSLOmNumber::getNoOfBitsTrunk() const {
  return m_noOfBitsTrunk;
}

const TInt CSLOmNumber::getNoOfBitsRound() const {
  return m_noOfBitsRound;
}

void CSLOmNumber::setNumType(CSLOmNumber::ENumType numType) {
  m_numType = numType;
}

void CSLOmNumber::setOverflow(TBool overflow) {
  m_overflow = overflow;
}

void CSLOmNumber::setHasXZ(TBool hasXZ) {
  m_hasXZ = hasXZ;
}

void CSLOmNumber::setIsConst(TBool isConst) {
  m_isConst = isConst;
}

void CSLOmNumber::setIsEvaluated(TBool isEvaluated) {
  m_isEvaluated = isEvaluated;
}

void CSLOmNumber::setIsTrunkated(TBool isTrunkated) {
  m_isTrunkated = isTrunkated;
}

void CSLOmNumber::setIsRounded(TBool isRounded) {
  m_isRounded = isRounded;
}

void CSLOmNumber::setWidth(TInt width) {
  m_width = width;
}

void CSLOmNumber::setNoOfBitsTrunk(TInt noOfBitsTrunk) {
  m_noOfBitsTrunk = noOfBitsTrunk;
}

void CSLOmNumber::setNoOfBitsRound(TInt noOfBitsRound) {
  m_noOfBitsRound = noOfBitsRound;
}

/**
 * Returns if number is signed.
 */
//TODO figure out how to do this for all numerics type
const TBool CSLOmNumber::isSigned() const {
  return m_isSigned;
}

/**
 * Returns size of number
 */
//TODO this should be virtual and implemented in all numeric classes
TInt CSLOmNumber::getSize() const {
  return ZERO;
}

/**
 * Returns the base in which the number is represented
 */

CSLOmNumber::ENumBaseType CSLOmNumber::getNumBaseType() const {
  return m_numBaseType;
}

const RefString CSLOmNumber::getTokenString() const {
  return m_tokenString;
}

/**
 * Returns the verilog number that corespondes to current number
 */

// RefCVeriNum CSLOmNumber::getVeriNum() const {
//   return m_veriNum;
// }

// void CSLOmNumber::setVeriNum(RefCVeriNum veriNum) {
//   (*m_veriNum) = (*veriNum);
// }

RefTMap_RefCSLOmUnitInstance_RefCSLOmBase CSLOmNumber::doParamEval(RefCSLOmBase evalFor) {
  RefTMap_RefCSLOmUnitInstance_RefCSLOmBase temp = RefTMap_RefCSLOmUnitInstance_RefCSLOmBase(new TMap_RefCSLOmUnitInstance_RefCSLOmBase);
  temp->insert(std::make_pair(RefCSLOmUnitInstance(), getThis()));
  return temp;
}

/**
 * Eval the number as an expr
 */
RefCSLOmBase CSLOmNumber::doEval(TBool convertEnumItem) {
  return getThis();
}

// ********************************************************************************
// CSLOmNum32 class
// ********************************************************************************
CSLOmNum32::CSLOmNum32(TLineNumberType lineNumber, RefString fileName, CSLOmNumber::ENumBaseType base, const TInt value)
  : CSLOmNumber(lineNumber,fileName, CSLOmNumber::NUM_INT32, base), m_value(value) { }

RefCSLOmNum32 CSLOmNum32::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmNum32();
  }
  else {
    ASSERT(object->isExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmNum32>(object);
  }
}

const TInt CSLOmNum32::maxWidth = sizeof(TInt)*8;
RefCSLOmNum32 CSLOmNum32::build(TLineNumberType lineNumber, RefString fileName, TInt value) {

  CSLOmNum32 *number;
  try {
    number = new CSLOmNum32(lineNumber,fileName, CSLOmNumber::NUM_BASE_DEC, value);
  }
  catch (std::exception& e) {
    ASSERT(ZERO,"new operator failed");
  }


  RefCSLOmNum32 refNumber = RefCSLOmNum32(number);
  number->m_weakRef = boost::weak_ptr<CSLOmBase>( refNumber);
  number->m_width = number->calcWidth();
  std::stringstream ss;
  ss << number->m_value;
  number->m_tokenString = RefString(new std::string(ss.str()));
  number->setIsEvaluated(TRUE);
  return refNumber;
}

RefCSLOmNum32 CSLOmNum32::build(TLineNumberType lineNumber, RefString fileName, CSLOmNumber::ENumBaseType base, RefString num, TInt width) {
  TInt value;
  if(num->length() >= 10 ) {
    value = 0;
    DCERR("WARNING: This is a number bigger that the numbers supported by cslc 1.0. This should be an error from the parser (replaced value by 0).")
  }
  else {
    value = CSLOmNum32::converter(base, num);
  }

  CSLOmNum32 *number;
  try {
    number = new CSLOmNum32(lineNumber,fileName, base, value);
  }
  catch (std::exception& e) {
    ASSERT(ZERO,"new operator failed");
  }

  RefCSLOmNum32 refNumber = RefCSLOmNum32(number);
  number->m_weakRef = boost::weak_ptr<CSLOmBase>( refNumber);
  if (width) {
    if (width < number->calcWidth()) {
      DCERR("WARNING: here we must add a warning; number has user set width smaller the the number is represented on.");    
    }
    number->m_width = width;
  }
  else {
    number->m_width = number->calcWidth();
  }
  number->m_tokenString = num;
  number->setIsEvaluated(TRUE);
  return refNumber;
}

TInt CSLOmNum32::converter(CSLOmNumber::ENumBaseType base, RefString number) {
  std::istringstream in(*number);
  TInt aux;
  switch(base) {
    case NUM_BASE_BIN: aux = strtol(number->c_str(),NULL,2); break;
    case NUM_BASE_OCT: in >> std::oct >> aux; break;
    case NUM_BASE_DEC: in >> std::dec >> aux; break;
    case NUM_BASE_HEX: in >> std::hex >> aux; break;
    default: {
      // args.push_back("number creation");
      //       addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, getThis()->getLineNumber());
      cslomHasErrors = TRUE;
      throw NSBase::IllegalArgumentException("bad base");
    }
  }

  return aux;
}

const TInt CSLOmNum32::getValue() const {
  return m_value;
}

void CSLOmNum32::setValue(TInt value) {
  m_value = value;
  m_width = calcWidth();
  m_tokenString = ltos(value);
  setIsEvaluated(TRUE);
}

void CSLOmNum32::changeSign() {
  m_value *= -1;
}

TInt CSLOmNum32::calcWidth() {
  TInt value = m_value;
  TInt val = 1<<(maxWidth/2);
  TInt width = maxWidth/2;
  TInt retWidth = maxWidth/2;
  if (value<ZERO) {
    value*=-1;
    retWidth+=1;
  }
  while (width!=ZERO) {
    width/=2;
    if (value < val) {
      retWidth-=width;
      val = val>>width;
    }
    else if (value > val) {
      retWidth+=width;
      val = val<<width;
    }
    else if (value == val) {
      return retWidth+1;
    }
  }
  if (val>value) {
    return retWidth;
  }
  else {
    return retWidth+1;       
  }
}

TBool CSLOmNum32::equals(TInt value) { 
  return value==m_value;
}

RefCSLOmNumber CSLOmNum32::maxValue() {
  return CSLOmNum32::build(m_lineNumber,m_fileName, (1<<m_width)-1);
}

RefCSLOmNumber CSLOmNum32::plus() {
  return CSLOmNum32::build(m_lineNumber, m_fileName,m_value);//CSLOmNum32::cast(number)->getValue()+m_value); 
}

RefCSLOmNumber CSLOmNum32::minus() {
  return CSLOmNum32::build(m_lineNumber,m_fileName, m_value * (-1));//CSLOmNum32::cast(number)->getValue()+m_value); 
}

RefCSLOmNumber CSLOmNum32::logicNot() {
  return CSLOmNum32::build(m_lineNumber,m_fileName, !m_value);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::bitwiseNot() {
  return CSLOmNum32::build(m_lineNumber,m_fileName, ~m_value);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::reductionAnd() {
  TInt val,result = 1;
  val = m_value;
  for(int i = ZERO; i < m_width; i++) {
    val = val >> 1;
    result &= val;
  }
  return CSLOmNum32::build(m_lineNumber,m_fileName, result);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::reductionNand() {
  TInt val,result = 1;
  val = m_value;
  for(int i = ZERO; i < m_width; i++) {
    val = val >> 1;
    result &= val;
  }
  return CSLOmNum32::build(m_lineNumber,m_fileName, !result);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::reductionOr() {
  TInt val,result = 1;
  val = m_value;
  for(int i = ZERO; i < m_width; i++) {
    val = val >> 1;
    result |= val;
  }
  return CSLOmNum32::build(m_lineNumber,m_fileName, result);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::reductionNor() {
  TInt val,result = 1;
  val = m_value;
  for(int i = ZERO; i < m_width; i++) {
    val = val >> 1;
    result |= val;
  }
  return CSLOmNum32::build(m_lineNumber,m_fileName, !result);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::reductionXor() {
  TInt val,result = 1;
  val = m_value;
  for(int i = ZERO; i < m_width; i++) {
    val = val >> 1;
    result ^= val;
  }
  return CSLOmNum32::build(m_lineNumber,m_fileName, result);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::reductionXnor() {
  TInt val,result = 1;
  val = m_value;
  for(int i = ZERO; i < m_width; i++) {
    val = val >> 1;
    result ^= val;
  }
  return CSLOmNum32::build(m_lineNumber,m_fileName, !result);//CSLOmNum32::cast(number)->getValue()+m_value);   
}

RefCSLOmNumber CSLOmNum32::add(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, num32->getValue()+m_value);//CSLOmNum32::cast(number)->getValue()+m_value); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::substract(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value-(num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::multiply(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32: return CSLOmNum32::build(m_lineNumber,m_fileName, m_value*(num32->getValue()));   break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::divide(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value/ (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::modulo(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value% (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::power(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, (int)pow((float)m_value, (num32->getValue())));//TODO: return NUM_BIGNUM double
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::shiftLeft(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value << (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::shiftRight(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value >> (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::equality(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32: {
      if(m_value == num32->getValue()) {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ONE);//(CSLOmNum32::cast(number)->getValue())); 
      } else {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ZERO);//(CSLOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::notEquality(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32: {
      if(m_value != num32->getValue()) {
        return CSLOmNum32::build(m_lineNumber, m_fileName,ONE);//(CSLOmNum32::cast(number)->getValue())); 
      } else {
        return CSLOmNum32::build(m_lineNumber, m_fileName, ZERO);//(CSLOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::equalityEqualCase(RefCSLOmNumber number) {
  //TODO: verinum equality operation
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::equalityNotEqualCase(RefCSLOmNumber number) {
  //TODO: verinum equality operation
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::logicAnd(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value && (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::logicOr(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber, m_fileName, m_value || (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::relationalLess(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32: {
      if(m_value < num32->getValue()) {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ONE);//(CSLOmNum32::cast(number)->getValue())); 
      } else {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ZERO);//(CSLOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::relationalLessEqual(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32: {
      if(m_value <= num32->getValue()) {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ONE);//(CSLOmNum32::cast(number)->getValue())); 
      } else {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ZERO);//(CSLOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::relationalGreater(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32: {
      if(m_value > num32->getValue()) {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ONE);//(CSLOmNum32::cast(number)->getValue())); 
      } else {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ZERO);//(CSLOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::relationalGreaterEqual(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32: {
      if(m_value >= num32->getValue()) {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ONE);//(CSLOmNum32::cast(number)->getValue())); 
      } else {
        return CSLOmNum32::build(m_lineNumber,m_fileName, ZERO);//(CSLOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::bitwiseAnd(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value & (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::bitwiseNand(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, ~(m_value & (num32->getValue())));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::bitwiseOr(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value | (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::bitwiseNor(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, ~(m_value | (num32->getValue())));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::bitwiseXor(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value ^ (num32->getValue()));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::bitwiseXnor(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, ~(m_value ^ (num32->getValue())));//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::binaryShiftLeft(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value << num32->getValue());//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::binaryShiftRight(RefCSLOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CSLOmNumber::NUM_INT32:  
      return CSLOmNum32::build(m_lineNumber,m_fileName, m_value >> num32->getValue());//(CSLOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(FAIL, "not implemented yet");
  }
  return RefCSLOmNumber();
}

RefCSLOmNumber CSLOmNum32::ternaryCondition(RefCSLOmNumber number1, RefCSLOmNumber number2) {
  ASSERT(number1.get(), "null pointer received");
  ASSERT(number1->isEvaluated(), "number should already be evaluated");
  ASSERT(number2.get(), "null pointer received");
  ASSERT(number2->isEvaluated(), "number should already be evaluated");

  RefCSLOmNum32 num32_1 = cast(number1);
  RefCSLOmNum32 num32_2 = cast(number2);
  if(m_value) {
    switch(number1->getNumType()) {
      case CSLOmNumber::NUM_INT32:
        return CSLOmNum32::build(m_lineNumber,m_fileName, num32_1->getValue());//(CSLOmNum32::cast(number)->getValue())); 
        break;
      default:   ASSERT(FAIL, "not implemented yet");
    }
  } else {
    switch(number1->getNumType()) {
      case CSLOmNumber::NUM_INT32:
        return CSLOmNum32::build(m_lineNumber,m_fileName, num32_2->getValue());//(CSLOmNum32::cast(number)->getValue())); 
        break;
      default:   ASSERT(FAIL, "not implemented yet");
    }
  }
  return RefCSLOmNumber();
}

void CSLOmNum32::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

RefCSLOmExpr CSLOmNum32::dupp() {
  RefCSLOmExpr expr = build(m_lineNumber, m_fileName, getValue());
  CSLOmNum32::cast(expr)->m_width = m_width;
  CSLOmNum32::cast(expr)->m_numBaseType = m_numBaseType;
  return expr;
}

// ********************************************************************************
// CSLOmListExpr class
// ********************************************************************************
 CSLOmListExpr::CSLOmListExpr( TLineNumberType lineNumber, RefString fileName) : 
   CSLOmBase( TYPE_LIST_EXPR, lineNumber, fileName) {}

RefCSLOmListExpr CSLOmListExpr::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmListExpr();
  }
  else {
    ASSERT(object->isListExpr() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmListExpr>(object);
  }
}

RefCSLOmListExpr CSLOmListExpr::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmExpr exprItem ) {
  CSLOmListExpr *listExpr;
  try {
    listExpr = new CSLOmListExpr(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmListExpr refListExpr (listExpr);
  listExpr->m_weakRef = boost::weak_ptr<CSLOmBase>( refListExpr);
  listExpr->addItem(exprItem);
  return refListExpr;
}
 
void CSLOmListExpr::addItem(RefCSLOmExpr exprItem){
  ASSERT(exprItem.get(), "null exprItem received");
  exprItem->setParent(getThis());
}

const RefTVec_RefCSLOmExpr CSLOmListExpr::getItems() const {
  return getChildren<CSLOmExpr>(TYPE_EXPR);
}

const RefTVec_RefCSLOmBase CSLOmListExpr::getItemsAsBase() const {
  return getChildrenAsBase(TYPE_EXPR);
}

const TUInt CSLOmListExpr::getNumberOfChildren() const {
  return getChildrenVec()->size();
}

void CSLOmListExpr::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(CSLOmListExpr::cast(getThis()));
}

RefCSLOmListExpr CSLOmListExpr::dupp() {
  RefCSLOmListExpr expr = build(m_lineNumber, m_fileName, CSLOmExpr::cast(getChild(0))->dupp());
  for (TInt i = 1; i < getChildrenSize() ; ++i) {
    CSLOmExpr::cast(getChild(i))->dupp()->setParent(expr);
  }
  return expr;
}
/**********************************************************************************
 **CSLOmVeriNum class
 **********************************************************************************
 */

//instantiation-related functions
CSLOmVeriNum::CSLOmVeriNum( TLineNumberType lineNumber, RefString fileName, RefString numString, TInt width, CSLOmNumber::ENumBaseType baseType, TBool isSigned, TBool hasXZ )
  : CSLOmNumber( lineNumber, fileName, CSLOmNumber::NUM_VERINUM, baseType, hasXZ ),
    m_numString( numString ) {
  m_width    = width;
  m_isSigned = isSigned;
}

RefCSLOmVeriNum CSLOmVeriNum::build( TLineNumberType lineNumber, RefString fileName, RefString numberString, TInt width, CSLOmNumber::ENumBaseType baseType, TBool isSigned, TBool hasXZ ) {
  CSLOmVeriNum *val;
  try {
    val = new CSLOmVeriNum( lineNumber, fileName, numberString, width, baseType, isSigned, hasXZ );
  }
  catch( std::exception& e) {
    ASSERT(ZERO, "new operator failed");
  }
  RefCSLOmVeriNum refVal = RefCSLOmVeriNum( val );
  refVal->m_weakRef = boost::weak_ptr< CSLOmBase >( refVal );
  return refVal;
}

RefCSLOmExpr CSLOmVeriNum::dupp() {
  return CSLOmVeriNum::build( m_lineNumber, m_fileName, m_numString, m_width, m_numBaseType, m_isSigned, m_hasXZ ); 
}

//value-manipulation functions
RefString CSLOmVeriNum::getNumString() {
  return m_numString;
}

void CSLOmVeriNum::setNumString( RefString numString ) {
  m_numString = numString;
}

//minimally-implemented pure virtual functions from base class

void CSLOmVeriNum::changeSign() {
}
TBool CSLOmVeriNum::equals(TInt value) {
  return FALSE;
}
TInt CSLOmVeriNum::calcWidth() {
  return 0;
}

RefCSLOmNumber CSLOmVeriNum::maxValue() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::plus() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::minus() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::logicNot() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::bitwiseNot() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::reductionAnd() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::reductionNand() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::reductionOr() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::reductionNor() {
  return RefCSLOmNumber(); 
}
RefCSLOmNumber CSLOmVeriNum::reductionXor() {
  return RefCSLOmNumber(); }
 

RefCSLOmNumber CSLOmVeriNum::reductionXnor() {
  return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::add(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::substract(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::multiply(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::divide(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::modulo(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::power(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::shiftLeft(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::shiftRight(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::equality(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::notEquality(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::equalityEqualCase(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::equalityNotEqualCase(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::logicAnd(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::logicOr(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::relationalLess(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::relationalLessEqual(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::relationalGreater(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::relationalGreaterEqual(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::bitwiseAnd(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::bitwiseNand(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::bitwiseOr(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::bitwiseNor(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::bitwiseXor(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::bitwiseXnor(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::binaryShiftLeft(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::binaryShiftRight(RefCSLOmNumber oper1) {
 return RefCSLOmNumber(); 
}

RefCSLOmNumber CSLOmVeriNum::ternaryCondition(RefCSLOmNumber oper1, RefCSLOmNumber oper2) {
 return RefCSLOmNumber();
}


//visitor
void CSLOmVeriNum::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


} //end namespace NSCSLOm
