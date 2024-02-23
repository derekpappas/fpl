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

const std::string ISA_FLD_CONSTRUCT("csl_isa_field constructor");
// ********************************************************************************
// CSLOmIsaField class
// ********************************************************************************
 CSLOmIsaField::CSLOmIsaField(TLineNumberType lineNumber, RefString fileName, CSLOmField::ECSLOmFieldType type):
   CSLOmField(lineNumber,fileName, type, FIELD_ISA_FIELD) ,
  m_mnemonic()                       ,
  m_name()                           ,
  m_isaFieldType(ISA_FIELD_UNDEFINED){}

RefCSLOmIsaField CSLOmIsaField::cast( RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmIsaField();
  } 
  else {
    ASSERT(object->isIsaField(), "type check on cast failure");
    return boost::static_pointer_cast<CSLOmIsaField>(object);
  }
}

RefCSLOmIsaField CSLOmIsaField::allocate( TLineNumberType    lineNumber,
                                          RefString          fileName,
                                          RefCSLOmBase       parent    ,
                                          const RefString&   name      ) {

  ASSERT(name.get(), "null name received");
  ASSERT(!name->empty(), "empty name received");
  ASSERT(parent.get(), "null parent received");

  CSLOmIsaField *isafield;
  try {
    isafield = new CSLOmIsaField(lineNumber,fileName, FIELD_UNDEFINED);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmIsaField refIsaField(isafield);
  isafield->m_weakRef = boost::weak_ptr<CSLOmBase>( refIsaField);
  if (parent->isIsaField()) {
    RefCSLOmIsaField hIsaField = CSLOmIsaField::cast(parent);
    if (hIsaField->getFieldType() == FIELD_UNDEFINED) {
      hIsaField->m_fieldType = FIELD_HIERARCHICAL;
      hIsaField->m_fieldPositions = RefTVec_RefCSLOmField(new TVec_RefCSLOmField);
    }
    if (hIsaField->getFieldType() != FIELD_HIERARCHICAL) {
      args.push_back(ISA_FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaField();
    }
    hIsaField->m_isUpdated = FALSE;
  }
  isafield->setParent(parent);

  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refIsaField, CSLOmIdentifier::ID_FIELD, name);
  isafield->m_scope = CSLOmScope::build(id);
  RefCSLOmNum32 offset = CSLOmNum32::build(lineNumber,fileName, 0);
  offset->setParent(refIsaField);

  RefCSLOmNum32 lower = CSLOmNum32::build(lineNumber,fileName, 0);
  RefCSLOmNum32 upper = CSLOmNum32::build(lineNumber,fileName, 0);
  lower->setParent(refIsaField);
  upper->setParent(refIsaField);
  isafield->m_isDefault = TRUE;

  RefCSLOmContainer allowed = CSLOmContainer::build(lineNumber,fileName, TYPE_ADDRESS_RANGE);
  allowed->setParent(refIsaField);

  return refIsaField; 
}

 RefCSLOmIsaField CSLOmIsaField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExprLink enumItemOrEnum) {
  ASSERT(name.get(), "null name received");
  ASSERT(!name->empty(), "empty name received");
  ASSERT(parent.get(), "null parent received");

  RefCSLOmIsaField isafield = RefCSLOmIsaField();
  if (enumItemOrEnum.get()) {

    RefCSLOmBase evaled = enumItemOrEnum->doEval();
    if (!evaled.get()) {
      args.push_back("csl_isa_field constructor");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaField();
    }
    if (evaled->isIsaField()) {
      return CSLOmIsaField::build(lineNumber,fileName, parent, name, CSLOmIsaField::cast(evaled));
    }
    else {
      isafield = allocate(lineNumber,fileName, parent, name);
    }
    if (!evaled->isEnum() && !evaled->isEnumItem()) {
      args.push_back("csl_isa_field constructor");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaField();
    }
    else {
      enumItemOrEnum->setParent(isafield);
      if (evaled->isEnum()) {
        isafield->m_fieldType = FIELD_ENUM;
      }
      else if (evaled->isEnumItem()){
        isafield->m_fieldType = FIELD_ENUM_ITEM;
      }
      else {
        // do nothing
      }
    }
  }
  else {
    isafield = allocate(lineNumber,fileName, parent, name);
  }
  DCERR("WARNING: calculate the width of the isafield from the enum/enumItem values/value isafield build!!"<<std::endl);
  return isafield;
}

 RefCSLOmIsaField CSLOmIsaField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr widthOrBr, RefCSLOmExprLink enumItemOrEnum) {
  ASSERT(name.get(), "null name received");
  ASSERT(!name->empty(), "empty name received");
  ASSERT(parent.get(), "null parent received");
  ASSERT(widthOrBr.get(), "null widthOrBr received");

  RefCSLOmBase brEval = widthOrBr->doEval(TRUE);
  if (brEval->isExpr() && CSLOmExpr::cast(brEval)->isNumber() && CSLOmNumber::cast(brEval)->getValue() <= 0) {
    args.push_back(ISA_FLD_CONSTRUCT);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmIsaField();
  }
  else if (!brEval->isBitRange() && !brEval->isNumber()) {
    args.push_back(ISA_FLD_CONSTRUCT);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmIsaField();
  }

  RefCSLOmIsaField isafield = allocate(lineNumber,fileName, parent, name);
  ASSERT(brEval.get(),"null evaluation");
  if (brEval->isExpr() && CSLOmExpr::cast(brEval)->isNumber()) {
    isafield->setWidth(CSLOmNumber::cast(brEval));
  }
  else if (brEval->isBitRange()){
    isafield->setBitRange(CSLOmSimpleBitRange::cast(brEval));
  }

  if (enumItemOrEnum.get()) {
    RefCSLOmBase evaled = enumItemOrEnum->doEval();
    if (!evaled.get()) {
      args.push_back(ISA_FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaField();
    }
    else if (!evaled->isEnum() && !evaled->isEnumItem()) {
      args.push_back(ISA_FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaField();
    }
    else {
      enumItemOrEnum->setParent(isafield);
      if (evaled->isEnum()) {
        isafield->m_fieldType = FIELD_ENUM;
      }
      else if (evaled->isEnumItem()){
        isafield->m_fieldType = FIELD_ENUM_ITEM;
      }
      else {
        // do nothing
      }
    }
  }
  return isafield;
}

RefCSLOmIsaField CSLOmIsaField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmExpr low, RefCSLOmExpr up, RefCSLOmExprLink enumItemOrEnum) {
  ASSERT(name.get(), "null name received");
  ASSERT(!name->empty(), "empty name received");
  ASSERT(parent.get(), "null parent received");
  ASSERT(low.get(),"null low received");
  ASSERT(up.get(),"null up received");

  RefCSLOmIsaField isafield = allocate(lineNumber,fileName, parent, name);
  RefCSLOmBase lower = low->doEval(TRUE);
  RefCSLOmBase upper = up->doEval(TRUE);

  if (!lower.get()) {
    args.push_back(ISA_FLD_CONSTRUCT);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmIsaField();
  }
  if (!upper.get()) {
    args.push_back(ISA_FLD_CONSTRUCT);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmIsaField();
  }



  if ((lower->isExpr() && CSLOmExpr::cast(lower)->isNumber()) &&
      (upper->isExpr() && CSLOmExpr::cast(upper)->isNumber())) {
    isafield->setRange(CSLOmNumber::cast(lower), CSLOmNumber::cast(upper));
  }
  else if ((lower->isExpr() && CSLOmExpr::cast(lower)->isNumber()) &&
           (upper->isEnum())) {
    isafield->setWidth(CSLOmNumber::cast(lower));
    isafield->setEnum(CSLOmEnum::cast(upper));
  }
  else {
    args.push_back(ISA_FLD_CONSTRUCT);
    addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
    cslomHasErrors = TRUE;
    return RefCSLOmIsaField();
  }

  if (enumItemOrEnum.get()) {
    RefCSLOmBase evaled = enumItemOrEnum->doEval();
    if (!evaled.get()) {
      args.push_back(ISA_FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaField();
    }
    if (!evaled->isEnum() && !evaled->isEnumItem()) {
      args.push_back(ISA_FLD_CONSTRUCT);
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaField();
    }
    else {
      enumItemOrEnum->setParent(isafield);
      if (evaled->isEnum()) {
        isafield->m_fieldType = FIELD_ENUM;
      }
      else if (evaled->isEnumItem()){
        isafield->m_fieldType = FIELD_ENUM_ITEM;
      }
      else {
        // do nothing
      }
    }
  }
  return isafield;

}

RefCSLOmIsaField CSLOmIsaField::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmIsaField sourceIsaField) {
  ASSERT(name.get(), "null name received");
  ASSERT(!name->empty(), "empty name received");
  ASSERT(parent.get(), "null parent received");
  ASSERT(sourceIsaField.get(), "null isafield received");
  
  RefCSLOmIsaField isafield = allocate(lineNumber,fileName, parent, name);
  RefCSLOmNumber offset = CSLOmNum32::build(lineNumber, fileName,ZERO);
  RefCSLOmNumber lower  = CSLOmNum32::build(lineNumber, fileName,ZERO);
  RefCSLOmNumber upper  = CSLOmNum32::build(lineNumber, fileName,ZERO);

  offset = offset->add(CSLOmNumber::cast(sourceIsaField->getOffset()->doEval())); 
  if (!sourceIsaField->isDefault()) {
    lower  = lower->add(CSLOmNumber::cast(sourceIsaField->getLower()->doEval())); 
  }
  if (!sourceIsaField->isDefault()) {
    upper  = upper->add(CSLOmNumber::cast(sourceIsaField->getUpper()->doEval())); 
  }

  isafield->setOffset(offset);
  if (!sourceIsaField->isDefault()) {
    isafield->setRange(lower, upper);
  }
  isafield->m_fieldType = sourceIsaField->m_fieldType;
  if (isafield->isHierarchical()) {
    isafield->m_fieldPositions = RefTVec_RefCSLOmField(new TVec_RefCSLOmField);
  }
  if (sourceIsaField->getParent()->isField() && CSLOmField::cast(sourceIsaField->getParent())->isHierarchical() && CSLOmField::cast(sourceIsaField->getParent())->getFieldPosition(sourceIsaField) != -1) {
    CSLOmField::cast(parent)->setFieldPosition(isafield, CSLOmNum32::build(lineNumber, fileName, CSLOmField::cast(sourceIsaField->getParent())->getFieldPosition(sourceIsaField)));
  }
  if (sourceIsaField->m_fieldType == FIELD_HIERARCHICAL) {
    RefTVec_RefCSLOmBase children = sourceIsaField->getFields();
    TVec_RefCSLOmBase::iterator it;
    for(it = children->begin(); it < children->end(); ++it) {
      CSLOmIsaField::build(sourceIsaField->m_lineNumber,sourceIsaField->m_fileName, isafield, CSLOmIdentifier::cast(CSLOmIsaField::cast(*it)->getChild(ID))->getName(), CSLOmIsaField::cast(*it));
    }
  }
  else if (sourceIsaField->m_fieldType == FIELD_ENUM) {
    RefCSLOmEnum en = CSLOmEnum::cast(sourceIsaField->getEnum());
    RefCSLOmIdentifier id = CSLOmIdentifier::cast(en->getChild(ID));
    RefString name = id->getName();
    RefCSLOmExprLink expr = CSLOmExprLink::build(lineNumber,fileName, name);
    expr->setValue(sourceIsaField->getEnum());
    expr->setParent(isafield);
    isafield->m_isInstance = TRUE;
  }
  else if (sourceIsaField->m_fieldType == FIELD_ENUM_ITEM) {
    RefCSLOmExprLink expr = CSLOmExprLink::build(lineNumber,fileName, CSLOmExprLink::cast(sourceIsaField->getChild(FIELD_POS_ENUM_ITEM))->getName());
    expr->setValue(sourceIsaField->getEnumItem());
    expr->setParent(isafield);
  }
  else if (sourceIsaField->m_fieldType == FIELD_VALUE) {
    isafield->setValue(CSLOmNumber::cast(sourceIsaField->getValue()));
  }
  isafield->setIsaFieldType(sourceIsaField->getIsaFieldType());
  
  return isafield;
}

void CSLOmIsaField::setName(RefString name) {
  m_name = name;
}

void CSLOmIsaField::setMnemonic(RefString abr) {
  m_mnemonic = abr;
}

void CSLOmIsaField::setIsaFieldType(ECSLOmIsaFieldType type) {
  m_isaFieldType = type;

  //for design checker
  m_mandatoryCounter++;
}

RefString CSLOmIsaField::getName() {
  return m_name;
}

RefString CSLOmIsaField::getMnemonic() {
  return m_mnemonic;
}

CSLOmIsaField::ECSLOmIsaFieldType CSLOmIsaField::getIsaFieldType() {
  return m_isaFieldType;
}
void CSLOmIsaField::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmIsaElement class
// ********************************************************************************
CSLOmIsaElement::CSLOmIsaElement(TLineNumberType lineNumber, RefString fileName) :
  CSLOmField(lineNumber,fileName, FIELD_HIERARCHICAL, FIELD_ISA_ELEMENT),
  m_registeredEnums(),
  m_registeredEnumItems(),
  m_isaElemType(ISA_ELEM_UNDEFINED),
  m_sourceType(ISA_ELEM_UNDEFINED),
  m_shouldBeRoot(FALSE),
  m_cannotBeInstr(FALSE),
  m_isaParent(),
  m_isaChildren() { 
  m_fieldPositions = RefTVec_RefCSLOmField(new TVec_RefCSLOmField); 
  m_isDefined = FALSE; 
}

RefCSLOmIsaElement CSLOmIsaElement::cast( RefCSLOmBase object) {
  if(!object.get()){
    return RefCSLOmIsaElement();
  } 
  else {
    ASSERT(object->isIsaElement(), "type check on cast failure");
    return boost::static_pointer_cast<CSLOmIsaElement>(object);
  }
}

RefCSLOmIsaElement CSLOmIsaElement::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, const RefString& name, RefCSLOmIsaElement source) {
  ASSERT(parent.get(), "null parent received");
  ASSERT(name.get(), "null name received");

  CSLOmIsaElement* elem;
  try {
    elem = new CSLOmIsaElement(lineNumber,fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmIsaElement refElem(elem);
  elem->m_weakRef = boost::weak_ptr<CSLOmBase>( refElem);
  elem->setParent(parent);

  RefCSLOmIdentifier id = CSLOmIdentifier::build(lineNumber,fileName, refElem, CSLOmIdentifier::ID_ISA_ELEM, name);
  elem->m_scope = CSLOmScope::build(id);

  RefCSLOmNumber offset = CSLOmNum32::build(lineNumber,fileName, ZERO);
  offset->setParent(refElem);
  RefCSLOmNumber lower = CSLOmNum32::build(lineNumber, fileName,ZERO);
  lower->setParent(refElem);                           
  RefCSLOmNumber upper = CSLOmNum32::build(lineNumber, fileName,ZERO);
  upper->setParent(refElem);
  elem->m_isDefault = TRUE;
  elem->m_fieldType = CSLOmField::FIELD_HIERARCHICAL;
  RefCSLOmContainer allowed = CSLOmContainer::build(lineNumber,fileName, TYPE_ADDRESS_RANGE);
  allowed->setParent(refElem);

  if (source.get()) {
    if (source->getIsaType() == ISA_ELEM_INSTR) {
      args.push_back("csl_isa_element constructor");
      addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, lineNumber, fileName);
      cslomHasErrors = TRUE;
      return RefCSLOmIsaElement();
    }
    else if (source->getIsaType() == ISA_ELEM_ROOT) {
      RefCSLOmNumber width = CSLOmNum32::build(lineNumber,fileName, CSLOmNumber::cast(source->getWidth()->doEval())->getValue());
      elem->setWidth(width);
      elem->m_cannotBeInstr = TRUE;
      elem->setIsaParent(source);
    }
    else if (source->getIsaType() == ISA_ELEM_FORMAT) {
      elem->setIsaParent(source);
      RefCSLOmNumber width = CSLOmNum32::build(lineNumber,fileName, CSLOmNumber::cast(source->getWidth()->doEval())->getValue());
      elem->setWidth(width);
      RefTVec_RefCSLOmBase fields = source->getChildrenAsBase(TYPE_ALL_FIELDS);
      if (fields.get()) {
        TVec_RefCSLOmBase_const_iter it = fields->begin();
        for (; it < fields->end(); ++it) {
          RefCSLOmField field = CSLOmIsaField::build(lineNumber,fileName, refElem, CSLOmIdentifier::cast((*it)->getChild(ID))->getName(), CSLOmIsaField::cast(*it));
        }
      }
    }
  }
  else {
    elem->m_shouldBeRoot = TRUE;
  }

  return refElem;
}

void CSLOmIsaElement::setIsaParent(RefCSLOmIsaElement parent) {
  ASSERT(parent.get(),"null parent received");
  m_isaParent = WeakRefCSLOmIsaElement(parent);

  parent->addIsaChild(getThis());
}

void CSLOmIsaElement::addIsaChild(RefCSLOmIsaElement child) {
  ASSERT(child.get(),"null child received");
  
  if (!m_isaChildren.get()) {
    m_isaChildren = RefTVec_WeakRefCSLOmIsaElement(new TVec_WeakRefCSLOmIsaElement);
  }
  
  m_isaChildren->push_back(WeakRefCSLOmIsaElement(child));
}

void CSLOmIsaElement::setIsaType(EIsaElementType type) {
  //this check should fail only when m_shouldBeRoot and type==ISA_ELEM_ROOT are of different values; if they are both TRUE or FALSE, it is correct
  ASSERT((!m_shouldBeRoot || type == ISA_ELEM_ROOT) && (m_shouldBeRoot || !(type==ISA_ELEM_ROOT)), "this should be checked in cmd");
  ASSERT(m_isaElemType == ISA_ELEM_UNDEFINED, "this should be checked in cmd");
 
  m_isaElemType = type;

  //for design checker
  m_mandatoryCounter++;
}

void CSLOmIsaElement::registeredEnum(RefCSLOmEnum en) {
  ASSERT(en.get(), "null id received");

  if (!m_isaParent.lock()->ancestorHasRegisteredEnum(en)) {
  
    if (!m_registeredEnums.get()) {
      m_registeredEnums = RefTVec_RefCSLOmBase(new TVec_RefCSLOmBase);
    }
  
    m_registeredEnums->push_back(en);
  }
}

TBool CSLOmIsaElement::ancestorHasRegisteredEnum(RefCSLOmBase en) {
  if (m_isaParent.lock().get()) {
    return hasRegisteredEnum(en) || m_isaParent.lock()->ancestorHasRegisteredEnum(en);
  }
  return FALSE;
}

TBool CSLOmIsaElement::hasRegisteredEnum(RefCSLOmBase en) {
  if (m_registeredEnums.get()) {
    TVec_RefCSLOmBase::iterator it = m_registeredEnums->begin();
    for (; it < m_registeredEnums->end(); it++) {
      if ((*it).get() == en.get()) {
        return TRUE;
      }
    }
  }
  return FALSE;
}

RefTVec_RefCSLOmIdentifier CSLOmIsaElement::getRegisteredEnums() { 
  RefTVec_RefCSLOmIdentifier ids = RefTVec_RefCSLOmIdentifier();
  if (m_registeredEnums.get()) {
    ids = RefTVec_RefCSLOmIdentifier(new TVec_RefCSLOmIdentifier);

 
    TVec_RefCSLOmBase::iterator it = m_registeredEnums->begin();
    for (; it < m_registeredEnums->end(); ++it) {
      RefTVec_RefCSLOmBase enIds = (*it)->getChildrenAsBase();
      TVec_RefCSLOmBase::iterator it1 = enIds->begin();
      ++it1; //sarim peste id-ul enumului
      for (; it1 < enIds->end(); ++it1) {
        ids->push_back(CSLOmIdentifier::cast(*it1));
      }
    }
  }
  return ids; 
}

void CSLOmIsaElement::registeredEnumItem(RefCSLOmIdentifier id) {
  ASSERT(id.get(), "null id received");
  
  if (m_isaParent.lock()->ancestorHasRegisteredEnum(id->getParent())) {
    m_isaParent.lock()->registeredEnumItem(id);
  }
  else {
    if (!m_registeredEnumItems.get()) {
      m_registeredEnumItems = RefTVec_RefCSLOmIdentifier(new TVec_RefCSLOmIdentifier);
    }
    m_registeredEnumItems->push_back(id);
  }
}

void CSLOmIsaElement::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


}
