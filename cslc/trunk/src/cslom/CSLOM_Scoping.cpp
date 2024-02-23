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

// ********************************************************************************
// CSLOmIdentifier class
// ********************************************************************************
CSLOmIdentifier::CSLOmIdentifier(TLineNumberType lineNumber, RefString fileName, ECSLOmType type, EIdType idType, const RefString& name, const RefCSLOmBase& payload) : 
  CSLOmBase(type, lineNumber, fileName), 
  m_idType(idType), 
  m_name(name), 
  m_payload(payload), 
  m_complementaryID() {}

// static method that up-casts object from base to indentifier
// if object does not exist the method returns Null pointer
RefCSLOmIdentifier CSLOmIdentifier::cast (RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmIdentifier();
  }
  ASSERT(object->isID(), "cast type mismatch");
  return boost::static_pointer_cast<CSLOmIdentifier>(object);
}



TBool CSLOmIdentifier::isToScopeDirect(EIdType idType) {
  return idType == ID_CSL_UNIT 
    || idType == ID_CSL_DESIGN
    || idType == ID_CSL_INTERFACE
    || idType == ID_CSL_GROUP
    || idType == ID_MEM_MAP_PAGE
    || idType == ID_MEMORY_MAP
    || idType == ID_FIELD
    || idType == ID_ISA_ELEM
    ;
}

TBool CSLOmIdentifier::isToScopeIndirect(EIdType idType) {
  return idType == ID_UNIT_INST;
}

TBool CSLOmIdentifier::supportsPayload() const {
  return m_idType == ID_CSL_SIGNAL || m_idType == ID_ENUM_ITEM;
}

void CSLOmIdentifier::checkPayload(EIdType idType, ECSLOmType payloadType) {
  switch(idType) {
    case ID_ENUM_ITEM:
      if(payloadType != TYPE_EXPR) {
        //args.push_back("[CSLOmIdentifier::checkPayload()]");
        //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, this->getLineNumber());
        //cslomHasErrors = TRUE;
        throw NSBase::IllegalArgumentException("[CSLOmIdentifier::checkPayload()] invalid arguments.");
      }
      break;
    case ID_CSL_SIGNAL:
      if(payloadType != TYPE_EXPR) {
        //args.push_back("[CSLOmIdentifier::checkPayload()]");
        //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, this->getLineNumber());
        //cslomHasErrors = TRUE;
        throw NSBase::IllegalArgumentException("[CSLOmIdentifier::checkPayload()] invalid arguments.");
      }
      break;
    case ID_UNIT_INST:
      if(payloadType != TYPE_BIT_RANGE) {
        //args.push_back("[CSLOmIdentifier::checkPayload()]");
        //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, this->getLineNumber());
        //cslomHasErrors = TRUE;
        throw NSBase::IllegalArgumentException("[CSLOmIdentifier::checkPayload()] invalid arguments.");
      }
      break;
    default:
      //args.push_back("[CSLOmIdentifier::checkPayload()]");
      //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, this->getLineNumber());
      //cslomHasErrors = TRUE;
      throw NSBase::IllegalArgumentException("[CSLOmIdentifier::checkPayload()] invalid arguments.");
  }
}
// TODO ask what this func should do, cause i don't get it from cdom
TBool CSLOmIdentifier::supportsComplementaryID() const {
  return FALSE;
  //  return m_idType == ID_CSL_SIGNAL
  //      || m_idType == ID_CSL_PORT
  //      ;
}

void CSLOmIdentifier::setComplementaryID(RefCSLOmIdentifier& id) {
  if(!supportsComplementaryID()) {
    //args.push_back("set_complementary_id");
    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
    //cslomHasErrors = TRUE;
    throw NSBase::IllegalStateException("[CSLOmIdentifier::setComplementaryID()] illegal state for this method call.", id->getLineNumber());
  }
  ASSERT(id.get(), "null id received");
  if(!id->supportsComplementaryID()) {
    //args.push_back("set_complementary_id");
    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, this->getLineNumber());
    //cslomHasErrors = TRUE;
    throw NSBase::IllegalStateException("[CSLOmIdentifier::setComplementaryID()] invalid arguments.", id->getLineNumber());
  }
  if(m_complementaryID.get() || id->getComplementaryID().get()) {
    //args.push_back("set_complementary_id");
    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ARGS, args, this->getLineNumber());
    //cslomHasErrors = TRUE;
    throw NSBase::IllegalStateException("[CSLOmIdentifier::setComplementaryID()] complementary id already set.", id->getLineNumber());
  }
  //TODO check the possible complementary id's again
  if( !(m_idType == ID_CSL_PORT && id->m_idType == ID_CSL_SIGNAL || m_idType == ID_CSL_SIGNAL && id->m_idType == ID_CSL_PORT) ) {
    args.push_back(*id->getName());
    args.push_back("port or signal identifier");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, id->getLineNumber(), id->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CSLOmIdentifier::setComplementaryID()] complementary id mismatch.", id->getLineNumber());
  }

  m_complementaryID = id;
  id->m_complementaryID = getThis(); // update reverse link
}

RefCSLOmIdentifier CSLOmIdentifier::getComplementaryID() const {
  if(!supportsComplementaryID()) {
    //args.push_back("set_complementary_id");
    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
    //cslomHasErrors = TRUE;
    throw NSBase::IllegalStateException("[CSLOmIdentifier::getComplementaryID()] illegal state for this method call.");
  }
  return m_complementaryID;
}

RefCSLOmIdentifier CSLOmIdentifier::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, EIdType idType, const RefString& name, RefCSLOmBase payload) {
  ASSERT(parent.get(), "null parent received");
  checkIdName(name, lineNumber, fileName);
  if(payload.get()) {
    checkPayload(idType, payload->getType());
  }
  CSLOmIdentifier* id;
  try {
    id = new CSLOmIdentifier(lineNumber, fileName, isToScopeDirect(idType) ? TYPE_ID_SCOPE_DIRECT :
                             isToScopeIndirect(idType) ? TYPE_ID_SCOPE_INDIRECT : TYPE_ID_SIMPLE,
                             idType, name, payload);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }

  RefCSLOmIdentifier refID(id);
  id->m_weakRef = boost::weak_ptr<CSLOmBase>( refID);
  id->setParent(parent); // self registration
  if(payload.get()) {
    CSLOmExpr::cast(payload)->dupp()->setParent(refID); // self registration
  }
  // self register id with the enclosing scope,
  // except for attribute ids, since these are in a separate namespace
  // and for explicit port ids
  RefCSLOmScope scope = RefCSLOmScope();
  if( !parent->isDesign() ) {
    if ( parent->getParent()->isInterface() && CSLOmInterface::cast(parent->getParent())->isDefaultIfc() ) {
      // if the parent is a default ifc we have to register the Identifier to the UnitDecl's scope of the default ifc
      scope = parent->getParent()->getParentScope();
      ASSERT(scope.get(), "null scope found");
    }
    else {
      scope = parent->getParentScope();
      ASSERT(scope.get(), "null scope found");
    }
  }
  else {
    RefCSLOmDesign design = CSLOmDesign::cast(parent);
    scope = design->getAttachedScope();//(CSLOmDesign::cast(parent))->getAttachedScope();
    ASSERT(scope.get(), "null scope received");
  }
  scope->registerID(refID); // id self registration into enclosing scope
  return refID;
}

TBool CSLOmIdentifier::isRemovable() const {
  return m_idType == ID_CSL_INTERFACE;
}

CSLOmIdentifier::EIdType CSLOmIdentifier::getIdType() const {
  return m_idType;
}

const RefString CSLOmIdentifier::getName() const {
  return m_name;
}

const RefString CSLOmIdentifier::getLowerName() const {
  return refStrToLower(m_name);
}

const RefString CSLOmIdentifier::getUpperName() const {
  return refStrToUpper(m_name);
}


const RefCSLOmBase CSLOmIdentifier::getPayload() const {
  if(!supportsPayload()) {
    //args.push_back("");
    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
    //cslomHasErrors = TRUE;
    throw NSBase::IllegalStateException("[CSLOmIdentifier::getPayload()] illegal state for this method call.", m_lineNumber);
  }

  return m_payload;
}

// this function returns the scope of the object that has as a child the current ID
// some object are not scope holders like signals, ports, expressions, etc
// this cases are tested with isToScopeID - method that returns if the parent of the ID is a scope holder or not
RefCSLOmScope CSLOmIdentifier::toScope() const {
  ASSERT(isToScopeID(),"[CSLOmIdentifier::toScope()] illegal state for this method call.");
  //  if(!isToScopeID()) {
  //    //args.push_back("");
  //    //addErr(NSWarningErr::CSE_CSC_FUNC_CSE_CSC_FUNC_ILLEGAL_STATE, args, this->getLineNumber());
  //    //cslomHasErrors = TRUE;
  //    throw NSBase::IllegalStateException("[CSLOmIdentifier::toScope()] illegal state for this method call.", m_lineNumber);
  //  } THIS IS NOT A USER ERROR

  return getAttachedScope(getParent().get());
}

void CSLOmIdentifier::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CSLOmScope class
// ********************************************************************************
CSLOmScope::CSLOmScope(EScopeType scopeType, const RefCSLOmIdentifier& id) : 
  m_scopeType(scopeType), 
  m_id(id), 
  m_ids(), 
  m_nameMap() { }

RefCSLOmScope CSLOmScope::build(const RefCSLOmIdentifier& id) {
  EScopeType scopeType;
  if(id.get()) {
    ASSERT(id->getType() == TYPE_ID_SCOPE_DIRECT, "scope is not Scope direct");
    switch(id->getIdType()) {
      case CSLOmIdentifier::ID_CSL_DESIGN:      scopeType = SCOPE_CSL_DESIGN;       break;
      case CSLOmIdentifier::ID_CSL_UNIT:        scopeType = SCOPE_UNIT_DECL;        break;
      case CSLOmIdentifier::ID_UNIT_INST:       scopeType = SCOPE_UNIT_INST;        break;
      case CSLOmIdentifier::ID_CSL_INTERFACE:   scopeType = SCOPE_INTERFACE;        break;
      case CSLOmIdentifier::ID_CSL_GROUP:       scopeType = SCOPE_GROUP;            break;
      case CSLOmIdentifier::ID_FIELD:           scopeType = SCOPE_FIELD;            break;
      case CSLOmIdentifier::ID_MEMORY_MAP:      scopeType = SCOPE_MEM_MAP;          break;
      case CSLOmIdentifier::ID_MEM_MAP_PAGE:    scopeType = SCOPE_MEM_MAP_PAGE;     break;
      case CSLOmIdentifier::ID_ISA_ELEM:        scopeType = SCOPE_ISA_ELEM;         break;
      default: ASSERT(FAIL,"[CSLOmScope::build()] bug detected...id type does not corespond to any scope holder object");
    }
  }
  else {
    scopeType = SCOPE_DESIGN;
  }
  try {
    return RefCSLOmScope(new CSLOmScope(scopeType, id));
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }
}
// this method searches an Identifier downward in the scope hierachy
// after a string HID "a.b.c"
RefCSLOmIdentifier CSLOmScope::lookupDownward(const RefString& name) const {
  TULong idx = name->find(DOT);
  if(idx == 0 || idx == name->length() - 1) {// if DOT is placed on the first or last position the name is invalid
    args.push_back(*name);
    addErr(NSWarningErr::CSE_CSC_ID_CSE_CSC_ID_ILLEGAL, args, getID()->getLineNumber(), getID()->getFileName());
    cslomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException(std::string("[CSLOmScope::lookupDownward()] invalid name: " + *name).c_str());
  }
  else if(idx != std::string::npos) {// if we find a DOT then we treat the name string as a HID
    RefString prefixStr = RefString(new std::string(name->substr(ZERO, idx)));
    if(name->at(idx + 1) == DOT) {// if there is in the string a ".." then the HID is invalid
      args.push_back(*name);
      addErr(NSWarningErr::CSE_CSC_ID_CSE_CSC_ID_ILLEGAL, args, getID()->getLineNumber(), getID()->getFileName());
      cslomHasErrors = TRUE;
      //throw NSBase::IllegalArgumentException(std::string("[CSLOmScope::lookupDownward()] invalid name: " + *name).c_str());
    }
    RefString suffixStr = RefString(new std::string(name->substr(idx + 1)));
    RefCSLOmIdentifier id = lookupLocal(prefixStr);
    // check if a valid identifier was found
    if(id.get() && id->isToScopeID()) {
      return id->toScope()->lookupDownward(suffixStr);
    }
    return RefCSLOmIdentifier();
  }
  else { // if name doesn't have any DOT then we look for the name in the local scope
    return lookupLocal(name);
  }
  return RefCSLOmIdentifier();
}

// same as the previous function only that it uses a vector to hold the HID instead of a string
// each name is hold in one element from the vector
RefCSLOmIdentifier CSLOmScope::lookupDownward(const RefTVec_RefString& hid) const {
  if(hid->size() > 1) {// more than one name HID
    RefCSLOmIdentifier id = lookupLocal(hid->at(ZERO));
    // check if a valid identifier was found
    if(id.get() && id->isToScopeID()) {
      RefTVec_RefString suffixHID = RefTVec_RefString(new TVec_RefString(++hid->begin(), hid->end()));
      return id->toScope()->lookupDownward(suffixHID);
    }
    return RefCSLOmIdentifier();
  }
  else {// vector holds only one name
    return lookupLocal(hid->at(ZERO));
  }
}

// this function registers a new identifier in the current scope.
void CSLOmScope::registerID(RefCSLOmIdentifier& id) {
  ASSERT(id.get(), "null id received");
  ASSERT(id->getParent().get(), "null parent received"); // must have a parent
  TBool errorGiven = FALSE;
  if(!m_ids.get()) {
    m_ids = RefTVec_RefCSLOmIdentifier(new TVec_RefCSLOmIdentifier());
    m_nameMap = RefTMap_RefString_RefCSLOmIdentifier(new TMap_RefString_RefCSLOmIdentifier());
  }
  else {
    // check for the same name in the scope
    if(containsID(id->getName())) { // if name exists in the current scope
      if(!id->supportsComplementaryID()) { // and the identifier does not support complementary ID : there is a duplicate name.
        args.push_back(*id->getName());
        if(!isDesignScope()) {
          args.push_back(*(getID()->getName()));
        }
        else {
          args.push_back("global");
        }
        addErr(NSWarningErr::CSE_CSC_SCOP_CSE_CSC_SCOP_ID_ALREADY_DEFINED, args, id->getLineNumber(), id->getFileName());
        cslomHasErrors = TRUE;
        errorGiven = TRUE;
        return;
        //throw NSBase::IllegalArgumentException(std::string("[CSLOmScope::registerID()] identifier name: " + *(id->getName()) + " already defined in scope.").c_str(), id->getLineNumber());
      }
      RefCSLOmIdentifier firstID = lookupLocal(id->getName());
      id->setComplementaryID(firstID);
      return; // do not insert the complementary id since it's link is already registered
    }
  }
  if (!errorGiven) { // no errors
    m_ids->push_back(id);
    m_nameMap->insert(TPair_RefString_RefCSLOmIdentifier(id->getName(), id)); // insert the id in the ID map of the scope
  }
}

// removes an ID from the current scope
void CSLOmScope::removeID(const RefString& name) {
  TRACE_ME(1, "CSLOmScope::removeID(const RefString& name)");
  //  checkIdName(name);
  // this should already be verified from the calling method
  ASSERT(containsID(name), "This CSLOmScope instance doesn't contain the name you are trying to remove");
  // searches to current name in the name map of the scope
  TMap_RefString_RefCSLOmIdentifier::iterator iter = m_nameMap->find(name);
  // this will not fail, unless there is a bug in containsID: until now containsID did not fail
  ASSERT(iter != m_nameMap->end(), "bug detected in CSLOmScope::containsID()");
  //ASSERT(iter->second->isRemovable(), "Trying to remove a scope item which is not removable");
  RefCSLOmIdentifier idToRemove = iter->second;
  // serches for the indentifier from the map in the m_ids vector of the scope
  TVec_RefCSLOmIdentifier::iterator it;
  for(it = m_ids->begin(); it < m_ids->end() && *it != idToRemove; ++it);
  // if id is present in the map and not present in the vector it is a bug in registerID
  ASSERT(it < m_ids->end(), "id to be removed not present, scope bug detected");
  // removes identifier, and the pair which contains the ID from the map and vector
  // after that the ID should not be registered any more in this scope
  m_nameMap->erase(iter);
  m_ids->erase(it);
}

CSLOmScope::EScopeType CSLOmScope::getScopeType() const {
  return m_scopeType;
}

RefCSLOmIdentifier CSLOmScope::getID() const {
  return m_id;
}

RefCSLOmBase CSLOmScope::getHolderObject() const {
  if (!m_ids.get() && isDesignScope()) {
    return RefCSLOmBase();
  }
  else if (isDesignScope() && m_ids.get()) {
    return m_ids->back()->getParent()->getParent();
  }
  else {
    return m_id->getParent();
  }
}

TBool CSLOmScope::containsID(const RefString& name) const {
  TRACE_ME(1, "CSLOmScope::containsID(const RefString& name) const");
  //  checkIdName(name);

  if(!m_ids.get()) {
    return FALSE;
  }
  else {
    return m_nameMap->find(name) != m_nameMap->end();
  }
}

// This function returns an identifier in the local scope only, that is
// no downward or upward scope search takes place.
RefCSLOmIdentifier CSLOmScope::lookupLocal(const RefString& name) const {
  //  checkIdName(name);

  if(!m_ids.get()) {
    return RefCSLOmIdentifier();
  }
  else {
    TMap_RefString_RefCSLOmIdentifier_const_iter iter = m_nameMap->find(name);

    if(iter == m_nameMap->end()) {
      return RefCSLOmIdentifier();
    }
    else {
      return iter->second;
    }
  }
}

// This function finds the first identifier match according to scope search rules and idMask
// idMask example: ID_TASK | ID_NAMED_BLOCK
// case example: disable <id>, id can refer to both a task id or a named block id
RefCSLOmIdentifier CSLOmScope::lookup(const RefString& name, TUInt idMask) const {
  ASSERT(name.get(), "null name received");
  ASSERT(name->length(), "name length should not be 0");

  RefCSLOmIdentifier id = lookupDownward(name);
  // check if a valid identifier was found
  if(id.get() && (id->getType() & idMask)) {
    return id;
  }
  else if(isDesignScope()) {
    return RefCSLOmIdentifier();
  }
  else {
    // fallback to parent scope
    RefCSLOmScope parentScope = m_id->getParentScope();
    if(!parentScope.get()) {
      return RefCSLOmIdentifier();
    }
    else {
      return parentScope->lookup(name, idMask);
    }
  }
}

// This function finds the first identifier match according to scope search rules and idMask
// idMask example: ID_TASK | ID_NAMED_BLOCK
// case example: disable <id>, id can refer to both a task id or a named block id
RefCSLOmIdentifier CSLOmScope::lookup(const RefTVec_RefString& hid, TUInt idMask) const {
  ASSERT(hid.get(), "null hid vec received");
  ASSERT(hid->size(), "empty hid vec received");

  RefCSLOmIdentifier id = lookupDownward(hid);
  // check if a valid identifier was found
  if(id.get() && (id->getType() & idMask)) {
    return id;
  }
  else if(isDesignScope()) {
    return RefCSLOmIdentifier();
  }
  else {
    // fallback to parent scope
    RefCSLOmScope parentScope = m_id->getParentScope();
    if(!parentScope.get()) {
      return RefCSLOmIdentifier();
    }
    else {
      return parentScope->lookup(hid, idMask);
    }
  }
}

const RefTVec_RefCSLOmIdentifier CSLOmScope::getIDs() const {
  return m_ids;
}

// ********************************************************************************
// CSLOmScopeBlock class
// ********************************************************************************
RefTVec_RefCSLOmScope CSLOmScopeBlock::m_path = RefTVec_RefCSLOmScope(new TVec_RefCSLOmScope);
RefTVec_RefString CSLOmScopeBlock::m_namePath = RefTVec_RefString(new TVec_RefString);

void CSLOmScopeBlock::enterScope(RefCSLOmScope scope) {
  ASSERT(scope.get(),"*** internal bug *** null scope received");
  m_path->push_back(scope);
  m_namePath->push_back(RefString(new std::string("")));
}

TBool CSLOmScopeBlock::enterScope(RefCSLOmExprLink linkToObject) {
  ASSERT(linkToObject.get(), "null link received");
  RefCSLOmIdentifier id = linkToObject->getLocalNameID();
  if (!id.get()) {
    args.push_back(*(linkToObject->getHidNames())->back());
    addErr(NSWarningErr::DEE_CSC_ID_DEE_CSC_SCOP_UNDEFINED_SCOPE, args, linkToObject->getLineNumber(), linkToObject->getFileName());
    cslomHasErrors = TRUE;
    return FALSE;
    //throw NSBase::IllegalArgumentException("Cannot change current scope, cannot find object");
  }
  ASSERT(id->getParent().get(), "bug detected: id does not have a parent");
  if (id->getParent()->isScopeHolder()) {
    m_path->push_back(CSLOmBase::getAttachedScope(id->getParent().get()));
    m_namePath->push_back(linkToObject->getName());
  }
  else if (id->isToScopeID()) {
    RefCSLOmUnitInstance instance = CSLOmUnitInstance::cast(id->getParent());
    m_path->push_back(CSLOmBase::getAttachedScope(instance->getUnitDecl().get()));
    m_namePath->push_back(linkToObject->getName());
  }
  else {
    args.push_back(*id->getName());
    args.push_back("scope holder");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, id->getLineNumber(), id->getFileName());
    cslomHasErrors = TRUE;
    return FALSE;
    //throw NSBase::IllegalArgumentException("Cannot change current scope, object is not a Scope Holder");
  }
  return TRUE;
}

void CSLOmScopeBlock::exitScope() {
  m_path->pop_back();
  m_namePath->pop_back();
}

RefCSLOmScope CSLOmScopeBlock::getCurrentScope() {
  return m_path->back();
}

RefString CSLOmScopeBlock::getCurrentScopeName() {
  return m_namePath->back();
}

RefCSLOmDesign CSLOmScopeBlock::getDesign() {
  RefCSLOmScope designScope = m_path->at(DESIGN_SCOPE);
  ASSERT(designScope->getHolderObject()->isDesign(), "this is bad...");
  return CSLOmDesign::cast(designScope->getHolderObject());
}

}
