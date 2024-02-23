//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
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

#include "CDOM.h"
#include "CDOM_Visitor.h"
#include <algorithm>
#include <iterator>
#include <sstream>
#include <iomanip>
#include <cmath>
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../support/CommonSupport.h"

// !!! inline functions
TBool cdomHasErrors = FALSE;

namespace NSCdom {
// *******************************************************************************
// WarnError
// *******************************************************************************

// ********************************************************************************
// CDOmList validator methods
// ********************************************************************************
void validateSpecifyTerminal(const RefCDOmExprLink& item) {
  ASSERT(item.get(), "item is NULL");
  ASSERT(!item->isHID() && !item->getArrayIndexes().get(), "invalid expression link");
}

// ********************************************************************************
// global variables
// ********************************************************************************
const TChar DOT = '.';

RefTVec_RefCDOmExprLink CDOmExprLink::exprLinks = RefTVec_RefCDOmExprLink();

// ********************************************************************************
// global functions
// ********************************************************************************
TBool checkIdName(const RefString& name, TLineNumberType lineNumber) {
  ASSERT(name.get(), "[checkIdName()] NULL name");
  ASSERT(name->length(), "[checkIdName()] illegal name (length is 0)");

  if(name->find(DOT) != std::string::npos) {
    args.push_back(*name);
    addErr(NSWarningErr::CSE_CSC_ID_CSE_CSC_ID_ILLEGAL, args, lineNumber);
    cdomHasErrors = TRUE;      
    return FALSE;
    //throw NSBase::IllegalArgumentException(std::string("[checkIdName()] illegal identifier name: " + *name).c_str());
  }
  return TRUE;
}

TBool checkDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength, TLineNumberType lineNumber) {
  //ASSERT(firstDriveStrength != DRIVE_STRENGTH_UNDEFINED && secondDriveStrength != DRIVE_STRENGTH_UNDEFINED, "illegal drive strength");
  //if(firstDriveStrength == DRIVE_STRENGTH_UNDEFINED || secondDriveStrength == DRIVE_STRENGTH_UNDEFINED) {
  //  addErr(NSWarningErr::VEE_CSA_DRST_DRVS_ILLEGAL_CSVE, args, lineNumber);
  //  cdomHasErrors = TRUE;
  //  return FALSE;
  //}
  if(firstDriveStrength & DRIVE_STRENGTH_0_MASK) {
    //ASSERT(secondDriveStrength & DRIVE_STRENGTH_1_MASK, "secondDriveStrength should be strength1");
    if(!(secondDriveStrength & DRIVE_STRENGTH_1_MASK)) {
      args.push_back("strength1");
      addErr(NSWarningErr::VEE_CSA_DRST_DRVS_SECOND_SHOULD_BE_CSVE, args, lineNumber);
      cdomHasErrors = TRUE;
      return FALSE;
    }
    if(firstDriveStrength == DRIVE_STRENGTH_HIGHZ_0) {
      //ASSERT(secondDriveStrength != DRIVE_STRENGTH_HIGHZ_1, "secondDriveStrength should be different that highz1");
      if(secondDriveStrength == DRIVE_STRENGTH_HIGHZ_1) {
        args.push_back("highz1");
        addErr(NSWarningErr::VEE_CSA_DRST_DRVS_SECOND_SHOULD_NOT_BE_CSVE, args, lineNumber);
        cdomHasErrors = TRUE;
        return FALSE;
      }
    }
  }
  else if(firstDriveStrength & DRIVE_STRENGTH_1_MASK) {
    //ASSERT(secondDriveStrength & DRIVE_STRENGTH_0_MASK, "secondDriveStrength should be strength0");
    if(!(secondDriveStrength & DRIVE_STRENGTH_0_MASK)) {
      args.push_back("strength0");
      addErr(NSWarningErr::VEE_CSA_DRST_DRVS_SECOND_SHOULD_BE_CSVE, args, lineNumber);
      cdomHasErrors = TRUE;
      return FALSE;
    }
    if(firstDriveStrength == DRIVE_STRENGTH_HIGHZ_1) {
      //ASSERT(secondDriveStrength != DRIVE_STRENGTH_HIGHZ_0, "secondDriveStrength should be different that highz0");
      args.push_back("highz0");
      addErr(NSWarningErr::VEE_CSA_DRST_DRVS_SECOND_SHOULD_NOT_BE_CSVE, args, lineNumber);
      cdomHasErrors = TRUE;
      return FALSE;
    }
  }
  return TRUE;
}

// ********************************************************************************
// class type functors
// ********************************************************************************
/**
 * This function is a binary predicate used to compare two strings to determine their
 * relative position in a container.
 *
 * @param s1 the first string
 * @param s2 the second string
 *
 * @return TBool
 */
inline TBool less_RefString::operator() (const RefString& s1, const RefString& s2) const {
  ASSERT(s1.get(), "s1 is NULL");
  ASSERT(s2.get(), "s2 is NULL");

  return s1->compare(*s2) < 0;
}

// ********************************************************************************
// CDOmBase class
// ********************************************************************************
CDOmBase::CDOmBase(ECDOmType type, TLineNumberType lineNumber, RefString fileName)
  : m_weakRef(),
    m_type(type),
    m_parent(),
    m_children(),
    m_cachedParentScope(),
    m_lineNumber(lineNumber) {

  //TODO: actually add the filename
  m_fileName = (fileName.get()
                ? fileName
                : RefString(new std::string("TO BE IMPLEMENTED")));
}

RefCDOmScope CDOmBase::getAttachedScope(const CDOmBase* base) {
  ASSERT(base->isScopeHolder(), "base is not a scope holder");

  switch(base->m_type) {
    case TYPE_DESIGN:
      return static_cast<const CDOmDesign*>(base)->getAttachedScope();
    case TYPE_DECL_MODULE:
      return static_cast<const CDOmModuleDecl*>(base)->getAttachedScope();
    case TYPE_DECL_TASK:
      return static_cast<const CDOmTaskDecl*>(base)->getAttachedScope();
    case TYPE_DECL_FUNCTION:
      return static_cast<const CDOmFuncDecl*>(base)->getAttachedScope();
    case TYPE_STMT_NAMED_BLOCK:
      return static_cast<const CDOmStmtBlock*>(base)->getAttachedScope();
    case TYPE_GEN_ITEM_BLOCK_NAMED:
      return static_cast<const CDOmGenItemBlock*>(base)->getAttachedScope();
    case TYPE_DECL_UDP:
      return static_cast<const CDOmUdpDecl*>(base)->getAttachedScope();
    default:
      ASSERT(FAIL, "[CDOmBase::getAttachedScope()] bug detected...");
      //throw NSBase::IllegalStateException("[CDOmBase::getAttachedScope()] bug detected...");
      
  }
}

void CDOmBase::addChild(const RefCDOmBase& child) {
  ASSERT(child.get(), "child is NULL");

  if(!m_children.get()) {
    m_children = RefTVec_RefCDOmBase(new TVec_RefCDOmBase());
  }
  m_children->push_back(child);
}

CDOmBase::~CDOmBase() {}


const RefCDOmBase CDOmBase::getChild(ECDOmType type, TInt index) const {
  RefTVec_RefCDOmBase children = getChildrenAsBase(type);
  ASSERT(children.get() && children->size() > index, "index out of range");
  return children->at(index);
}

const TInt CDOmBase::getChildrenSize() const {
  //ASSERT(m_children.get(), "m_children is NULL");
  TInt childrenSize = 0;
  if(m_children.get()) {
    childrenSize =  m_children->size();
  }

  return childrenSize;
}   

ECDOmType CDOmBase::getType() const {
  return m_type;
}


TBool CDOmBase::isTopLevel() const {
  return
    m_type == TYPE_DECL_MODULE ||
    m_type == TYPE_DECL_UDP;
}

TBool CDOmBase::isScopeHolder() const {
  return m_type == TYPE_DESIGN 
    || m_type == TYPE_DECL_MODULE 
    || m_type == TYPE_DECL_TASK 
    || m_type == TYPE_DECL_FUNCTION 
    || m_type == TYPE_STMT_NAMED_BLOCK
    || m_type == TYPE_GEN_ITEM_BLOCK_NAMED
    || m_type == TYPE_DECL_UDP
    ;
}

TBool CDOmBase::isToScopeID() const {
  return
    m_type == TYPE_ID_SCOPE_DIRECT ||
    m_type == TYPE_ID_SCOPE_INDIRECT;
}

TBool CDOmBase::isID() const {
  return
    m_type == TYPE_ID_SIMPLE ||
    m_type == TYPE_ID_SCOPE_DIRECT ||
    m_type == TYPE_ID_SCOPE_DIRECT;
}

TBool CDOmBase::isStmt() const {
  return
    m_type == TYPE_STMT ||
    m_type == TYPE_STMT_NAMED_BLOCK;
}

TBool CDOmBase::isFuncStmt() const {
  return isStmt(); // !!! to be completed
}

TBool CDOmBase::isModuleItem() const {
  switch(m_type) {
    case TYPE_PORT_DECL:
    case TYPE_NET_DECL:
    case TYPE_VAR_DECL:
    case TYPE_EVENT_DECL:
    case TYPE_GENVAR_DECL:
    case TYPE_DECL_TASK:
    case TYPE_DECL_FUNCTION:
    case TYPE_PARAM_OVERRIDE:
    case TYPE_CONT_ASSN:
    case TYPE_INST_GATE:
    case TYPE_INST_UDP:
    case TYPE_MODULE_INSTANTIATION:
    case TYPE_INITIAL_OR_ALWAYS:
    case TYPE_SPEC_BLOCK:
    case TYPE_GEN_INST:
    case TYPE_PARAM_DECL:
      return true;
    default:
      return false;
  }
}

TBool CDOmBase::isBlockItem() const {
  return
    m_type == TYPE_VAR_DECL ||
    m_type == TYPE_EVENT_DECL ||
    (m_type == TYPE_PARAM_DECL && static_cast<const CDOmParamDecl*>(this)->getParamDeclType() != CDOmParamDecl::PARAM_DECL_SPEC); // only simple param decl and local param decl
}

TBool CDOmBase::isTaskItem() const {
  return isBlockItem() || m_type == TYPE_TF_PORT_DECL;
}

TBool CDOmBase::isFuncItem() const {
  return isBlockItem() || (m_type == TYPE_TF_PORT_DECL && static_cast<const CDOmTFPortDecl*>(this)->getPortType() == PORT_INPUT);
}

TBool CDOmBase::isGenerateItem() const {
  return //generated item types
    m_type == TYPE_GEN_ITEM_IF
    || m_type == TYPE_GEN_ITEM_CASE
    || m_type == TYPE_GEN_ITEM_LOOP
    || m_type == TYPE_GEN_ITEM_BLOCK_NAMED
    || m_type == TYPE_GEN_ITEM_BLOCK_UNNAMED
    //module or generated item declarations
    || m_type == TYPE_NET_DECL
    || m_type == TYPE_VAR_DECL
    || m_type == TYPE_EVENT_DECL
    || m_type == TYPE_GENVAR_DECL
    || m_type == TYPE_DECL_TASK
    || m_type == TYPE_DECL_FUNCTION
    //remaining generated items
    || m_type == TYPE_PARAM_OVERRIDE
    || m_type == TYPE_CONT_ASSN
    //TODO uncomment this when implemented || m_type == TYPE_GATE_INST
    //TODO uncomment this when implemented || m_type == TYPE_UDP_INST
    || m_type == TYPE_MODULE_INSTANTIATION
    || m_type == TYPE_INITIAL_OR_ALWAYS
    ;
}

void CDOmBase::setParent(RefCDOmBase parent) {
  ASSERT(parent.get(), "parent is NULL");
  if(m_parent.lock().get()) {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_HAS_PARENT, args, this->getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmBase::setParent()] parent already set.", m_lineNumber);
  }

  if(parent->m_type == TYPE_DECL_MODULE && isModuleItem()) { // logic to update module decl inner state before adding a module item to it
    static_cast<CDOmModuleDecl*>(parent.get())->beforeAddingModuleItem(m_type == TYPE_PORT_DECL);
  }
  else if(parent->m_type == TYPE_DECL_TASK && isTaskItem()) { // logic to update task decl inner state before adding a task item to it
    static_cast<CDOmTaskDecl*>(parent.get())->beforeAddingTaskItem(m_type == TYPE_TF_PORT_DECL);
  }
  else if(parent->m_type == TYPE_DECL_FUNCTION && isFuncItem()) { // logic to update function decl inner state before adding a function item to it
    static_cast<CDOmFuncDecl*>(parent.get())->beforeAddingFuncItem(m_type == TYPE_TF_PORT_DECL); // this should be of subtype PORT_INPUT
  }
  else if(parent->m_type == TYPE_GEN_ITEM_IF) {
    static_cast<CDOmGenItemIf*>(parent.get())->beforeAddingGenItemOrNull();
  }
  else if(parent->m_type == TYPE_GEN_ITEM_CASE && m_type != TYPE_LIST_EXPR) {
    static_cast<CDOmGenItemCase*>(parent.get())->beforeAddingGenItemOrNull();
  }
  else if(parent->m_type == TYPE_GEN_ITEM_LOOP) {
    static_cast<CDOmGenItemLoop*>(parent.get())->beforeAddingGenItemBlock(m_type);
  }
  else if(parent->m_type == TYPE_DECL_UDP) {
    if(m_type == TYPE_PORT_DECL)
      static_cast<CDOmUdpDecl*>(parent.get())->beforeAddingPortDecl();
    else if(m_type == TYPE_UDP_COMB_ENTRY)
      static_cast<CDOmUdpDecl*>(parent.get())->beforeAddingUdpEntry(true);
    else if(m_type == TYPE_UDP_SEQ_ENTRY)
      static_cast<CDOmUdpDecl*>(parent.get())->beforeAddingUdpEntry(false);
    else if(m_type == TYPE_UDP_INIT_STMT)
      static_cast<CDOmUdpDecl*>(parent.get())->beforeAddingUdpInitStmt();
  }

  m_parent = boost::weak_ptr<CDOmBase>( parent);
  //parent->addChild(m_weakRef.lock());
  parent->addChild(getThis());

  // added to improve scope lookup performance
  if(parent->isScopeHolder() && m_type != TYPE_ID_SCOPE_DIRECT) {
    m_cachedParentScope = boost::weak_ptr<CDOmScope>( getAttachedScope(parent.get()));
  }
  else if(parent->m_cachedParentScope.lock().get()) {
    m_cachedParentScope = parent->m_cachedParentScope;
  }
}

// Returns the nearest parent scope up in the scope hierarchy
// If there is no upper scope this method returns null, that is, calling get() on returned object returns 0
// NOTE: for performance reasons, this method also triggers the update of m_cachedParentScope member
// on all m_parents up in the hierarchy
RefCDOmScope CDOmBase::getParentScope() const {
  if(m_cachedParentScope.lock().get()) {
    return m_cachedParentScope.lock();
  }
  if(m_type != TYPE_ID_SCOPE_DIRECT && getParent().get() && getParent()->isScopeHolder()) {
    // update m_cachedParentScope
    m_cachedParentScope = boost::weak_ptr<CDOmScope>( getAttachedScope(getParent().get()));
    return m_cachedParentScope.lock();
  }
  if(!getParent().get()) {
    return m_cachedParentScope.lock(); // whose get() method returns 0
  }
  // update m_cachedParentScope
  m_cachedParentScope = boost::weak_ptr<CDOmScope>( getParent()->getParentScope());
  return m_cachedParentScope.lock();
}

RefCDOmBase CDOmBase::getParent() const {
  return m_parent.lock();
}

template<class T> const boost::shared_ptr<std::vector<boost::shared_ptr<T> > >
  CDOmBase::getChildren(ECDOmType typeFilter) const {
  typedef boost::shared_ptr<T>              RefCDOmT;
  typedef std::vector<RefCDOmT>                TVec_RefCDOmT;
  typedef boost::shared_ptr<TVec_RefCDOmT>  RefTVec_RefCDOmT;

  if(!m_children.get()) {
    return RefTVec_RefCDOmT();
  }
  TVec_RefCDOmT* filteredChildren = 0;
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
    if(typeFilter == TYPE_ALL_TYPES ||
       (typeFilter == TYPE_ALL_TOP_LEVELS && (*iter)->isTopLevel()) ||
       (typeFilter == TYPE_ALL_SCOPE_HOLDERS && (*iter)->isScopeHolder()) ||
       (typeFilter == TYPE_ALL_STMTS && (*iter)->isStmt()) ||
       (typeFilter == TYPE_ALL_FUNC_STMTS && (*iter)->isFuncStmt()) ||
       (typeFilter == TYPE_ALL_MODULE_ITEMS && (*iter)->isModuleItem()) ||
       (typeFilter == TYPE_ALL_BLOCK_ITEMS && (*iter)->isBlockItem()) ||
       (typeFilter == TYPE_ALL_TASK_ITEMS && (*iter)->isTaskItem()) ||
       (typeFilter == TYPE_ALL_FUNC_ITEMS && (*iter)->isFuncItem()) ||
       (typeFilter == TYPE_ALL_GEN_ITEMS && (*iter)->isGenerateItem()) ||
       (*iter)->getType() == typeFilter) {
      if(!filteredChildren) {
        filteredChildren = new TVec_RefCDOmT();
      }
      filteredChildren->push_back(boost::static_pointer_cast<T>(*iter));
    }
  }
  return RefTVec_RefCDOmT(filteredChildren);
}

const RefTVec_RefCDOmBase CDOmBase::getChildrenAsBase(ECDOmType typeFilter) const {
  if(typeFilter == TYPE_ALL_TYPES || !m_children.get()) {
    return m_children;
  }
  TVec_RefCDOmBase* filteredChildren = 0;
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
    if((typeFilter == TYPE_ALL_TOP_LEVELS && (*iter)->isTopLevel()) ||
       (typeFilter == TYPE_ALL_SCOPE_HOLDERS && (*iter)->isScopeHolder()) ||
       (typeFilter == TYPE_ALL_STMTS && (*iter)->isStmt()) ||
       (typeFilter == TYPE_ALL_FUNC_STMTS && (*iter)->isFuncStmt()) ||
       (typeFilter == TYPE_ALL_MODULE_ITEMS && (*iter)->isModuleItem()) ||
       (typeFilter == TYPE_ALL_BLOCK_ITEMS && (*iter)->isBlockItem()) ||
       (typeFilter == TYPE_ALL_TASK_ITEMS && (*iter)->isTaskItem()) ||
       (typeFilter == TYPE_ALL_FUNC_ITEMS && (*iter)->isFuncItem()) ||
       (*iter)->getType() == typeFilter) {
      if(!filteredChildren) {
        filteredChildren = new TVec_RefCDOmBase();
      }
      filteredChildren->push_back(*iter);
    }
  }
  return RefTVec_RefCDOmBase(filteredChildren);
}
const RefTVec_RefCDOmBase CDOmBase::getExclusiveChildrenAsBase(ECDOmType typeFilter) const {
  //if(typeFilter == TYPE_ALL_TYPES || !m_children.get()) {
  //  return m_children;
  //}
  TVec_RefCDOmBase* filteredChildren = 0;
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
    if((*iter)->getType() != typeFilter) {
      if(!filteredChildren) {
        filteredChildren = new TVec_RefCDOmBase();
      }
      filteredChildren->push_back(*iter);
    }
  }
  return RefTVec_RefCDOmBase(filteredChildren);
}

const RefTVec_RefCDOmBase CDOmBase::getTwoExclusiveChildrenAsBase(ECDOmType typeFilterA, ECDOmType typeFilterB) const {
  //if(typeFilter == TYPE_ALL_TYPES || !m_children.get()) {
  //  return m_children;
  //}
  TVec_RefCDOmBase* filteredChildren = 0;
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
    if((*iter)->getType() != typeFilterA                                  &&
       (*iter)->getType() != typeFilterB                                   ){
      if(!filteredChildren) {
        filteredChildren = new TVec_RefCDOmBase();
      }
      filteredChildren->push_back(*iter);
    }
  }
  return RefTVec_RefCDOmBase(filteredChildren);
}

TULong CDOmBase::getLineNumber() const {
  return m_lineNumber;
}

// visitor pattern
void CDOmBase::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  std::cout << "NOT IMPLEMENTED";
  ASSERT(0, "");
}

// ********************************************************************************
// CDOmComment class
// ********************************************************************************
CDOmComment::CDOmComment(TLineNumberType lineNumber, ECommentType commentType):
  CDOmBase(TYPE_COMMENT, lineNumber),
  m_isAtLeastOneLineLong(false),
  m_commentType(commentType),
  m_commentText(RefTVec_RefString(new TVec_RefString())){}

RefCDOmComment CDOmComment::build(TLineNumberType lineNumber, RefCDOmBase parent, ECommentType commentType, RefString commentLine) {
  ASSERT(commentType > TYPE_UNDEF, "CDOmComment:: build(): invalid input parameters");
  ASSERT(commentLine.get() && commentLine->size(), "CDOmComment::build(): invalid input parameters");
  CDOmComment* comment;
  try {
    comment = new CDOmComment(lineNumber, commentType);
  }
  catch(std::exception& e) {
    ASSERT(0, "New operator failed");
  }

  RefCDOmComment refComment(comment);
  comment->m_weakRef = boost::weak_ptr<CDOmBase>(refComment);
  comment->setParent(parent);

  refComment->addCommentLine(commentLine);
  return refComment;
}

void CDOmComment::addCommentLine(RefString commentLine) {
  if(m_commentType == TYPE_SLASH_SLASH && m_isAtLeastOneLineLong) {
    ASSERT(0, "CDOmComment::addCommentLine(): This is a TYPE_SLASH_SLASH comment. Addinfg another line is illegal");
  }
  m_commentText->push_back(commentLine);
  m_isAtLeastOneLineLong = true;

}

const RefString CDOmComment::getCommentLine(TInt index) const {
  ASSERT(0 <= index && index < m_commentText->size(), "CDOmComment::getCommentLine():index exceeds comment lines vector dimensions");
  return m_commentText->at(index);
}

const RefTVec_RefString CDOmComment::getCommentText() const {
  return m_commentText;
}

const CDOmComment::ECommentType CDOmComment::getCommentType() const {
  return m_commentType;
}

void CDOmComment::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmInclude class
// ********************************************************************************
CDOmInclude::CDOmInclude(TLineNumberType lineNumber, EIncludeFileType type, RefString fileName) : 
  CDOmBase(TYPE_INCLUDE, lineNumber),
  m_fileType(type),
  m_fileName(fileName) {}

RefCDOmInclude CDOmInclude::build(TLineNumberType lineNumber, RefCDOmBase parent, EIncludeFileType type, RefString fileName) {
  //  RefCDOmBase parent = CDOmScopeBlock::getCurrentScope()->getHolderObject();
  //  if (!parent->isUnitDecl()) {
  //    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ILLEGAL_PARENT_UD, args, lineNumber);
  //    cdomHasErrors = TRUE;
  //    //throw NSBase::IllegalArgumentException("UnitDecl::build - parent should be the Design");
  //  }

  CDOmInclude* include;
  try {
    include = new CDOmInclude(lineNumber, type, fileName);
  }
  catch (std::exception& e) {
    ASSERT(0,"new operator failed");
  }

  RefCDOmInclude refInclude(include);
  include->m_weakRef = boost::weak_ptr<CDOmBase>( refInclude);
  include->setParent(parent);
  return refInclude;
}

const RefString CDOmInclude::getFileName() const {
  return m_fileName;
}

const EIncludeFileType CDOmInclude::getFileType() const {
  return m_fileType;
}

void CDOmInclude::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmDefine class
// ********************************************************************************
CDOmDefine::CDOmDefine(TLineNumberType lineNumber, EDefineType defineType, const RefString& textMacroName) : CDOmBase(TYPE_DEFINE, lineNumber), m_defineType(defineType), m_textMacroName(textMacroName) { }

RefCDOmDefine CDOmDefine::cast (RefCDOmBase object) {
  if(!object.get()){
    return RefCDOmDefine();
  }
  ASSERT(object->getType() == TYPE_DEFINE, "type check on CDOmDefine failure");
  return boost::static_pointer_cast<CDOmDefine>(object);
}

RefCDOmDefine CDOmDefine::build(TLineNumberType lineNumber, RefCDOmBase parent, EDefineType defineType, RefString textMacroName, RefCDOmExpr macroText) {
  ASSERT(parent.get(), "parent is NULL");
  CDOmDefine *defineObj = new CDOmDefine(lineNumber, defineType, textMacroName);
  RefCDOmDefine refDefineObj = RefCDOmDefine(defineObj);
  defineObj->m_weakRef = boost::weak_ptr<CDOmBase>( refDefineObj);
  refDefineObj->setParent(parent);
  
  if(macroText.get()){
    macroText->setParent(refDefineObj);
  }
  
  return refDefineObj;
}

const RefString CDOmDefine::getMacroName() const {
  return m_textMacroName;
}

const CDOmDefine::EDefineType CDOmDefine::getDefineType() const {
  return m_defineType;
}

void CDOmDefine::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}



// ********************************************************************************
// CDOmAttrHolder class
// ********************************************************************************
CDOmAttrHolder::CDOmAttrHolder(TLineNumberType lineNumber, ECDOmType type) : CDOmBase(type, lineNumber), m_attrListCollection() {}

void CDOmAttrHolder::setAttrListCollection(RefCDOmAttrListCollection& attrListCollection) {
  ASSERT(attrListCollection.get(), "attrListCollection is NULL");
  if(m_attrListCollection.get()){
    throw NSBase::IllegalStateException("[CDOmAttrHolder::setAttrListCollection()] attrListCollection already set.", m_lineNumber);
  }

  //attrListCollection->setParent(m_weakRef.lock()); // self registration
  attrListCollection->setParent(getThis()); // self registration
  m_attrListCollection = attrListCollection;
}

RefCDOmAttrListCollection CDOmAttrHolder::getAttrListCollection() const {
  return m_attrListCollection;
}

// ********************************************************************************
// CDOmIdentifier class
// ********************************************************************************
CDOmIdentifier::CDOmIdentifier(TLineNumberType lineNumber, ECDOmType type, EIdType idType, const RefString& name, const RefCDOmBase& payload)
  : CDOmBase(type, lineNumber), m_idType(idType), m_name(name), m_payload(payload), m_complementaryID() {}

RefCDOmIdentifier CDOmIdentifier::cast (RefCDOmBase object) {
  ASSERT(object.get(), "casting object is NULL");
  //  ASSERT(object->getType() == TYPE_ID_SCOPE_DIRECT || object->getType() == TYPE_ID_SIMPLE || object->getType() == TYPE_ID_SCOPE_INDIRECT, "illegal object type"); //-------OB commented
  return boost::static_pointer_cast<CDOmIdentifier>(object);
}

TBool CDOmIdentifier::isToScopeDirect(EIdType idType) {
  return idType == ID_MODULE 
    || idType == ID_UDP
    || idType == ID_TASK 
    || idType == ID_FUNCTION 
    || idType == ID_NAMED_BLOCK
    || idType == ID_GEN_ITEM_NAMED_BLOCK
    ;
}

TBool CDOmIdentifier::isToScopeIndirect(EIdType idType) {
  return idType == ID_MODULE_INST || idType == ID_GATE_INST;
}

TBool CDOmIdentifier::supportsPayload() const {
  return
    m_idType == ID_ATTR ||
    m_idType == ID_PARAM ||
    (m_idType == ID_PORT && boost::static_pointer_cast<CDOmPortDecl>(getParent())->getVarType() != VAR_UNDEFINED)  || // only variable output ports
    (m_idType == ID_UDP_PORT_OUTPUT_PL && boost::static_pointer_cast<CDOmUdpPortDeclOutput>(getParent())->getPortType() == CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT_REG) ||
    m_idType == ID_NET ||
    m_idType == ID_VAR ||
    m_idType == ID_EVENT ||
    m_idType == ID_MODULE_INST;
}

void CDOmIdentifier::checkPayload(EIdType idType, ECDOmType payloadType) {
  switch(idType) {
    case ID_ATTR:
    case ID_PARAM:
    case ID_PORT:
    case ID_UDP_PORT_OUTPUT_PL:
      ASSERT(payloadType == TYPE_EXPR, "[CDOmIdentifier::checkPayload()] invalid arguments.");
      //if(payloadType != TYPE_EXPR) {
      //  //throw NSBase::IllegalArgumentException("[CDOmIdentifier::checkPayload()] invalid arguments.");
      //}
      break;
    case ID_NET:
    case ID_VAR:
      ASSERT(payloadType == TYPE_RANGE_LIST || payloadType == TYPE_EXPR, "[CDOmIdentifier::checkPayload()] invalid arguments.");
      //if(payloadType != TYPE_RANGE_LIST && payloadType != TYPE_EXPR) {
      //  throw NSBase::IllegalArgumentException("[CDOmIdentifier::checkPayload()] invalid arguments.");
      //}
      break;
    case ID_MODULE_INST:
      ASSERT(payloadType == TYPE_RANGE, "[CDOmIdentifier::checkPayload()] invalid arguments.");
      //if(payloadType != TYPE_RANGE) {
      //  throw NSBase::IllegalArgumentException("[CDOmIdentifier::checkPayload()] invalid arguments.");
      //}
      break;
    case ID_EVENT:
      ASSERT(payloadType == TYPE_RANGE_LIST, "[CDOmIdentifier::checkPayload()] invalid arguments.");
      //if( payloadType != TYPE_RANGE_LIST ) {
      //  throw NSBase::IllegalArgumentException("[CDOmIdentifier::checkPayload()] invalid arguments.");
      //}
      break;
    default:
      ASSERT(FAIL, "[CDOmIdentifier::checkPayload()] invalid arguments.");
      //throw NSBase::IllegalArgumentException("[CDOmIdentifier::checkPayload()] invalid arguments.");
  }
}

TBool CDOmIdentifier::supportsComplementaryID() const {
  return
    (m_idType == ID_PORT && boost::static_pointer_cast<CDOmPortDecl>(getParent())->getVarType() == VAR_UNDEFINED &&
     boost::static_pointer_cast<CDOmPortDecl>(getParent())->getNetType() == NET_UNDEFINED)  || // only undefined net ports
    (m_idType == ID_TF_PORT && boost::static_pointer_cast<CDOmTFPortDecl>(getParent())->getVarType() == VAR_UNDEFINED) || // only undefined var ports
    m_idType == ID_NET ||
    ( m_idType == ID_UDP_PORT_OUTPUT 
      && boost::static_pointer_cast<CDOmUdpPortDeclOutput>(getParent())->getPortType() != CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT_REG)
    || m_idType == ID_VAR
    || m_idType == ID_GATE_INST;
}

void CDOmIdentifier::setComplementaryID(RefCDOmIdentifier& id) {
  ASSERT(supportsComplementaryID() || m_idType == ID_GATE_INST, "[CDOmIdentifier::setComplementaryID()] illegal state for this method call.");
  //if(!supportsComplementaryID() && m_idType != ID_GATE_INST) {
  //  throw NSBase::IllegalStateException("[CDOmIdentifier::setComplementaryID()] illegal state for this method call.", id->getLineNumber());
  //}
  ASSERT(id.get(), "id is NULL");
  ASSERT(id->supportsComplementaryID() || id->getIdType() == ID_GATE_INST, "[CDOmIdentifier::setComplementaryID()] invalid arguments.");
  //if(!id->supportsComplementaryID() && id->getIdType() != ID_GATE_INST) {
  //  throw NSBase::IllegalStateException("[CDOmIdentifier::setComplementaryID()] invalid arguments.", id->getLineNumber());
  //}
  //TODO check the possible complementary id's again
  if( !((m_idType == ID_VAR || m_idType == ID_PORT || m_idType == ID_TF_PORT) && (id->m_idType == ID_VAR || id->m_idType == ID_TF_PORT || id->m_idType == ID_PORT)) 
      && !((m_idType == ID_NET || m_idType == ID_PORT) && (id->m_idType == ID_NET || id->m_idType == ID_PORT))
      && !(m_idType == ID_GATE_INST && id->m_idType == ID_GATE_INST)
      &&  !(m_idType == ID_UDP_PORT_OUTPUT 
            && boost::static_pointer_cast<CDOmUdpPortDeclOutput>(getParent())->getPortType() == CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT
            && id->m_idType == ID_UDP_PORT_OUTPUT
            && boost::static_pointer_cast<CDOmUdpPortDeclOutput>(id->getParent())->getPortType() == CDOmUdpPortDeclOutput::UDP_DECL_TYPE_REG
            || m_idType == ID_UDP_PORT_OUTPUT 
            && boost::static_pointer_cast<CDOmUdpPortDeclOutput>(getParent())->getPortType() == CDOmUdpPortDeclOutput::UDP_DECL_TYPE_REG
            && id->m_idType == ID_UDP_PORT_OUTPUT
            && boost::static_pointer_cast<CDOmUdpPortDeclOutput>(id->getParent())->getPortType() == CDOmUdpPortDeclOutput::UDP_DECL_TYPE_OUTPUT
            )
      ) {
    args.push_back(*id->getName());
    args.push_back("var, port, tf port or net identifier");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, id->getLineNumber());
    cdomHasErrors = TRUE;
  }
  //throw NSBase::IllegalStateException("[CDOmIdentifier::setComplementaryID()] complementary id mismatch.", id->getLineNumber());
  //if( ( ( (m_idType == ID_PORT || m_idType == ID_TF_PORT) && (id->m_idType == ID_PORT || id->m_idType == ID_TF_PORT)) 
  //  ||( (m_idType == ID_NET || m_idType == ID_VAR) && (id->m_idType == ID_NET || id->m_idType == ID_VAR))
  //  )) {
  //  throw NSBase::IllegalStateException("[CDOmIdentifier::setComplementaryID()] complementary id mismatch.");
  //}
  if((m_complementaryID.get() || id->getComplementaryID().get()) && m_idType != ID_GATE_INST && id->getIdType() != ID_GATE_INST) {
    args.push_back(*id->getName());   
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_COMP_ID, args, id->getLineNumber());
    cdomHasErrors = TRUE;  
    //throw NSBase::IllegalStateException("[CDOmIdentifier::setComplementaryID()] complementary id already set.", id->getLineNumber());
  }

  m_complementaryID = id;
  //id->m_complementaryID = boost::static_pointer_cast<CDOmIdentifier>(m_weakRef.lock()); // update reverse link
  RefCDOmBase identifierAsBase = getThis();
  RefCDOmIdentifier identifier = CDOmIdentifier::cast(identifierAsBase);
  id->m_complementaryID = identifier; // update reverse link
}

RefCDOmIdentifier CDOmIdentifier::getComplementaryID() const {
  ASSERT(supportsComplementaryID(), "[CDOmIdentifier::getComplementaryID()] illegal state for this method call.");
  //if(!supportsComplementaryID()) {
  //  throw NSBase::IllegalStateException("[CDOmIdentifier::getComplementaryID()] illegal state for this method call.");
  //}

  return m_complementaryID;
}

RefCDOmIdentifier CDOmIdentifier::build(TLineNumberType lineNumber, RefCDOmBase parent, EIdType idType, const RefString& name, RefCDOmBase payload) {
  ASSERT(parent.get(), "parent is NULL");
  if(checkIdName(name, lineNumber)) {
    if(payload.get()) {
      checkPayload(idType, payload->getType());
    }

    CDOmIdentifier* id = new CDOmIdentifier(lineNumber, isToScopeDirect(idType) ? TYPE_ID_SCOPE_DIRECT :
                                            isToScopeIndirect(idType) ? TYPE_ID_SCOPE_INDIRECT : TYPE_ID_SIMPLE,
                                            idType, name, payload);
    RefCDOmIdentifier refID(id);
    id->m_weakRef = boost::weak_ptr<CDOmBase>( refID);
    id->setParent(parent); // self registration
    if(payload.get()) {
      payload->setParent(refID); // self registration
    }
    // self register id with the enclosing scope,
    // except for attribute ids, since these are in a separate namespace
    // and for explicit port ids
    // !!!FIX get rid of this particular case: id_named block is bypassed here because of late scope registering
    if(idType != ID_ATTR 
       && idType != ID_EXPLICIT_PORT 
       && idType != ID_NAMED_BLOCK 
       && idType != ID_GEN_ITEM_NAMED_BLOCK
       ) {
      RefCDOmScope scope = parent->getParentScope();
      ASSERT(scope.get(), "NULL scope");
      scope->registerID(refID); // id self registration into enclosing scope
    }
    return refID;
  }
  return RefCDOmIdentifier();
}

CDOmIdentifier::EIdType CDOmIdentifier::getIdType() const {
  return m_idType;
}

const RefString CDOmIdentifier::getName() const {
  return m_name;
}

const RefCDOmBase CDOmIdentifier::getPayload() const {
  ASSERT(supportsPayload(), "[CDOmIdentifier::getPayload()] illegal state for this method call.");
  //if(!supportsPayload()) {
  //  throw NSBase::IllegalStateException("[CDOmIdentifier::getPayload()] illegal state for this method call.", m_lineNumber);
  //}

  return m_payload;
}

RefCDOmScope CDOmIdentifier::toScope() const {
  ASSERT(isToScopeID(), "[CDOmIdentifier::toScope()] illegal state for this method call.");
  //if(!isToScopeID()) {
  //  throw NSBase::IllegalStateException("[CDOmIdentifier::toScope()] illegal state for this method call.", m_lineNumber);
  //}

  if(m_idType == ID_MODULE_INST) {
    // !!!
    //RefCDOmModuleOrUdpInstantiation moduleInst = boost::static_pointer_cast<CDOmModuleOrUdpInstance>(m_parent);
    //RefCDOmExprLink link = moduleInst->getModuleLink();
    //return moduleLink->isResolved() ? moduleLink->getID()->toScope() : RefCDOmScope();
  }
  return getAttachedScope(getParent().get());
}

  //--------OB added----start
  //  void  CDOmIdentifier::setIdType(EIdType idType) {
  //    m_idType = idType;
  //  }
  //-----------end

void CDOmIdentifier::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmIdentifier>(m_weakRef.lock()));
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmScope class
// ********************************************************************************
CDOmScope::CDOmScope(EScopeType scopeType, const RefCDOmIdentifier& id) : m_scopeType(scopeType), m_id(id), m_ids(), m_nameMap() {}

RefCDOmScope CDOmScope::build(const RefCDOmIdentifier& id) {
  EScopeType scopeType;
  if(id.get()) {
    ASSERT(id->getType() == TYPE_ID_SCOPE_DIRECT, "illegal id type");
    switch(id->getIdType()) {
      case CDOmIdentifier::ID_MODULE:                 scopeType = SCOPE_MODULE;                  break;
      case CDOmIdentifier::ID_UDP:                    scopeType = SCOPE_UDP;                     break;
      case CDOmIdentifier::ID_TASK:                   scopeType = SCOPE_TASK;                    break;
      case CDOmIdentifier::ID_FUNCTION:               scopeType = SCOPE_FUNCTION;                break;
      case CDOmIdentifier::ID_NAMED_BLOCK:            scopeType = SCOPE_NAMED_BLOCK;             break;
      case CDOmIdentifier::ID_GEN_ITEM_NAMED_BLOCK:   scopeType = SCOPE_GEN_ITEM_NAMED_BLOCK;    break;
      default: ASSERT(FAIL,"[CDOmScope::build()] bug detected...id type does not corespond to any scope holder object");
        //throw NSBase::IllegalStateException("[CDOmScope::build()] bug detected...", id->getLineNumber());
    }
  }
  else {
    scopeType = SCOPE_DESIGN;
  }
  return RefCDOmScope(new CDOmScope(scopeType, id));
}

RefCDOmIdentifier CDOmScope::lookupDownward(const RefString& name) const {
  TInt idx = name->find(DOT);
  if(idx == 0 || idx == name->length() - 1) {
    args.push_back(*name);
    addErr(NSWarningErr::CSE_CSC_ID_CSE_CSC_ID_ILLEGAL, args, getID()->getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalArgumentException(std::string("[CDOmScope::lookupDownward()] invalid name: " + *name).c_str());
  }

  if(idx != std::string::npos) {
    RefString prefixStr = RefString(new std::string(name->substr(0, idx)));
    if(name->at(idx + 1) == DOT) {
      args.push_back(*name);
      addErr(NSWarningErr::CSE_CSC_ID_CSE_CSC_ID_ILLEGAL, args, getID()->getLineNumber());
      cdomHasErrors = TRUE;
      //throw NSBase::IllegalArgumentException(std::string("[CDOmScope::lookupDownward()] invalid name: " + *name).c_str());
    }
    RefString suffixStr = RefString(new std::string(name->substr(idx + 1)));
    RefCDOmIdentifier id = lookupLocal(prefixStr);
    // check if a valid identifier was found
    if(id.get() && id->isToScopeID()) {
      return id->toScope()->lookupDownward(suffixStr);
    }
    return RefCDOmIdentifier();
  }
  return lookupLocal(name);
}

RefCDOmIdentifier CDOmScope::lookupDownward(const RefTVec_RefString& hid) const {
  if(hid->size() > 1) {
    RefCDOmIdentifier id = lookupLocal(hid->at(0));
    // check if a valid identifier was found
    if(id.get() && id->isToScopeID()) {
      RefTVec_RefString suffixHID = RefTVec_RefString(new TVec_RefString(++hid->begin(), hid->end()));
      return id->toScope()->lookupDownward(suffixHID);
    }
    return RefCDOmIdentifier();
  }
  return lookupLocal(hid->at(0));
}

// this function registers a new identifier in the current scope.
void CDOmScope::registerID(RefCDOmIdentifier& id) {
  ASSERT(id.get(), "found NULL id");
  ASSERT(id->getParent().get(), "id must have a parent");

  if(!m_ids.get()) {
    m_ids = RefTVec_RefCDOmIdentifier(new TVec_RefCDOmIdentifier());
    m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
  }
  else {
    // check for the same name in the scope
    if(containsID(id->getName())) {
      if(!id->supportsComplementaryID()) {
        args.push_back(*id->getName());
        if(getScopeType() != SCOPE_DESIGN) {
          args.push_back(*(getID()->getName()));
        }
        else {
          args.push_back("global");
        }
        addErr(NSWarningErr::CSE_CSC_SCOP_CSE_CSC_SCOP_ID_ALREADY_DEFINED, args, id->getLineNumber());
        cdomHasErrors = TRUE;
        return;
        //std::cerr << "id typ is " << id->getIdType() << std::endl;
        //throw NSBase::IllegalArgumentException(std::string("[CDOmScope::registerID()] identifier name: " + *(id->getName()) + " already defined in scope.").c_str(), id->getLineNumber());
      }
      RefCDOmIdentifier firstID = lookupLocal(id->getName());
      id->setComplementaryID(firstID);
      return; // do not insert the complementary id since it's link is already registered
    }
  }
  m_ids->push_back(id);
  m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(id->getName(), id));
}

CDOmScope::EScopeType CDOmScope::getScopeType() const {
  return m_scopeType;
}

RefCDOmIdentifier CDOmScope::getID() const {
  return m_id;
}

TBool CDOmScope::containsID(const RefString& name) const {
  //if(checkIdName(name, getID()->getLineNumber())) {

  //std::cerr << "looking for id name:" << *name << std::endl;
  //DCERR("looking for id name:" << *name << std::endl);
  if(!m_ids.get()) {
    return FALSE;
  }
  return m_nameMap->find(name) != m_nameMap->end();
  //}
  //return FALSE;
}

// This function returns an identifier in the local scope only, that is
// no downward or upward scope search takes place.
RefCDOmIdentifier CDOmScope::lookupLocal(const RefString& name) const {
  TBool ok = FALSE;
  if(!getID().get()) { // design doesn't have an ID
    ok = checkIdName(name, 0);
  }
  else {
    ok = checkIdName(name, getID()->getLineNumber());
  }
  if(ok) {

    if(!m_ids.get()) {
      return RefCDOmIdentifier();
    }
    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    if(iter == m_nameMap->end()) {
      return RefCDOmIdentifier();
    }
    return iter->second;
  }
  return RefCDOmIdentifier();
}

// This function finds the first identifier match according to scope search rules and idMask
// idMask example: ID_TASK | ID_NAMED_BLOCK
// case example: disable <id>, id can refer to both a task id or a named block id
RefCDOmIdentifier CDOmScope::lookup(const RefString& name, TUInt idMask) const {
  ASSERT(name.get(), "NULL name");
  ASSERT(name->length(), "illegal name (length = 0)");

  RefCDOmIdentifier id = lookupDownward(name);
  // check if a valid identifier was found
  if(id.get() && (id->getType() & idMask)) {
    return id;
  }
  if(m_scopeType == SCOPE_DESIGN) {
    return RefCDOmIdentifier();
  }
  // search shall not cross module boundary
  if(m_id->getType() == TYPE_DECL_MODULE) {
    TInt idx = name->find(DOT);
    if(idx != std::string::npos) {
      if(!name->substr(0, idx).compare(*(m_id->getName()))) {
        RefString suffixStr = RefString(new std::string(name->substr(idx + 1)));
        return lookupDownward(suffixStr);
      }
      return RefCDOmIdentifier();
    }
    if(!name->compare(*(id->getName()))) {
      return m_id;
    }
    return RefCDOmIdentifier();
  }
  // fallback to parent scope
  RefCDOmScope parentScope = m_id->getParentScope();
  if(!parentScope.get()) {
    return RefCDOmIdentifier();
  }
  return parentScope->lookup(name, idMask);
}

// This function finds the first identifier match according to scope search rules and idMask
// idMask example: ID_TASK | ID_NAMED_BLOCK
// case example: disable <id>, id can refer to both a task id or a named block id
RefCDOmIdentifier CDOmScope::lookup(const RefTVec_RefString& hid, TUInt idMask) const {
  ASSERT(hid.get(), "NULL hid");
  ASSERT(hid->size(), "hid size is 0");

  RefCDOmIdentifier id = lookupDownward(hid);
  // check if a valid identifier was found
  if(id.get() && (id->getType() & idMask)) {
    return id;
  }
  if(m_scopeType == SCOPE_DESIGN) {
    return RefCDOmIdentifier();
  }
  // search shall not cross module boundary
  if(m_id->getType() == TYPE_DECL_MODULE) {
    if(hid->size() > 1) {
      if(!hid->at(0)->compare(*(m_id->getName()))) {
        RefTVec_RefString suffixHID = RefTVec_RefString(new TVec_RefString(++hid->begin(), hid->end()));
        return lookupDownward(suffixHID);
      }
      return RefCDOmIdentifier();
    }
    if(!hid->at(0)->compare(*(m_id->getName()))) {
      return m_id;
    }
    return RefCDOmIdentifier();
  }
  // fallback to parent scope
  RefCDOmScope parentScope = m_id->getParentScope();
  if(!parentScope.get()) {
    return RefCDOmIdentifier();
  }
  return parentScope->lookup(hid, idMask);
}

const RefTVec_RefCDOmIdentifier CDOmScope::getIDs() const {
  return m_ids;
}

void CDOmScope::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //to be implemented
}

// ********************************************************************************
// CDOmExpr class
// ********************************************************************************
CDOmExpr::CDOmExpr(TLineNumberType lineNumber, EExprType exprType) : CDOmBase(TYPE_EXPR, lineNumber), m_exprType(exprType), m_cachedEval() {}

RefCDOmExpr CDOmExpr::cast (RefCDOmBase object) {
  ASSERT(object.get(), "casting object is NULL");
  ASSERT(object->getType() == TYPE_EXPR, "object type is different that TYPE_EXPR");
  return boost::static_pointer_cast<CDOmExpr>(object);
}

CDOmExpr::EExprType CDOmExpr::getExprType() const {
  return m_exprType;
}

TBool CDOmExpr::canBeLvalue() const {
  if(getExprType() == EXPR_HID)
    return TRUE;
  else if(getExprType() == EXPR_CONCAT) {
    //RefCDOmExprConcat exprConcat = boost::static_pointer_cast<CDOmExprConcat>(m_weakRef.lock());
    RefCDOmBase exprconcatAsBase = getThis();
    RefCDOmExprConcat exprConcat = CDOmExprConcat::cast(exprconcatAsBase);
    const RefTVec_RefCDOmExpr vectExpr = exprConcat->getChildren<CDOmExpr>(TYPE_EXPR);
    for(TVec_RefCDOmExpr_const_iter it = vectExpr->begin(); it != vectExpr->end(); ++it)
      if( (*it)->getExprType() != EXPR_HID )
        return FALSE;
    return TRUE;
  }
  else
    return FALSE;
}

TBool CDOmExpr::isPrimary() const {
  return
    m_exprType == EXPR_NUMBER ||
    m_exprType == EXPR_REAL_NUMBER ||
    m_exprType == EXPR_HID ||
    m_exprType == EXPR_CONCAT ||
    m_exprType == EXPR_MULTI_CONCAT ||
    m_exprType == EXPR_FUNCTION_CALL ||
    m_exprType == EXPR_MINTYPMAX;
}

const RefTVec_RefCDOmExpr CDOmExpr::getExprs() const {
  return getChildren<CDOmExpr>(TYPE_EXPR);
}

//RefCDOmEvalRes CDOmExpr::eval() const {
//  if(!m_cachedEval.get()) {
//    m_cachedEval = doEval();
//  }
//  return m_cachedEval;
//}

RefCDOmBase CDOmExpr::eval() const {
  if(!m_cachedEval.get()) {
    m_cachedEval = doEval();
  }
  return m_cachedEval;
}

// ********************************************************************************
// CDOmExprLink class
// ********************************************************************************
CDOmExprLink::CDOmExprLink(TLineNumberType lineNumber) : CDOmExpr(lineNumber, CDOmExpr::EXPR_HID),
                                                         m_state(HID_ITEM), m_names(RefTVec_RefString(new TVec_RefString())), m_exprs(RefTVec_RefCDOmExpr(new TVec_RefCDOmExpr())), m_ids(),
                                                         m_arrayIndexes(), m_rangeExpr() {}

RefCDOmExprLink CDOmExprLink::cast (RefCDOmBase object) {
  ASSERT(object.get(), "casting object is NULL");
  ASSERT(object->getType() == TYPE_EXPR, "object type is different that TYPE_EXPR");
  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  RefCDOmBase cdomexprAsBase = object;
  RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
  RefCDOmExpr obj = cdomexpr;
  ASSERT(obj->getExprType() == CDOmExpr::EXPR_HID, "obj type is different that EXPR_HID");
  return boost::static_pointer_cast<CDOmExprLink>(object);
}

RefCDOmExprLink CDOmExprLink::build(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr) {
  CDOmExprLink* exprLink = new CDOmExprLink(lineNumber);
  RefCDOmExprLink refExprLink(exprLink);
  exprLink->m_weakRef = boost::weak_ptr<CDOmBase>( refExprLink);
  exprLink->addHidItem(name, expr);
  if(!exprLinks.get()) {
    exprLinks = RefTVec_RefCDOmExprLink(new TVec_RefCDOmExprLink());
  }
  exprLinks->push_back(refExprLink); // add to global expr links in order to be resolved at linking phase
  return refExprLink;
}

TBool CDOmExprLink::isHID() const {
  return m_names->size() > 1;
}

RefString CDOmExprLink::getName() const {
  if(isHID()) {
    ASSERT(m_names.get(),"[CDOmExprLink::getName() const] illegal state for this method call");
    //throw NSBase::IllegalStateException("[CDOmExprLink::getName()] illegal state for this method call.", m_lineNumber);
  }

  return m_names->at(0);
}

void CDOmExprLink::addHidItem(const RefString& name, RefCDOmExpr expr) {
  ASSERT(m_state == HID_ITEM, "CDOmExprLink m_state is not a HID_ITEM");
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(name->length(), "illegal name length");

    if(expr.get()) {
      //expr->setParent(m_weakRef.lock()); // self registration
      expr->setParent(getThis()); // self registration
    }
    m_names->push_back(name);
    m_exprs->push_back(expr);
  }
}

void CDOmExprLink::setArrayIndexes(RefCDOmListExpr arrayIndexes) {
  ASSERT(m_state == HID_ITEM, "CDOmExprLink m_state is not a HID_ITEM");
  ASSERT(arrayIndexes.get(), "NULL arrayIndexes");
  if(m_arrayIndexes.get()) {
    args.push_back(*getName());
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_INDEX, args, getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmExprLink::setArrayIndexes()] arrayIndexes already set.", m_lineNumber);
  }

  //arrayIndexes->setParent(m_weakRef.lock()); // self registration
  arrayIndexes->setParent(getThis()); // self registration
  m_arrayIndexes = arrayIndexes;
  //update state
  m_state = ARRAY_INDEXES;
}

RefCDOmListExpr CDOmExprLink::getArrayIndexes() const {
  return m_arrayIndexes;
}

void CDOmExprLink::setRangeExpr(RefCDOmRangeExpr rangeExpr) {
  ASSERT(m_state == HID_ITEM || m_state == ARRAY_INDEXES, "illegal m_state");
  ASSERT(rangeExpr.get(), "found NULL rangeExpr");
  if(m_rangeExpr.get()) {
    args.push_back(*getName());
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmExprLink::setRangeExpr()] rangeExpr already set.", m_lineNumber);
  }

  //rangeExpr->setParent(m_weakRef.lock()); // self registration
  rangeExpr->setParent(getThis()); // self registration
  m_rangeExpr = rangeExpr;

  //update state
  m_state = RANGE_EXPR;
}

RefCDOmRangeExpr CDOmExprLink::getRangeExpr() const {
  return m_rangeExpr;
}

TBool CDOmExprLink::isConst() const {
  return true; //!!! fix
  /*
    if(!isResolved()) {
    throw NSBase::IllegalStateException("[CDOmExprLink::isConst()] illegal state for this method call.", m_lineNumber);
    }

    //return m_id; // !!! based on m_id type return isConst status
    return false;*/
}

TBool CDOmExprLink::canBeModulePath() const {
  return !isHID() && !getArrayIndexes().get() && !getRangeExpr().get();
}

TBool CDOmExprLink::isResolved() const {
  return m_ids.get() != 0;
}

RefCDOmIdentifier CDOmExprLink::toID() const {
  ASSERT(isResolved(),"[CDOmExprLink::toID() const] illegal state for this method call");
  //throw NSBase::IllegalStateException("[CDOmExprLink::toID()] illegal state for this method call.", m_lineNumber);

  return m_ids->back();
}

const RefTVec_RefString CDOmExprLink::getHidNames() const {
  ASSERT(isHID(), "[CDOmExprLink::getHidNames() const] illegal ExprLink");  
  //if(!isHID()) {
  //  throw NSBase::IllegalStateException("[CDOmExprLink::getHidNames()] illegal state for this method call.", m_lineNumber);
  //}

  return m_names;
}

const RefTVec_RefCDOmExpr CDOmExprLink::getHidExprs() const {
  ASSERT(isHID(), "[CDOmExprLink::getHidExprs() const] illegal ExprLink");
  //if(!isHID()) {
  //  throw NSBase::IllegalStateException("[CDOmExprLink::getHidExprs()] illegal state for this method call.", m_lineNumber);
  //}

  return m_exprs;
}

//RefCDOmEvalRes CDOmExprLink::doEval() const {
//  ASSERT(isResolved(), "[CDOmExprLink::doEval()] illegal state for this method call.");
//  //if(!isResolved()) {
//  //  throw NSBase::IllegalStateException("[CDOmExprLink::doEval()] illegal state for this method call.", m_lineNumber);
//  //}

//
//  // !!! track m_id eval value and return it
//  return RefCDOmEvalRes();
//}

//RefCDOmBase CDOmExprLink::doEval() const {
//  ASSERT(isResolved(), "[CDOmExprLink::doEval()] illegal state for this method call.");
//  //if(!isResolved()) {
//  //  throw NSBase::IllegalStateException("[CDOmExprLink::doEval()] illegal state for this method call.", m_lineNumber);
//  //}
//
//  // !!! track m_id eval value and return it
//  //return RefCDOmEvalRes();
//  
//}

RefCDOmBase CDOmExprLink::doEval() const {
  //ASSERT(isResolved(), "[CDOmExprLink::doEval()] illegal state for this method call.");
  RefCDOmScope      design   = RefCDOmScope();
  RefCDOmBase       parent   = getParent();
  RefString         name     = RefString();
  RefCDOmIdentifier id       = RefCDOmIdentifier();
  RefTVec_RefString hidNames = RefTVec_RefString(new TVec_RefString());
  TUInt mask = 0;

  if(parent.get()){
    if(parent->getType() == TYPE_MODULE_INSTANTIATION){
      while(parent->getType() != TYPE_DESIGN){
        parent = parent->getParent();
      }
    }
    else {
      while(!parent->isScopeHolder()){
        parent = parent->getParent();
      }
    }
    //RefCDOmScope design = CDOmDesign::cast(parent)->getAttachedScope();
    //RefCDOmScope design = parent->getAttachedScope(parent);

    switch(parent->getType()) {
      case TYPE_DESIGN:
        design = CDOmDesign::cast(parent)->getAttachedScope();
        break;
      case TYPE_DECL_MODULE:
        design = CDOmModuleDecl::cast(parent)->getAttachedScope();
        break;
      case TYPE_DECL_TASK:
        design = CDOmTaskDecl::cast(parent)->getAttachedScope();
        break;
      case TYPE_DECL_FUNCTION:
        design = CDOmFuncDecl::cast(parent)->getAttachedScope();
        break;
      case TYPE_STMT_NAMED_BLOCK:
        design = CDOmStmtBlock::cast(parent)->getAttachedScope();
        break;
      case TYPE_GEN_ITEM_BLOCK_NAMED:
        design = CDOmGenItemBlock::cast(parent)->getAttachedScope();
        break;
      case TYPE_DECL_UDP:
        design = CDOmUdpDecl::cast(parent)->getAttachedScope();
        break;
      default:
        ASSERT(FAIL, "[CDOmBase::getAttachedScope()] bug detected...");
    }

    if(design.get()){
      if(!isHID()){
        name = getName();
        id = design->lookupLocal(name);
      }
      else {
        hidNames = getHidNames();
        //because we want all types the mask is 0xFFFFFFFF
        id = design->lookup(hidNames, ~(mask));
      }
      if(id.get()){
        RefCDOmBase baseObj = id->getParent();
        if(baseObj.get()){
          return baseObj;
        }
        else{
          return RefCDOmBase();
        }
      }
    }
  }
  return RefCDOmBase();
}

void CDOmExprLink::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmExprOp class
// ********************************************************************************
CDOmExprOp::CDOmExprOp(TLineNumberType lineNumber, EOpType opType, TBool isConst, TBool canBeModPath) : 
  CDOmExpr(lineNumber, CDOmExpr::EXPR_OP), m_opType(opType), m_isConst(isConst), m_attrListCollection(), m_canBeModulePath(canBeModPath) {}

RefCDOmExprOp CDOmExprOp::cast (RefCDOmBase object) {
  ASSERT(object.get(), "casting object is NULL");
  ASSERT(object->getType() == TYPE_EXPR, "illegal object type");
  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  RefCDOmBase cdomexprAsBase = object;
  RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
  RefCDOmExpr obj = cdomexpr;
  ASSERT(obj->getExprType() == CDOmExpr::EXPR_OP, "illegal obj type in CDOmExprOp::cast");
  return boost::static_pointer_cast<CDOmExprOp>(object);    
}

RefCDOmExprOp CDOmExprOp::build(TLineNumberType lineNumber, EOpType opType, RefCDOmExpr expr1, RefCDOmExpr expr2, RefCDOmExpr expr3) {
  ASSERT(expr1.get(), "expr1 is NULL");
  TBool isConst = expr1->isConst();
  TBool canBeModulePath = expr1->canBeModulePath();
  switch(opType & OP_MASK) {
    case OP_UNARY_MASK:
      //ASSERT(expr1->isPrimary(), "for unary operators, according to grammar rules, expr must be a primary"); 
      ASSERT(!(expr2.get()), "expr2 should be NULL");
      ASSERT(!(expr3.get()), "expr3 should be NULL");
      break;
    case OP_BINARY_MASK:
      ASSERT(expr2.get(), "expr2 is NULL");
      ASSERT(!(expr3.get()), "expr3 should be NULL");
      isConst = isConst && expr2->isConst();
      canBeModulePath = canBeModulePath && expr2->canBeModulePath();
      break;
    case OP_TERNARY_MASK:
      ASSERT(expr2.get(), "expr2 is NULL");
      ASSERT(expr3.get(), "expr3 is NULL");
      isConst = isConst && expr2->isConst() && expr3->isConst();
      canBeModulePath = canBeModulePath && expr2->canBeModulePath() && expr3->canBeModulePath();
      break;
    default:
      throw NSBase::IllegalStateException("[CDOmExprOp::build()] invalid arguments...", lineNumber);
  }

  canBeModulePath = canBeModulePath && ( opType & OP_MODULE_PATH_MASK );
  CDOmExprOp* exprOp = new CDOmExprOp(lineNumber, opType, isConst, canBeModulePath);
  RefCDOmExprOp refExprOp(exprOp);
  exprOp->m_weakRef = boost::weak_ptr<CDOmBase>( refExprOp);
  expr1->setParent(refExprOp); // self registration
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
      throw NSBase::IllegalStateException("[CDOmExprOp::build()] bug detected...", lineNumber);
  }
  return refExprOp;
}

void CDOmExprOp::setAttrListCollection(RefCDOmAttrListCollection& attrListCollection) {
  ASSERT(attrListCollection.get(), "attrListCollection is NULL");
  ASSERT(!m_attrListCollection.get(), "[CDOmExprOp::setAttrListCollection()] attrListCollection already set.");
  //if(m_attrListCollection.get()){
  //  throw NSBase::IllegalStateException("[CDOmExprOp::setAttrListCollection()] attrListCollection already set.", m_lineNumber);
  //}

  //attrListCollection->setParent(m_weakRef.lock()); // self registration
  attrListCollection->setParent(getThis()); // self registration
  m_attrListCollection = attrListCollection;
}

RefCDOmAttrListCollection CDOmExprOp::getAttrListCollection() const {
  return m_attrListCollection;
}

TBool CDOmExprOp::isConst() const {
  return m_isConst;
}


TBool CDOmExprOp::canBeModulePath() const {
  return m_canBeModulePath;
}

CDOmExprOp::EOpType CDOmExprOp::getOpType() const {
  return m_opType;
}

const RefCDOmExpr CDOmExprOp::getExpr1() const {
  //return boost::static_pointer_cast<CDOmExprOp>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

const RefCDOmExpr CDOmExprOp::getExpr2() const {
  ASSERT(!(m_opType & OP_UNARY_MASK), "[CDOmExprOp::getExpr2()] illegal state for this method call.");
  //if(m_opType & OP_UNARY_MASK) {
  //  throw NSBase::IllegalStateException("[CDOmExprOp::getExpr2()] illegal state for this method call.", m_lineNumber);
  //}

  // return boost::static_pointer_cast<CDOmExprOp>(m_children->at(1));
  RefCDOmBase exprAsBase = getChild(1);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

const RefCDOmExpr CDOmExprOp::getExpr3() const {
  ASSERT(!(m_opType & OP_UNARY_MASK || m_opType & OP_BINARY_MASK), "[CDOmExprOp::getExpr3()] illegal state for this method call.");
  // if(m_opType & OP_UNARY_MASK || m_opType & OP_BINARY_MASK) {
  //   throw NSBase::IllegalStateException("[CDOmExprOp::getExpr3()] illegal state for this method call.", m_lineNumber);
  // }

  //return boost::static_pointer_cast<CDOmExprOp>(m_children->at(2));
  RefCDOmBase exprAsBase = getChild(2);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

TBool CDOmExprOp::isUnary() const {
  return (m_opType & OP_UNARY_MASK) ? true : false;
}

TBool CDOmExprOp::isBinary() const {
  return (m_opType & OP_BINARY_MASK) ? true : false;
}

TBool CDOmExprOp::isTernary() const {
  return (m_opType & OP_TERNARY_MASK) ? true : false;
}
  
//RefCDOmEvalRes CDOmExprOp::doEval() const {
//  // !!! to be completed
//  return RefCDOmEvalRes();
//}

RefCDOmBase CDOmExprOp::doEval() const {
  // !!! to be completed
  return RefCDOmBase();
}

void CDOmExprOp::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
  /*
    switch(m_opType & OP_MASK) {
    case OP_UNARY_MASK: {
    //visitor.visit(boost::static_pointer_cast<CDOmExprOp>(getThis()));    
    //RefCDOmBase exprOpAsBase = getThis();
    //RefCDOmExprOp exprOp = CDOmExprOp::cast(exprOpAsBase);
    visitor.visit(getThis());
    //getExpr1()->acceptVisitor(visitor);
    break;
    }  
    case OP_BINARY_MASK: {
    //visitor.visit(boost::static_pointer_cast<CDOmExprOp>(m_weakRef.lock()));
    getExpr1()->acceptVisitor(visitor);
    //visitor.visit(boost::static_pointer_cast<CDOmExprOp>(m_weakRef.lock()));
    RefCDOmBase exprOpAsBase1 = getThis();
    RefCDOmExprOp exprOp1 = CDOmExprOp::cast(exprOpAsBase1);
    visitor.visit(exprOp1);
    getExpr2()->acceptVisitor(visitor);
    break;
    }
    case OP_TERNARY_MASK: {
    getExpr1()->acceptVisitor(visitor);
    //visitor.visit(boost::static_pointer_cast<CDOmExprOp>(m_weakRef.lock()));
    RefCDOmBase exprOpAsBase2 = getThis();
    RefCDOmExprOp exprOp2 = CDOmExprOp::cast(exprOpAsBase2);
    visitor.visit(exprOp2);
    getExpr2()->acceptVisitor(visitor);
    //visitor.visit(boost::static_pointer_cast<CDOmExprOp>(m_weakRef.lock()));
    RefCDOmBase exprOpAsBase3 = getThis();
    RefCDOmExprOp exprOp3 = CDOmExprOp::cast(exprOpAsBase3);
    visitor.visit(exprOp3);    
    getExpr3()->acceptVisitor(visitor);
    break;
    }
    default:
    throw NSBase::IllegalStateException("[CDOmExprOp::acceptVisitor()] Error", m_lineNumber);
    }
  */
}


// ********************************************************************************
// CDOmListExpr class
// ********************************************************************************

CDOmListExpr::CDOmListExpr(TLineNumberType lineNumber) : CDOmBase(TYPE_LIST_EXPR, lineNumber) { }

RefCDOmListExpr CDOmListExpr::build(TLineNumberType lineNumber,  RefCDOmExpr item) {
  CDOmListExpr* list = new CDOmListExpr(lineNumber);
  RefCDOmListExpr refList(list);
  list->m_weakRef = boost::weak_ptr<CDOmBase>( refList);
  list->addItem(item);
  return refList;
}

void CDOmListExpr::addItem(RefCDOmExpr item) {
  ASSERT(item.get(), "given item is NULL");
  item->setParent(m_weakRef.lock()); // self registration
}

RefTVec_RefCDOmExpr CDOmListExpr::getItems() const {
  return getChildren<CDOmExpr>(TYPE_EXPR);
}

TUInt CDOmListExpr::getNumberOfChildren() const {
  return m_children->size();
}

void CDOmListExpr::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


// ********************************************************************************
// CDOmRangeList class
// ********************************************************************************

CDOmRangeList::CDOmRangeList(TLineNumberType lineNumber) : CDOmBase(TYPE_RANGE_LIST, lineNumber) { }

RefCDOmRangeList CDOmRangeList::build(TLineNumberType lineNumber,  RefCDOmRange item) {
  CDOmRangeList* list = new CDOmRangeList(lineNumber);
  RefCDOmRangeList refList(list);
  list->m_weakRef = boost::weak_ptr<CDOmBase>( refList);
  list->addItem(item);
  return refList;
}

void CDOmRangeList::addItem(RefCDOmRange item) {
  ASSERT(item.get(), "given item is NULL");
  item->setParent(m_weakRef.lock()); // self registration
}

RefTVec_RefCDOmRange CDOmRangeList::getItems() const {
  return getChildren<CDOmRange>(TYPE_RANGE);
}

TUInt CDOmRangeList::getNumberOfChildren() const {
  return m_children->size();
}

void CDOmRangeList::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


// ********************************************************************************
// CDOmSpecifyTerminalList class
// ********************************************************************************

CDOmSpecifyTerminalList::CDOmSpecifyTerminalList(TLineNumberType lineNumber) : CDOmBase(TYPE_SPEC_TERM_LIST, lineNumber) { }

RefCDOmSpecifyTerminalList CDOmSpecifyTerminalList::build(TLineNumberType lineNumber,  RefCDOmExprLink item) {
  CDOmSpecifyTerminalList* list = new CDOmSpecifyTerminalList(lineNumber);
  RefCDOmSpecifyTerminalList refList(list);
  list->m_weakRef = boost::weak_ptr<CDOmBase>( refList);
  list->addItem(item);
  return refList;
}

void CDOmSpecifyTerminalList::addItem(RefCDOmExprLink item) {
  ASSERT(item.get(), "given item is NULL");
  validateSpecifyTerminal(item);
  item->setParent(m_weakRef.lock()); // self registration
}

RefTVec_RefCDOmExprLink CDOmSpecifyTerminalList::getItems() const {
  return getChildren<CDOmExprLink>(TYPE_HID_ITEMS);
}

TUInt CDOmSpecifyTerminalList::getNumberOfChildren() const {
  return m_children->size();
}

void CDOmSpecifyTerminalList::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}


// ********************************************************************************
// CDOmMinTypMaxList class
// ********************************************************************************

CDOmMinTypMaxList::CDOmMinTypMaxList(TLineNumberType lineNumber) : CDOmBase(TYPE_MINTYPMAX_LIST, lineNumber) { }

RefCDOmMinTypMaxList CDOmMinTypMaxList::build(TLineNumberType lineNumber,  RefCDOmMinTypMax item) {
  CDOmMinTypMaxList* list = new CDOmMinTypMaxList(lineNumber);
  RefCDOmMinTypMaxList refList(list);
  list->m_weakRef = boost::weak_ptr<CDOmBase>( refList);
  list->addItem(item);
  return refList;
}

void CDOmMinTypMaxList::addItem(RefCDOmMinTypMax item) {
  ASSERT(item.get(), "given item is NULL");
  item->setParent(m_weakRef.lock()); // self registration
}

RefTVec_RefCDOmMinTypMax CDOmMinTypMaxList::getItems() const {
  return getChildren<CDOmMinTypMax>(TYPE_EXPR);
}

TUInt CDOmMinTypMaxList::getNumberOfChildren() const {
  return m_children->size();
}

void CDOmMinTypMaxList::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}



// ********************************************************************************
// CDOmExprConcat class
// ********************************************************************************
CDOmExprConcat::CDOmExprConcat(TLineNumberType lineNumber) : CDOmExpr(lineNumber, CDOmExpr::EXPR_CONCAT), m_isConst(true), m_canBeModulePath(true) {}

RefCDOmExprConcat CDOmExprConcat::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmExprConcat::cast");
  ASSERT(object->getType() == TYPE_EXPR, "illegal object type in CDOmExprOp::cast");
  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  RefCDOmBase exprAsBase = object;
  RefCDOmExpr obj = CDOmExpr::cast(exprAsBase);
  ASSERT(obj->getExprType() == CDOmExpr::EXPR_CONCAT, "illegal obj type in CDOmExprOp::cast");
  return boost::static_pointer_cast<CDOmExprConcat>(object);
}

RefCDOmExprConcat CDOmExprConcat::build(TLineNumberType lineNumber, RefCDOmExpr expr) {
  CDOmExprConcat* exprConcat = new CDOmExprConcat(lineNumber);
  RefCDOmExprConcat refExprConcat(exprConcat);
  exprConcat->m_weakRef = boost::weak_ptr<CDOmBase>( refExprConcat);
  exprConcat->addExpr(expr);
  return refExprConcat;
}

TBool CDOmExprConcat::isConst() const {
  return m_isConst;
}

TBool CDOmExprConcat::canBeModulePath() const {
  return m_canBeModulePath;
}

void CDOmExprConcat::addExpr(RefCDOmExpr expr) {
  ASSERT(expr.get(), "found NULL expr");

  //expr->setParent(m_weakRef.lock()); // self registration
  expr->setParent(getThis()); // self registration
  m_isConst &= expr->isConst();

  m_canBeModulePath &= expr->canBeModulePath();
}

//RefCDOmEvalRes CDOmExprConcat::doEval() const {
//  // !!! to be completed
//  return RefCDOmEvalRes();
//}

RefCDOmBase CDOmExprConcat::doEval() const {
  // !!! to be completed
  return RefCDOmBase();
}

void CDOmExprConcat::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  /* visitor.setInList();
  //visitor.visit(boost::static_pointer_cast<CDOmExprConcat>(m_weakRef.lock())); // print out the opening curly brace
  RefCDOmBase exprconcatAsBase = getThis();
  RefCDOmExprConcat exprconcat = CDOmExprConcat::cast(exprconcatAsBase);
  visitor.visit(exprconcat);
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
  (*iter)->acceptVisitor(visitor);
  //visitor.visit(boost::static_pointer_cast<CDOmExprConcat>(m_weakRef.lock())); // print out the commas
  RefCDOmBase exprconcatAsBase = getThis();
  RefCDOmExprConcat exprconcat = CDOmExprConcat::cast(exprconcatAsBase);
  visitor.visit(exprconcat);
  }
  //visitor.visit(boost::static_pointer_cast<CDOmExprConcat>(m_weakRef.lock())); // print out the closing curly brace
  RefCDOmBase exprconcatAsBase1 = getThis();
  RefCDOmExprConcat exprconcat1 = CDOmExprConcat::cast(exprconcatAsBase1);
  visitor.visit(exprconcat1);
  visitor.clrInList();*/
  visitor.visit(getThis());

}

// ********************************************************************************
// CDOmExprMultiConcat class
// ********************************************************************************
CDOmExprMultiConcat::CDOmExprMultiConcat(TLineNumberType lineNumber, TBool canBeModPath) : CDOmExpr(lineNumber, CDOmExpr::EXPR_MULTI_CONCAT), m_canBeModulePath(canBeModPath) {}

RefCDOmExprMultiConcat CDOmExprMultiConcat::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmExprMultiConcat::cast");
  ASSERT(object->getType() == TYPE_EXPR, "illegal object type in CDOmExprMultiConcat::cast");
  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  RefCDOmBase cdomexprAsBase = object;
  RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
  RefCDOmExpr obj = cdomexpr;
  ASSERT(obj->getExprType() == CDOmExpr::EXPR_MULTI_CONCAT, "illegal obj type in CDOmExprMultiConcat::cast");
  return boost::static_pointer_cast<CDOmExprMultiConcat>(object);
}

RefCDOmExprMultiConcat CDOmExprMultiConcat::build(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmExprConcat& exprConcat) {
  ASSERT(expr.get(), "found NULL expr");
  ASSERT(exprConcat.get(), "exprConcat is a NULL object");
  ASSERT(expr->isConst(), "expr is const");

  CDOmExprMultiConcat* exprMultiConcat = new CDOmExprMultiConcat(lineNumber, exprConcat->canBeModulePath());
  RefCDOmExprMultiConcat refExprMultiConcat(exprMultiConcat);
  exprMultiConcat->m_weakRef = boost::weak_ptr<CDOmBase>( refExprMultiConcat);
  expr->setParent(refExprMultiConcat); // self registration
  exprConcat->setParent(refExprMultiConcat); // self registration
  return refExprMultiConcat;
}

TBool CDOmExprMultiConcat::isConst() const {
  return getExprConcat()->isConst();
}

TBool CDOmExprMultiConcat::canBeModulePath() const {
  return m_canBeModulePath;
}

RefCDOmExpr CDOmExprMultiConcat::getExpr() const {
  // return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmExprConcat CDOmExprMultiConcat::getExprConcat() const {
  //return boost::static_pointer_cast<CDOmExprConcat>(m_children->at(1));
  RefCDOmBase exprConcatAsBase = getChild(1);
  RefCDOmExprConcat exprConcat = CDOmExprConcat::cast(exprConcatAsBase);
  return exprConcat;
}

//RefCDOmEvalRes CDOmExprMultiConcat::doEval() const {
//  // !!! to be completed
//  return RefCDOmEvalRes();
//}

RefCDOmBase CDOmExprMultiConcat::doEval() const {
  // !!! to be completed
  return RefCDOmBase();
}

void CDOmExprMultiConcat::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  /*
  // fix look at the nesting of the arrays
  visitor.setInList();
  //visitor.visit(boost::static_pointer_cast<CDOmExprMultiConcat>(m_weakRef.lock())); // print out the opening curly brace
  RefCDOmBase exprmulticoncatAsBase = getThis();
  RefCDOmExprMultiConcat exprmulticoncat = CDOmExprMultiConcat::cast(exprmulticoncatAsBase);
  visitor.visit(exprmulticoncat);
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
  (*iter)->acceptVisitor(visitor);
  //visitor.visit(boost::static_pointer_cast<CDOmExprMultiConcat>(m_weakRef.lock())); // print out the commas
  RefCDOmBase exprmulticoncatAsBase = getThis();
  RefCDOmExprMultiConcat exprmulticoncat = CDOmExprMultiConcat::cast(exprmulticoncatAsBase);
  visitor.visit(exprmulticoncat);
  }
  //visitor.visit(boost::static_pointer_cast<CDOmExprMultiConcat>(m_weakRef.lock())); // print out the closing curly brace
  RefCDOmBase exprmulticoncatAsBase1 = getThis();
  RefCDOmExprMultiConcat exprmulticoncat1 = CDOmExprMultiConcat::cast(exprmulticoncatAsBase1);
  visitor.visit(exprmulticoncat1);
  visitor.clrInList();*/
  visitor.visit(getThis());

}

// ********************************************************************************
// CDOmAttrList class
// ********************************************************************************
//const RefCDOmNumber CDOmAttrList::ATTR_DEFAULT_VALUE = CDOmNumber::build(0, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("1")), RefString(new std::string("1")));
const RefCDOmNumber CDOmAttrList::ATTR_DEFAULT_VALUE = CDOmNumber::build(0, CDOmNumber::NUM_BASE_BIN, RefString(new std::string("1")), false);

CDOmAttrList::CDOmAttrList(TLineNumberType lineNumber) : CDOmBase(TYPE_ATTR_LIST, lineNumber), m_nameMMap() {}

RefCDOmAttrList CDOmAttrList::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmAttrList::cast");
  ASSERT(object->getType() == TYPE_ATTR_LIST, "illegal object type in CDOmAttrList::cast");
  return boost::static_pointer_cast<CDOmAttrList>(object);
}

RefCDOmAttrList CDOmAttrList::build(TLineNumberType lineNumber, RefCDOmAttrListCollection parent) {
  ASSERT(parent.get(), "parent is a NULL object");

  CDOmAttrList* attrList = new CDOmAttrList(lineNumber);
  RefCDOmAttrList refAttrList(attrList);
  attrList->m_weakRef = boost::weak_ptr<CDOmBase>( refAttrList);
  attrList->setParent(parent); // self registration
  return refAttrList;
}

const RefCDOmNumber CDOmAttrList::getAttrDefaultValue() {
  return ATTR_DEFAULT_VALUE;
}

void CDOmAttrList::addAttr(TLong lineNumber, const RefString& name, RefCDOmExpr expr) {
  if(checkIdName(name, lineNumber)) {
    if(expr.get()) {
      ASSERT(expr->isConst(), "expr is const");
    }

    if(!m_nameMMap.get()) {
      m_nameMMap = RefTMultiMap_RefString_RefCDOmIdentifier(new TMultiMap_RefString_RefCDOmIdentifier());
    }
    else {
      // check for duplicates and issue a warning if found
      if(m_nameMMap->find(name) != m_nameMMap->end()) {
        args.push_back(*name);
        addErr(NSWarningErr::VEW_CDC_PARM_DUPLICATE_ATTR_NAME_CDV, args, m_lineNumber);
        //std::cerr << "[CDOmAttrList::addAttr()] WARNING: duplicate attribute name found: " << *name << std::endl;
      }
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_ATTR, name, expr);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_ATTR, name, expr);
    m_nameMMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

TBool CDOmAttrList::containsAttr(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMMap.get()) {
      return FALSE;
    }
    return m_nameMMap->find(name) != m_nameMMap->end();
  }
  return FALSE;
}

// attributes whose values are null, that is, that is, calling get() on returned object returns 0,
// should use the default value provided by static function getAttrDefaultValue()
RefCDOmExpr CDOmAttrList::getAttrVal(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {
    if(!m_nameMMap.get()) {
      throw NSBase::IllegalArgumentException(std::string("[CDOmAttrList::getAttrVal()] attribute: " + *name + " not found.").c_str(), m_lineNumber);
    }

    TMultiMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMMap->upper_bound(name);
    --iter;
    if(iter->first->compare(*name)) {
      throw NSBase::IllegalArgumentException(std::string("[CDOmAttrList::getAttrVal()] attribute: " + *name + " not found.").c_str(), m_lineNumber);
    }
    //return boost::static_pointer_cast<CDOmExpr>(iter->second->getPayload());
    RefCDOmBase cdomexprAsBase = iter->second->getPayload();
    RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
    return cdomexpr;
  }
  return RefCDOmExpr();
}

const RefTVec_RefCDOmIdentifier CDOmAttrList::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmAttrList::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  /* 
  // fix read the .h file
  //visitor.visit(boost::static_pointer_cast<CDOmAttrList>(m_weakRef.lock()));
  RefCDOmBase attrlistAsBase = getThis();
  RefCDOmAttrList attrlist = CDOmAttrList::cast(attrlistAsBase);
  visitor.visit(attrlist);
  visitor.setInList();
  //visitor.visit(boost::static_pointer_cast<CDOmAttrList>(m_weakRef.lock())); // print out the opening paren
  RefCDOmBase attrlistAsBase1 = getThis();
  RefCDOmAttrList attrlist1 = CDOmAttrList::cast(attrlistAsBase1);
  visitor.visit(attrlist1);
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
  (*iter)->acceptVisitor(visitor);
  //visitor.visit(boost::static_pointer_cast<CDOmAttrList>(m_weakRef.lock())); // print out the commas
  RefCDOmBase attrlistAsBase = getThis();
  RefCDOmAttrList attrlist = CDOmAttrList::cast(attrlistAsBase);
  visitor.visit(attrlist);
  }
  //visitor.visit(boost::static_pointer_cast<CDOmAttrList>(m_weakRef.lock())); // print out the closing paren
  RefCDOmBase attrlistAsBase2 = getThis();
  RefCDOmAttrList attrlist2 = CDOmAttrList::cast(attrlistAsBase2);
  visitor.visit(attrlist2);
  visitor.clrInList();
  */
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmAttrListCollection class
// ********************************************************************************
CDOmAttrListCollection::CDOmAttrListCollection(TLineNumberType lineNumber) : CDOmBase(TYPE_ATTR_LIST_COLLECTION, lineNumber) {}

RefCDOmAttrListCollection CDOmAttrListCollection::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmAttrListCollection::cast");
  ASSERT(object->getType() == TYPE_ATTR_LIST_COLLECTION, "illegal object type in CDOmAttrListCollection::cast");
  return boost::static_pointer_cast<CDOmAttrListCollection>(object);
}
RefCDOmAttrListCollection CDOmAttrListCollection::build(TLineNumberType lineNumber) {
  CDOmAttrListCollection* attrListCollection = new CDOmAttrListCollection(lineNumber);
  RefCDOmAttrListCollection refAttrListCollection(attrListCollection);
  attrListCollection->m_weakRef = boost::weak_ptr<CDOmBase>( refAttrListCollection);
  return refAttrListCollection;
}

RefCDOmAttrList CDOmAttrListCollection::buildAttrList(TLineNumberType lineNumber) {
  //return CDOmAttrList::build(lineNumber, boost::static_pointer_cast<CDOmAttrListCollection>(m_weakRef.lock()));
  RefCDOmBase attrlistcollectionAsBase = getThis();
  RefCDOmAttrListCollection attrlistcollection = CDOmAttrListCollection::cast(attrlistcollectionAsBase);
  return CDOmAttrList::build(lineNumber, attrlistcollection );
}

const RefTVec_RefCDOmAttrList CDOmAttrListCollection::getAttrLists() const {
  return getChildren<CDOmAttrList>(TYPE_ATTR_LIST);
}

void CDOmAttrListCollection::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  /*
  // !!! FIX to be completed
  visitor.setInList();
  //visitor.visit(boost::static_pointer_cast<CDOmAttrListCollection>(m_weakRef.lock())); // print out the opening paren
  RefCDOmBase attrlistcollectionAsBase = getThis();
  RefCDOmAttrListCollection attrlistcollection = CDOmAttrListCollection::cast(attrlistcollectionAsBase);
  visitor.visit(attrlistcollection);
  for(TVec_RefCDOmBase_const_iter iter = m_children->begin(); iter != m_children->end(); ++iter) {
  (*iter)->acceptVisitor(visitor);
  //visitor.visit(boost::static_pointer_cast<CDOmAttrListCollection>(m_weakRef.lock())); // print out the commas
  RefCDOmBase attrlistcollectionAsBase = getThis();
  RefCDOmAttrListCollection attrlistcollection = CDOmAttrListCollection::cast(attrlistcollectionAsBase);
  visitor.visit(attrlistcollection);
  }
  //visitor.visit(boost::static_pointer_cast<CDOmAttrListCollection>(m_weakRef.lock())); // print out the closing paren
  RefCDOmBase attrlistcollectionAsBase1 = getThis();
  RefCDOmAttrListCollection attrlistcollection1 = CDOmAttrListCollection::cast(attrlistcollectionAsBase1);
  visitor.visit(attrlistcollection1);
  visitor.clrInList();
  */
  visitor.visit(getThis());

}

// ********************************************************************************
// CDOmStmt class
// ********************************************************************************
CDOmStmt::CDOmStmt(TLineNumberType lineNumber, EStmtType stmtType) :
  CDOmAttrHolder(lineNumber, stmtType == STMT_BLOCK_NAMED ? TYPE_STMT_NAMED_BLOCK : TYPE_STMT), m_stmtType(stmtType) {}

RefCDOmStmt CDOmStmt::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmt::cast");
  ASSERT(object->getType() == TYPE_STMT || object->getType() == TYPE_STMT_NAMED_BLOCK, "illegal object type in CDOmStmt::cast");
  return boost::static_pointer_cast<CDOmStmt>(object);
}

RefCDOmStmt CDOmStmt::buildNullStmt(TLineNumberType lineNumber) {
  CDOmStmt* stmt = new CDOmStmt(lineNumber, STMT_NULL);
  RefCDOmStmt refStmt(stmt);
  stmt->m_weakRef = boost::weak_ptr<CDOmBase>( refStmt);
  return refStmt;
}

CDOmStmt::EStmtType CDOmStmt::getStmtType() const {
  return m_stmtType;
}

void CDOmStmt::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(getThis());
   
  switch(getStmtType()) {
    case STMT_ASSN : {
      //(boost::static_pointer_cast<CDOmStmtAssn >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtassnAsBase = getThis();
      RefCDOmStmtAssn cdomstmtassn = CDOmStmtAssn::cast(cdomstmtassnAsBase);
      cdomstmtassn->acceptVisitor(visitor);
      break;
    }  
    case STMT_CASE : {
      //(boost::static_pointer_cast<CDOmStmtCase >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtcaseAsBase = getThis();
      RefCDOmStmtCase cdomstmtcase = CDOmStmtCase::cast(cdomstmtcaseAsBase);
      cdomstmtcase->acceptVisitor(visitor);
      break;
    }  
    case STMT_IF : {
      //(boost::static_pointer_cast<CDOmStmtIf >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtifAsBase = getThis();
      RefCDOmStmtIf cdomstmtif = CDOmStmtIf::cast(cdomstmtifAsBase);
      cdomstmtif->acceptVisitor(visitor);
      break;
    }  
    case STMT_DISABLE : {
      //(boost::static_pointer_cast<CDOmStmtDisable >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtdisableAsBase = getThis();
      RefCDOmStmtDisable cdomstmtdisable = CDOmStmtDisable::cast(cdomstmtdisableAsBase);
      cdomstmtdisable->acceptVisitor(visitor);
      break;
    }  
    case STMT_EVENT_TRIGGER : {
      //(boost::static_pointer_cast<CDOmStmtEventTrigger >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmteventtriggerAsBase = getThis();
      RefCDOmStmtEventTrigger cdomstmteventtrigger = CDOmStmtEventTrigger::cast(cdomstmteventtriggerAsBase);
      cdomstmteventtrigger->acceptVisitor(visitor);
      break;
    }  
    case STMT_LOOP : {
      //(boost::static_pointer_cast<CDOmStmtLoop >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtloopAsBase = getThis();
      RefCDOmStmtLoop cdomstmtloop = CDOmStmtLoop::cast(cdomstmtloopAsBase);
      cdomstmtloop->acceptVisitor(visitor);
      break;
    } 
    
    case STMT_BLOCK_NAMED : {
      //(boost::static_pointer_cast<CDOmStmtBlock >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtblockAsBase = getThis();
      RefCDOmStmtBlock cdomstmtblock = CDOmStmtBlock::cast(cdomstmtblockAsBase);
      cdomstmtblock->acceptVisitor(visitor);
      break;
    }  
    case STMT_BLOCK_UNNAMED : {
      //(boost::static_pointer_cast<CDOmStmtBlock >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtblockAsBase = getThis();
      RefCDOmStmtBlock cdomstmtblock = CDOmStmtBlock::cast(cdomstmtblockAsBase);
      cdomstmtblock->acceptVisitor(visitor);
      break;
    }  
        
    case STMT_PROC_CONT_ASSN : {
      //(boost::static_pointer_cast<CDOmStmtProcContAssn >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtproccontassnAsBase = getThis();
      RefCDOmStmtProcContAssn cdomstmtproccontassn = CDOmStmtProcContAssn::cast(cdomstmtproccontassnAsBase);
      cdomstmtproccontassn->acceptVisitor(visitor);
      break;
    }  
    case STMT_PROC_TIMING_CONTROL : {
      //(boost::static_pointer_cast<CDOmStmtProcTimingControl >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtproctimingcontrolAsBase = getThis();
      RefCDOmStmtProcTimingControl cdomstmtproctimingcontrol = CDOmStmtProcTimingControl::cast(cdomstmtproctimingcontrolAsBase);
      cdomstmtproctimingcontrol->acceptVisitor(visitor);
      break;
    }  
    case STMT_TASK_ENABLE : {
      //(boost::static_pointer_cast<CDOmStmtTaskEnable >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmttaskenableAsBase = getThis();
      RefCDOmStmtTaskEnable cdomstmttaskenable = CDOmStmtTaskEnable::cast(cdomstmttaskenableAsBase);
      cdomstmttaskenable->acceptVisitor(visitor);
      break;
    }  
    case STMT_WAIT : {
      //(boost::static_pointer_cast<CDOmStmtWait >(m_weakRef.lock()))->acceptVisitor(visitor);
      RefCDOmBase cdomstmtwaitAsBase = getThis();
      RefCDOmStmtWait cdomstmtwait = CDOmStmtWait::cast(cdomstmtwaitAsBase);
      cdomstmtwait->acceptVisitor(visitor);
      break;
    }  
       

    case STMT_NULL : {
      //RefCDOmBase cdomStmtNullAsBase = getThis();
      //RefCDOmStmt cdomStmtNull = CDOmStmt::cast(cdomStmtNullAsBase);
      //RefCDOmStmt cdomStmtNull = getThis();
      //cdomStmtNull->acceptVisitor(visitor);
      visitor.visit(getThis());
      break;
    }
    default:
      ASSERT(FAIL, "[CDOmStmt::acceptVisitor()] Error");
      //throw NSBase::IllegalStateException("[CDOmStmt::acceptVisitor()] Error", m_lineNumber);
  }
  

}

// ********************************************************************************
// CDOmStmtAssn class
// ********************************************************************************
CDOmStmtAssn::CDOmStmtAssn(TLineNumberType lineNumber, EAssnType assnType, EControlType controlType) : CDOmStmt(lineNumber, STMT_ASSN), m_assnType(assnType), m_controlType(controlType) {}

RefCDOmStmtAssn CDOmStmtAssn::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtAssn::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtAssn::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_ASSN, "illegal obj type in CDOmStmtAssn::cast");
  return boost::static_pointer_cast<CDOmStmtAssn>(object);
}

RefCDOmStmtAssn CDOmStmtAssn::buildSimple(TLineNumberType lineNumber, EAssnType assnType, RefCDOmExpr lvalue, RefCDOmExpr expr) {
  ASSERT(lvalue.get(), "found NULL RefCDOmExpr lvalue");
  ASSERT(expr.get(), "found NULL expr object");
  ASSERT(lvalue->canBeLvalue(), "lvalue is not a left value expression");

  CDOmStmtAssn* stmtAssn = new CDOmStmtAssn(lineNumber, assnType, CONTROL_NONE);
  RefCDOmStmtAssn refStmtAssn(stmtAssn);
  stmtAssn->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtAssn);
  lvalue->setParent(refStmtAssn); // self registration
  expr->setParent(refStmtAssn); // self registration
  return refStmtAssn;
}

RefCDOmStmtAssn CDOmStmtAssn::buildWithDelayControl(TLineNumberType lineNumber, EAssnType assnType, RefCDOmExpr lvalue, RefCDOmExpr expr, RefCDOmDelayControl delayControl) {
  ASSERT(lvalue.get(), "found NULL RefCDOmExpr lvalue");
  ASSERT(expr.get(), "found NULL RefCDOmExpr expr");
  ASSERT(delayControl.get(), "found NULL delayControl object");
  ASSERT(lvalue->canBeLvalue(), "lvalue is not a left value expression ");

  CDOmStmtAssn* stmtAssn = new CDOmStmtAssn(lineNumber, assnType, CONTROL_DELAY_CONTROL);
  RefCDOmStmtAssn refStmtAssn(stmtAssn);
  stmtAssn->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtAssn);
  lvalue->setParent(refStmtAssn); // self registration
  expr->setParent(refStmtAssn); // self registration
  delayControl->setParent(refStmtAssn); // self registration
  return refStmtAssn;
}

RefCDOmStmtAssn CDOmStmtAssn::buildWithEventControl(TLineNumberType lineNumber, EAssnType assnType, RefCDOmExpr lvalue, RefCDOmExpr expr, RefCDOmEventControl eventControl, RefCDOmExpr repeatExpr) {
  ASSERT(lvalue.get(), "found NULL RefCDOmExpr lvalue");
  ASSERT(expr.get(), "found NULL RefCDOmExpr expr");
  ASSERT(eventControl.get(), "found NULL eventControl");
  ASSERT(lvalue->canBeLvalue(), "lvalue is not a left value expression");

  CDOmStmtAssn* stmtAssn = new CDOmStmtAssn(lineNumber, assnType, repeatExpr.get() ? CONTROL_REPEAT_EVENT_CONTROL : CONTROL_EVENT_CONTROL);
  RefCDOmStmtAssn refStmtAssn(stmtAssn);
  stmtAssn->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtAssn);
  lvalue->setParent(refStmtAssn); // self registration
  expr->setParent(refStmtAssn); // self registration
  eventControl->setParent(refStmtAssn); // self registration
  if(repeatExpr.get()) {
    repeatExpr->setParent(refStmtAssn); // self registration
  }
  return refStmtAssn;
}

CDOmStmtAssn::EAssnType CDOmStmtAssn::getAssnType() const {
  return m_assnType;
}

CDOmStmtAssn::EControlType CDOmStmtAssn::getControlType() const {
  return m_controlType;
}

RefCDOmExpr CDOmStmtAssn::getLvalue() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmExpr CDOmStmtAssn::getExpr() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(1));
  RefCDOmBase exprAsBase = getChild(1);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmDelayControl CDOmStmtAssn::getDelayControl() const {
  ASSERT(m_controlType == CONTROL_DELAY_CONTROL, "[CDOmStmtAssn::getDelayControl()] illegal state for this method call.");
  //if(m_controlType != CONTROL_DELAY_CONTROL) {
  //  throw NSBase::IllegalStateException("[CDOmStmtAssn::getDelayControl()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmDelayControl>(m_children->at(2));
  RefCDOmBase delayControlAsBase = getChild(2);
  RefCDOmDelayControl delayControl = CDOmDelayControl::cast(delayControlAsBase);
  return delayControl;
}

RefCDOmEventControl CDOmStmtAssn::getEventControl() const {
  ASSERT(m_controlType == CONTROL_EVENT_CONTROL || m_controlType == CONTROL_REPEAT_EVENT_CONTROL, "[CDOmStmtAssn::getEventControl()] illegal state for this method call.");
  //if(m_controlType != CONTROL_EVENT_CONTROL && m_controlType != CONTROL_REPEAT_EVENT_CONTROL) {
  //  throw NSBase::IllegalStateException("[CDOmStmtAssn::getEventControl()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmEventControl>(m_children->at(2));
  RefCDOmBase eventControlAsBase = getChild(2);
  RefCDOmEventControl eventControl = CDOmEventControl::cast(eventControlAsBase);
  return eventControl;
}

RefCDOmExpr CDOmStmtAssn::getRepeatExpr() const {
  ASSERT(m_controlType == CONTROL_REPEAT_EVENT_CONTROL, "[CDOmStmtAssn::getRepeatExpr()] illegal state for this method call.");
  //if(m_controlType != CONTROL_REPEAT_EVENT_CONTROL) {
  //  throw NSBase::IllegalStateException("[CDOmStmtAssn::getRepeatExpr()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(3));
  RefCDOmBase exprAsBase = getChild(3);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

void CDOmStmtAssn::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmDelayControl class
// ********************************************************************************
CDOmDelayControl::CDOmDelayControl(TLineNumberType lineNumber, EDelayControlType delayControlType)
  : CDOmBase(TYPE_DELAY_CONTROL, lineNumber), m_delayControlType(delayControlType) {}

RefCDOmDelayControl CDOmDelayControl::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmDelayControl::cast");
  ASSERT(object->getType() == TYPE_DELAY_CONTROL, "illegal object type in CDOmDelayControl::cast");
  return boost::static_pointer_cast<CDOmDelayControl>(object);
}

RefCDOmDelayControl CDOmDelayControl::build(TLineNumberType lineNumber, RefCDOmNumber num) {
  ASSERT(num.get(), "RefCDOmNumber num is NULL");
  ASSERT(!num->isSigned(), "num is signed");
  ASSERT(num->getNumBaseType() == CDOmNumber::NUM_BASE_DEC, "illegal num base type");

  CDOmDelayControl* delayControl = new CDOmDelayControl(lineNumber, DELAY_CONTROL_UNSIGNED_NUMBER);
  RefCDOmDelayControl refDelayControl(delayControl);
  delayControl->m_weakRef = boost::weak_ptr<CDOmBase>( refDelayControl);
  num->setParent(refDelayControl); // self registration
  return refDelayControl;
}

RefCDOmDelayControl CDOmDelayControl::build(TLineNumberType lineNumber, RefCDOmReal realNum) {
  ASSERT(realNum.get(), "RefCDOmReal realNum is NULL");

  CDOmDelayControl* delayControl = new CDOmDelayControl(lineNumber, DELAY_CONTROL_REAL_NUMBER);
  RefCDOmDelayControl refDelayControl(delayControl);
  delayControl->m_weakRef = boost::weak_ptr<CDOmBase>( refDelayControl);
  realNum->setParent(refDelayControl); // self registration
  return refDelayControl;
}

RefCDOmDelayControl CDOmDelayControl::build(TLineNumberType lineNumber, RefCDOmExprLink exprLink) {
  ASSERT(exprLink.get(), "found NULL exprLink");
  ASSERT(!exprLink->isHID(), "exprLink should not be HID");

  CDOmDelayControl* delayControl = new CDOmDelayControl(lineNumber, DELAY_CONTROL_IDENTIFIER);
  RefCDOmDelayControl refDelayControl(delayControl);
  delayControl->m_weakRef = boost::weak_ptr<CDOmBase>( refDelayControl);
  exprLink->setParent(refDelayControl); // self registration
  return refDelayControl;
}

RefCDOmDelayControl CDOmDelayControl::build(TLineNumberType lineNumber, RefCDOmMinTypMax minTypMax) {
  ASSERT(minTypMax.get(), "minTypMax is NULL");

  CDOmDelayControl* delayControl = new CDOmDelayControl(lineNumber, DELAY_CONTROL_MINTYPMAX);
  RefCDOmDelayControl refDelayControl(delayControl);
  delayControl->m_weakRef = boost::weak_ptr<CDOmBase>( refDelayControl);
  minTypMax->setParent(refDelayControl); // self registration
  return refDelayControl;
}

CDOmDelayControl::EDelayControlType CDOmDelayControl::getDelayControlType() const {
  return m_delayControlType;
}

RefCDOmNumber CDOmDelayControl::getNumber() const {
  ASSERT(m_delayControlType == DELAY_CONTROL_UNSIGNED_NUMBER, "[CDOmDelayControl::getNumber()] illegal state for this method call.");
  //if(m_delayControlType != DELAY_CONTROL_UNSIGNED_NUMBER) {
  //  throw NSBase::IllegalStateException("[CDOmDelayControl::getNumber()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmNumber>(m_children->at(0));
  RefCDOmBase numberAsBase = getChild(0);
  RefCDOmNumber number = CDOmNumber::cast(numberAsBase);
  return number;

}

RefCDOmReal CDOmDelayControl::getRealNumber() const {
  ASSERT(m_delayControlType == DELAY_CONTROL_REAL_NUMBER, "[CDOmDelayControl::getRealNumber()] illegal state for this method call.");
  //if(m_delayControlType != DELAY_CONTROL_REAL_NUMBER) {
  //  throw NSBase::IllegalStateException("[CDOmDelayControl::getRealNumber()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmReal>(m_children->at(0));
  RefCDOmBase realAsBase = getChild(0);
  RefCDOmReal real = CDOmReal::cast(realAsBase);
  return real;

}

RefCDOmExprLink CDOmDelayControl::getExprLink() const {
  ASSERT(m_delayControlType == DELAY_CONTROL_IDENTIFIER, "[CDOmDelayControl::getExprLink()] illegal state for this method call.");
  //if(m_delayControlType != DELAY_CONTROL_IDENTIFIER) {
  //  throw NSBase::IllegalStateException("[CDOmDelayControl::getExprLink()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprLinkAsBase = getChild(0);
  RefCDOmExprLink exprLink = CDOmExprLink::cast(exprLinkAsBase);
  return exprLink;
}

RefCDOmMinTypMax CDOmDelayControl::getMinTypMax() const {
  ASSERT(m_delayControlType == DELAY_CONTROL_MINTYPMAX, "[CDOmDelayControl::getMinTypMax()] illegal state for this method call.");
  //if(m_delayControlType != DELAY_CONTROL_MINTYPMAX) {
  //  throw NSBase::IllegalStateException("[CDOmDelayControl::getMinTypMax()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(0));
  RefCDOmBase minTypMaxAsBase = getChild(0);
  RefCDOmMinTypMax minTypMax = CDOmMinTypMax::cast(minTypMaxAsBase);
  return minTypMax;
}

void CDOmDelayControl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmEventControl class
// ********************************************************************************
CDOmEventControl::CDOmEventControl(TLineNumberType lineNumber, EEventControlType eventControlType) : CDOmBase(TYPE_EVENT_CONTROL, lineNumber), m_eventControlType(eventControlType) {}

RefCDOmEventControl CDOmEventControl::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmEventControl::cast");
  ASSERT(object->getType() == TYPE_EVENT_CONTROL, "illegal object type in CDOmEventControl::cast");
  return boost::static_pointer_cast<CDOmEventControl>(object);
}

RefCDOmEventControl CDOmEventControl::build(TLineNumberType lineNumber, RefCDOmExprLink hid) {
  ASSERT(hid.get(), "RefCDOmExprLink hid is NULL");

  CDOmEventControl* eventControl = new CDOmEventControl(lineNumber, EVENT_CONTROL_HID);
  RefCDOmEventControl refEventControl(eventControl);
  eventControl->m_weakRef = boost::weak_ptr<CDOmBase>( refEventControl);
  hid->setParent(refEventControl); // self registration
  return refEventControl;
}

RefCDOmEventControl CDOmEventControl::build(TLineNumberType lineNumber, RefCDOmEventExpr eventExpr) {
  ASSERT(eventExpr.get(), "eventExpr is NULL");

  CDOmEventControl* eventControl = new CDOmEventControl(lineNumber, EVENT_CONTROL_EVENT_EXPR);
  RefCDOmEventControl refEventControl(eventControl);
  eventControl->m_weakRef = boost::weak_ptr<CDOmBase>( refEventControl);
  eventExpr->setParent(refEventControl); // self registration
  return refEventControl;
}

RefCDOmEventControl CDOmEventControl::build(TLineNumberType lineNumber, TBool starWithParenthesis) {
  CDOmEventControl* eventControl = new CDOmEventControl(lineNumber, starWithParenthesis ? EVENT_CONTROL_STAR_WITH_PARENTHESIS : EVENT_CONTROL_STAR);
  RefCDOmEventControl refEventControl(eventControl);
  eventControl->m_weakRef = boost::weak_ptr<CDOmBase>( refEventControl);
  return refEventControl;
}

CDOmEventControl::EEventControlType CDOmEventControl::getEventControlType() const {
  return m_eventControlType;
}

RefCDOmExprLink CDOmEventControl::getHID() const {
  ASSERT(m_eventControlType == EVENT_CONTROL_HID, "[CDOmEventControl::getHID()] illegal state for this method call.");
  //if(m_eventControlType != EVENT_CONTROL_HID) {
  //  throw NSBase::IllegalStateException("[CDOmEventControl::getHID()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprLinkAsBase = getChild(0);
  RefCDOmExprLink exprLink = CDOmExprLink::cast(exprLinkAsBase);
  return exprLink;

}

RefCDOmEventExpr CDOmEventControl::getEventExpr() const {
  ASSERT(m_eventControlType == EVENT_CONTROL_EVENT_EXPR, "[CDOmEventControl::getEventExpr()] illegal state for this method call.");
  //if(m_eventControlType != EVENT_CONTROL_EVENT_EXPR) {
  //  throw NSBase::IllegalStateException("[CDOmEventControl::getEventExpr()] illegal state for this method call.", m_lineNumber); 
  //}

  //return boost::static_pointer_cast<CDOmEventExpr>(m_children->at(0));
  RefCDOmBase eventExprAsBase = getChild(0);
  RefCDOmEventExpr eventExpr = CDOmEventExpr::cast(eventExprAsBase);
  return eventExpr;
}

void CDOmEventControl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmEventExpr class
// ********************************************************************************
CDOmEventExpr::CDOmEventExpr(TLineNumberType lineNumber, EEventExprType eventExprType) : CDOmBase(TYPE_EVENT_EXPR, lineNumber), m_eventExprType(eventExprType) {}

RefCDOmEventExpr CDOmEventExpr::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmEventExpr::cast");
  ASSERT(object->getType() == TYPE_EVENT_EXPR, "illegal object type in CDOmEventExpr::cast");
  return boost::static_pointer_cast<CDOmEventExpr>(object);
}

RefCDOmEventExpr CDOmEventExpr::build(TLineNumberType lineNumber, EEventExprType eventExprType, RefCDOmExpr expr) {
  ASSERT(eventExprType == EVENT_EXPR_EXPR || eventExprType == EVENT_EXPR_POSEDGE || eventExprType == EVENT_EXPR_NEGEDGE, "[CDOmEventExpr::build()] invalid arguments.");
  //if(eventExprType != EVENT_EXPR_EXPR && eventExprType != EVENT_EXPR_POSEDGE && eventExprType != EVENT_EXPR_NEGEDGE) {
  //  throw NSBase::IllegalArgumentException("[CDOmEventExpr::build()] invalid arguments.", lineNumber);
  //}
  ASSERT(expr.get(), "RefCDOmExpr expr NULL");

  CDOmEventExpr* eventExpr = new CDOmEventExpr(lineNumber, eventExprType);
  RefCDOmEventExpr refEventExpr(eventExpr);
  eventExpr->m_weakRef = boost::weak_ptr<CDOmBase>( refEventExpr);
  expr->setParent(refEventExpr); // self registration
  return refEventExpr;
}

RefCDOmEventExpr CDOmEventExpr::build(TLineNumberType lineNumber, EEventExprType eventExprType, RefCDOmEventExpr eventExpr1, RefCDOmEventExpr eventExpr2) {
  ASSERT(eventExprType == EVENT_EXPR_OR || eventExprType == EVENT_EXPR_COMMA, "[CDOmEventExpr::build()] invalid arguments.");
  //if(eventExprType != EVENT_EXPR_OR && eventExprType != EVENT_EXPR_COMMA) {
  //  throw NSBase::IllegalArgumentException("[CDOmEventExpr::build()] invalid arguments.", lineNumber);
  //}
  ASSERT(eventExpr1.get(), "eventExpr1 is NULL");
  ASSERT(eventExpr2.get(), "eventExpr2 is NULL");

  CDOmEventExpr* eventExpr = new CDOmEventExpr(lineNumber, eventExprType);
  RefCDOmEventExpr refEventExpr(eventExpr);
  eventExpr->m_weakRef = boost::weak_ptr<CDOmBase>( refEventExpr);
  eventExpr1->setParent(refEventExpr); // self registration
  eventExpr2->setParent(refEventExpr); // self registration
  return refEventExpr;
}

const CDOmEventExpr::EEventExprType CDOmEventExpr::getEventExprType() const {
  return m_eventExprType;
}

RefCDOmExpr CDOmEventExpr::getExpr() const {
  ASSERT(m_eventExprType == EVENT_EXPR_EXPR || m_eventExprType == EVENT_EXPR_POSEDGE || m_eventExprType == EVENT_EXPR_NEGEDGE, "[CDOmEventExpr::getExpr()] illegal state for this method call.");
  //if(m_eventExprType != EVENT_EXPR_EXPR && m_eventExprType != EVENT_EXPR_POSEDGE && m_eventExprType != EVENT_EXPR_NEGEDGE) {
  //  throw NSBase::IllegalStateException("[CDOmEventExpr::getExpr()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;

}

RefCDOmEventExpr CDOmEventExpr::getEventExpr1() const {
  ASSERT(m_eventExprType == EVENT_EXPR_OR || m_eventExprType == EVENT_EXPR_COMMA, "[CDOmEventExpr::getEventExpr1()] illegal state for this method call.");
  //if(m_eventExprType != EVENT_EXPR_OR && m_eventExprType != EVENT_EXPR_COMMA) {
  //  throw NSBase::IllegalStateException("[CDOmEventExpr::getEventExpr1()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmEventExpr>(m_children->at(0));
  RefCDOmBase eventExprAsBase = getChild(0);
  RefCDOmEventExpr eventExpr = CDOmEventExpr::cast(eventExprAsBase);
  return eventExpr;

}

RefCDOmEventExpr CDOmEventExpr::getEventExpr2() const {
  ASSERT(m_eventExprType == EVENT_EXPR_OR || m_eventExprType == EVENT_EXPR_COMMA, "[CDOmEventExpr::getEventExpr2()] illegal state for this method call.");
  //if(m_eventExprType != EVENT_EXPR_OR && m_eventExprType != EVENT_EXPR_COMMA) {
  //  throw NSBase::IllegalStateException("[CDOmEventExpr::getEventExpr2()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmEventExpr>(m_children->at(1));
  RefCDOmBase eventExprAsBase = getChild(1);
  RefCDOmEventExpr eventExpr = CDOmEventExpr::cast(eventExprAsBase);
  return eventExpr;
}

void CDOmEventExpr::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtCase class
// ********************************************************************************
CDOmStmtCase::CDOmStmtCase(TLineNumberType lineNumber, ECaseType caseType) : CDOmStmt(lineNumber, STMT_CASE), m_caseType(caseType), m_hasDefault(false) {}

RefCDOmStmtCase CDOmStmtCase::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtCase::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtCase::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_CASE, "illegal obj type in CDOmStmtCase::cast");
  return boost::static_pointer_cast<CDOmStmtCase>(object);
}

// a null exprList means "default:"
RefCDOmStmtCase CDOmStmtCase::build(TLineNumberType lineNumber, ECaseType caseType, RefCDOmExpr expr, RefCDOmListExpr exprList, RefCDOmStmt stmt) {
  ASSERT(expr.get(), "RefCDOmExpr expr is NULL");

  CDOmStmtCase* stmtCase = new CDOmStmtCase(lineNumber, caseType);
  RefCDOmStmtCase refStmtCase(stmtCase);
  stmtCase->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtCase);
  expr->setParent(refStmtCase); // self registration
  stmtCase->addCaseItem(exprList, stmt);
  return refStmtCase;
}

TBool CDOmStmtCase::hasDefault() const {
  return m_hasDefault;
}

CDOmStmtCase::ECaseType CDOmStmtCase::getCaseType() const {
  return m_caseType;
}

// a null exprList means "default:"
void CDOmStmtCase::addCaseItem(RefCDOmListExpr exprList, RefCDOmStmt stmt) {
  ASSERT(stmt.get(), "RefCDOmStmt stmt is NULL");

  if(!exprList.get()) {
    if(m_hasDefault) {
      addErr(NSWarningErr::VHE_CSC_CSI_FULL_CASE_HAS_DEFAULT_CSCVH, args, getLineNumber());
      //throw NSBase::IllegalStateException("[CDOmStmtCase::addCaseItem()] already has default.", m_lineNumber);
    }
    m_hasDefault = true;
  }
  else {
    //exprList->setParent(m_weakRef.lock()); // self registration
    exprList->setParent(getThis()); // self registration
  }
  //stmt->setParent(m_weakRef.lock()); // self registration
  stmt->setParent(getThis()); // self registration
}

void CDOmStmtCase::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtIf class
// ********************************************************************************
CDOmStmtIf::CDOmStmtIf(TLineNumberType lineNumber) : CDOmStmt(lineNumber, STMT_IF) {}

RefCDOmStmtIf CDOmStmtIf::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtIf::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtIf::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_IF, "illegal obj type in CDOmStmtIf::cast");
  return boost::static_pointer_cast<CDOmStmtIf>(object);
}

// a null elseStmt means no else
RefCDOmStmtIf CDOmStmtIf::build(TLineNumberType lineNumber, RefCDOmExpr ifCondExpr, RefCDOmStmt ifStmt, RefCDOmStmt elseStmt) {
  ASSERT(ifCondExpr.get(), "ifCondExpr is NULL");
  ASSERT(ifStmt.get(), "ifStmt is NULL");

  CDOmStmtIf* stmtIf = new CDOmStmtIf(lineNumber);
  RefCDOmStmtIf refStmtIf(stmtIf);
  stmtIf->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtIf);
  ifCondExpr->setParent(refStmtIf); // self registration
  ifStmt->setParent(refStmtIf); // self registration
  if(elseStmt.get()) {
    elseStmt->setParent(refStmtIf); // self registration
  }
  return refStmtIf;
}
  
RefCDOmExpr CDOmStmtIf::getIfCondExpr() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmStmt CDOmStmtIf::getIfStmt() const {
  //return boost::static_pointer_cast<CDOmStmt>(m_children->at(1));
  RefCDOmBase stmtAsBase = getChild(1);
  RefCDOmStmt stmt = CDOmStmt::cast(stmtAsBase);
  return stmt;
}

RefCDOmStmt CDOmStmtIf::getElseStmt() const {
  if(m_children->size() >= 3) {
    //return boost::static_pointer_cast<CDOmStmt>(m_children->at(2));
    RefCDOmBase stmtAsBase = getChild(2);
    //std::cout << "type of if else is " << stmtAsBase->getType() << std::endl;
    if(stmtAsBase->getType() == TYPE_STMT){
      RefCDOmStmt stmt = CDOmStmt::cast(stmtAsBase);
      return stmt; 
    }
  }
  return RefCDOmStmt();
}

void CDOmStmtIf::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtDisable class
// ********************************************************************************
CDOmStmtDisable::CDOmStmtDisable(TLineNumberType lineNumber) : CDOmStmt(lineNumber, STMT_DISABLE) {}

RefCDOmStmtDisable CDOmStmtDisable::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtDisable::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtDisable::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_DISABLE, "illegal obj type in CDOmStmtDisable::cast");
  return boost::static_pointer_cast<CDOmStmtDisable>(object);
}

RefCDOmStmtDisable CDOmStmtDisable::build(TLineNumberType lineNumber, RefCDOmExprLink hid) {
  ASSERT(hid.get(), "RefCDOmExprLink hid is NULL");

  CDOmStmtDisable* stmtDisable = new CDOmStmtDisable(lineNumber);
  RefCDOmStmtDisable refStmtDisable(stmtDisable);
  stmtDisable->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtDisable);
  hid->setParent(refStmtDisable); // self registration
  return refStmtDisable;
}

RefCDOmExprLink CDOmStmtDisable::getHID() const {
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprLinkAsBase = getChild(0);
  RefCDOmExprLink exprLink = CDOmExprLink::cast(exprLinkAsBase);
  return exprLink; 
}

void CDOmStmtDisable::acceptVisitor(NSCdomVisitor::CVisitor &visitor) const{
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtEventTrigger class
// ********************************************************************************
CDOmStmtEventTrigger::CDOmStmtEventTrigger(TLineNumberType lineNumber) : CDOmStmt(lineNumber, STMT_EVENT_TRIGGER) {}

RefCDOmStmtEventTrigger CDOmStmtEventTrigger::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtEventTrigger::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtEventTrigger::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_EVENT_TRIGGER, "illeagal obj type in CDOmStmtEventTrigger::cast");
  return boost::static_pointer_cast<CDOmStmtEventTrigger>(object);
}

RefCDOmStmtEventTrigger CDOmStmtEventTrigger::build(TLineNumberType lineNumber, RefCDOmExprLink hid, RefCDOmListExpr exprList) {
  ASSERT(hid.get(), "RefCDOmExprLink hid is NULL");

  CDOmStmtEventTrigger* stmtEventTrigger = new CDOmStmtEventTrigger(lineNumber);
  RefCDOmStmtEventTrigger refStmtEventTrigger(stmtEventTrigger);
  stmtEventTrigger->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtEventTrigger);
  hid->setParent(refStmtEventTrigger); // self registration
  if(exprList.get()) {
    exprList->setParent(refStmtEventTrigger); // self registration
  }
  return refStmtEventTrigger;
}

RefCDOmExprLink CDOmStmtEventTrigger::getHID() const {
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprLinkAsBase = getChild(0);
  RefCDOmExprLink exprLink = CDOmExprLink::cast(exprLinkAsBase);
  return exprLink; 
}

RefCDOmListExpr CDOmStmtEventTrigger::getExprList() const {
  if(m_children->size() == 2) {
    return boost::static_pointer_cast<CDOmListExpr>(m_children->at(1));
    /* RefCDOmBase listExprAsBase = getChild(1);
       RefCDOmListExpr listExpr = CDOmListExpr::cast(listExprAsBase);
       return listExpr;*/
  }
  return RefCDOmListExpr();
}

void CDOmStmtEventTrigger::acceptVisitor(NSCdomVisitor::CVisitor &visitor) const{
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtLoop class
// ********************************************************************************
CDOmStmtLoop::CDOmStmtLoop(TLineNumberType lineNumber, ELoopType loopType) : CDOmStmt(lineNumber, STMT_LOOP), m_loopType(loopType) {}

RefCDOmStmtLoop CDOmStmtLoop::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtLoop::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtLoop::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_LOOP, "illegal obj type in CDOmStmtLoop::cast");
  return boost::static_pointer_cast<CDOmStmtLoop>(object);
}

RefCDOmStmtLoop CDOmStmtLoop::buildForeverStmt(TLineNumberType lineNumber, RefCDOmStmt stmt) {
  ASSERT(stmt.get() && stmt->getStmtType() != CDOmStmt::STMT_NULL, "stmt is NULL or has illegal type");

  CDOmStmtLoop* stmtLoop = new CDOmStmtLoop(lineNumber, LOOP_FOREVER);
  RefCDOmStmtLoop refStmtLoop(stmtLoop);
  stmtLoop->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtLoop);
  stmt->setParent(refStmtLoop); // self registration
  return refStmtLoop;
}

RefCDOmStmtLoop CDOmStmtLoop::buildRepeatStmt(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmStmt stmt) {
  ASSERT(expr.get(), "expr is NULL");
  ASSERT(stmt.get() && stmt->getStmtType() != CDOmStmt::STMT_NULL, "stmt is NULL or has illeagal type");

  CDOmStmtLoop* stmtLoop = new CDOmStmtLoop(lineNumber, LOOP_REPEAT);
  RefCDOmStmtLoop refStmtLoop(stmtLoop);
  stmtLoop->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtLoop);
  expr->setParent(refStmtLoop); // self registration
  stmt->setParent(refStmtLoop); // self registration
  return refStmtLoop;
}

RefCDOmStmtLoop CDOmStmtLoop::buildWhileStmt(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmStmt stmt) {
  ASSERT(expr.get(), "expr is NULL");
  ASSERT(stmt.get() && stmt->getStmtType() != CDOmStmt::STMT_NULL, "stmt is NULL or has illegal type");

  CDOmStmtLoop* stmtLoop = new CDOmStmtLoop(lineNumber, LOOP_WHILE);
  RefCDOmStmtLoop refStmtLoop(stmtLoop);
  stmtLoop->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtLoop);
  expr->setParent(refStmtLoop); // self registration
  stmt->setParent(refStmtLoop); // self registration
  return refStmtLoop;
}

RefCDOmStmtLoop CDOmStmtLoop::buildForStmt(TLineNumberType lineNumber, RefCDOmAssn initAssn, RefCDOmExpr condExpr, RefCDOmAssn incAssn, RefCDOmStmt stmt) {
  ASSERT(initAssn.get(), "initAssn is NULL");
  ASSERT(condExpr.get(), "condExpr is NULL");
  ASSERT(incAssn.get(), "incAssn is NULL");
  ASSERT(stmt.get() && stmt->getStmtType() != CDOmStmt::STMT_NULL, "stmt is NULL or has illeagl type");

  CDOmStmtLoop* stmtLoop = new CDOmStmtLoop(lineNumber, LOOP_FOR);
  RefCDOmStmtLoop refStmtLoop(stmtLoop);
  stmtLoop->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtLoop);
  initAssn->setParent(refStmtLoop); // self registration
  condExpr->setParent(refStmtLoop); // self registration
  incAssn->setParent(refStmtLoop);   // self registration
  stmt->setParent(refStmtLoop);   // self registration
  return refStmtLoop;
}

CDOmStmtLoop::ELoopType CDOmStmtLoop::getLoopType() const {
  return m_loopType;
}

RefCDOmStmt CDOmStmtLoop::getStmt() const {
  TUInt idx;
  switch(m_loopType) {
    case LOOP_FOREVER:
      idx = 0;
      break;
    case LOOP_REPEAT:
    case LOOP_WHILE:
      idx = 1;
      break;
    case LOOP_FOR:
      idx = 3;
      break;
    default:
      throw NSBase::IllegalStateException("[CDOmStmtLoop::getStmt()] bug detected...", m_lineNumber);
  }
  //return boost::static_pointer_cast<CDOmStmt>(m_children->at(idx));
  RefCDOmBase stmtAsBase = getChild(idx);
  RefCDOmStmt stmt = CDOmStmt::cast(stmtAsBase);
  return stmt;
}

// in case of for loop this returns condForExpr
RefCDOmExpr CDOmStmtLoop::getExpr() const {
  TUInt idx;
  switch(m_loopType) {
    case LOOP_FOREVER:
      throw NSBase::IllegalStateException("[CDOmStmtLoop::getExpr()] illegal state for this method call.", m_lineNumber);
    case LOOP_REPEAT:
    case LOOP_WHILE:
      idx = 0;
      break;
    case LOOP_FOR:
      idx = 1;
      break;
    default:
      throw NSBase::IllegalStateException("[CDOmStmtLoop::getExpr()] bug detected...", m_lineNumber);
  }
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(idx));
  RefCDOmBase exprAsBase = getChild(idx);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmAssn CDOmStmtLoop::getInitForAssn() const {
  ASSERT(m_loopType == LOOP_FOR, "[CDOmStmtLoop::getInitForAssn()] illegal state for this method call.");
  //if(m_loopType != LOOP_FOR) {
  //  throw NSBase::IllegalStateException("[CDOmStmtLoop::getInitForAssn()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmAssn>(m_children->at(0));
  RefCDOmBase assnAsBase = getChild(0);
  RefCDOmAssn assn = CDOmAssn::cast(assnAsBase);
  return assn;
}

RefCDOmAssn CDOmStmtLoop::getIncForAssn() const {
  ASSERT(m_loopType == LOOP_FOR, "[CDOmStmtLoop::getIncForAssn()] illegal state for this method call.");
  //if(m_loopType != LOOP_FOR) {
  //  throw NSBase::IllegalStateException("[CDOmStmtLoop::getIncForAssn()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmAssn>(m_children->at(2));
  RefCDOmBase assnAsBase = getChild(2);
  RefCDOmAssn assn = CDOmAssn::cast(assnAsBase);
  return assn;
}

void CDOmStmtLoop::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtBlock class
// ********************************************************************************
CDOmStmtBlock::CDOmStmtBlock(TLineNumberType lineNumber, EBlockType blockType, TBool isNamed)
  : CDOmStmt(lineNumber, isNamed ? STMT_BLOCK_NAMED : STMT_BLOCK_UNNAMED), m_blockType(blockType), m_scope() {}
  
RefCDOmStmtBlock CDOmStmtBlock::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtBlock::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtBlock::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_BLOCK_UNNAMED || obj->getStmtType() == CDOmStmt::STMT_BLOCK_NAMED, "obj has illeagal type");
  return boost::static_pointer_cast<CDOmStmtBlock>(object);
}

RefCDOmStmtBlock CDOmStmtBlock::build(TLineNumberType lineNumber, EBlockType blockType, const RefString& name) {
  CDOmStmtBlock* stmtBlock = new CDOmStmtBlock(lineNumber, blockType, name.get() ? true : false);
  RefCDOmStmtBlock refStmtBlock(stmtBlock);
  stmtBlock->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtBlock);
  if(name.get()) {
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, refStmtBlock, CDOmIdentifier::ID_NAMED_BLOCK, name);
    // initialize attached scope
    stmtBlock->m_scope = CDOmScope::build(id);
  }
  return refStmtBlock;
}

RefCDOmScope CDOmStmtBlock::getAttachedScope() const {
  ASSERT(isNamed(), "[CDOmStmtBlock::getAttachedScope()] illegal state for this method call.");
  //if(!isNamed()) {
  //  throw NSBase::IllegalStateException("[CDOmStmtBlock::getAttachedScope()] illegal state for this method call.", m_lineNumber);
  //}

  return m_scope;
}

CDOmStmtBlock::EBlockType CDOmStmtBlock::getBlockType() const {
  return m_blockType;
}

TBool CDOmStmtBlock::isNamed() const {
  return getStmtType() == STMT_BLOCK_NAMED;
}

void CDOmStmtBlock::addStmt(RefCDOmStmt stmt) {
  ASSERT(stmt.get() && stmt->getStmtType() != CDOmStmt::STMT_NULL, "stmt is NULL or has illegal type");

  //stmt->setParent(m_weakRef.lock()); // self registration
  stmt->setParent(getThis()); // self registration
}

const RefTVec_RefCDOmStmt CDOmStmtBlock::getStmts() const {
  return getChildren<CDOmStmt>(TYPE_STMT);
}

void CDOmStmtBlock::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmAssn class
// ********************************************************************************
CDOmAssn::CDOmAssn(TLineNumberType lineNumber) : CDOmBase(TYPE_ASSN, lineNumber) {}

RefCDOmAssn CDOmAssn::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmAssn::cast");
  ASSERT(object->getType() == TYPE_ASSN, "illegal object type in CDOmAssn::cast");
  return boost::static_pointer_cast<CDOmAssn>(object);
}

RefCDOmAssn CDOmAssn::build(TLineNumberType lineNumber, RefCDOmExpr lvalue, RefCDOmExpr expr) {
  ASSERT(lvalue.get(), "lvalue is NULL");
  ASSERT(expr.get(), "expr is NULL");
  ASSERT(lvalue->canBeLvalue(), "lvalue is not a left value expression");

  CDOmAssn* assn = new CDOmAssn(lineNumber);
  RefCDOmAssn refAssn(assn);
  assn->m_weakRef = boost::weak_ptr<CDOmBase>( refAssn);
  lvalue->setParent(refAssn); // self registration
  expr->setParent(refAssn); // self registration
  return refAssn;
}

RefCDOmExpr CDOmAssn::getLvalue() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmExpr CDOmAssn::getExpr() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(1));
  RefCDOmBase exprAsBase = getChild(1);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

void CDOmAssn::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtProcContAssn class
// ********************************************************************************
CDOmStmtProcContAssn::CDOmStmtProcContAssn(TLineNumberType lineNumber, EProcContAssnType procContAssnType) : CDOmStmt(lineNumber, STMT_PROC_CONT_ASSN), m_procContAssnType(procContAssnType) {}

RefCDOmStmtProcContAssn CDOmStmtProcContAssn::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtProcContAssn::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtProcContAssn::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_PROC_CONT_ASSN, "illegal obj type in CDOmStmtProcContAssn::cast");
  return boost::static_pointer_cast<CDOmStmtProcContAssn>(object);
}

RefCDOmStmtProcContAssn CDOmStmtProcContAssn::build(TLineNumberType lineNumber, EProcContAssnType procContAssnType, RefCDOmAssn assn) {
  ASSERT(procContAssnType == PROC_CONT_ASSN_ASSIGN || procContAssnType == PROC_CONT_ASSN_FORCE, "procContAssnType has illegal type");
  ASSERT(assn.get(), "assn is NULL");

  CDOmStmtProcContAssn* stmtProcContAssn = new CDOmStmtProcContAssn(lineNumber, procContAssnType);
  RefCDOmStmtProcContAssn refStmtProcContAssn(stmtProcContAssn);
  stmtProcContAssn->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtProcContAssn);
  assn->setParent(refStmtProcContAssn); // self registration
  return refStmtProcContAssn;
}

RefCDOmStmtProcContAssn CDOmStmtProcContAssn::build(TLineNumberType lineNumber, EProcContAssnType procContAssnType, RefCDOmExpr lvalue) {
  ASSERT(procContAssnType == PROC_CONT_ASSN_DEASSIGN || procContAssnType == PROC_CONT_ASSN_RELEASE, "procContAssnType has illegal type");
  ASSERT(lvalue.get(), "lvalue is NULL");
  ASSERT(lvalue->canBeLvalue(), "lvalue is not a left value expression");

  CDOmStmtProcContAssn* stmtProcContAssn = new CDOmStmtProcContAssn(lineNumber, procContAssnType);
  RefCDOmStmtProcContAssn refStmtProcContAssn(stmtProcContAssn);
  stmtProcContAssn->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtProcContAssn);
  lvalue->setParent(refStmtProcContAssn); // self registration
  return refStmtProcContAssn;
}

CDOmStmtProcContAssn::EProcContAssnType CDOmStmtProcContAssn::getProcContAssnType() const {
  return m_procContAssnType;
}

RefCDOmAssn CDOmStmtProcContAssn::getAssn() const {
  ASSERT(m_procContAssnType == PROC_CONT_ASSN_ASSIGN || m_procContAssnType == PROC_CONT_ASSN_FORCE, "[CDOmStmtProcContAssn::getAssn()] illegal state for this method call.");
  //if(m_procContAssnType != PROC_CONT_ASSN_ASSIGN && m_procContAssnType != PROC_CONT_ASSN_FORCE) {
  //  throw NSBase::IllegalStateException("[CDOmStmtProcContAssn::getAssn()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmAssn>(m_children->at(0));
  RefCDOmBase assnAsBase = getChild(0);
  RefCDOmAssn assn = CDOmAssn::cast(assnAsBase);
  return assn;
}

RefCDOmExpr CDOmStmtProcContAssn::getLvalue() const {
  ASSERT(m_procContAssnType == PROC_CONT_ASSN_DEASSIGN || m_procContAssnType == PROC_CONT_ASSN_RELEASE, "[CDOmStmtProcContAssn::getLvalue()] illegal state for this method call.");
  //if(m_procContAssnType != PROC_CONT_ASSN_DEASSIGN && m_procContAssnType != PROC_CONT_ASSN_RELEASE) {
  //  throw NSBase::IllegalStateException("[CDOmStmtProcContAssn::getLvalue()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

void CDOmStmtProcContAssn::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtProcTimingControl class
// ********************************************************************************
CDOmStmtProcTimingControl::CDOmStmtProcTimingControl(TLineNumberType lineNumber, EProcTimingControlType procTimingControlType)
  : CDOmStmt(lineNumber, STMT_PROC_TIMING_CONTROL), m_procTimingControlType(procTimingControlType) {}
  
RefCDOmStmtProcTimingControl CDOmStmtProcTimingControl::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtProcTimingControl::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtProcTimingControl::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_PROC_TIMING_CONTROL, "illegal obj type in CDOmStmtProcTimingControl::cast");
  return boost::static_pointer_cast<CDOmStmtProcTimingControl>(object);
}

RefCDOmStmtProcTimingControl CDOmStmtProcTimingControl::buildWithDelayControl(TLineNumberType lineNumber, RefCDOmDelayControl delayControl, RefCDOmStmt stmt) {
  ASSERT(delayControl.get(), "delayControl is NULL");
  ASSERT(stmt.get(), "stmt is NULL");

  CDOmStmtProcTimingControl* stmtProcTimingControl = new CDOmStmtProcTimingControl(lineNumber, PROC_TIMING_CONTROL_DELAY);
  RefCDOmStmtProcTimingControl refStmtProcTimingControl(stmtProcTimingControl);
  stmtProcTimingControl->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtProcTimingControl);
  delayControl->setParent(refStmtProcTimingControl); // self registration
  stmt->setParent(refStmtProcTimingControl); // self registration
  return refStmtProcTimingControl;
}

RefCDOmStmtProcTimingControl CDOmStmtProcTimingControl::buildWithEventControl(TLineNumberType lineNumber, RefCDOmEventControl eventControl, RefCDOmStmt stmt) {
  ASSERT(eventControl.get(), "eventControl is NULL");
  ASSERT(stmt.get(), "stmt is NULL");

  CDOmStmtProcTimingControl* stmtProcTimingControl = new CDOmStmtProcTimingControl(lineNumber, PROC_TIMING_CONTROL_EVENT);
  RefCDOmStmtProcTimingControl refStmtProcTimingControl(stmtProcTimingControl);
  stmtProcTimingControl->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtProcTimingControl);
  eventControl->setParent(refStmtProcTimingControl); // self registration
  stmt->setParent(refStmtProcTimingControl); // self registration
  return refStmtProcTimingControl;
}

CDOmStmtProcTimingControl::EProcTimingControlType CDOmStmtProcTimingControl::getProcTimingControlType() const {
  return m_procTimingControlType;
}

RefCDOmDelayControl CDOmStmtProcTimingControl::getDelayControl() const {
  ASSERT(m_procTimingControlType == PROC_TIMING_CONTROL_DELAY, "[CDOmStmtProcTimingControl::getDelayControl()] illegal state for this method call.");
  //if(m_procTimingControlType != PROC_TIMING_CONTROL_DELAY) {
  //  throw NSBase::IllegalStateException("[CDOmStmtProcTimingControl::getDelayControl()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmDelayControl>(m_children->at(0));
  RefCDOmBase delayControlAsBase = getChild(0);
  RefCDOmDelayControl delayControl = CDOmDelayControl::cast(delayControlAsBase);
  return delayControl;
}

RefCDOmEventControl CDOmStmtProcTimingControl::getEventControl() const {
  ASSERT(m_procTimingControlType == PROC_TIMING_CONTROL_EVENT, "[CDOmStmtProcTimingControl::getEventControl()] illegal state for this method call.");
  //if(m_procTimingControlType != PROC_TIMING_CONTROL_EVENT) {
  //  throw NSBase::IllegalStateException("[CDOmStmtProcTimingControl::getEventControl()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmEventControl>(m_children->at(0));
  RefCDOmBase eventControlAsBase = getChild(0);
  RefCDOmEventControl eventControl = CDOmEventControl::cast(eventControlAsBase);
  return eventControl;
}

RefCDOmStmt CDOmStmtProcTimingControl::getStmt() const {
  //return boost::static_pointer_cast<CDOmStmt>(m_children->at(1));
  RefCDOmBase stmtAsBase = getChild(1);
  RefCDOmStmt stmt = CDOmStmt::cast(stmtAsBase);
  return stmt;
}

void CDOmStmtProcTimingControl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtTaskEnable class
// ********************************************************************************
CDOmStmtTaskEnable::CDOmStmtTaskEnable(TLineNumberType lineNumber, ETaskEnableType taskEnableType) : CDOmStmt(lineNumber, STMT_TASK_ENABLE), m_taskEnableType(taskEnableType), m_exprs() { }

RefCDOmStmtTaskEnable CDOmStmtTaskEnable::cast (RefCDOmBase object) {
  ASSERT(object.get(), "found NULL object in CDOmStmtTaskEnable::cast");
  ASSERT(object->getType() == TYPE_STMT, "illegal object type in CDOmStmtTaskEnable::cast");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_TASK_ENABLE, "illegal obj type in CDOmStmtTaskEnable::cast");
  return boost::static_pointer_cast<CDOmStmtTaskEnable>(object);
}

RefCDOmStmtTaskEnable CDOmStmtTaskEnable::build(TLineNumberType lineNumber, ETaskEnableType taskEnableType, RefCDOmExprLink hid) {
  ASSERT(hid.get(), "RefCDOmExprLink hid is NULL");

  CDOmStmtTaskEnable* stmtTaskEnable = new CDOmStmtTaskEnable(lineNumber, taskEnableType);
  RefCDOmStmtTaskEnable refStmtTaskEnable(stmtTaskEnable);
  stmtTaskEnable->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtTaskEnable);

  hid->setParent(refStmtTaskEnable); // self registration

  return refStmtTaskEnable;
}

void CDOmStmtTaskEnable::addExpr(RefCDOmExpr expr) {
  if(m_taskEnableType == TASK_ENABLE_TASK)
    ASSERT(expr.get(), "RefCDOmExpr expr is NULL");
  if(expr.get())
    //expr->setParent(m_weakRef.lock());
    expr->setParent(getThis());
  if(!m_exprs.get())
    m_exprs = RefTVec_RefCDOmExpr(new TVec_RefCDOmExpr());
  m_exprs->push_back(expr);
} 

CDOmStmtTaskEnable::ETaskEnableType CDOmStmtTaskEnable::getTaskEnableType() const {
  return m_taskEnableType;
}

RefCDOmExprLink CDOmStmtTaskEnable::getHID() const {
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprLinkAsBase = getChild(0);
  RefCDOmExprLink exprLink = CDOmExprLink::cast(exprLinkAsBase);
  return exprLink;
}

const RefTVec_RefCDOmExpr CDOmStmtTaskEnable::getExprList() const {
  return m_exprs;
}

void CDOmStmtTaskEnable::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmStmtWait class
// ********************************************************************************
CDOmStmtWait::CDOmStmtWait(TLineNumberType lineNumber) : CDOmStmt(lineNumber, STMT_WAIT) {}

RefCDOmStmtWait CDOmStmtWait::cast (RefCDOmBase object) {
  ASSERT(object.get(), "in CDOmStmtWait::cast function object is NULL");
  ASSERT(object->getType() == TYPE_STMT, "in CDOmStmtWait::cast function object has illegal type");
  //RefCDOmStmt obj = boost::static_pointer_cast<CDOmStmt>(object);
  RefCDOmBase cdomstmtAsBase = object;
  RefCDOmStmt cdomstmt = CDOmStmt::cast(cdomstmtAsBase);
  RefCDOmStmt obj = cdomstmt;
  ASSERT(obj->getStmtType() == CDOmStmt::STMT_WAIT, "in CDOmStmtWait::cast function obj has illegal type");
  return boost::static_pointer_cast<CDOmStmtWait>(object);
}

RefCDOmStmtWait CDOmStmtWait::build(TLineNumberType lineNumber, RefCDOmExpr expr, RefCDOmStmt stmt) {
  ASSERT(expr.get(), "RefCDOmExpr expr is NULL");
  ASSERT(stmt.get(), "RefCDOmStmt stmt is NULL");

  CDOmStmtWait* stmtWait = new CDOmStmtWait(lineNumber);
  RefCDOmStmtWait refStmtWait(stmtWait);
  stmtWait->m_weakRef = boost::weak_ptr<CDOmBase>( refStmtWait);
  expr->setParent(refStmtWait); // self registration
  stmt->setParent(refStmtWait); // self registration
  return refStmtWait;
}

RefCDOmExpr CDOmStmtWait::getExpr() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmStmt CDOmStmtWait::getStmt() const {
  //return boost::static_pointer_cast<CDOmStmt>(m_children->at(1));
  RefCDOmBase stmtAsBase = getChild(1);
  RefCDOmStmt stmt = CDOmStmt::cast(stmtAsBase);
  return stmt;
}

void CDOmStmtWait::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmRange class
// ********************************************************************************
// This class is used for both: dimension and range
CDOmRange::CDOmRange(TLineNumberType lineNumber) : CDOmBase(TYPE_RANGE, lineNumber) {}

RefCDOmRange CDOmRange::cast(RefCDOmBase object) {
  ASSERT(object.get(), "in CDOmRange::cast function object is NULL");
  ASSERT(object->getType() == TYPE_RANGE, "in CDOmRange::cast function object has illegal type");
  return boost::static_pointer_cast<CDOmRange>(object);
}

RefCDOmRange CDOmRange::build(TLineNumberType lineNumber, RefCDOmExpr firstExpr, RefCDOmExpr secondExpr) {
  ASSERT(firstExpr.get(), "received NULL firstExpr");
  ASSERT(secondExpr.get(), "received NULL secondExpr");
  ASSERT(firstExpr->isConst(), "firstExpr should be const");
  ASSERT(secondExpr->isConst(), "secondExpr sould be const");

  CDOmRange* range = new CDOmRange(lineNumber);
  RefCDOmRange refRange(range);
  range->m_weakRef = boost::weak_ptr<CDOmBase>( refRange);
  firstExpr->setParent(refRange); // self registration
  secondExpr->setParent(refRange); // self registration
  return refRange;
}

RefCDOmExpr CDOmRange::getFirstExpr() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmExpr CDOmRange::getSecondExpr() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(1));
  RefCDOmBase exprAsBase = getChild(1);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

TUInt CDOmRange::getWidth() const { // !!! request VeriNum support
  throw NSBase::NotImplementedException();
  return 0;
}

void CDOmRange::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  /*
    visitor.setInRangeOpenBrace();
    //visitor.visit(boost::static_pointer_cast<CDOmRange>(m_weakRef.lock()));
    RefCDOmBase cdomrangeAsBase = getThis();
    RefCDOmRange cdomrange = CDOmRange::cast(cdomrangeAsBase);
    visitor.visit(cdomrange);
    visitor.clrInRangeOpenBrace();

    getFirstExpr()->acceptVisitor(visitor);

    visitor.setInRangeColon();
    //visitor.visit(boost::static_pointer_cast<CDOmRange>(m_weakRef.lock()));
    RefCDOmBase cdomrangeAsBase1 = getThis();
    RefCDOmRange cdomrange1 = CDOmRange::cast(cdomrangeAsBase1);
    visitor.visit(cdomrange1);
    visitor.clrInRangeColon();

    getSecondExpr()->acceptVisitor(visitor);

    visitor.setInRangeClosedBrace();
    //visitor.visit(boost::static_pointer_cast<CDOmRange>(m_weakRef.lock()));
    RefCDOmBase cdomrangeAsBase2 = getThis();
    RefCDOmRange cdomrange2 = CDOmRange::cast(cdomrangeAsBase2);
    visitor.visit(cdomrange2);
    visitor.clrInRangeClosedBrace();
  */
  visitor.visit(getThis());

}

// ********************************************************************************
// CDOmRangeExpr class
// ********************************************************************************
CDOmRangeExpr::CDOmRangeExpr(TLineNumberType lineNumber, ERangeExprType rangeExprType, TBool isConst)
  : CDOmBase(TYPE_RANGE_EXPR, lineNumber), m_rangeExprType(rangeExprType), m_isConst(isConst) {}

RefCDOmRangeExpr CDOmRangeExpr::cast(RefCDOmBase object) {
  ASSERT(object.get(), "in CDOmRangeExpr::cast function object is NULL");
  ASSERT(object->getType() == TYPE_RANGE_EXPR, "type check on cast failure");
  return boost::static_pointer_cast<CDOmRangeExpr>(object);
}

RefCDOmRangeExpr CDOmRangeExpr::buildSingleRangeExpr(TLineNumberType lineNumber, RefCDOmExpr firstExpr) {
  ASSERT(firstExpr.get(), "firstExpr is NULL");
  // !!! firstExpr may or may not be const

  CDOmRangeExpr* rangeExpr = new CDOmRangeExpr(lineNumber, RANGE_EXPR_SINGLE, firstExpr->isConst());
  RefCDOmRangeExpr refRangeExpr(rangeExpr);
  rangeExpr->m_weakRef = boost::weak_ptr<CDOmBase>( refRangeExpr);
  firstExpr->setParent(refRangeExpr); // self registration
  return refRangeExpr;
}

RefCDOmRangeExpr CDOmRangeExpr::buildDoubleRangeExpr(TLineNumberType lineNumber, RefCDOmExpr firstExpr, RefCDOmExpr secondExpr, ERangeExprType rangeExprType) {
  ASSERT(firstExpr.get(), "firstExpr is NULL");
  ASSERT(secondExpr.get(), "secondExpr is NULL");
  ASSERT(rangeExprType != RANGE_EXPR_SINGLE, "rangeExprType should be RANGE_EXPR_SINGLE");
  if(rangeExprType == RANGE_EXPR_DOUBLE) {
    ASSERT(firstExpr->isConst(), "firstExpr should be const");
  }
  else {
    // !!! firstExpr may or may not be const
  }
  ASSERT(secondExpr->isConst(), "secondExpr should be const"); // secondExpr must always be const

  CDOmRangeExpr* rangeExpr = new CDOmRangeExpr(lineNumber, rangeExprType, firstExpr->isConst() && secondExpr->isConst());
  RefCDOmRangeExpr refRangeExpr(rangeExpr);
  rangeExpr->m_weakRef = boost::weak_ptr<CDOmBase>( refRangeExpr);
  firstExpr->setParent(refRangeExpr); // self registration
  secondExpr->setParent(refRangeExpr); // self registration
  return refRangeExpr;
}

CDOmRangeExpr::ERangeExprType CDOmRangeExpr::getRangeExprType() const {
  return m_rangeExprType;
}

RefCDOmExpr CDOmRangeExpr::getFirstExpr() const {
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmExpr CDOmRangeExpr::getSecondExpr() const {
  ASSERT(m_rangeExprType != RANGE_EXPR_SINGLE, "[CDOmRangeExpr::getSecondExpr()] illegal state for this method call.");
  //if(m_rangeExprType == RANGE_EXPR_SINGLE) {
  //  throw NSBase::IllegalStateException("[CDOmRangeExpr::getSecondExpr()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(1));
  RefCDOmBase exprAsBase = getChild(1);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

TBool CDOmRangeExpr::isConst() const {
  return m_isConst;
}

TUInt CDOmRangeExpr::getWidth() const { // !!! request VeriNum support
  throw NSBase::NotImplementedException();
  return 0;
}

void CDOmRangeExpr::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmRangeExpr>(m_weakRef.lock()));
  RefCDOmBase cdomrangeexprAsBase = getThis();
  RefCDOmRangeExpr cdomrangeexpr = CDOmRangeExpr::cast(cdomrangeexprAsBase);
  visitor.visit(cdomrangeexpr);
}

// ********************************************************************************
// CDOmParamDecl class
// ********************************************************************************
CDOmParamDecl::CDOmParamDecl(TLineNumberType lineNumber, EParamDeclType paramDeclType, EParamDeclType2 paramDeclType2, EParamType paramType)
  : CDOmAttrHolder(lineNumber, TYPE_PARAM_DECL), m_paramDeclType(paramDeclType), m_paramDeclType2(paramDeclType2),
    m_isSigned(false), m_range(), m_paramType(paramType), m_nameMap() {}

RefCDOmParamDecl CDOmParamDecl::cast (RefCDOmBase object) {
  ASSERT(object.get(), "in CDOnParamDecl::cast function object is NULL");
  ASSERT(object->getType() == TYPE_PARAM_DECL, "type check on cast failure");
  return boost::static_pointer_cast<CDOmParamDecl>(object);
}

RefCDOmParamDecl CDOmParamDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, EParamDeclType paramDeclType) {
  ASSERT(parent.get(), "parent is NULL");
  if(paramDeclType == PARAM_DECL_SPEC) {
    ASSERT(parent->isScopeHolder() || parent->getType() == TYPE_PARAM_DECL_COLLECTION || parent->getType() == TYPE_SPEC_BLOCK, "parent should be a scope or a param decl collection or a spec block");
  }
  else {
    ASSERT(parent->isScopeHolder() || parent->getType() == TYPE_PARAM_DECL_COLLECTION, "parent should be a scope or a param decl collection");
  }

  CDOmParamDecl* paramDecl = new CDOmParamDecl(lineNumber, paramDeclType, paramDeclType != PARAM_DECL_SPEC ? DECL_1 : DECL_NA, PARAM_NA);
  RefCDOmParamDecl refParamDecl(paramDecl);
  paramDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refParamDecl);
  paramDecl->setParent(parent); // self registration
  return refParamDecl;
}

RefCDOmParamDecl CDOmParamDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, EParamDeclType paramDeclType, EParamType paramType) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->isScopeHolder() || parent->getType() == TYPE_PARAM_DECL_COLLECTION, "parent should be a scope or a param decl collection");
  ASSERT(paramDeclType == PARAM_DECL_SIMPLE || paramDeclType == PARAM_DECL_LOCAL, "paramDeclType check on build failure");

  CDOmParamDecl* paramDecl = new CDOmParamDecl(lineNumber, paramDeclType, DECL_2, paramType);
  RefCDOmParamDecl refParamDecl(paramDecl);
  paramDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refParamDecl);
  paramDecl->setParent(parent); // self registration
  return refParamDecl;
}

CDOmParamDecl::EParamDeclType CDOmParamDecl::getParamDeclType() const {
  return m_paramDeclType;
}

CDOmParamDecl::EParamDeclType2 CDOmParamDecl::getParamDeclType2() const {
  return m_paramDeclType2;
}

void CDOmParamDecl::setSigned() {
  ASSERT(m_paramDeclType2 == DECL_1, "[CDOmParamDecl::setSigned()] illegal state for this method call.");
  //if(m_paramDeclType2 != DECL_1) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::setSigned()] illegal state for this method call.", m_lineNumber);
  //}

  m_isSigned = true;
}

TBool CDOmParamDecl::isSigned() const {
  ASSERT(m_paramDeclType2 == DECL_1, "[CDOmParamDecl::setSigned()] illegal state for this method call.");
  //if(m_paramDeclType2 != DECL_1) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::isSigned()] illegal state for this method call.", m_lineNumber);
  //}

  return m_isSigned;
}

void CDOmParamDecl::setRange(RefCDOmRange range) {
  //assert(!m_children.get() || (m_children->size() == 1 && m_children->at(0)->getType() == TYPE_ATTR_LIST_COLLECTION));
  ASSERT(!m_children.get() || (m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION), "m_children is NULL or has an illegal type");
  ASSERT(range.get(), "range is NULL");
  ASSERT(m_paramDeclType2 != DECL_2, "[CDOmParamDecl::setRange()] illegal state for this method call.");
  //if(m_paramDeclType2 == DECL_2) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::setRange()] illegal state for this method call.", m_lineNumber);
  //}
  if(m_range.get()) {
    args.push_back("param");
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, getLineNumber());
    //throw NSBase::IllegalStateException("[CDOmParamDecl::setRange()] range already set.", m_lineNumber);
  }

  //range->setParent(m_weakRef.lock()); // self registration
  range->setParent(getThis()); // self registration
  m_range = range;
}

RefCDOmRange CDOmParamDecl::getRange() const {
  ASSERT(m_paramDeclType2 != DECL_2, "[CDOmParamDecl::getRange()] illegal state for this method call.");
  //if(m_paramDeclType2 == DECL_2) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::getRange()] illegal state for this method call.", m_lineNumber);
  //}

  return m_range;
}

CDOmParamDecl::EParamType CDOmParamDecl::getParamType() const {
  ASSERT(m_paramDeclType2 == DECL_2, "[CDOmParamDecl::getParamType()] illegal state for this method call.");
  //if(m_paramDeclType2 != DECL_2) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::getParamType()] illegal state for this method call.", m_lineNumber);
  //}

  return m_paramType;
}

void CDOmParamDecl::addParam(TLineNumberType lineNumber, const RefString& name, RefCDOmMinTypMax minTypMax) {
  if(checkIdName(name, lineNumber)) {
    ASSERT(minTypMax.get(), "minTypMax is NULL");
    ASSERT(minTypMax->isConst(), "minTypMax should be const");

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_PARAM, name, minTypMax);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_PARAM, name, minTypMax);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

void CDOmParamDecl::addPulseControl(TLineNumberType lineNumber, RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue) {
  ASSERT(m_paramDeclType == PARAM_DECL_SPEC, "[CDOmParamDecl::addPulseControl()] illegal state for this method call.");
  //if(m_paramDeclType != PARAM_DECL_SPEC) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::addPulseControl()] illegal state for this method call.", m_lineNumber);
  //}

  //CDOmPulseControl::build(lineNumber, boost::static_pointer_cast<CDOmParamDecl>(m_weakRef.lock()), rejectLimitValue, errorLimitValue);
  RefCDOmBase cdomparamdeclAsBase = getThis();
  RefCDOmParamDecl cdomparamdecl = CDOmParamDecl::cast(cdomparamdeclAsBase);
  CDOmPulseControl::build(lineNumber, cdomparamdecl, rejectLimitValue, errorLimitValue);
}

void CDOmParamDecl::addPulseControl(TLineNumberType lineNumber, RefCDOmExprLink inputTerminalExprLink, RefCDOmExprLink outputTerminalExprLink,
                                    RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue) {
  ASSERT(m_paramDeclType == PARAM_DECL_SPEC, "[CDOmParamDecl::addPulseControl()] illegal state for this method call.");
  //if(m_paramDeclType != PARAM_DECL_SPEC) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::addPulseControl()] illegal state for this method call.", m_lineNumber);
  //}
  
  /* CDOmPulseControl::build(lineNumber, boost::static_pointer_cast<CDOmParamDecl>(m_weakRef.lock()),
     inputTerminalExprLink, outputTerminalExprLink, rejectLimitValue, errorLimitValue); */
  RefCDOmBase cdomparamdeclAsBase = getThis();
  RefCDOmParamDecl cdomparamdecl = CDOmParamDecl::cast(cdomparamdeclAsBase);
  CDOmPulseControl::build(lineNumber, cdomparamdecl, inputTerminalExprLink, outputTerminalExprLink, rejectLimitValue, errorLimitValue);
}

TBool CDOmParamDecl::containsParam(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMap.get()) {
      return FALSE;
    }
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

RefCDOmMinTypMax CDOmParamDecl::getParamVal(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {
    if(!m_nameMap.get()) {
      throw NSBase::IllegalArgumentException(std::string("[CDOmParamDecl::getParamVal()] parameter: " + *name + " not found.").c_str(), m_lineNumber);
    }

    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    if(iter == m_nameMap->end()) {
      throw NSBase::IllegalArgumentException(std::string("[CDOmParamDecl::getParamVal()] parameter: " + *name + " not found.").c_str(), m_lineNumber);
    }
    //return boost::static_pointer_cast<CDOmMinTypMax>(iter->second->getPayload());
    RefCDOmBase cdommintypmaxAsBase = iter->second->getPayload();
    RefCDOmMinTypMax cdommintypmax = CDOmMinTypMax::cast(cdommintypmaxAsBase); 
    return cdommintypmax;
  }
  return RefCDOmMinTypMax();
}

const RefTVec_RefCDOmIdentifier CDOmParamDecl::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

const RefTVec_RefCDOmPulseControl CDOmParamDecl::getPulseControls() const {
  ASSERT(m_paramDeclType == PARAM_DECL_SPEC, "[CDOmParamDecl::getPulseControls()] illegal state for this method call.");
  //if(m_paramDeclType != PARAM_DECL_SPEC) {
  //  throw NSBase::IllegalStateException("[CDOmParamDecl::getPulseControls()] illegal state for this method call.", m_lineNumber);
  //}

  return getChildren<CDOmPulseControl>(TYPE_PULSE_CONTROL);
}

void CDOmParamDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmParamDecl>(m_weakRef.lock()));
  RefCDOmBase cdomparamdeclAsBase = getThis();
  RefCDOmParamDecl cdomparamdecl = CDOmParamDecl::cast(cdomparamdeclAsBase);
  visitor.visit(cdomparamdecl);
}

// ********************************************************************************
// CDOmPulseControl class
// ********************************************************************************
CDOmPulseControl::CDOmPulseControl(TLineNumberType lineNumber, const RefCDOmExprLink& inputTerminalExprLink, const RefCDOmExprLink& outputTerminalExprLink,
                                   const RefCDOmMinTypMax& rejectLimitValue, const RefCDOmMinTypMax& errorLimitValue) :
  CDOmBase(TYPE_PULSE_CONTROL, lineNumber),
  m_inputTerminalExprLink(inputTerminalExprLink), m_outputTerminalExprLink(outputTerminalExprLink),
  m_rejectLimitValue(rejectLimitValue), m_errorLimitValue(errorLimitValue) {}

RefCDOmPulseControl CDOmPulseControl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmPulseControl();
  }
  ASSERT(object->getType() == TYPE_PULSE_CONTROL, "type check on cast failure");
  return boost::static_pointer_cast<CDOmPulseControl>(object);
}

RefCDOmPulseControl CDOmPulseControl::build(TLineNumberType lineNumber, RefCDOmParamDecl parent,
                                            RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SPEC, "parent should be a spec param decl");
  ASSERT(rejectLimitValue.get(), "rejectLimitValue is NULL");
  ASSERT(rejectLimitValue->isConst(), "rejectLimitValue should be const");
  if(errorLimitValue.get()) {
    ASSERT(errorLimitValue->isConst(), "errorLimitValue should be const");
  }

  CDOmPulseControl* pulseControl = new CDOmPulseControl(lineNumber, RefCDOmExprLink(), RefCDOmExprLink(), rejectLimitValue, errorLimitValue);
  RefCDOmPulseControl refPulseControl(pulseControl);
  pulseControl->m_weakRef = boost::weak_ptr<CDOmBase>( refPulseControl);
  rejectLimitValue->setParent(refPulseControl); // self registration
  if(errorLimitValue.get()) {
    errorLimitValue->setParent(refPulseControl); // self registration
  }
  pulseControl->setParent(parent); // self registration
  return refPulseControl;
}

RefCDOmPulseControl CDOmPulseControl::build(TLineNumberType lineNumber, RefCDOmParamDecl parent,
                                            RefCDOmExprLink inputTerminalExprLink, RefCDOmExprLink outputTerminalExprLink,
                                            RefCDOmMinTypMax rejectLimitValue, RefCDOmMinTypMax errorLimitValue) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getParamDeclType() == CDOmParamDecl::PARAM_DECL_SPEC, "parent should be a spec param decl");
  ASSERT(inputTerminalExprLink.get(), "inputTerminalExprLink is NULL");
  ASSERT(outputTerminalExprLink.get(), "outputTerminalExprLink is NULL");
  ASSERT(rejectLimitValue.get(), "rejectLimitValue is NULL");
  ASSERT(rejectLimitValue->isConst(), "rejectLimitValue should be const");
  if(errorLimitValue.get()) {
    ASSERT(errorLimitValue->isConst(), "errorLimitValue should be const");
  }

  CDOmPulseControl* pulseControl = new CDOmPulseControl(lineNumber, inputTerminalExprLink, outputTerminalExprLink, rejectLimitValue, errorLimitValue);
  RefCDOmPulseControl refPulseControl(pulseControl);
  pulseControl->m_weakRef = boost::weak_ptr<CDOmBase>( refPulseControl);
  inputTerminalExprLink->setParent(refPulseControl); // self registration
  outputTerminalExprLink->setParent(refPulseControl); // self registration
  rejectLimitValue->setParent(refPulseControl); // self registration
  if(errorLimitValue.get()) {
    errorLimitValue->setParent(refPulseControl); // self registration
  }
  pulseControl->setParent(parent); // self registration
  return refPulseControl;
}

RefCDOmExprLink CDOmPulseControl::getInputTerminalExprLink() const {
  return m_inputTerminalExprLink;
}

RefCDOmExprLink CDOmPulseControl::getOutputTerminalExprLink() const {
  return m_outputTerminalExprLink;
}

RefCDOmMinTypMax CDOmPulseControl::getRejectLimitValue() const {
  return m_rejectLimitValue;
}

RefCDOmMinTypMax CDOmPulseControl::getErrorLimitValue() const {
  return m_errorLimitValue;
}

void CDOmPulseControl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmParamDeclCollection class
// ********************************************************************************
CDOmParamDeclCollection::CDOmParamDeclCollection(TLineNumberType lineNumber) : CDOmBase(TYPE_PARAM_DECL_COLLECTION, lineNumber) {}

RefCDOmParamDeclCollection CDOmParamDeclCollection::cast(RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmParamDeclCollection();
  }
  ASSERT(object->getType() == TYPE_PARAM_DECL_COLLECTION, "type check on cast failure");
  return boost::static_pointer_cast<CDOmParamDeclCollection>(object);
}

RefCDOmParamDeclCollection CDOmParamDeclCollection::build(TLineNumberType lineNumber, RefCDOmModuleDecl parent) {
  ASSERT(parent.get(), "parent is NULL");

  CDOmParamDeclCollection* paramDeclCollection = new CDOmParamDeclCollection(lineNumber);
  RefCDOmParamDeclCollection refParamDeclCollection(paramDeclCollection);
  paramDeclCollection->m_weakRef = boost::weak_ptr<CDOmBase>( refParamDeclCollection);
  paramDeclCollection->setParent(parent); // self registration
  return refParamDeclCollection;
}

const RefTVec_RefCDOmParamDecl CDOmParamDeclCollection::getParamDecls() const {
  return getChildren<CDOmParamDecl>(TYPE_PARAM_DECL);
}

void CDOmParamDeclCollection::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmParamDeclCollection>(m_weakRef.lock()));
  RefCDOmBase cdomparamdeclcollectionAsBase = getThis();
  RefCDOmParamDeclCollection cdomparamdeclcollection = CDOmParamDeclCollection::cast(cdomparamdeclcollectionAsBase);
  visitor.visit(cdomparamdeclcollection);
}

// ********************************************************************************
// CDOmPortDecl class
// ********************************************************************************
CDOmPortDecl::CDOmPortDecl(TLineNumberType lineNumber, ECDOmPortType portType, ECDOmNetType netType, ECDOmVarType varType)
  : CDOmAttrHolder(lineNumber, TYPE_PORT_DECL), m_portType(portType), m_netType(netType), m_varType(varType), m_isSigned(false), m_range(), m_nameMap() {}

RefCDOmPortDecl CDOmPortDecl::cast (RefCDOmBase object) {
  //ASSERT(object.get());
  if (!object.get()) {
    return RefCDOmPortDecl();
  }
  ASSERT(object->getType() == TYPE_PORT_DECL, "type check on CDOmPortDecl::cast failure");
  return boost::static_pointer_cast<CDOmPortDecl>(object);
}

RefCDOmPortDecl CDOmPortDecl::buildNetPortDecl(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmPortType portType, ECDOmNetType netType) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE, "parent should be a module declaration");

  CDOmPortDecl* portDecl = new CDOmPortDecl(lineNumber, portType, netType, VAR_UNDEFINED);
  RefCDOmPortDecl refPortDecl(portDecl);
  portDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refPortDecl);
  portDecl->setParent(parent); // self registration
  return refPortDecl;
}

RefCDOmPortDecl CDOmPortDecl::buildVarPortDecl(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmVarType varType) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE, "parent should be a module declaraion");
  ASSERT(varType == VAR_REG || varType == VAR_INTEGER || varType == VAR_TIME, "varType check on buildVarPortDecl failure");

  CDOmPortDecl* portDecl = new CDOmPortDecl(lineNumber, PORT_OUTPUT, NET_UNDEFINED, varType);
  RefCDOmPortDecl refPortDecl(portDecl);
  portDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refPortDecl);
  portDecl->setParent(parent); // self registration
  return refPortDecl;
}

ECDOmPortType CDOmPortDecl::getPortType() const {
  return m_portType;
}

ECDOmNetType CDOmPortDecl::getNetType() const {
  return m_netType;
}

ECDOmVarType CDOmPortDecl::getVarType() const {
  return m_varType;
}

void CDOmPortDecl::setSigned() {
  if(m_varType != VAR_UNDEFINED && (m_varType == VAR_INTEGER || m_varType == VAR_TIME)) { // sign is not supported for var integer and var time
    args.push_back("port");
    args.push_back("sign supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmPortDecl::setSigned()] illegal state for this method call.", m_lineNumber);
  }

  m_isSigned = true;
}

TBool CDOmPortDecl::isSigned() const {
  if(m_varType != VAR_UNDEFINED && (m_varType == VAR_INTEGER || m_varType == VAR_TIME)) { // sign is not supported for var integer and var time
    args.push_back("port");
    args.push_back("sign supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmPortDecl::isSigned()] illegal state for this method call.", m_lineNumber);
  }

  return m_isSigned;
}

void CDOmPortDecl::setRange(RefCDOmRange range) {
  //assert(!m_children.get() || (m_children->size() == 1 && m_children->at(0)->getType() == TYPE_ATTR_LIST_COLLECTION));
  ASSERT(!m_children.get() || (m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION), "m_children is NULL or has an illegal type");
  ASSERT(range.get(), "range is NULL");
  if(m_varType != VAR_UNDEFINED && (m_varType == VAR_INTEGER || m_varType == VAR_TIME)) { // range is not supported for var integer and var time
    args.push_back("port");
    args.push_back("range supporting port");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, range->getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmPortDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  if(m_range.get()) {
    args.push_back("port(s)");
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, range->getLineNumber());
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmPortDecl::setRange()] range already set.", m_lineNumber);
  }

  //range->setParent(m_weakRef.lock()); // self registration
  range->setParent(getThis()); // self registration
  m_range = range;
}

RefCDOmRange CDOmPortDecl::getRange() const {
  ASSERT(!(m_varType != VAR_UNDEFINED && (m_varType == VAR_INTEGER || m_varType == VAR_TIME)), "[CDOmPortDecl::getRange()] illegal state for this method call.");
  //if(m_varType != VAR_UNDEFINED && (m_varType == VAR_INTEGER || m_varType == VAR_TIME)) { // range is not supported for var integer and var time
  //  throw NSBase::IllegalStateException("[CDOmPortDecl::getRange()] illegal state for this method call.", m_lineNumber);
  //}

  return m_range;
}

void CDOmPortDecl::addPort(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr) {
  if(checkIdName(name, lineNumber)) {
    if(expr.get()) {
      ASSERT(m_varType == VAR_REG || m_varType == VAR_INTEGER || m_varType == VAR_TIME, "[CDOmPortDecl::addPort()] illegal state for this method call.");
      //if(m_varType != VAR_REG && m_varType != VAR_INTEGER && m_varType != VAR_TIME) {
      //  throw NSBase::IllegalStateException("[CDOmPortDecl::addPort()] illegal state for this method call.", m_lineNumber);
      //}
      ASSERT(expr->isConst(), "expr should be const");
    }

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_PORT, name, expr);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_PORT, name, expr);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

TBool CDOmPortDecl::containsPort(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMap.get()) {
      return FALSE;
    }
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

RefCDOmExpr CDOmPortDecl::getPortVal(const RefString& name) const {
  ASSERT(m_varType == VAR_REG || m_varType == VAR_INTEGER || m_varType == VAR_TIME, "[CDOmPortDecl::getPortVal()] illegal state for this method call.");
  //if(m_varType != VAR_REG && m_varType != VAR_INTEGER && m_varType != VAR_TIME) {
  //  throw NSBase::IllegalStateException("[CDOmPortDecl::getPortVal()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(m_nameMap.get(), std::string("[CDOmPortDecl::getPortVal()] port: " + *name + " not found.").c_str());
    //if(!m_nameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmPortDecl::getPortVal()] port: " + *name + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    ASSERT(iter != m_nameMap->end(), std::string("[CDOmPortDecl::getPortVal()] port: " + *name + " not found.").c_str());
    //if(iter == m_nameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmPortDecl::getPortVal()] port: " + *name + " not found.").c_str(), m_lineNumber);
    //}
    //return boost::static_pointer_cast<CDOmExpr>(iter->second->getPayload());
    RefCDOmBase cdomexprAsBase = iter->second->getPayload();
    RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
    return cdomexpr;
  }
  return RefCDOmExpr();
}

const RefTVec_RefCDOmIdentifier CDOmPortDecl::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmPortDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmPortDecl>(m_weakRef.lock()));
  RefCDOmBase cdomportdeclAsBase = getThis();
  RefCDOmPortDecl cdomportdecl = CDOmPortDecl::cast(cdomportdeclAsBase);
  visitor.visit(cdomportdecl);
}

// ********************************************************************************
// CDOmUdpPortDeclOutput class
// ********************************************************************************
CDOmUdpPortDeclOutput::CDOmUdpPortDeclOutput(TLineNumberType lineNumber, EUdpPortDeclOutputType portType) : CDOmAttrHolder(lineNumber, TYPE_UDP_PORT_DECL_OUTPUT), m_portType(portType) { }

RefCDOmUdpPortDeclOutput CDOmUdpPortDeclOutput::cast (RefCDOmBase object) {
  //ASSERT(object.get());
  if (!object.get()) {
    return RefCDOmUdpPortDeclOutput();
  }
  ASSERT(object->getType() == TYPE_UDP_PORT_DECL_OUTPUT, "type check on CDOmUdpPortDeclOutput::cast failure");
  return boost::static_pointer_cast<CDOmUdpPortDeclOutput>(object);
}

RefCDOmUdpPortDeclOutput CDOmUdpPortDeclOutput::build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, EUdpPortDeclOutputType type, const RefString portName, RefCDOmExpr expr ) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(portName.get(), "portName is NULL");
  if(checkIdName(portName, lineNumber)) {

    CDOmUdpPortDeclOutput *udpPortDecl = new CDOmUdpPortDeclOutput(lineNumber, type);
    RefCDOmUdpPortDeclOutput refUdpPortDecl(udpPortDecl);
    udpPortDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refUdpPortDecl);
    udpPortDecl->setParent(parent);


    if( type == UDP_DECL_TYPE_OUTPUT_REG && expr.get() )
      CDOmIdentifier::build(lineNumber, refUdpPortDecl, CDOmIdentifier::ID_UDP_PORT_OUTPUT_PL, portName, expr);
    else {
      ASSERT(!expr.get(), "expr should be NULL");
      CDOmIdentifier::build(lineNumber, refUdpPortDecl, CDOmIdentifier::ID_UDP_PORT_OUTPUT, portName);
    }

    return refUdpPortDecl;
  }
  return RefCDOmUdpPortDeclOutput();
}

CDOmUdpPortDeclOutput::EUdpPortDeclOutputType CDOmUdpPortDeclOutput::getPortType() const {
  return m_portType;
}

TBool CDOmUdpPortDeclOutput::containsPort(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {
    //return *(boost::static_pointer_cast<CDOmIdentifier>(m_children->at(0))->getName()) == *name;
    RefCDOmBase identifierAsBase = getChild(0);
    RefCDOmIdentifier identifier = CDOmIdentifier::cast(identifierAsBase);
    return *(identifier->getName()) == *name;
  }
  return FALSE;
}

const RefCDOmIdentifier CDOmUdpPortDeclOutput::getID() const {
  //return boost::static_pointer_cast<CDOmIdentifier>(m_children->at(0));
  RefCDOmBase identifierAsBase = getChild(0);
  RefCDOmIdentifier identifier = CDOmIdentifier::cast(identifierAsBase);
  return identifier;
}

void CDOmUdpPortDeclOutput::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const { 
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmUdpPortDeclInput class
// ********************************************************************************
CDOmUdpPortDeclInput::CDOmUdpPortDeclInput(TLineNumberType lineNumber) : CDOmAttrHolder(lineNumber, TYPE_UDP_PORT_DECL_INPUT), m_nameMap() { }

RefCDOmUdpPortDeclInput CDOmUdpPortDeclInput::cast (RefCDOmBase object) {
  // assert(object.get());
  if (!object.get()) {
    return RefCDOmUdpPortDeclInput();
  }
  ASSERT(object->getType() == TYPE_UDP_PORT_DECL_INPUT, "type check on CDOmUdpPortDeclInput::cast failure");
  return boost::static_pointer_cast<CDOmUdpPortDeclInput>(object);
}

RefCDOmUdpPortDeclInput CDOmUdpPortDeclInput::build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, const RefString portName) {
  ASSERT(parent.get(), "parent is NULL");

  CDOmUdpPortDeclInput *udpPortDecl = new CDOmUdpPortDeclInput(lineNumber);
  RefCDOmUdpPortDeclInput refUdpPortDecl(udpPortDecl);
  udpPortDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refUdpPortDecl);

  udpPortDecl->setParent(parent);
  udpPortDecl->m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
  udpPortDecl->addPort(lineNumber, portName);

  return refUdpPortDecl;
}

void CDOmUdpPortDeclInput::addPort(TLineNumberType lineNumber, const RefString portName) {
  if(checkIdName(portName, lineNumber)) {
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_UDP_PORT_INPUT, portName);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_UDP_PORT_INPUT, portName);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(portName, id));
  }
}

TBool CDOmUdpPortDeclInput::containsPort(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

const RefTVec_RefCDOmIdentifier CDOmUdpPortDeclInput::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmUdpPortDeclInput::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const { 
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmPortItem class
// ********************************************************************************
CDOmPortItem::CDOmPortItem(TLineNumberType lineNumber, EPortItemType portItemType) : CDOmBase(TYPE_PORT_ITEM, lineNumber), m_portItemType(portItemType) {}

RefCDOmPortItem CDOmPortItem::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmPortItem();
  }
  ASSERT(object->getType() == TYPE_PORT_ITEM, "type check on CDOmPortItem::cast failure");
  return boost::static_pointer_cast<CDOmPortItem>(object);
}

RefCDOmPortItem CDOmPortItem::build(TLineNumberType lineNumber, RefCDOmModuleDecl parent, EPortItemType portItemType, const RefString& explicitName) {
  ASSERT(parent.get(), "parent is NULL");

  CDOmPortItem* portItem = new CDOmPortItem(lineNumber, portItemType);
  RefCDOmPortItem refPortItem(portItem);
  portItem->m_weakRef = boost::weak_ptr<CDOmBase>( refPortItem);
  portItem->setParent(parent); // self registration
  if(explicitName.get()) {
    CDOmIdentifier::build(lineNumber, refPortItem, CDOmIdentifier::ID_EXPLICIT_PORT, explicitName);
  }
  return refPortItem;
}

CDOmPortItem::EPortItemType CDOmPortItem::getPortItemType() const {
  return m_portItemType;
}

// if there is no explicit name set on this port item,
// this method returns null, that is, calling get() on returned object returns 0
RefString CDOmPortItem::getExplicitName() const {
  //if(m_children.get() && m_children->at(0)->isID()) {
  if(m_children.get() && getChild(0)->isID()) {
    //return static_cast<const CDOmIdentifier*>(m_children->at(0).get())->getName();
    return static_cast<const CDOmIdentifier*>(getChild(0).get())->getName();
  }
  return RefString();
}

void CDOmPortItem::addPortExprLink(RefCDOmExprLink exprLink) {
  ASSERT(!(m_portItemType == PORT_ITEM_EMPTY || (m_portItemType == PORT_ITEM_SIMPLE && m_children.get() && (m_children->size() > 1 || !getChild(0)->isID()))), "[CDOmPortItem::addPortExprLink()] illegal state for this method call.");
  //if(m_portItemType == PORT_ITEM_EMPTY ||
  //   //(m_portItemType == PORT_ITEM_SIMPLE && m_children.get() && (m_children->size() > 1 || !m_children->at(0)->isID()))) {
  // (m_portItemType == PORT_ITEM_SIMPLE && m_children.get() && (m_children->size() > 1 || !getChild(0)->isID()))) {
  //  throw NSBase::IllegalStateException("[CDOmPortItem::addPortExprLink()] illegal state for this method call.", m_lineNumber);
  //}
  ASSERT(exprLink.get(), "exprLink is NULL");

  //exprLink->setParent(m_weakRef.lock()); // self registration
  exprLink->setParent(getThis()); // self registration
  static_cast<CDOmModuleDecl*>(getParent().get())->registerPortExprLink(exprLink->getName(), exprLink); // registers port expr link in module
}

const RefCDOmExprLink CDOmPortItem::getExprLink() const {
  ASSERT(m_portItemType == PORT_ITEM_SIMPLE && m_children.get(), "[CDOmPortItem::getExprLink()] illegal state for this method call.");
  //if(m_portItemType != PORT_ITEM_SIMPLE || !m_children.get()) {
  //  throw NSBase::IllegalStateException("[CDOmPortItem::getExprLink()] illegal state for this method call.", m_lineNumber);
  //}

  if( m_children->size() == 1 ) {
    //if( m_children->at(0)->getType() != TYPE_EXPR )
    ASSERT(getChild(0)->getType() == TYPE_EXPR, "[CDOmPortItem::getExprLink()] illegal state for this method call.");
    //if( getChild(0)->getType() != TYPE_EXPR )
    //   throw NSBase::IllegalStateException("[CDOmPortItem::getExprLink()] illegal state for this method call.", m_lineNumber);
    //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
    RefCDOmBase exprlinkAsBase = getChild(0);
    RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
    return exprlink;
  }
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(1));
  RefCDOmBase exprlinkAsBase = getChild(1);
  RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
  return exprlink;
}

const RefTVec_RefCDOmExprLink CDOmPortItem::getExprLinks() const {
  ASSERT(m_portItemType == PORT_ITEM_CONCAT, "[CDOmPortItem::getExprLinks()] illegal state for this method call.");
  //if(m_portItemType != PORT_ITEM_CONCAT) {
  //  throw NSBase::IllegalStateException("[CDOmPortItem::getExprLinks()] illegal state for this method call.", m_lineNumber);
  //}

  return getChildren<CDOmExprLink>(TYPE_EXPR);
}

void CDOmPortItem::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmPortItem>(m_weakRef.lock()));
  RefCDOmBase cdomportitemAsBase = getThis();
  RefCDOmPortItem cdomportitem = CDOmPortItem::cast(cdomportitemAsBase);
  visitor.visit(cdomportitem);
}

// ********************************************************************************
// CDOmModuleDecl class
// ********************************************************************************
CDOmModuleDecl::CDOmModuleDecl(TLineNumberType lineNumber, EKeywordType keywordType)
  : m_isInstantiated(FALSE),
    CDOmAttrHolder(lineNumber, TYPE_DECL_MODULE), m_keywordType(keywordType), m_moduleDeclType(UNDEFINED), m_scope(),
    m_paramDeclCollection(), m_portItems(), m_portNameMap(), m_explicitPortNameMap(), m_cslSourceUnitType(GEN_FROM_UNDEFINED) {}

RefCDOmModuleDecl CDOmModuleDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmModuleDecl();
  }
  ASSERT(object->getType() == TYPE_DECL_MODULE, "type check on CDOmModuleDecl::cast failure");
  return boost::static_pointer_cast<CDOmModuleDecl>(object);
}

void CDOmModuleDecl::registerPortExprLink(const RefString& name, const RefCDOmExprLink& portExprLink) {
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(portExprLink.get(), "portExprLink is NULL");
    ASSERT(portExprLink->getName() == name, "portExprLink has illegal name");

    if(!m_portNameMap.get()) {
      m_portNameMap = RefTMap_RefString_RefCDOmExprLink(new TMap_RefString_RefCDOmExprLink());
    }
    else {
      // check for the same port name and issue a warning if found
      if(m_portNameMap->find(name) != m_portNameMap->end()) {
        std::cerr << "[CDOmModuleDecl::registerPortExprLink()] WARNING: duplicate port ref name found: " << *name << std::endl;
      }
    }
    m_portNameMap->insert(TPair_RefString_RefCDOmExprLink(name, portExprLink)); // if there are duplicates, only the 1st one is inserted (this is how map works)
  }
}

void CDOmModuleDecl::beforeAddingModuleItem(TBool isPortDecl) {
  // if this module decl is UNDEFINED up to this point it means it has to update to DECL_2. It cannot update to DECL_1
  // because for a DECL_1 list_of_ports must had been added before triggering a DECL_1 state in the first place
  if(m_moduleDeclType == UNDEFINED) {
    m_moduleDeclType = DECL_2;
  }
  else if(isPortDecl && m_moduleDeclType == DECL_2) {
    ASSERT(m_children->back()->getType() == TYPE_PORT_DECL, "type check on beforeAddingModuleItem failure");
  }
}

RefCDOmModuleDecl CDOmModuleDecl::build(TLineNumberType lineNumber, RefCDOmDesign parent, const RefString& name, EKeywordType keywordType) {
  ASSERT(parent.get(), "parent is NULL");
  if(checkIdName(name, lineNumber)) {

    CDOmModuleDecl* moduleDecl = new CDOmModuleDecl(lineNumber, keywordType);
    RefCDOmModuleDecl refModuleDecl(moduleDecl);
    moduleDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refModuleDecl);
    refModuleDecl->setParent(parent); // self registration
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, refModuleDecl, CDOmIdentifier::ID_MODULE, name);
    // initialize attached scope
    moduleDecl->m_scope = CDOmScope::build(id);
    return refModuleDecl;
  }
  return RefCDOmModuleDecl();
}

RefCDOmScope CDOmModuleDecl::getAttachedScope() const {
  return m_scope;
}

CDOmModuleDecl::EKeywordType CDOmModuleDecl::getKeywordType() const {
  return m_keywordType;
}

TBool CDOmModuleDecl::hasParamDeclCollection() const {
  return m_paramDeclCollection.get() ? true : false;
}

void CDOmModuleDecl::buildParamDeclCollection(TLineNumberType lineNumber) {
  //assert(m_children->size() == 1 || (m_children->size() == 2 && m_children->at(1)->getType() == TYPE_ATTR_LIST_COLLECTION)); // up to this point we must have: TYPE_ID [TYPE_ATTR_LIST_COLLECTION]
  ASSERT(m_children->size() == 1 || (m_children->size() == 2 && getChild(1)->getType() == TYPE_ATTR_LIST_COLLECTION), "up to this point we must have: TYPE_ID [TYPE_ATTR_LIST_COLLECTION]");
  if(!m_paramDeclCollection.get()){
    //m_paramDeclCollection = CDOmParamDeclCollection::build(lineNumber, boost::static_pointer_cast<CDOmModuleDecl>(m_weakRef.lock()));
    RefCDOmBase cdommoduledeclAsBase = getThis();
    RefCDOmModuleDecl cdommoduledecl = CDOmModuleDecl::cast(cdommoduledeclAsBase);
    m_paramDeclCollection = CDOmParamDeclCollection::build(lineNumber, cdommoduledecl);
  }
  else {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_HAS_PARAMETER, args, m_lineNumber);
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmModuleDecl::buildParamDeclCollection()] parameter already set.", m_lineNumber);
  }
}

RefCDOmParamDeclCollection CDOmModuleDecl::getParamDeclCollection() {
  ASSERT(m_paramDeclCollection.get(), "[CDOmModuleDecl::getParamDeclCollection()] parameter not set.");
  //if(m_paramDeclCollection.get()) {
  return m_paramDeclCollection;
  //}
  //else {
  //  //throw NSBase::IllegalStateException("[CDOmModuleDecl::getParamDeclCollection()] parameter not set.", m_lineNumber);
  //}
}

const RefCDOmParamDeclCollection CDOmModuleDecl::getParamDeclCollection() const {
  ASSERT(m_paramDeclCollection.get(), "[CDOmModuleDecl::getParamDeclCollection() const] parameter not set.");
  //if(m_paramDeclCollection.get())
  return m_paramDeclCollection;
  //throw NSBase::IllegalStateException("[CDOmModuleDecl::getParamDeclCollection() const] parameter not set.", m_lineNumber);
}

RefCDOmPortItem CDOmModuleDecl::buildPortItem(TLineNumberType lineNumber, CDOmPortItem::EPortItemType portItemType, const RefString& explicitName) {
  //assert(m_moduleDeclType == UNDEFINED || (m_moduleDeclType == DECL_1 && m_children->back()->getType() == TYPE_PORT_ITEM));

  if(m_moduleDeclType == UNDEFINED) {
    m_moduleDeclType = DECL_1;
  }
  if(explicitName.get()) {
    if(checkIdName(explicitName, lineNumber)) {
      if(!m_explicitPortNameMap.get()) {
        m_explicitPortNameMap = RefTMap_RefString_RefCDOmPortItem(new TMap_RefString_RefCDOmPortItem());
      }
      else {
        // check for explicit port name duplicate
        ASSERT(m_explicitPortNameMap->find(explicitName) == m_explicitPortNameMap->end(), std::string("[CDOmModuleDecl::buildPortItem()] duplicate explicit port name found: " + *explicitName).c_str());
        //if(m_explicitPortNameMap->find(explicitName) != m_explicitPortNameMap->end()) {
        //  throw NSBase::IllegalArgumentException(std::string("[CDOmModuleDecl::buildPortItem()] duplicate explicit port name found: " + *explicitName).c_str(), lineNumber);
        //}
      }
    }
    else {
      return RefCDOmPortItem();
    }
  }
  //RefCDOmPortItem portItem = CDOmPortItem::build(lineNumber, boost::static_pointer_cast<CDOmModuleDecl>(m_weakRef.lock()), portItemType, explicitName);
  RefCDOmBase cdommoduledeclAsBase = getThis();
  RefCDOmModuleDecl cdommoduledecl = CDOmModuleDecl::cast(cdommoduledeclAsBase);
  RefCDOmPortItem portItem = CDOmPortItem::build(lineNumber, cdommoduledecl, portItemType, explicitName);
  if(explicitName.get()) {
    m_explicitPortNameMap->insert(TPair_RefString_RefCDOmPortItem(explicitName, portItem));
  }
  return portItem;
}

TBool CDOmModuleDecl::containsExplicitPortName(const RefString& name) const {
  ASSERT(m_moduleDeclType == DECL_1, "[CDOmModuleDecl::containsExplicitPortName()] illegal state for this method call.");
  //if(m_moduleDeclType != DECL_1) {
  //  throw NSBase::IllegalStateException("[CDOmModuleDecl::containsExplicitPortName()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, m_lineNumber)) {

    if(!m_explicitPortNameMap.get()) {
      return FALSE;
    }
    return m_explicitPortNameMap->find(name) != m_explicitPortNameMap->end();
  }
  return FALSE;
}

RefCDOmPortItem CDOmModuleDecl::getPortItem(const RefString& explicitPortName) const {
  ASSERT(m_moduleDeclType != DECL_1, "[CDOmModuleDecl::getPortItem()] illegal state for this method call.");
  //if(m_moduleDeclType != DECL_1) {
  //  throw NSBase::IllegalStateException("[CDOmModuleDecl::getPortItem()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(explicitPortName, m_lineNumber)) {
    ASSERT(m_explicitPortNameMap.get(), std::string("[CDOmModuleDecl::getPortItem()] explicit port name: " + *explicitPortName + " not found.").c_str());
    //if(!m_explicitPortNameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmModuleDecl::getPortItem()] explicit port name: " + *explicitPortName + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmPortItem_constIter iter = m_explicitPortNameMap->find(explicitPortName);
    ASSERT(iter != m_explicitPortNameMap->end(), std::string("[CDOmModuleDecl::getPortItem()] explicit port name: " + *explicitPortName + " not found.").c_str());
    //if(iter == m_explicitPortNameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmModuleDecl::getPortItem()] explicit port name: " + *explicitPortName + " not found.").c_str(), m_lineNumber);
    //}
    return iter->second;
  }
  return RefCDOmPortItem();
}


const RefTVec_RefCDOmPortItem CDOmModuleDecl::getPortItems() const {
  //if(m_moduleDeclType != DECL_2) {
  //  throw NSBase::IllegalStateException("[CDOmModuleDecl::getPortDecls()] illegal state for this method call.", m_lineNumber);
  //}

  return getChildren<CDOmPortItem>(TYPE_PORT_ITEM);
}

TBool CDOmModuleDecl::containsPortExprLink(const RefString& name) const {
  ASSERT(m_moduleDeclType == DECL_1, "[CDOmModuleDecl::containsPortExprLink()] illegal state for this method call.");
  //if(m_moduleDeclType != DECL_1) {
  //  throw NSBase::IllegalStateException("[CDOmModuleDecl::containsPortExprLink()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, m_lineNumber)) {

    if(!m_portNameMap.get()) {
      return FALSE;
    }
    return m_portNameMap->find(name) != m_portNameMap->end();
  }
  return FALSE;
}

const RefTVec_RefCDOmPortDecl CDOmModuleDecl::getPortDecls() const {
  //if(m_moduleDeclType != DECL_2) {
  //  throw NSBase::IllegalStateException("[CDOmModuleDecl::getPortDecls()] illegal state for this method call.", m_lineNumber);
  //}

  return getChildren<CDOmPortDecl>(TYPE_PORT_DECL);
}

const RefTVec_RefCDOmPortDecl CDOmModuleDecl::getOutputPortDecls() const {
  RefTVec_RefCDOmPortDecl outputPortDecls = RefTVec_RefCDOmPortDecl(new TVec_RefCDOmPortDecl());
  RefTVec_RefCDOmPortDecl portDecls = getChildren<CDOmPortDecl>(TYPE_PORT_DECL);
  if(portDecls.get()) {
    for(TVec_RefCDOmPortDecl_const_iter iter = portDecls->begin(); iter < portDecls->end(); ++iter) {
      if((*iter)->getPortType() == PORT_OUTPUT) {
        outputPortDecls->push_back(*iter);
      }
    }
  }
  return outputPortDecls;
}

const RefTVec_RefCDOmPortDecl CDOmModuleDecl::getInputPortDecls() const {
  RefTVec_RefCDOmPortDecl inputPortDecls = RefTVec_RefCDOmPortDecl(new TVec_RefCDOmPortDecl());
  RefTVec_RefCDOmPortDecl portDecls = getChildren<CDOmPortDecl>(TYPE_PORT_DECL);
  if(portDecls.get()) {
    for(TVec_RefCDOmPortDecl_const_iter iter = portDecls->begin(); iter < portDecls->end(); ++iter) {
      if((*iter)->getPortType() == PORT_INPUT) {
        inputPortDecls->push_back(*iter);
      }
    }
  }
  return inputPortDecls;
}

const RefTVec_RefCDOmPortDecl CDOmModuleDecl::getInoutPortDecls() const {
  RefTVec_RefCDOmPortDecl inoutPortDecls = RefTVec_RefCDOmPortDecl(new TVec_RefCDOmPortDecl());
  RefTVec_RefCDOmPortDecl portDecls = getChildren<CDOmPortDecl>(TYPE_PORT_DECL);
  if(portDecls.get()) {
    for(TVec_RefCDOmPortDecl_const_iter iter = portDecls->begin(); iter < portDecls->end(); ++iter) {
      if((*iter)->getPortType() == PORT_INOUT) {
        inoutPortDecls->push_back(*iter);
      }
    }
  }
  return inoutPortDecls;
}

const RefString CDOmModuleDecl::getModuleName() const {
  //return( boost::static_pointer_cast<CDOmIdentifier> (m_children->at(0)))->getName(); 
  RefCDOmBase identifierAsBase = getChild(0);
  RefCDOmIdentifier identifier = CDOmIdentifier::cast(identifierAsBase);
  return identifier->getName();
}

void CDOmModuleDecl::setCslSourceUnitType(ECslSourceUnitType type) {
  m_cslSourceUnitType = type;
}

CDOmModuleDecl::ECslSourceUnitType CDOmModuleDecl::getCslSourceUnitType() const {
  return m_cslSourceUnitType;
}

TBool CDOmModuleDecl::hasInstantiations() const {
  RefTVec_RefCDOmBase instVec = getInstantiationsAsBase();
  if(instVec.get() && instVec->size() > 0){
    return TRUE;
  }
  else {
    return FALSE;
  }
}

const RefTVec_RefCDOmBase CDOmModuleDecl::getInstancesDeclarationsAsBase() const {
  RefTVec_RefCDOmBase instancesDeclarations = RefTVec_RefCDOmBase(new TVec_RefCDOmBase());
  RefTVec_RefCDOmBase currentInstantiations = getInstantiationsAsBase();
  //We need the parent scope (design scope) for the doEval() substitute trick
  RefCDOmScope design = getParentScope();
  if(currentInstantiations.get() && design.get()){
    for(TVec_RefCDOmBase_const_iter iter = currentInstantiations->begin(); iter < currentInstantiations->end(); ++iter){

      RefCDOmExprLink moduleExprLink = (CDOmModuleOrUdpInstantiation::cast(*iter))->getModuleExprLink();
      //TEST
      //RefCDOmBase testBase = moduleExprLink->doEval();
      //DCERR("THE TYPE OF testBase is " << testBase->getType());
      //DCERR("THE NAME IS" << *(CDOmModuleDecl::cast(testBase)->getModuleName()));
      //
      RefCDOmIdentifier moduleIdentifier = design->lookupLocal(moduleExprLink->getName());
      if(moduleIdentifier.get()){
        RefCDOmBase moduleAsBase = moduleIdentifier->getParent();
        if(moduleAsBase.get()){
          instancesDeclarations->push_back(moduleAsBase);
        }
      }
    }
  }

  return instancesDeclarations;
}

void CDOmModuleDecl::isInstantiated() {
  m_isInstantiated = TRUE;
}

const TBool CDOmModuleDecl::isTopModule() const {
  return !m_isInstantiated;
}

void CDOmModuleDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());

  // std::cout << "// CDOmModuleDecl::acceptVisitor " << std::endl;

  //visitor.visit(boost::static_pointer_cast<CDOmModuleDecl>(m_weakRef.lock()));
  /*RefCDOmBase cdommoduledeclAsBase = getThis();
    RefCDOmModuleDecl cdommoduledecl = CDOmModuleDecl::cast(cdommoduledeclAsBase);
    visitor.visit(cdommoduledecl);*/

  //TVec_RefCDOmBase_const_iter iter = m_portItems->begin();
  // boost::static_pointer_cast<CDOmIdentifier>(m_weakRef.lock()));
  
  //  for(TVec_RefCDOmBase_const_iter iter = m_portItems->begin(); iter != m_portItems->end(); ++iter) {
  //
  //  }
  //  for(TVec_RefCDOmBase_const_iter iter = m_portItems->begin(); iter != m_portItems->end(); ++iter) {
  //      std::cout << "// CDOmModuleDecl::acceptVisitor for loop port items" << std::endl;
  //    (*iter)->acceptVisitor(visitor);
  //  }

}

// ********************************************************************************
// CDOmUdpDecl class
// ********************************************************************************
CDOmUdpDecl::CDOmUdpDecl(TLineNumberType lineNumber) : CDOmAttrHolder(lineNumber, TYPE_DECL_UDP), m_ports(), m_declType(DECL_UNDEFINED), m_bodyType(BODY_UNDEFINED), m_scope() { }

RefCDOmUdpDecl CDOmUdpDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmUdpDecl();
  }
  ASSERT(object->getType() == TYPE_DECL_UDP, "type check on CDOmUdpDecl::cast failure");
  return boost::static_pointer_cast<CDOmUdpDecl>(object);
}

RefCDOmUdpDecl CDOmUdpDecl::build(TLineNumberType lineNumber, RefCDOmDesign parent, const RefString& name) {
  ASSERT(parent.get(), "parent is NULL");
  if(checkIdName(name, lineNumber)) {

    CDOmUdpDecl* udpDecl = new CDOmUdpDecl(lineNumber);
    RefCDOmUdpDecl refUdpDecl(udpDecl);
    udpDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refUdpDecl);
    refUdpDecl->setParent(parent); // self registration
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, refUdpDecl, CDOmIdentifier::ID_UDP, name);
    // initialize attached scope
    udpDecl->m_scope = CDOmScope::build(id);
    return refUdpDecl;
  }
  return RefCDOmUdpDecl();
}

void CDOmUdpDecl::beforeAddingPortDecl() {
  ASSERT(m_bodyType == BODY_UNDEFINED, "illegal m_bodyType, it should be BODY_UNDEFINED");
  if( m_declType == DECL_UNDEFINED )
    m_declType = DECL_2;
}

void CDOmUdpDecl::beforeAddingUdpEntry(TBool isCombinationalEntry) {
  if(isCombinationalEntry) {
    if(m_bodyType == BODY_UNDEFINED)
      m_bodyType = UDP_TYPE_COMBINATIONAL;
    ASSERT(m_bodyType == UDP_TYPE_COMBINATIONAL, "illegal m_bodyType, it should be UDP_TYPE_COMBINATIONAL");
  }
  else {
    if(m_bodyType == BODY_UNDEFINED)
      m_bodyType = UDP_TYPE_SEQUENTIAL;
    ASSERT(m_bodyType == UDP_TYPE_SEQUENTIAL, "illegal m_bodyType, it should be UDP_TYPE_SEQUENTIAL");
  }
}

void CDOmUdpDecl::beforeAddingUdpInitStmt() {
  ASSERT(m_bodyType == BODY_UNDEFINED, "illegal m_bodyType, it should be BODY_UNDEFINED");
  m_bodyType = UDP_TYPE_SEQUENTIAL;
}

RefCDOmScope CDOmUdpDecl::getAttachedScope() const {
  return m_scope;
}

void CDOmUdpDecl::addPort(const RefString& portName) {
  ASSERT(portName.get(), "portName is NULL");
  if(m_declType == DECL_UNDEFINED) {
    m_declType = DECL_1;
    m_ports = RefTVec_RefString(new TVec_RefString());
  }
  ASSERT(m_declType == DECL_1, "illegal m_declType, it should be DECL_1");
  for( TVec_RefString_const_iter it = m_ports->begin(); it != m_ports->end(); ++it )
    if(**it == *portName) {
      if(getAttachedScope()->getScopeType() != CDOmScope::SCOPE_DESIGN) {
        args.push_back(*getAttachedScope()->getID()->getName());
      }
      else {
        args.push_back("global");
      }
      args.push_back(*portName);
      addErr(NSWarningErr::VEE_CDC_INST_INST_DUPLICATE_ENTITY_NAME_CDCVE, args, m_lineNumber);
      //throw NSBase::IllegalArgumentException(std::string("[CDOmUdpDecl::addPort(const RefString& portName)] duplicate port predeclaration name foud: " + *portName).c_str(), m_lineNumber);
    }
  m_ports->push_back(portName);
}

TBool CDOmUdpDecl::containsPort(const RefString& portName) {
  ASSERT(m_declType == DECL_1, "[CDOmUdpDecl::containsPort(const RefString& portName)] illegal state for this method call");
  //if( m_declType != DECL_1 )
  //  throw NSBase::IllegalStateException("[CDOmUdpDecl::containsPort(const RefString& portName)] illegal state for this method call", m_lineNumber);
  for( TVec_RefString_const_iter it = m_ports->begin(); it != m_ports->end(); ++it )
    if( *portName == **it )
      return TRUE;
  return FALSE;
}

RefTVec_RefString CDOmUdpDecl::getPortItemNames() const {
  return m_ports;
}

void CDOmUdpDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const { 
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmUdpInitStmt class
// ********************************************************************************
CDOmUdpInitStmt::CDOmUdpInitStmt(TLineNumberType lineNumber, EInitVal val) : CDOmBase(TYPE_UDP_INIT_STMT, lineNumber), m_initVal(val) { }

RefCDOmUdpInitStmt CDOmUdpInitStmt::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmUdpInitStmt();
  }
  ASSERT(object->getType() == TYPE_UDP_INIT_STMT, "type check on CDOmUdpInitStmt::cast failure");
  return boost::static_pointer_cast<CDOmUdpInitStmt>(object);
}

RefCDOmUdpInitStmt CDOmUdpInitStmt::build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, RefCDOmExprLink outputPortId, EInitVal val) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(outputPortId.get(), "outputPortId is NULL");
  ASSERT(!outputPortId->isHID() && !outputPortId->getRangeExpr().get() && !outputPortId->getArrayIndexes().get(), "outputPortId should not be HID or");

  CDOmUdpInitStmt *initStmt = new CDOmUdpInitStmt(lineNumber, val);
  RefCDOmUdpInitStmt refInitStmt(initStmt);
  initStmt->m_weakRef = boost::weak_ptr<CDOmBase>( refInitStmt);

  initStmt->setParent(parent);
  outputPortId->setParent(refInitStmt);
  
  return refInitStmt;
}

CDOmUdpInitStmt::EInitVal CDOmUdpInitStmt::getInitVal() const {
  return m_initVal;
}

void CDOmUdpInitStmt::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmUdpCombEntry class
// ********************************************************************************
CDOmUdpCombEntry::CDOmUdpCombEntry(TLineNumberType lineNumber, ECDOmUdpSymbol outputSymbol, RefTVec_ECDOmUdpSymbol intputList) 
  : CDOmBase(TYPE_UDP_COMB_ENTRY, lineNumber), m_outputSymbol(outputSymbol),  m_inputList(intputList) { }

RefCDOmUdpCombEntry CDOmUdpCombEntry::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmUdpCombEntry();
  }
  ASSERT(object->getType() == TYPE_UDP_COMB_ENTRY, "type check on CDOmUdpCombEntry::cast failure");
  return boost::static_pointer_cast<CDOmUdpCombEntry>(object);
}

RefCDOmUdpCombEntry CDOmUdpCombEntry::build(TLineNumberType lineNumber, RefCDOmUdpDecl parent, RefTVec_ECDOmUdpSymbol inputList, ECDOmUdpSymbol outputSymbol) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(inputList.get(), "inputList is NULL");
  ASSERT(inputList->size(), "inputList is empty");
  ASSERT(outputSymbol & UDP_SYMBOL_MASK_OUTPUT_SYMBOL, "outputSymbol is illegal");
  for(TVec_ECDOmUdpSymbol_const_iter it = inputList->begin(); it != inputList->end(); ++it)
    ASSERT(*it & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "inputList has illegal udp symbol");

  CDOmUdpCombEntry *combEntry = new CDOmUdpCombEntry(lineNumber, outputSymbol, inputList);
  RefCDOmUdpCombEntry refCombEntry(combEntry);
  combEntry->m_weakRef = boost::weak_ptr<CDOmBase>( refCombEntry);

  combEntry->setParent(parent);
  
  return refCombEntry;
}

ECDOmUdpSymbol CDOmUdpCombEntry::getOutputSymbol() const {
  return m_outputSymbol;
}

const RefTVec_ECDOmUdpSymbol CDOmUdpCombEntry::getInputList() const {
  return m_inputList;
}

void CDOmUdpCombEntry::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const { 
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmUdpSeqEntry class
// ********************************************************************************
CDOmUdpSeqEntry::CDOmUdpSeqEntry(TLineNumberType lineNumber, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, RefTVec_ECDOmUdpSymbol inputList)
  : CDOmBase(TYPE_UDP_SEQ_ENTRY, lineNumber), m_currState(currState), m_nextState(nextState), m_levelSymbolList1(inputList), m_levelSymbolList2(), m_levelSymbol1(UDP_SYMBOL_UNDEF), m_levelSymbol2(UDP_SYMBOL_UNDEF), m_edgeSymbol(EDGE_UNDEF) { }

CDOmUdpSeqEntry::CDOmUdpSeqEntry(TLineNumberType lineNumber, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2, ECDOmUdpSymbol levelSymbol1, ECDOmUdpSymbol levelSymbol2)
  : CDOmBase(TYPE_UDP_SEQ_ENTRY, lineNumber), m_currState(currState), m_nextState(nextState), m_levelSymbolList1(levelSymbolList1), m_levelSymbolList2(levelSymbolList2), 
    m_levelSymbol1(levelSymbol1), m_levelSymbol2(levelSymbol2), m_edgeSymbol(EDGE_UNDEF) { }

CDOmUdpSeqEntry::CDOmUdpSeqEntry(TLineNumberType lineNumber, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2,
                                 ESeqEdgeSymbol edgeSymbol)
  : CDOmBase(TYPE_UDP_SEQ_ENTRY, lineNumber), m_currState(currState), m_nextState(nextState), m_levelSymbolList1(levelSymbolList1), m_levelSymbolList2(levelSymbolList2), 
    m_levelSymbol1(UDP_SYMBOL_UNDEF), m_levelSymbol2(UDP_SYMBOL_UNDEF), m_edgeSymbol(edgeSymbol) { }

RefCDOmUdpSeqEntry CDOmUdpSeqEntry::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmUdpSeqEntry();
  }
  ASSERT(object->getType() == TYPE_UDP_SEQ_ENTRY, "type check on CDOmUdpSeqEntry::cast failure");
  return boost::static_pointer_cast<CDOmUdpSeqEntry>(object);
}

RefCDOmUdpSeqEntry CDOmUdpSeqEntry::buildWithLevelInputList(TLineNumberType lineNumber, RefCDOmUdpDecl parent, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, 
                                                            RefTVec_ECDOmUdpSymbol inputList) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(currState & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "illegal currState");
  ASSERT(nextState & UDP_SYMBOL_MASK_NEXT_STATE, "illegal nextState");
  ASSERT(inputList.get(), "inputList is NULL");
  ASSERT(inputList->size(), "inputList is empty");
  for(TVec_ECDOmUdpSymbol_const_iter it = inputList->begin(); it != inputList->end(); ++it)
    ASSERT(*it & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "inputList has illegal element");

  CDOmUdpSeqEntry *seqEntry = new CDOmUdpSeqEntry(lineNumber, currState, nextState, inputList);
  RefCDOmUdpSeqEntry refSeqEntry(seqEntry);
  seqEntry->m_weakRef = boost::weak_ptr<CDOmBase>( refSeqEntry);

  seqEntry->setParent(parent);

  return refSeqEntry;
}

RefCDOmUdpSeqEntry CDOmUdpSeqEntry::buildWithEdgeInputList(TLineNumberType lineNumber, RefCDOmUdpDecl parent, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, 
                                                           RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2, ECDOmUdpSymbol levelSymbol1, ECDOmUdpSymbol levelSymbol2) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(currState & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "illegal currState");
  ASSERT(nextState & UDP_SYMBOL_MASK_NEXT_STATE, "illegal nextState");
  if( levelSymbolList1.get() )
    for(TVec_ECDOmUdpSymbol_const_iter it = levelSymbolList1->begin(); it != levelSymbolList1->end(); ++it)
      ASSERT(*it & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "levelSymbolList1 has illegal element");
  if( levelSymbolList2.get() )
    for(TVec_ECDOmUdpSymbol_const_iter it = levelSymbolList2->begin(); it != levelSymbolList2->end(); ++it)
      ASSERT(*it & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "levelSymbolList2 has illegal element");
  ASSERT(levelSymbol1 & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "illegal levelSymbol1");
  ASSERT(levelSymbol2 & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "illegal levelSymbol2");

  CDOmUdpSeqEntry *seqEntry = new CDOmUdpSeqEntry(lineNumber, currState, nextState, levelSymbolList1, levelSymbolList2, levelSymbol1, levelSymbol2);
  RefCDOmUdpSeqEntry refSeqEntry(seqEntry);
  seqEntry->m_weakRef = boost::weak_ptr<CDOmBase>( refSeqEntry);

  seqEntry->setParent(parent);

  return refSeqEntry;
}

RefCDOmUdpSeqEntry CDOmUdpSeqEntry::buildWithEdgeInputList(TLineNumberType lineNumber, RefCDOmUdpDecl parent, ECDOmUdpSymbol currState, ECDOmUdpSymbol nextState, 
                                                           RefTVec_ECDOmUdpSymbol levelSymbolList1, RefTVec_ECDOmUdpSymbol levelSymbolList2, ESeqEdgeSymbol edgeSymbol) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(currState & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "illegal currState");
  ASSERT(nextState & UDP_SYMBOL_MASK_NEXT_STATE, "illegal nextState");
  if( levelSymbolList1.get() )
    for(TVec_ECDOmUdpSymbol_const_iter it = levelSymbolList1->begin(); it != levelSymbolList1->end(); ++it)
      ASSERT(*it & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "levelSymbolList1 has illegal element");
  if( levelSymbolList2.get() )
    for(TVec_ECDOmUdpSymbol_const_iter it = levelSymbolList2->begin(); it != levelSymbolList2->end(); ++it)
      ASSERT(*it & UDP_SYMBOL_MASK_LEVEL_SYMBOL, "levelSymbolList2 has illegal element");
  ASSERT(edgeSymbol!=EDGE_UNDEF, "edgeSymbol must be EDGE_UNDEF");
  CDOmUdpSeqEntry *seqEntry = new CDOmUdpSeqEntry(lineNumber, currState, nextState, levelSymbolList1, levelSymbolList2, edgeSymbol);
  RefCDOmUdpSeqEntry refSeqEntry(seqEntry);
  seqEntry->m_weakRef = boost::weak_ptr<CDOmBase>( refSeqEntry);

  seqEntry->setParent(parent);

  return refSeqEntry;
}

ECDOmUdpSymbol CDOmUdpSeqEntry::getCurrState() const {
  return m_currState;
}

ECDOmUdpSymbol CDOmUdpSeqEntry::getNextState() const {
  return m_nextState;
}

const RefTVec_ECDOmUdpSymbol CDOmUdpSeqEntry::getLevelInputList() const {
  ASSERT(!(m_levelSymbol2 || m_edgeSymbol != EDGE_UNDEF), "[CDOmUdpSeqEntry::getLevelInputList() const] illegal state for this method call");
  //if(m_levelSymbol2 || m_edgeSymbol != EDGE_UNDEF)
  //  throw NSBase::IllegalStateException("[CDOmUdpSeqEntry::getLevelInputList() const] illegal state for this method call", m_lineNumber);
  return m_levelSymbolList1;
}

const RefTVec_ECDOmUdpSymbol CDOmUdpSeqEntry::getLevelSymbolList1() const {
  ASSERT(!(!m_levelSymbol2 && m_edgeSymbol == EDGE_UNDEF), "[CDOmUdpSeqEntry::getLevelSymbolList1() const] illegal state for this method call");
  //if(!m_levelSymbol2 && m_edgeSymbol == EDGE_UNDEF)
  //  throw NSBase::IllegalStateException("[CDOmUdpSeqEntry::getLevelSymbolList1() const] illegal state for this method call", m_lineNumber);
  return m_levelSymbolList1;
}

const RefTVec_ECDOmUdpSymbol CDOmUdpSeqEntry::getLevelSymbolList2() const {
  ASSERT(!(!m_levelSymbol2 && m_edgeSymbol == EDGE_UNDEF), "[CDOmUdpSeqEntry::getLevelSymbolList2() const] illegal state for this method call");
  //if(!m_levelSymbol2 && m_edgeSymbol == EDGE_UNDEF)
  //  throw NSBase::IllegalStateException("[CDOmUdpSeqEntry::getLevelSymbolList2() const] illegal state for this method call", m_lineNumber);
  return m_levelSymbolList2;
}

ECDOmUdpSymbol CDOmUdpSeqEntry::getEdgeIndicator1() const {
  ASSERT(m_levelSymbol2, "[CDOmUdpSeqEntry::getEdgeIndicator1() const] illegal state for this method call");
  //if(!m_levelSymbol2)
  //  throw NSBase::IllegalStateException("[CDOmUdpSeqEntry::getEdgeIndicator1() const] illegal state for this method call", m_lineNumber);
  return m_levelSymbol1;
}

ECDOmUdpSymbol CDOmUdpSeqEntry::getEdgeIndicator2() const {
  ASSERT(m_levelSymbol2, "[CDOmUdpSeqEntry::getEdgeIndicator2() const] illegal state for this method call");
  //if(!m_levelSymbol2)
  //  throw NSBase::IllegalStateException("[CDOmUdpSeqEntry::getEdgeIndicator2() const] illegal state for this method call", m_lineNumber);
  return m_levelSymbol2;
}

CDOmUdpSeqEntry::ESeqEdgeSymbol CDOmUdpSeqEntry::getSeqEdgeSymbol() const {
  ASSERT(m_edgeSymbol != EDGE_UNDEF, "[CDOmUdpSeqEntry::getSeqEdgeSymbol() const] illegal state for this method call");
  //if(m_edgeSymbol == EDGE_UNDEF)
  //  throw NSBase::IllegalStateException("[CDOmUdpSeqEntry::getSeqEdgeSymbol() const] illegal state for this method call", m_lineNumber);
  return m_edgeSymbol;
}

TBool CDOmUdpSeqEntry::hasLevelInputList() const {
  return (m_edgeSymbol == EDGE_UNDEF) && (m_levelSymbol2 == UDP_SYMBOL_UNDEF);
}

TBool CDOmUdpSeqEntry::hasEdgeSymbol() const {
  return m_edgeSymbol != EDGE_UNDEF;
}

void CDOmUdpSeqEntry::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const { 
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmTFPortDecl class
// ********************************************************************************
CDOmTFPortDecl::CDOmTFPortDecl(TLineNumberType lineNumber, ECDOmPortType portType, ECDOmVarType varType)
  : CDOmAttrHolder(lineNumber, TYPE_TF_PORT_DECL), m_portType(portType), m_varType(varType), m_isSigned(false), m_range(), m_nameMap() {}

RefCDOmTFPortDecl CDOmTFPortDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmTFPortDecl();
  }
  ASSERT(object->getType() == TYPE_TF_PORT_DECL, "type check on CDOmTFPortDecl::cast failure");
  return boost::static_pointer_cast<CDOmTFPortDecl>(object);
}

RefCDOmTFPortDecl CDOmTFPortDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmPortType portType, ECDOmVarType varType) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_TASK || (parent->getType() == TYPE_DECL_FUNCTION && portType == PORT_INPUT), "parent should be a task declaration or a function declaration (for port input types only)");

  CDOmTFPortDecl* tfPortDecl = new CDOmTFPortDecl(lineNumber, portType, varType);
  RefCDOmTFPortDecl refTFPortDecl(tfPortDecl);
  tfPortDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refTFPortDecl);
  tfPortDecl->setParent(parent); // self registration
  return refTFPortDecl;
}

ECDOmPortType CDOmTFPortDecl::getPortType() const {
  return m_portType;
}

ECDOmVarType CDOmTFPortDecl::getVarType() const {
  return m_varType;
}

void CDOmTFPortDecl::setSigned() {
  if(m_varType != VAR_UNDEFINED && m_varType != VAR_REG) { // sign is only supported for var reg
    args.push_back("port");
    args.push_back("var reg");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    cdomHasErrors = TRUE;
    //  throw NSBase::IllegalStateException("[CDOmTFPortDecl::setSigned()] illegal state for this method call.", m_lineNumber);
  }
  else {
    m_isSigned = true;
  }
}

TBool CDOmTFPortDecl::isSigned() const {
  if(m_varType != VAR_UNDEFINED && m_varType != VAR_REG) { // sign is only supported for var reg
    args.push_back("port");
    args.push_back("var reg");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    cdomHasErrors = TRUE;
    return FALSE;
    //  throw NSBase::IllegalStateException("[CDOmTFPortDecl::isSigned()] illegal state for this method call.", m_lineNumber);
  }
  return m_isSigned;
}

void CDOmTFPortDecl::setRange(RefCDOmRange range) {
  //assert(!m_children.get() || (m_children->size() == 1 && m_children->at(0)->getType() == TYPE_ATTR_LIST_COLLECTION));
  ASSERT(!m_children.get() || (m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION), "the following logical expression is not true: m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION");
  ASSERT(range.get(), "range is NULL");
  if(m_varType != VAR_UNDEFINED && m_varType != VAR_REG) { // range is only supported for var reg
    args.push_back("port");
    args.push_back("var reg");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    cdomHasErrors = TRUE;
    return;
    //throw NSBase::IllegalStateException("[CDOmTFPortDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  if(m_range.get()) {
    args.push_back("port");
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, m_lineNumber);
    cdomHasErrors = TRUE;
    return;
    //throw NSBase::IllegalStateException("[CDOmTFPortDecl::setRange()] range already set.", m_lineNumber);
  }

  //range->setParent(m_weakRef.lock()); // self registration
  range->setParent(getThis()); // self registration
  m_range = range;  
}

RefCDOmRange CDOmTFPortDecl::getRange() const {
  if(m_varType != VAR_UNDEFINED && m_varType != VAR_REG) { // range is only supported for var reg
    args.push_back("port");
    args.push_back("var reg");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    cdomHasErrors = TRUE;
    return RefCDOmRange();
    //throw NSBase::IllegalStateException("[CDOmTFPortDecl::getRange()] illegal state for this method call.", m_lineNumber);
  }
  return m_range;
}

void CDOmTFPortDecl::addPort(TLineNumberType lineNumber, const RefString& name) {
  if(checkIdName(name, lineNumber)) {

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_TF_PORT, name);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_TF_PORT, name);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

TBool CDOmTFPortDecl::containsPort(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMap.get()) {
      return FALSE;
    }
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

const RefTVec_RefCDOmIdentifier CDOmTFPortDecl::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmTFPortDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmTaskDecl class
// ********************************************************************************
CDOmTaskDecl::CDOmTaskDecl(TLineNumberType lineNumber, ETaskDeclType taskDeclType, TBool isAutomatic)
  : CDOmAttrHolder(lineNumber, TYPE_DECL_TASK), m_taskDeclType(taskDeclType), m_isAutomatic(isAutomatic), m_stmt(), m_scope() {}

RefCDOmTaskDecl CDOmTaskDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmTaskDecl();
  }
  ASSERT(object->getType() == TYPE_DECL_TASK, "type check on CDOmTaskDecl::cast failure");
  return boost::static_pointer_cast<CDOmTaskDecl>(object);
}

void CDOmTaskDecl::beforeAddingTaskItem(TBool isTFPortDecl) {
  ASSERT(!(*(m_children->end() - 1))->isStmt(), "should not be preceded by a statement; a statement must appear last in the task declaration");
  if(isTFPortDecl && m_taskDeclType == TASK_DECL_WITH_TASK_PORT_LIST) {
    ASSERT(!(*(m_children->end() - 1))->isBlockItem(), "should not be preceded by a block item; tf port declarations must appear before any block items");
  }
}

RefCDOmTaskDecl CDOmTaskDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, ETaskDeclType taskDeclType, const RefString& name, TBool isAutomatic) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE || parent->getType() == TYPE_GEN_INST || parent->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED || parent->getType() == TYPE_GEN_ITEM_BLOCK_NAMED, "parent should be a module or a generated instantiation or a named/unnamed generate block");
  if(checkIdName(name, lineNumber)) {

    CDOmTaskDecl* taskDecl = new CDOmTaskDecl(lineNumber, taskDeclType, isAutomatic);
    RefCDOmTaskDecl refTaskDecl(taskDecl);
    taskDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refTaskDecl);
    refTaskDecl->setParent(parent); // self registration
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, refTaskDecl, CDOmIdentifier::ID_TASK, name);
    // initialize attached scope
    taskDecl->m_scope = CDOmScope::build(id);
    return refTaskDecl;
  }
  return RefCDOmTaskDecl();
}

RefCDOmScope CDOmTaskDecl::getAttachedScope() const {
  return m_scope;
}

CDOmTaskDecl::ETaskDeclType CDOmTaskDecl::getTaskDeclType() const {
  return m_taskDeclType;
}

TBool CDOmTaskDecl::isAutomatic() const {
  return m_isAutomatic;
}

void CDOmTaskDecl::setStmt(RefCDOmStmt stmt) {
  ASSERT(stmt.get(), "stmt is NULL");
  ASSERT(!m_stmt.get(), "[CDOmTaskDecl::setStmt()] statement already set.");
  //if(m_stmt.get()) {
  //  throw NSBase::IllegalStateException("[CDOmTaskDecl::setStmt()] statement already set.", m_lineNumber);
  //}

  //stmt->setParent(m_weakRef.lock()); // self registration
  stmt->setParent(getThis()); // self registration
  m_stmt = stmt;
}

RefCDOmStmt CDOmTaskDecl::getStmt() const {
  return m_stmt;  
}

void CDOmTaskDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());

}

// ********************************************************************************
// CDOmFuncDecl class
// ********************************************************************************
CDOmFuncDecl::CDOmFuncDecl(TLineNumberType lineNumber, EFuncDeclType funcDeclType, TBool isAutomatic, TBool isSigned)
  : CDOmAttrHolder(lineNumber, TYPE_DECL_FUNCTION), m_funcDeclType(funcDeclType),
    m_isAutomatic(isAutomatic), m_isSigned(isSigned), m_range(), m_varType(VAR_UNDEFINED), m_stmt(), m_scope() {}

RefCDOmFuncDecl CDOmFuncDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmFuncDecl();
  }
  ASSERT(object->getType() == TYPE_DECL_FUNCTION, "type check on CDOmFuncDecl::cast failure");
  return boost::static_pointer_cast<CDOmFuncDecl>(object);
}

void CDOmFuncDecl::beforeAddingFuncItem(TBool isTFPortDecl) {
  ASSERT(!(*(m_children->end() - 1))->isFuncStmt(), "should not be preceded by a function statement; a function statement must appear last in the function declaration");
  if(isTFPortDecl && m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST) {
    ASSERT(!(*(m_children->end() - 1))->isBlockItem(), "should not be preceded by a block item; tf port declarations must appear before any block items");
  }
}

RefCDOmFuncDecl CDOmFuncDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, EFuncDeclType funcDeclType, const RefString& name, TBool isAutomatic, TBool isSigned) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE || parent->getType() == TYPE_GEN_INST, "parent should be a module or a generated instantiation");
  ASSERT(funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST || funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST, "funcDeclType check on CDOmFuncDecl::build failure");
  if(checkIdName(name, lineNumber)) {

    CDOmFuncDecl* funcDecl = new CDOmFuncDecl(lineNumber, funcDeclType, isAutomatic, isSigned);
    RefCDOmFuncDecl refFuncDecl(funcDecl);
    funcDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refFuncDecl);
    refFuncDecl->setParent(parent); // self registration
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, refFuncDecl, CDOmIdentifier::ID_FUNCTION, name);
    // initialize attached scope
    funcDecl->m_scope = CDOmScope::build(id);
    return refFuncDecl;
  }
  return RefCDOmFuncDecl();
}

RefCDOmScope CDOmFuncDecl::getAttachedScope() const {
  return m_scope;
}

CDOmFuncDecl::EFuncDeclType CDOmFuncDecl::getFuncDeclType() const {
  return m_funcDeclType;
}

TBool CDOmFuncDecl::isAutomatic() const {
  return m_isAutomatic;
}

TBool CDOmFuncDecl::isSigned() const {
  return m_isSigned;
}

void CDOmFuncDecl::setRange(RefCDOmRange range) {
  //assert(m_children->size() == 1 || (m_children->size() == 2 && m_children->at(1)->getType() == TYPE_ATTR_LIST_COLLECTION));
  ASSERT(m_children->size() == 1 || (m_children->size() == 2 && getChild(1)->getType() == TYPE_ATTR_LIST_COLLECTION), "the following logical expression is not true: m_children->size() == 1 || (m_children->size() == 2 && getChild(1)->getType() == TYPE_ATTR_LIST_COLLECTION");
  ASSERT(range.get(), "range is NULL");
  if(m_funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE || m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE) {
    if(getAttachedScope()->getScopeType() != CDOmScope::SCOPE_DESIGN) {
      args.push_back(*getAttachedScope()->getID()->getName());
    }
    else {
      args.push_back("global");
    }
    args.push_back("function with range");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, getThis()->getLineNumber());
    cdomHasErrors = TRUE;
    return;
    //throw NSBase::IllegalStateException("[CDOmFuncDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  else if(m_funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST) {
    m_funcDeclType = FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE;
  }
  else if(m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST) {
    m_funcDeclType = FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE;
  }
  if(m_range.get()) {
    if(getAttachedScope()->getScopeType() != CDOmScope::SCOPE_DESIGN) {
      args.push_back(*getAttachedScope()->getID()->getName());
    }
    else {
      args.push_back("global");
    }
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, m_lineNumber);
    cdomHasErrors = TRUE;
    return;
    //throw NSBase::IllegalStateException("[CDOmFuncDecl::setRange()] range already set.", m_lineNumber);
  }

  //range->setParent(m_weakRef.lock()); // self registration
  range->setParent(getThis()); // self registration
  m_range = range;
}

RefCDOmRange CDOmFuncDecl::getRange() const {
  ASSERT(m_funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE || m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE, "[CDOmFuncDecl::getRange()] illegal state for this method call.");
  //if(m_funcDeclType != FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE && m_funcDeclType != FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE) {
  //  throw NSBase::IllegalStateException("[CDOmFuncDecl::getRange()] illegal state for this method call.", m_lineNumber);
  //}

  return m_range;
}

void CDOmFuncDecl::setVarType(ECDOmVarType varType) {
  ASSERT(!(varType == VAR_UNDEFINED || varType == VAR_REG), "[CDOmFuncDecl::setType()] invalid arguments...");
  //if(varType == VAR_UNDEFINED || varType == VAR_REG) {
  //  throw NSBase::IllegalStateException("[CDOmFuncDecl::setType()] invalid arguments...", m_lineNumber);
  //}
  ASSERT(!(m_funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE || m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE), "[CDOmFuncDecl::setVarType()] illegal state for this method call.");
  //if(m_funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_RANGE || m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_RANGE) {
  //  throw NSBase::IllegalStateException("[CDOmFuncDecl::setVarType()] illegal state for this method call.", m_lineNumber);
  //}
  if(m_funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST) {
    m_funcDeclType = FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE;
  }
  else if(m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST) {
    m_funcDeclType = FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE;
  }

  m_varType = varType;
}

ECDOmVarType CDOmFuncDecl::getVarType() const {
  ASSERT(m_funcDeclType == FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE || m_funcDeclType == FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE, "[CDOmFuncDecl::getVarType()] illegal state for this method call.");
  //if(m_funcDeclType != FUNC_DECL_WITHOUT_FUNC_PORT_LIST_WITH_TYPE && m_funcDeclType != FUNC_DECL_WITH_FUNC_PORT_LIST_WITH_TYPE) {
  //  throw NSBase::IllegalStateException("[CDOmFuncDecl::getVarType()] illegal state for this method call.", m_lineNumber);
  //}

  return m_varType;
}

void CDOmFuncDecl::setFuncStmt(RefCDOmStmt stmt) {
  ASSERT(stmt.get() && stmt->getStmtType() != CDOmStmt::STMT_NULL && stmt->isFuncStmt(), "stmt is NULL, has illegal type or is not a function statement");
  ASSERT(!m_stmt.get(), "[CDOmFuncDecl::setFuncStmt()] function statement already set.");
  //if(m_stmt.get()) {
  //  throw NSBase::IllegalStateException("[CDOmFuncDecl::setFuncStmt()] function statement already set.", m_lineNumber);
  //}

  //stmt->setParent(m_weakRef.lock()); // self registration
  stmt->setParent(getThis()); // self registration
  m_stmt = stmt;
}

RefCDOmStmt CDOmFuncDecl::getFuncStmt() const {
  return m_stmt;  
}

void CDOmFuncDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmVarDecl class
// ********************************************************************************
CDOmVarDecl::CDOmVarDecl(TLineNumberType lineNumber, ECDOmVarType varType)
  : CDOmAttrHolder(lineNumber, TYPE_VAR_DECL), m_varType(varType), m_isSigned(false), m_range(), m_nameMap() {}
  
RefCDOmVarDecl CDOmVarDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmVarDecl();
  }
  ASSERT(object->getType() == TYPE_VAR_DECL, "type check on CDOmVarDecl::cast failure");
  return boost::static_pointer_cast<CDOmVarDecl>(object);
}

RefCDOmVarDecl CDOmVarDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmVarType varType) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->isScopeHolder() | parent->isGenerateItem(), "parent should be a scope");
  ASSERT(varType != VAR_UNDEFINED, "illegal varType");

  CDOmVarDecl* varDecl = new CDOmVarDecl(lineNumber, varType);
  RefCDOmVarDecl refVarDecl(varDecl);
  varDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refVarDecl);
  varDecl->setParent(parent); // self registration
  return refVarDecl;
}

ECDOmVarType CDOmVarDecl::getVarType() const {
  return m_varType;
}

void CDOmVarDecl::setSigned() {
  if(m_varType != VAR_REG) {
    args.push_back("var");
    args.push_back("var reg");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, m_lineNumber);
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmVarDecl::setSigned()] illegal state for this method call.", m_lineNumber);
  }
  else {
    m_isSigned = true;
  }
}

TBool CDOmVarDecl::isSigned() const {
  if(m_varType != VAR_REG) {
    args.push_back("var");
    args.push_back("var reg");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, m_lineNumber);
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmVarDecl::isSigned()] illegal state for this method call.", m_lineNumber);
  }
  else {
    return m_isSigned;
  }
}

void CDOmVarDecl::setRange(RefCDOmRange range) {
  //assert(!m_children.get() || (m_children->size() == 1 && m_children->at(0)->getType() == TYPE_ATTR_LIST_COLLECTION));
  ASSERT(!m_children.get() || (m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION), "the following logical expression is not true: m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION");
  ASSERT(range.get(), "range is NULL");
  if(m_varType != VAR_REG) {
    args.push_back("var");
    args.push_back("var reg");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, m_lineNumber);
    cdomHasErrors = TRUE;
    return;
    //throw NSBase::IllegalStateException("[CDOmVarDecl::setRange()] illegal state for this method call.", m_lineNumber);
  }
  if(m_range.get()) {
    args.push_back("var(s)");
    addErr(NSWarningErr::DEE_CSC_DSGN_DEE_CSC_DSGN_ALREADY_SET_WIDTH, args, m_lineNumber);
    cdomHasErrors = TRUE;
    return; 
    //throw NSBase::IllegalStateException("[CDOmVarDecl::setRange()] range already set.", m_lineNumber);
  }

  //range->setParent(m_weakRef.lock()); // self registration
  range->setParent(getThis()); // self registration
  m_range = range;
}

RefCDOmRange CDOmVarDecl::getRange() const {
  ASSERT(m_varType == VAR_REG, "[CDOmVarDecl::getRange()] illegal state for this method call.");
  //if(m_varType != VAR_REG) {
  //  throw NSBase::IllegalStateException("[CDOmVarDecl::getRange()] illegal state for this method call.", m_lineNumber);
  //}

  return m_range;
}

void CDOmVarDecl::addVar(TLineNumberType lineNumber, const RefString& name, RefCDOmRangeList rangeList) {
  if(checkIdName(name, lineNumber)) {

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_VAR, name, rangeList);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_VAR, name, rangeList);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

void CDOmVarDecl::addVar(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr) {
  if(checkIdName(name, lineNumber)) {
    ASSERT(expr.get(), "expr is NULL");
    ASSERT(expr->isConst(), "expr sould be const");

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_VAR, name, expr);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_VAR, name, expr);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

TBool CDOmVarDecl::containsVar(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMap.get()) {
      return FALSE;
    }
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

RefCDOmRangeList CDOmVarDecl::getVarRangeList(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(m_nameMap.get(), std::string("[CDOmVarDecl::getVarRangeList()] variable: " + *name + " not found.").c_str());
    //if(!m_nameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmVarDecl::getVarRangeList()] variable: " + *name + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    ASSERT(iter != m_nameMap->end(), std::string("[CDOmVarDecl::getVarRangeList()] variable: " + *name + " not found.").c_str());
    //if(iter == m_nameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmVarDecl::getVarRangeList()] variable: " + *name + " not found.").c_str(), m_lineNumber);
    //}
    RefCDOmBase value = iter->second->getPayload();
    ASSERT(!(value.get() && value->getType() != TYPE_RANGE_LIST), "[CDOmVarDecl::getVarRangeList()] illegal state for this method call.");
    //if(value.get() && value->getType() != TYPE_RANGE_LIST) {
    //  throw NSBase::IllegalStateException("[CDOmVarDecl::getVarRangeList()] illegal state for this method call.", m_lineNumber);
    //}
    return boost::static_pointer_cast<CDOmRangeList>(value);
    /*RefCDOmBase cdomrangelistAsBase = value;
      RefCDOmRangeList cdomrangelist = CDOmRangeList::cast(cdomrangelistAsBase);
      return cdomrangelist;*/
  }
  return RefCDOmRangeList();
}

RefCDOmExpr CDOmVarDecl::getVarVal(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(m_nameMap.get(), std::string("[CDOmVarDecl::getVarVal()] variable: " + *name + " not found.").c_str());
    //if(!m_nameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmVarDecl::getVarVal()] variable: " + *name + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    ASSERT(iter != m_nameMap->end(), std::string("[CDOmVarDecl::getVarVal()] variable: " + *name + " not found.").c_str());
    //if(iter == m_nameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmVarDecl::getVarVal()] variable: " + *name + " not found.").c_str(), m_lineNumber);
    //}
    RefCDOmBase value = iter->second->getPayload();
    ASSERT(!(!value.get() || value->getType() != TYPE_EXPR), "[CDOmVarDecl::getVarVal()] illegal state for this method call.");
    //if(!value.get() || value->getType() != TYPE_EXPR) {
    //  throw NSBase::IllegalStateException("[CDOmVarDecl::getVarVal()] illegal state for this method call.", m_lineNumber);
    //}
    //return boost::static_pointer_cast<CDOmExpr>(value);
    RefCDOmBase cdomexprAsBase = value;
    RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
    return cdomexpr;
  }
  return RefCDOmExpr();
}

const RefTVec_RefCDOmIdentifier CDOmVarDecl::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmVarDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmVarDecl>(m_weakRef.lock()));
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmMinTypMax class
// ********************************************************************************
CDOmMinTypMax::CDOmMinTypMax(TLineNumberType lineNumber, EMinTypMaxType minTypMaxType, TBool isConst, TBool canBeModPath)
  : CDOmExpr(lineNumber, EXPR_MINTYPMAX), m_minTypMaxType(minTypMaxType), m_isConst(isConst), m_canBeModulePath(canBeModPath) {}

RefCDOmMinTypMax CDOmMinTypMax::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmMinTypMax();
  }
  ASSERT(object->getType() == TYPE_EXPR, "type check on CDOmMinTypMax::cast failure");
  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  RefCDOmBase cdomexprAsBase = object;
  RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
  RefCDOmExpr obj = cdomexpr;
  ASSERT(obj->getExprType() == CDOmExpr::EXPR_MINTYPMAX, "type check on CDOmMinTypMax::cast failure");
  return boost::static_pointer_cast<CDOmMinTypMax>(object);
}

RefCDOmMinTypMax CDOmMinTypMax::build(TLineNumberType lineNumber, RefCDOmExpr expr) {
  ASSERT(expr.get(), "expr is NULL");

  CDOmMinTypMax* minTypMax = new CDOmMinTypMax(lineNumber, MINTYPMAX_SINGLE, expr->isConst(), expr->canBeModulePath());
  RefCDOmMinTypMax refMinTypMax(minTypMax);
  minTypMax->m_weakRef = boost::weak_ptr<CDOmBase>( refMinTypMax);
  expr->setParent(refMinTypMax); // self registration
  return refMinTypMax;
}

RefCDOmMinTypMax CDOmMinTypMax::build(TLineNumberType lineNumber, RefCDOmExpr expr1, RefCDOmExpr expr2, RefCDOmExpr expr3) {
  ASSERT(expr1.get(), "expr1 is NULL");
  ASSERT(expr2.get(), "expr2 is NULL");
  ASSERT(expr3.get(), "expr3 is NULL");
  
  CDOmMinTypMax* minTypMax = new CDOmMinTypMax(lineNumber, MINTYPMAX_TRIAD, expr1->isConst() && expr2->isConst() && expr3->isConst(),
                                               expr1->canBeModulePath() && expr2->canBeModulePath() && expr3->canBeModulePath());
  RefCDOmMinTypMax refMinTypMax(minTypMax);
  minTypMax->m_weakRef = boost::weak_ptr<CDOmBase>( refMinTypMax);
  expr1->setParent(refMinTypMax); // self registration
  expr2->setParent(refMinTypMax); // self registration
  expr3->setParent(refMinTypMax); // self registration
  return refMinTypMax;
}

CDOmMinTypMax::EMinTypMaxType CDOmMinTypMax::getMinTypMaxType() const {
  return m_minTypMaxType;
}

TBool CDOmMinTypMax::isConst() const {
  return m_isConst;
}

TBool CDOmMinTypMax::canBeModulePath() const {
  return m_canBeModulePath;
}

//RefCDOmEvalRes CDOmMinTypMax::doEval() const {
//  // !!! to be completed
//  return RefCDOmEvalRes();
//}

RefCDOmBase CDOmMinTypMax::doEval() const {
  // !!! to be completed
  return RefCDOmBase();
}

void CDOmMinTypMax::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmMinTypMax>(m_weakRef.lock()));
  RefCDOmBase cdommintypmaxAsBase = getThis();
  RefCDOmMinTypMax cdommintypmax = CDOmMinTypMax::cast(cdommintypmaxAsBase);
  visitor.visit(cdommintypmax);
}

// ********************************************************************************
// CDOmDelay class
// ********************************************************************************
CDOmDelay::CDOmDelay(TLineNumberType lineNumber, EDelayType delayType) : CDOmBase(TYPE_DELAY, lineNumber), m_delayType(delayType), m_delayDeclType(UNDEFINED) {}

RefCDOmDelay CDOmDelay::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmDelay();
  }
  ASSERT(object->getType() == TYPE_DELAY, "type check on CDOmDelay::cast failure");
  return boost::static_pointer_cast<CDOmDelay>(object);
}

RefCDOmDelay CDOmDelay::build(TLineNumberType lineNumber, RefCDOmBase parent, EDelayType delayType) {
  ASSERT(parent.get(), "parent is NULL");

  CDOmDelay* delay = new CDOmDelay(lineNumber, delayType);
  RefCDOmDelay refDelay(delay);
  delay->m_weakRef = boost::weak_ptr<CDOmBase>( refDelay);
  delay->setParent(parent); // self registration
  return refDelay;
}

CDOmDelay::EDelayType CDOmDelay::getDelayType() const {
  return m_delayType;
}

CDOmDelay::EDelayDeclType CDOmDelay::getDelayDeclType() const{
  return m_delayDeclType;
}

void CDOmDelay::setNumDelayValue(RefCDOmNumber num) {
  if(m_delayDeclType == UNDEFINED) {
    m_delayDeclType = DECL_1;
  }
  ASSERT(m_delayDeclType == DECL_1, "[CDOmDelay::setNumDelayValue()] illegal state for this method call.");
  //else if(m_delayDeclType != DECL_1) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::setNumDelayValue()] illegal state for this method call.", m_lineNumber);
  //}
  ASSERT(num.get(), "num is NULL");
  ASSERT(!num->isSigned(), "num should be unsigned");
  ASSERT(num->getNumBaseType() == CDOmNumber::NUM_BASE_DEC, "num has illegal base type");

  //num->setParent(m_weakRef.lock()); // self registration
  num->setParent(getThis()); // self registration
}

RefCDOmNumber CDOmDelay::getNumDelayValue() const {
  ASSERT(m_delayDeclType == DECL_1, "[CDOmDelay::getNumDelayValue()] illegal state for this method call.");
  //if(m_delayDeclType != DECL_1) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::getNumDelayValue()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmNumber>(m_children->at(0));
  RefCDOmBase numberAsBase = getChild(0);
  RefCDOmNumber number = CDOmNumber::cast(numberAsBase);
  return number;
}

void CDOmDelay::setRealNumDelayValue(RefCDOmReal realNum) {
  if(m_delayDeclType == UNDEFINED) {
    m_delayDeclType = DECL_2;
  }
  ASSERT(m_delayDeclType == DECL_2, "[CDOmDelay::setRealNumDelayValue()] illegal state for this method call.");
  //else if(m_delayDeclType != DECL_2) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::setRealNumDelayValue()] illegal state for this method call.", m_lineNumber);
  //}
  ASSERT(realNum.get(), "realNum is NULL");

  //realNum->setParent(m_weakRef.lock()); // self registration
  realNum->setParent(getThis()); // self registration
}

RefCDOmReal CDOmDelay::getRealNumDelayValue() const {
  ASSERT(m_delayDeclType == DECL_2, "[CDOmDelay::getRealNumDelayValue()] illegal state for this method call.");
  //if(m_delayDeclType != DECL_2) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::getRealNumDelayValue()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmReal>(m_children->at(0));
  RefCDOmBase realAsBase = getChild(0);
  RefCDOmReal real = CDOmReal::cast(realAsBase);
  return real;
}

void CDOmDelay::setExprLink(RefCDOmExprLink exprLink) {
  if(m_delayDeclType == UNDEFINED) {
    m_delayDeclType = DECL_3;
  }
  ASSERT(m_delayDeclType == DECL_3, "[CDOmDelay::setExprLink()] illegal state for this method call.");
  //else if(m_delayDeclType != DECL_3) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::setExprLink()] illegal state for this method call.", m_lineNumber);
  //}
  ASSERT(exprLink.get(), "exprLink is NULL");
  ASSERT(!exprLink->isHID(), "exprLink should not be HID");

  //exprLink->setParent(m_weakRef.lock()); // self registration
  exprLink->setParent(getThis()); // self registration
}

RefCDOmExprLink CDOmDelay::getExprLink() const {
  ASSERT(m_delayDeclType == DECL_3, "[CDOmDelay::getExprLink()] illegal state for this method call.");
  //if(m_delayDeclType != DECL_3) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::getExprLink()] illegal state for this method call.", m_lineNumber);
  //}

  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprlinkAsBase = getChild(0);
  RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
  return exprlink;
}

void CDOmDelay::addMinTypMax(RefCDOmMinTypMax minTypMax) {
  if(m_delayDeclType == UNDEFINED) {
    m_delayDeclType = DECL_4;
  }
  ASSERT(m_delayDeclType == DECL_4, "[CDOmDelay::addMinTypMax()] illegal state for this method call.");
  //else if(m_delayDeclType != DECL_4) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::addMinTypMax()] illegal state for this method call.", m_lineNumber);
  //}
  if(m_children.get()) {
    TUInt nrMinTypMax = m_children->size();
    switch(m_delayType) {
      case DELAY_2:
        ASSERT(nrMinTypMax < 2, "[CDOmDelay::addMinTypMax()] the maximum number of minTypMax has already been reached.");
        //if(nrMinTypMax >= 2) {
        //  throw NSBase::IllegalStateException("[CDOmDelay::addMinTypMax()] the maximum number of minTypMax has already been reached.", m_lineNumber);
        //}
        break;
      case DELAY_3:
        ASSERT(nrMinTypMax < 3, "[CDOmDelay::addMinTypMax()] the maximum number of minTypMax has already been reached.");
        //if(nrMinTypMax >= 3) {
        //  throw NSBase::IllegalStateException("[CDOmDelay::addMinTypMax()] the maximum number of minTypMax has already been reached.", m_lineNumber);
        //}
        break;
      default:
        ASSERT(FAIL, "[CDOmDelay::addMinTypMax()] bug detected...");
        //throw NSBase::IllegalStateException("[CDOmDelay::addMinTypMax()] bug detected...", m_lineNumber);
    }
  }

  //minTypMax->setParent(m_weakRef.lock()); // self registration
  minTypMax->setParent(getThis()); // self registration
}

RefCDOmMinTypMax CDOmDelay::getMinTypMax(TUInt index) const {
  ASSERT(m_delayDeclType == DECL_4, "[CDOmDelay::getMinTypMax()] illegal state for this method call.");
  //if(m_delayDeclType != DECL_4) {
  //  throw NSBase::IllegalStateException("[CDOmDelay::getMinTypMax()] illegal state for this method call.", m_lineNumber);
  //}
  switch(m_delayType) {
    case DELAY_2:
      ASSERT(index < 2, "[CDOmDelay::getMinTypMax()] invalid arguments.");
      //if(index >= 2) {
      //  throw NSBase::IllegalArgumentException("[CDOmDelay::getMinTypMax()] invalid arguments.", m_lineNumber);
      //}
      break;
    case DELAY_3:
      ASSERT(index < 3, "[CDOmDelay::getMinTypMax()] invalid arguments.");
      //if(index >= 3) {
      //  throw NSBase::IllegalArgumentException("[CDOmDelay::getMinTypMax()] invalid arguments.", m_lineNumber);
      //}
      break;
    default:
      ASSERT(FAIL, "[CDOmDelay::getMinTypMax()] bug detected...");
      //throw NSBase::IllegalStateException("[CDOmDelay::getMinTypMax()] bug detected...", m_lineNumber);
  }

  TUInt nrMinTypMax = m_children->size();
  if(index >= nrMinTypMax) {
    return RefCDOmMinTypMax();
  }
  //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(index));
  RefCDOmBase mintypmaxAsBase = getChild(index);
  RefCDOmMinTypMax mintypmax = CDOmMinTypMax::cast(mintypmaxAsBase);
  return mintypmax;
}

void CDOmDelay::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmDelay>(m_weakRef.lock()));
  RefCDOmBase cdomdelayAsBase = getThis();
  RefCDOmDelay cdomdelay = CDOmDelay::cast(cdomdelayAsBase);
  visitor.visit(cdomdelay);
}

// ********************************************************************************
// CDOmNetDecl class
// ********************************************************************************
CDOmNetDecl::CDOmNetDecl(TLineNumberType lineNumber, ECDOmNetType netType)
  : CDOmAttrHolder(lineNumber, TYPE_NET_DECL), m_netDeclType(NET_DECL_UNDEFINED), m_netType(netType), m_isSigned(false), m_delay3(),
    m_firstDriveStrength(DRIVE_STRENGTH_UNDEFINED), m_secondDriveStrength(DRIVE_STRENGTH_UNDEFINED),
    m_chargeStrength(CHARGE_STRENGTH_UNDEFINED), m_range(), m_vectorAccessType(VECTOR_ACCESS_UNDEFINED),
    m_nameMap() {}

RefCDOmNetDecl CDOmNetDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmNetDecl();
  }
  ASSERT(object->getType() == TYPE_NET_DECL, "type check on CDOmNetDecl::cast failure"); 
  return boost::static_pointer_cast<CDOmNetDecl>(object);
}

RefCDOmNetDecl CDOmNetDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmNetType netType) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->isScopeHolder(), "parent should be a scope"); 

  CDOmNetDecl* netDecl = new CDOmNetDecl(lineNumber, netType);
  RefCDOmNetDecl refNetDecl(netDecl);
  netDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refNetDecl);
  netDecl->setParent(parent); // self registration
  return refNetDecl;
}

ECDOmNetType CDOmNetDecl::getNetType() const {
  return m_netType;
}

void CDOmNetDecl::setSigned() {
  m_isSigned = true;
}

TBool CDOmNetDecl::isSigned() const {
  return m_isSigned;
}

TBool CDOmNetDecl::hasDelay3() const {
  return m_delay3.get() ? true : false;
}

RefCDOmDelay CDOmNetDecl::getDelay3() {
  ASSERT(m_delay3.get(), "[CDOmNetDecl::getDelay3()] parameter not set.");
  //if(m_delay3.get())
  return m_delay3;
  //throw NSBase::IllegalStateException("[CDOmNetDecl::getDelay3()] parameter not set.", m_lineNumber);
}

const RefCDOmDelay CDOmNetDecl::getDelay3() const {
  ASSERT(m_delay3.get(), "[CDOmNetDecl::getDelay3() const] parameter not set.");
  //if(m_delay3.get())
  return m_delay3;
  //throw NSBase::IllegalStateException("[CDOmNetDecl::getDelay3() const] parameter not set.", m_lineNumber);
}

void CDOmNetDecl::buildDelay3(TLineNumberType lineNumber) {
  ASSERT(!m_delay3.get(), "[CDOmNetDecl::buildDelay3()] parameter already set.");
  //if(m_delay3.get())
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::buildDelay3()] parameter already set.", m_lineNumber);
  //else
  //  m_delay3 = CDOmDelay::build(lineNumber, m_weakRef.lock(),CDOmDelay::DELAY_3);
  m_delay3 = CDOmDelay::build(lineNumber, getThis(),CDOmDelay::DELAY_3);
}

void CDOmNetDecl::setDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength) {
  if(m_netDeclType == NET_DECL_UNDEFINED) {
    m_netDeclType = NET_DECL_ID_EXPR_PAIR;
  }
  ASSERT(m_netDeclType == NET_DECL_ID_EXPR_PAIR, "[CDOmNetDecl::setDriveStrength()] illegal state for this method call.");
  //else if(m_netDeclType != NET_DECL_ID_EXPR_PAIR) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::setDriveStrength()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkDriveStrength(firstDriveStrength, secondDriveStrength, m_lineNumber)) {
    m_firstDriveStrength = firstDriveStrength;
    m_secondDriveStrength = secondDriveStrength;
  }
}

ECDOmDriveStrength CDOmNetDecl::getFirstDriveStrength() const {
  ASSERT(m_netDeclType == NET_DECL_ID_EXPR_PAIR, "[CDOmNetDecl::getFirstDriveStrength()] illegal state for this method call.");
  //if(m_netDeclType != NET_DECL_ID_EXPR_PAIR) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::getFirstDriveStrength()] illegal state for this method call.", m_lineNumber);
  //}

  return m_firstDriveStrength;
}

ECDOmDriveStrength CDOmNetDecl::getSecondDriveStrength() const {
  ASSERT(m_netDeclType == NET_DECL_ID_EXPR_PAIR, "[CDOmNetDecl::getSecondDriveStrength()] illegal state for this method call.");
  //if(m_netDeclType != NET_DECL_ID_EXPR_PAIR) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::getSecondDriveStrength()] illegal state for this method call.", m_lineNumber);
  //}

  return m_secondDriveStrength;
}

void CDOmNetDecl::setChargeStrength(EChargeStrength chargeStrength) {
  ASSERT(m_netType == NET_TRIREG, "net must be a trireg to support charge strength");
  if(m_netDeclType == NET_DECL_UNDEFINED) {
    m_netDeclType = NET_DECL_ID_ONLY;
  }
  ASSERT(m_netDeclType == NET_DECL_ID_ONLY, "[CDOmNetDecl::setChargeStrength()] illegal state for this method call.");
  //else if(m_netDeclType != NET_DECL_ID_ONLY) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::setChargeStrength()] illegal state for this method call.", m_lineNumber);
  //}

  m_chargeStrength = chargeStrength;
}

CDOmNetDecl::EChargeStrength CDOmNetDecl::getChargeStrength() const {
  ASSERT(!(m_netDeclType != NET_DECL_ID_ONLY || m_netType != NET_TRIREG), "[CDOmNetDecl::getChargeStrength()] illegal state for this method call.");
  //if(m_netDeclType != NET_DECL_ID_ONLY || m_netType != NET_TRIREG) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::getChargeStrength()] illegal state for this method call.", m_lineNumber);
  //}

  return m_chargeStrength;
}

void CDOmNetDecl::setRange(RefCDOmRange range, EVectorAccessType vectorAccessType) {
  //assert(!m_children.get() || (m_children->size() == 1 && m_children->at(0)->getType() == TYPE_ATTR_LIST_COLLECTION));
  ASSERT(!m_children.get() || (m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION), "the following logical expression is not true: m_children->size() == 1 && getChild(0)->getType() == TYPE_ATTR_LIST_COLLECTION");
  ASSERT(range.get(), "range is NULL");
  if(m_range.get()) {
    args.push_back("port");
    args.push_back("range supporting net");
    addErr(NSWarningErr::DEE_CSC_STMT_DEE_CSC_STMT_TYPE_EXPECTED, args, m_lineNumber);
    cdomHasErrors = TRUE;       
    return;
    //throw NSBase::IllegalStateException("[CDOmNetDecl::setRange()] range already set.", m_lineNumber);
  }

  //range->setParent(m_weakRef.lock()); // self registration
  range->setParent(getThis()); // self registration
  m_range = range;
  m_vectorAccessType = vectorAccessType;
}

RefCDOmRange CDOmNetDecl::getRange() const {
  return m_range;
}

CDOmNetDecl::EVectorAccessType CDOmNetDecl::getVectorAccessType() const {
  return m_vectorAccessType;
}

void CDOmNetDecl::addNet(TLineNumberType lineNumber, const RefString& name, RefCDOmRangeList rangeList) {
  if(m_netDeclType == NET_DECL_UNDEFINED) {
    m_netDeclType = NET_DECL_ID_ONLY;
  }
  ASSERT(m_netDeclType == NET_DECL_ID_ONLY, "[CDOmNetDecl::addNet()] illegal state for this method call.");
  //else if(m_netDeclType != NET_DECL_ID_ONLY) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::addNet()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, lineNumber)) {

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_NET, name, rangeList);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_NET, name, rangeList);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

void CDOmNetDecl::addNet(TLineNumberType lineNumber, const RefString& name, RefCDOmExpr expr) {
  if(m_netDeclType == NET_DECL_UNDEFINED) {
    m_netDeclType = NET_DECL_ID_EXPR_PAIR;
  }
  ASSERT(m_netDeclType == NET_DECL_ID_EXPR_PAIR, "[CDOmNetDecl::addNet()] illegal state for this method call.");
  //else if(m_netDeclType != NET_DECL_ID_EXPR_PAIR) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::addNet()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, lineNumber)) {
    ASSERT(expr.get(), "expr is NULL");

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_NET, name, expr);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_NET, name, expr);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

TBool CDOmNetDecl::containsNet(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMap.get()) {
      return FALSE;
    }
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

RefCDOmRangeList CDOmNetDecl::getNetRangeList(const RefString& name) const {
  ASSERT(m_netDeclType == NET_DECL_ID_ONLY, "[CDOmNetDecl::getNetRangeList()] illegal state for this method call.");
  //if(m_netDeclType != NET_DECL_ID_ONLY) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::getNetRangeList()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(m_nameMap.get(), std::string("[CDOmNetDecl::getNetRangeList()] net: " + *name + " not found.").c_str());
    //if(!m_nameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmNetDecl::getNetRangeList()] net: " + *name + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    ASSERT(iter != m_nameMap->end(), std::string("[CDOmNetDecl::getNetRangeList()] net: " + *name + " not found.").c_str());
    //if(iter == m_nameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmNetDecl::getNetRangeList()] net: " + *name + " not found.").c_str(), m_lineNumber);
    //}
    return boost::static_pointer_cast<CDOmRangeList>(iter->second->getPayload());
    /*RefCDOmBase cdomrangelistAsBase = iter->second->getPayload();
      RefCDOmRangeList cdomrangelist = CDOmRangeList::cast(cdomrangelistAsBase);
      return cdomrangelist;*/
  }
  RefCDOmRangeList();
}

RefCDOmExpr CDOmNetDecl::getNetVal(const RefString& name) const {
  ASSERT(m_netDeclType == NET_DECL_ID_EXPR_PAIR, "[CDOmNetDecl::getNetVal()] illegal state for this method call.");
  //if(m_netDeclType != NET_DECL_ID_EXPR_PAIR) {
  //  throw NSBase::IllegalStateException("[CDOmNetDecl::getNetVal()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(m_nameMap.get(), std::string("[CDOmNetDecl::getNetVal()] net: " + *name + " not found.").c_str());
    //if(!m_nameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmNetDecl::getNetVal()] net: " + *name + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    ASSERT(iter != m_nameMap->end(), std::string("[CDOmNetDecl::getNetVal()] net: " + *name + " not found.").c_str());
    //if(iter == m_nameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmNetDecl::getNetVal()] net: " + *name + " not found.").c_str(), m_lineNumber);
    //}
    //return boost::static_pointer_cast<CDOmExpr>(iter->second->getPayload());
    RefCDOmBase cdomexprAsBase = iter->second->getPayload();
    RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
    return cdomexpr;
  }
  return RefCDOmExpr();
}

const RefTVec_RefCDOmIdentifier CDOmNetDecl::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmNetDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //visitor.visit(boost::static_pointer_cast<CDOmNetDecl>(m_weakRef.lock()));   
  //RefCDOmBase cdomnetdeclAsBase = getThis();
  //RefCDOmNetDecl cdomnetdecl = CDOmNetDecl::cast(cdomnetdeclAsBase);
  visitor.visit(getThis());   
}

// ********************************************************************************
// CDOmEventDecl class
// ********************************************************************************
CDOmEventDecl::CDOmEventDecl(TLineNumberType lineNumber) : CDOmAttrHolder(lineNumber, TYPE_EVENT_DECL), m_nameMap() {}

RefCDOmEventDecl CDOmEventDecl::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmEventDecl();
  }
  ASSERT(object->getType() == TYPE_EVENT_DECL, "type check on CDOmEventDecl::cast failure");
  return boost::static_pointer_cast<CDOmEventDecl>(object);
}

RefCDOmEventDecl CDOmEventDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, const RefString& name, RefCDOmRangeList rangeList) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE || parent->getType() == TYPE_GEN_INST ||
         parent->getType() == TYPE_DECL_FUNCTION || parent->getType() == TYPE_DECL_TASK ||
         parent->getType() == TYPE_STMT_NAMED_BLOCK, "parent should be one of: module decl, generated instantiation, function decl, task decl or stmt named block");

  CDOmEventDecl* eventDecl = new CDOmEventDecl(lineNumber);
  RefCDOmEventDecl refEventDecl(eventDecl);
  eventDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refEventDecl);
  eventDecl->setParent(parent); // self registration
  eventDecl->addEvent(lineNumber, name, rangeList);
  return refEventDecl;
}

void CDOmEventDecl::addEvent(TLineNumberType lineNumber, const RefString& name, RefCDOmRangeList rangeList) {
  if(checkIdName(name, lineNumber)) {

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_EVENT, name, rangeList);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_EVENT, name, rangeList);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

TBool CDOmEventDecl::containsEvent(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMap.get()) {
      return FALSE;
    }
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

RefCDOmRangeList CDOmEventDecl::getEventRangeList(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {
    ASSERT(m_nameMap.get(), std::string("[CDOmEventDecl::getEventRangeList()] range: " + *name + " not found.").c_str());
    //if(!m_nameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmEventDecl::getEventRangeList()] range: " + *name + " not found.").c_str(), 
    //      m_lineNumber);
    //}

    TMap_RefString_RefCDOmIdentifier_constIter iter = m_nameMap->find(name);
    ASSERT(iter != m_nameMap->end(), std::string("[CDOmEventDecl::getEventRangeList()] range: " + *name + " not found.").c_str());
    //if(iter == m_nameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmEventDecl::getEventRangeList()] range: " + *name + " not found.").c_str(), 
    //      m_lineNumber);
    //}
    return boost::static_pointer_cast<CDOmRangeList>(iter->second->getPayload());
    /*RefCDOmBase cdomrangelistAsBase = iter->second->getPayload();
      RefCDOmRangeList cdomrangelist = CDOmRangeList::cast(cdomrangelistAsBase);
      return cdomrangelist;*/
  }
  return RefCDOmRangeList();
}

const RefTVec_RefCDOmIdentifier CDOmEventDecl::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmEventDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGenvarDecl class
// ********************************************************************************
CDOmGenvarDecl::CDOmGenvarDecl(TLineNumberType lineNumber) : CDOmAttrHolder(lineNumber, TYPE_GENVAR_DECL) {}

RefCDOmGenvarDecl CDOmGenvarDecl::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmGenvarDecl();
  }
  ASSERT(object->getType() == TYPE_GENVAR_DECL, "type check on CDOmGenvarDecl::cast failure");
  return boost::static_pointer_cast<CDOmGenvarDecl>(object);
}

RefCDOmGenvarDecl CDOmGenvarDecl::build(TLineNumberType lineNumber, RefCDOmBase parent, const RefString& name) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE || parent->getType() == TYPE_GEN_INST, "parent should be a module decl or a or a generated instantiation");

  CDOmGenvarDecl* genvarDecl = new CDOmGenvarDecl(lineNumber);
  RefCDOmGenvarDecl refGenvarDecl(genvarDecl);
  genvarDecl->m_weakRef = boost::weak_ptr<CDOmBase>( refGenvarDecl);
  genvarDecl->setParent(parent); // self registration
  genvarDecl->addGenvar(lineNumber, name);
  return refGenvarDecl;
}

void CDOmGenvarDecl::addGenvar(TLineNumberType lineNumber, const RefString& name) {
  if(checkIdName(name, lineNumber)) {

    if(!m_nameMap.get()) {
      m_nameMap = RefTMap_RefString_RefCDOmIdentifier(new TMap_RefString_RefCDOmIdentifier());
    }
    //RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, m_weakRef.lock(), CDOmIdentifier::ID_GENVAR, name);
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, getThis(), CDOmIdentifier::ID_GENVAR, name);
    m_nameMap->insert(TPair_RefString_RefCDOmIdentifier(name, id));
  }
}

TBool CDOmGenvarDecl::containsGenvar(const RefString& name) const {
  if(checkIdName(name, m_lineNumber)) {

    if(!m_nameMap.get()) {
      return FALSE;
    }
    return m_nameMap->find(name) != m_nameMap->end();
  }
  return FALSE;
}

const RefTVec_RefCDOmIdentifier CDOmGenvarDecl::getIDs() const {
  return getChildren<CDOmIdentifier>(TYPE_ID_SIMPLE);
}

void CDOmGenvarDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmParamOverride class
// ********************************************************************************
CDOmParamOverride::CDOmParamOverride(TLineNumberType lineNumber) : CDOmAttrHolder(lineNumber, TYPE_PARAM_OVERRIDE) {}

RefCDOmParamOverride CDOmParamOverride::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmParamOverride();
  }
  ASSERT(object->getType() == TYPE_PARAM_OVERRIDE, "type check on CDOmParamOverride::cast failure");
  return boost::static_pointer_cast<CDOmParamOverride>(object);
}

RefCDOmParamOverride CDOmParamOverride::build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExprLink hid, RefCDOmMinTypMax minTypMax) {
  ASSERT(parent.get(), "parent is NULL");

  CDOmParamOverride* paramOverride = new CDOmParamOverride(lineNumber);
  RefCDOmParamOverride refParamOverride(paramOverride);
  paramOverride->m_weakRef = boost::weak_ptr<CDOmBase>( refParamOverride);
  paramOverride->setParent(parent); // self registration
  paramOverride->addParamAssn(hid, minTypMax);
  return refParamOverride;
}

void CDOmParamOverride::addParamAssn(RefCDOmExprLink hid, RefCDOmMinTypMax minTypMax) {
  ASSERT(hid.get(), "hid is NULL");
  ASSERT(minTypMax.get(), "minTypMax is NULL");

  //hid->setParent(m_weakRef.lock()); // self registration
  hid->setParent(getThis()); // self registration
  //minTypMax->setParent(m_weakRef.lock()); // self registration
  minTypMax->setParent(getThis()); // self registration
}

void CDOmParamOverride::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmContAssn class
// ********************************************************************************
CDOmContAssn::CDOmContAssn(TLineNumberType lineNumber, ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength)
  : CDOmAttrHolder(lineNumber, TYPE_CONT_ASSN), m_firstDriveStrength(firstDriveStrength), m_secondDriveStrength(secondDriveStrength), m_delay3() {}
  
RefCDOmContAssn CDOmContAssn::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmContAssn();
  }
  ASSERT(object->getType() == TYPE_CONT_ASSN, "type check on CDOmContAssn::cast failure");
  return boost::static_pointer_cast<CDOmContAssn>(object);
}

RefCDOmContAssn CDOmContAssn::build(TLineNumberType lineNumber, RefCDOmBase parent, ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength) {
  ASSERT(parent.get(), "parent is NULL");
  //if(firstDriveStrength != DRIVE_STRENGTH_UNDEFINED || secondDriveStrength != DRIVE_STRENGTH_UNDEFINED) {
  //  checkDriveStrength(firstDriveStrength, secondDriveStrength);
  //}
  //if(checkDriveStrength(firstDriveStrength, secondDriveStrength, lineNumber)) {
  CDOmContAssn* contAssn = new CDOmContAssn(lineNumber, firstDriveStrength, secondDriveStrength);
  RefCDOmContAssn refContAssn(contAssn);
  contAssn->m_weakRef = boost::weak_ptr<CDOmBase>( refContAssn);
  contAssn->setParent(parent); // self registration
  return refContAssn;
  //}
  //return RefCDOmContAssn();
}

ECDOmDriveStrength CDOmContAssn::getFirstDriveStrength() const {
  return m_firstDriveStrength;
}

ECDOmDriveStrength CDOmContAssn::getSecondDriveStrength() const {
  return m_secondDriveStrength;
}

TBool CDOmContAssn::hasDelay3() const {
  return m_delay3.get() ? true : false;
}

void CDOmContAssn::buildDelay3(TLineNumberType lineNumber) {
  ASSERT(!m_delay3.get(), "[CDOmContAssn::buildDelay3()] parameter already set.");
  m_delay3 = CDOmDelay::build(lineNumber, getThis(), CDOmDelay::DELAY_3);
  //if(!m_delay3.get()){
  // //m_delay3 = CDOmDelay::build(lineNumber, m_weakRef.lock(), CDOmDelay::DELAY_3);
  //  m_delay3 = CDOmDelay::build(lineNumber, getThis(), CDOmDelay::DELAY_3);
  //}
  //else
  //  throw NSBase::IllegalStateException("[CDOmContAssn::buildDelay3()] parameter already set.", m_lineNumber);
}

RefCDOmDelay CDOmContAssn::getDelay3() {
  ASSERT(m_delay3.get(), "[CDOmContAssn::buildDelay3()] parameter not set.");
  return m_delay3;
  //if(m_delay3.get())
  //  return m_delay3;
  //throw NSBase::IllegalStateException("[CDOmContAssn::buildDelay3()] parameter not set.", m_lineNumber);
}

const RefCDOmDelay CDOmContAssn::getDelay3() const{
  ASSERT(m_delay3.get(), "[CDOmContAssn::buildDelay3() const] parameter not set.");
  //if(m_delay3.get())
  return m_delay3;
  //throw NSBase::IllegalStateException("[CDOmContAssn::buildDelay3() const] parameter not set.", m_lineNumber);
}

void CDOmContAssn::addNetAssn(RefCDOmAssn assn) {
  ASSERT(assn.get(), "assn is NULL");

  //assn->setParent(m_weakRef.lock()); // self registration
  assn->setParent(getThis()); // self registration
}

const RefTVec_RefCDOmAssn CDOmContAssn::getNetAssns() const {
  return getChildren<CDOmAssn>(TYPE_ASSN);
}

void CDOmContAssn::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());  
}

// ********************************************************************************
// CDOmModuleOrUdpInstance class
// ********************************************************************************
CDOmModuleOrUdpInstance::CDOmModuleOrUdpInstance(TLineNumberType lineNumber)
  : CDOmBase(TYPE_INST_MODULE, lineNumber), m_moduleInstanceType(MODULE_INSTANCE_UNDEFINED), m_explicitPortNameMap(),
    m_emptyIndexes(), m_portConnectionCount() {}
  
RefCDOmModuleOrUdpInstance CDOmModuleOrUdpInstance::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmModuleOrUdpInstance();
  }
  ASSERT(object->getType() == TYPE_INST_MODULE, "type check on CDOmModuleOrUdpInstance::cast failure");
  return boost::static_pointer_cast<CDOmModuleOrUdpInstance>(object);
}

RefCDOmModuleOrUdpInstance CDOmModuleOrUdpInstance::build(TLineNumberType lineNumber, RefCDOmModuleOrUdpInstantiation parent, const RefString& instName, RefCDOmRange range) {
  ASSERT(parent.get(), "parent is NULL");
  if(instName.get() && checkIdName(instName, lineNumber)) {

    CDOmModuleOrUdpInstance* moduleInstance = new CDOmModuleOrUdpInstance(lineNumber);
    RefCDOmModuleOrUdpInstance refModuleInstance(moduleInstance);
    moduleInstance->m_weakRef = boost::weak_ptr<CDOmBase>( refModuleInstance);
    moduleInstance->setParent(parent); // self registration
    if(instName.get())
      RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, refModuleInstance, CDOmIdentifier::ID_MODULE_INST, instName, range);
    return refModuleInstance;
  }
  return RefCDOmModuleOrUdpInstance();
}

CDOmModuleOrUdpInstance::~CDOmModuleOrUdpInstance() {
  //if(m_emptyIndexes) {
  //  delete m_emptyIndexes;
  //}
}

CDOmModuleOrUdpInstance::EModuleInstanceType CDOmModuleOrUdpInstance::getModuleInstanceType() const {
  return m_moduleInstanceType;
}

RefCDOmRange CDOmModuleOrUdpInstance::getRange() const {
  //return boost::static_pointer_cast<CDOmRange>(static_cast<const CDOmIdentifier*>(m_children->at(0).get())->getPayload());
  RefCDOmBase cdomIdentifierAsBase = getChild(0);
  CDOmBase* cdomIdentifierPtr = cdomIdentifierAsBase.get();
  CDOmIdentifier* cdomIdentifierPtrId = static_cast<CDOmIdentifier*>(cdomIdentifierPtr);
  RefCDOmRange cdomRange = CDOmRange::cast(cdomIdentifierPtrId->getPayload());
  return cdomRange;
}

void CDOmModuleOrUdpInstance::addPortConnection(RefCDOmAttrListCollection attrListCollection, RefCDOmExpr expr, const RefString& explicitPortName) {
  ASSERT(m_moduleInstanceType == MODULE_INSTANCE_UNDEFINED ||
         (explicitPortName.get() ? m_moduleInstanceType == MODULE_INSTANCE_NAMED_PORT_CONNECTION : m_moduleInstanceType == MODULE_INSTANCE_ORDERED_PORT_CONNECTION), "m_moduleInstanceType check failure");

  if(m_moduleInstanceType == MODULE_INSTANCE_UNDEFINED) {
    m_moduleInstanceType = (explicitPortName.get() ? MODULE_INSTANCE_NAMED_PORT_CONNECTION : MODULE_INSTANCE_ORDERED_PORT_CONNECTION);
  }

  //RefCDOmModuleOrUdpInstantiation parent = boost::static_pointer_cast<CDOmModuleOrUdpInstantiation>(m_parent);
  RefCDOmModuleOrUdpInstantiation parent = CDOmModuleOrUdpInstantiation::cast(getParent());
  if( parent->m_moduleInstantiationType == CDOmModuleOrUdpInstantiation::UDP_INSTANTIATION )
    ASSERT(m_moduleInstanceType == MODULE_INSTANCE_ORDERED_PORT_CONNECTION && !attrListCollection.get(), "m_moduleInstanceType check failure");
  if( explicitPortName.get() && parent->m_moduleInstantiationType == CDOmModuleOrUdpInstantiation::MODULE_OR_UDP_INSTANTIATION )
    parent->m_moduleInstantiationType = CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_UNDEFINED;
    
  if(attrListCollection.get()) {
    //attrListCollection->setParent(m_weakRef.lock()); // self registration
    attrListCollection->setParent(getThis()); // self registration
    if( parent->m_moduleInstantiationType == CDOmModuleOrUdpInstantiation::MODULE_OR_UDP_INSTANTIATION )
      parent->m_moduleInstantiationType = CDOmModuleOrUdpInstantiation::MODULE_INSTANTIATION_UNDEFINED;
  }
  if(expr.get()) {
    //expr->setParent(m_weakRef.lock()); // self registration
    expr->setParent(getThis()); // self registration
  }
  if(m_moduleInstanceType == MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
    if(!m_explicitPortNameMap.get()) {
      m_explicitPortNameMap = RefTMap_RefString_RefCDOmExpr(new TMap_RefString_RefCDOmExpr());
    }
    else {
      // check for explicit port name duplicate
      if(m_explicitPortNameMap->find(explicitPortName) != m_explicitPortNameMap->end()) {
        args.push_back(*explicitPortName);
        if(CDOmIdentifier::cast(getChild(0))->getName().get()) {
          args.push_back(*CDOmIdentifier::cast(getChild(0))->getName());
        }
        else {
          args.push_back("module or upd instance");
        }
        addErr(NSWarningErr::VEE_CDC_INST_INST_DUPLICATE_ENTITY_NAME_CDCVE, args, m_lineNumber);
        cdomHasErrors = TRUE;
        return;
        //throw NSBase::IllegalArgumentException(std::string("[CDOmModuleOrUdpInstance::addPortConnection()] duplicate explicit port name found: " + *explicitPortName).c_str(), m_lineNumber);
      }
    }
    m_explicitPortNameMap->insert(TPair_RefString_RefCDOmExpr(explicitPortName, expr));
  }
  else {
    if(!attrListCollection.get() && !expr.get()) {
      if(!m_emptyIndexes) {
        m_emptyIndexes = RefTVec_TUInt(new std::vector<TUInt>());
      }
      m_emptyIndexes->push_back(m_portConnectionCount);
    }
    m_portConnectionCount++;
  }
}

TBool CDOmModuleOrUdpInstance::containsExplicitPortName(const RefString& name) const {
  ASSERT(m_moduleInstanceType == MODULE_INSTANCE_NAMED_PORT_CONNECTION, "[CDOmModuleOrUdpInstance::containsExplicitPortName()] illegal state for this method call.");
  //if(m_moduleInstanceType != MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
  //  throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstance::containsExplicitPortName()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, m_lineNumber)) {

    if(!m_explicitPortNameMap.get()) {
      return FALSE;
    }
    return m_explicitPortNameMap->find(name) != m_explicitPortNameMap->end();
  }
  return FALSE;
}

RefCDOmExpr CDOmModuleOrUdpInstance::getPortExpr(const RefString& explicitPortName) {
  ASSERT(m_moduleInstanceType == MODULE_INSTANCE_NAMED_PORT_CONNECTION, "[CDOmModuleOrUdpInstance::getPortExpr()] illegal state for this method call.");
  //if(m_moduleInstanceType != MODULE_INSTANCE_NAMED_PORT_CONNECTION) {
  //  throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstance::getPortExpr()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(explicitPortName, m_lineNumber)) {
    ASSERT(m_explicitPortNameMap.get(), std::string("[CDOmModuleOrUdpInstance::getPortExpr()] explicit port name: " + *explicitPortName + " not found.").c_str());
    //if(!m_explicitPortNameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmModuleOrUdpInstance::getPortExpr()] explicit port name: " + *explicitPortName + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmExpr_constIter iter = m_explicitPortNameMap->find(explicitPortName);
    ASSERT(iter != m_explicitPortNameMap->end(), std::string("[CDOmModuleOrUdpInstance::getPortExpr()] explicit port name: " + *explicitPortName + " not found.").c_str());
    //if(iter == m_explicitPortNameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmModuleOrUdpInstance::getPortExpr()] explicit port name: " + *explicitPortName + " not found.").c_str(), m_lineNumber);
    //}
    return iter->second;
  }
  return RefCDOmExpr();
}

RefTVec_TUInt CDOmModuleOrUdpInstance::getEmptyIndexes() const {
  RefTVec_TUInt vectEmptyIndexes = RefTVec_TUInt();
  if(m_emptyIndexes.get()) {
    vectEmptyIndexes = RefTVec_TUInt(new std::vector<TUInt>(*m_emptyIndexes.get()));
  }
  return vectEmptyIndexes;
}

void CDOmModuleOrUdpInstance::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}
 
// ********************************************************************************
// CDOmModuleOrUdpInstantiation class
// ********************************************************************************
CDOmModuleOrUdpInstantiation::CDOmModuleOrUdpInstantiation(TLineNumberType lineNumber)
  : CDOmAttrHolder(lineNumber, TYPE_MODULE_INSTANTIATION), m_moduleInstantiationType(MODULE_OR_UDP_INSTANTIATION), m_explicitParamNameMap(), 
    m_delay2(), m_firstDriveStrength(DRIVE_STRENGTH_UNDEFINED), m_secondDriveStrength(DRIVE_STRENGTH_UNDEFINED) {}
    
RefCDOmModuleOrUdpInstantiation CDOmModuleOrUdpInstantiation::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmModuleOrUdpInstantiation();
  }
  ASSERT(object->getType() == TYPE_MODULE_INSTANTIATION, "type check on CDOmModuleOrUdpInstantiation::cast failure");
  return boost::static_pointer_cast<CDOmModuleOrUdpInstantiation>(object);
}

RefCDOmModuleOrUdpInstantiation CDOmModuleOrUdpInstantiation::build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExprLink moduleExprLink) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE 
         || parent->getType() == TYPE_GEN_INST
         || parent->getType() == TYPE_GEN_ITEM_LOOP
         || parent->getType() == TYPE_GEN_ITEM_IF
         || parent->getType() == TYPE_GEN_ITEM_CASE
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_NAMED
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED
         , "parent should be a module or a generated instantiation");
  ASSERT(moduleExprLink.get() && !moduleExprLink->isHID(), "moduleExprLink is NULL or is HID");
  
  CDOmModuleOrUdpInstantiation* moduleInstantiation = new CDOmModuleOrUdpInstantiation(lineNumber);
  RefCDOmModuleOrUdpInstantiation refModuleInstantiation(moduleInstantiation);
  moduleInstantiation->m_weakRef = boost::weak_ptr<CDOmBase>( refModuleInstantiation);
  moduleInstantiation->setParent(parent); // self registration
  moduleExprLink->setParent(refModuleInstantiation); // self registration

  //WARNING: AB: This needs to be replaced with doEval() when it will work
  //Most likely parent will be a ModuleDecl here so we're getting the parent scope (design)
  RefCDOmScope design = parent->getParentScope();
  RefCDOmIdentifier moduleId = design->lookupLocal(moduleExprLink->getName());
  if(moduleId.get()){
    RefCDOmBase moduleBase = moduleId->getParent();
    (CDOmModuleDecl::cast(moduleBase))->isInstantiated();
  }
  return refModuleInstantiation;
}

const RefCDOmExprLink CDOmModuleOrUdpInstantiation::getModuleExprLink() const {
  return CDOmExprLink::cast(getChild(0));
}

CDOmModuleOrUdpInstantiation::EModuleInstantiationType CDOmModuleOrUdpInstantiation::getModuleInstantiationType() const {
  return m_moduleInstantiationType;
}

void CDOmModuleOrUdpInstantiation::addOrderedParamAssn(RefCDOmExpr expr) {
  ASSERT(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION || m_moduleInstantiationType == MODULE_INSTANTIATION_ORDERED_PARAM_ASSN, "m_moduleInstantiationType check failure"); 
  ASSERT(expr.get(), "expr is NULL");
  //May be delay2, depends on the context
  if(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION)
    m_moduleInstantiationType = MODULE_INSTANTIATION_ORDERED_PARAM_ASSN;

  //expr->setParent(m_weakRef.lock()); // self registration
  expr->setParent(getThis()); // self registration
}

void CDOmModuleOrUdpInstantiation::addNamedParamAssn(const RefString& explicitParamName, RefCDOmMinTypMax minTypMax) {
  ASSERT(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION || m_moduleInstantiationType == MODULE_INSTANTIATION_NAMED_PARAM_ASSN, "m_moduleInstantiationType check failure");
  if(checkIdName(explicitParamName, m_lineNumber)) {

    if(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION)
      m_moduleInstantiationType = MODULE_INSTANTIATION_NAMED_PARAM_ASSN;
    if(minTypMax.get()) {
      //minTypMax->setParent(m_weakRef.lock()); // self registration
      minTypMax->setParent(getThis()); // self registration
    }
    if(!m_explicitParamNameMap.get()) {
      m_explicitParamNameMap = RefTMap_RefString_RefCDOmMinTypMax(new TMap_RefString_RefCDOmMinTypMax());
    }
    else {
      // check for explicit param name duplicate
      if(m_explicitParamNameMap->find(explicitParamName) != m_explicitParamNameMap->end()) {
        args.push_back(*explicitParamName);
        addErr(NSWarningErr::VEE_CDC_PARM_DUPLICATE_DECL_PARM_NAME_CDV, args, m_lineNumber);
        //throw NSBase::IllegalArgumentException(std::string("[CDOmModuleOrUdpInstantiation::addNamedParamAssn()] duplicate explicit parameter name found: " + *explicitParamName).c_str(), m_lineNumber);
      }
    }
    m_explicitParamNameMap->insert(TPair_RefString_RefCDOmMinTypMax(explicitParamName, minTypMax));
    for(TMap_RefString_RefCDOmMinTypMax::const_iterator it = m_explicitParamNameMap->begin(); it != m_explicitParamNameMap->end(); ++it) {
      RefString paramName = it->first;
    }
  }
}

RefTMap_RefString_RefCDOmMinTypMax CDOmModuleOrUdpInstantiation::getExplicitParamNameMap() {
  ASSERT(m_explicitParamNameMap.get(), "CDOmModuleOrUdpInstantiation::getExplicitParamNameMap() Explicit param name map is empty.");
  return m_explicitParamNameMap;
}

RefCDOmModuleOrUdpInstance CDOmModuleOrUdpInstantiation::buildModuleInstance(TLineNumberType lineNumber, const RefString& instName, RefCDOmRange range) {
  if(!instName.get()) {
    ASSERT(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION || m_moduleInstantiationType == UDP_INSTANTIATION, "m_moduleInstantiationType check failure");
    if(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION)
      m_moduleInstantiationType = UDP_INSTANTIATION;
  }
  //return CDOmModuleOrUdpInstance::build(lineNumber, boost::static_pointer_cast<CDOmModuleOrUdpInstantiation>(m_weakRef.lock()), instName, range);
  RefCDOmBase cdommoduleorudpinstantiationAsBase = getThis();
  RefCDOmModuleOrUdpInstantiation cdommoduleorudpinstantiation = CDOmModuleOrUdpInstantiation::cast(cdommoduleorudpinstantiationAsBase);
  return CDOmModuleOrUdpInstance::build(lineNumber, cdommoduleorudpinstantiation, instName, range);
}

TBool CDOmModuleOrUdpInstantiation::containsExplicitParamName(const RefString& name) const {
  ASSERT(m_moduleInstantiationType == MODULE_INSTANTIATION_NAMED_PARAM_ASSN, "[CDOmModuleOrUdpInstantiation::containsExplicitParamName()] illegal state for this method call.");
  //if(m_moduleInstantiationType != MODULE_INSTANTIATION_NAMED_PARAM_ASSN) {
  //  throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstantiation::containsExplicitParamName()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(name, m_lineNumber)) {

    if(!m_explicitParamNameMap.get()) {
      return FALSE;
    }
    return m_explicitParamNameMap->find(name) != m_explicitParamNameMap->end();
  }
  return FALSE;
}

RefCDOmMinTypMax CDOmModuleOrUdpInstantiation::getParamExpr(const RefString& explicitParamName) {
  ASSERT(m_moduleInstantiationType == MODULE_INSTANTIATION_NAMED_PARAM_ASSN, "[CDOmModuleOrUdpInstantiation::getParamExpr()] illegal state for this method call.");
  //if(m_moduleInstantiationType != MODULE_INSTANTIATION_NAMED_PARAM_ASSN) {
  //  throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstantiation::getParamExpr()] illegal state for this method call.", m_lineNumber);
  //}
  if(checkIdName(explicitParamName, m_lineNumber)) {
    ASSERT(m_explicitParamNameMap.get(), std::string("[CDOmModuleOrUdpInstantiation::getParamExpr()] explicit parameter name: " + *explicitParamName + " not found.").c_str());
    //if(!m_explicitParamNameMap.get()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmModuleOrUdpInstantiation::getParamExpr()] explicit parameter name: " + *explicitParamName + " not found.").c_str(), m_lineNumber);
    //}

    TMap_RefString_RefCDOmMinTypMax_constIter iter = m_explicitParamNameMap->find(explicitParamName);
    ASSERT(iter != m_explicitParamNameMap->end(), std::string("[CDOmModuleOrUdpInstantiation::getParamExpr()] explicit parameter name: " + *explicitParamName + " not found.").c_str());
    //if(iter == m_explicitParamNameMap->end()) {
    //  throw NSBase::IllegalArgumentException(std::string("[CDOmModuleOrUdpInstantiation::getParamExpr()] explicit parameter name: " + *explicitParamName + " not found.").c_str(), m_lineNumber);
    //}
    return iter->second;
  }
  return RefCDOmMinTypMax();
}

RefTVec_RefCDOmModuleOrUdpInstance CDOmModuleOrUdpInstantiation::getModuleInstances() const {
  return getChildren<CDOmModuleOrUdpInstance>(TYPE_INST_MODULE);  
}

void CDOmModuleOrUdpInstantiation::setDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength) {
  ASSERT(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION || m_moduleInstantiationType == UDP_INSTANTIATION, "m_moduleInstantiationType check failure");
  if( m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION )
    m_moduleInstantiationType = UDP_INSTANTIATION;
  if(firstDriveStrength != DRIVE_STRENGTH_UNDEFINED && secondDriveStrength != DRIVE_STRENGTH_UNDEFINED) {
    if(checkDriveStrength(firstDriveStrength, secondDriveStrength, m_lineNumber)) {
      m_firstDriveStrength = firstDriveStrength;
      m_secondDriveStrength = secondDriveStrength;
    }
  }
  else {
    addErr(NSWarningErr::VEE_CSA_DRST_DRVS_ILLEGAL_CSVE, args, m_lineNumber);
    cdomHasErrors = TRUE;
  }
}

ECDOmDriveStrength CDOmModuleOrUdpInstantiation::getFirstDriveStrength() const {
  ASSERT(m_moduleInstantiationType == UDP_INSTANTIATION, "[CDOmModuleOrUdpInstantiation::getFirstDriveStrength() const] illegal state for this method call");
  //if( m_moduleInstantiationType != UDP_INSTANTIATION)
  //  throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstantiation::getFirstDriveStrength() const] illegal state for this method call", m_lineNumber);
  return m_firstDriveStrength;
}

ECDOmDriveStrength CDOmModuleOrUdpInstantiation::getSecondDriveStrength() const {
  ASSERT(m_moduleInstantiationType == UDP_INSTANTIATION, "[CDOmModuleOrUdpInstantiation::getSecondDriveStrength() const] illegal state for this method call");
  //if( m_moduleInstantiationType != UDP_INSTANTIATION)
  //  throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstantiation::getSecondDriveStrength() const] illegal state for this method call", m_lineNumber);
  return m_secondDriveStrength;
}

void CDOmModuleOrUdpInstantiation::buildDelay2(TLineNumberType lineNumber) {
  ASSERT(m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION || m_moduleInstantiationType == UDP_INSTANTIATION, "m_moduleInstantiationType check failure");
  if( m_moduleInstantiationType == MODULE_OR_UDP_INSTANTIATION )
    m_moduleInstantiationType = UDP_INSTANTIATION;

  if(!m_delay2.get()){
    //m_delay2 = CDOmDelay::build(lineNumber, m_weakRef.lock(), CDOmDelay::DELAY_2);
    m_delay2 = CDOmDelay::build(lineNumber, getThis(), CDOmDelay::DELAY_2);
  }
  else {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_HAS_PARAMETER, args, m_lineNumber);
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstantiation::buildDelay2()] parameter already set", m_lineNumber);
  }
}

RefCDOmDelay CDOmModuleOrUdpInstantiation::getDelay2() {
  if(m_delay2.get()) {
    return m_delay2;
  }
  else {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_PARAMETER_NOT_SET, args, m_lineNumber);
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstantiation::getDelay2()] parameter not set", m_lineNumber); 
  }
}

const RefCDOmDelay CDOmModuleOrUdpInstantiation::getDelay2() const {
  if(m_delay2.get()) {
    return m_delay2;
  }
  else {
    addErr(NSWarningErr::CSE_CSC_DSGN_CSE_CSC_DSGN_PARAMETER_NOT_SET, args, m_lineNumber);
    cdomHasErrors = TRUE;
    //throw NSBase::IllegalStateException("[CDOmModuleOrUdpInstantiation::getDelay2() const] parameter not set", m_lineNumber); 
  }
}

void CDOmModuleOrUdpInstantiation::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmInitOrAlways class
// ********************************************************************************
CDOmInitOrAlways::CDOmInitOrAlways(TLineNumberType lineNumber, EInitOrAlwaysType initOrAlwaysType) : CDOmAttrHolder(lineNumber, TYPE_INITIAL_OR_ALWAYS), m_initOrAlwaysType(initOrAlwaysType) {}

RefCDOmInitOrAlways CDOmInitOrAlways::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmInitOrAlways();
  }
  ASSERT(object->getType() == TYPE_INITIAL_OR_ALWAYS, "type check on CDOmInitOrAlways::cast failure");
  return boost::static_pointer_cast<CDOmInitOrAlways>(object);
}

RefCDOmInitOrAlways CDOmInitOrAlways::build(TLineNumberType lineNumber, RefCDOmBase parent, EInitOrAlwaysType initOrAlwaysType, RefCDOmStmt stmt) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(stmt.get() && stmt->getStmtType() != CDOmStmt::STMT_NULL, "stmt is NULL or has illegal type");

  CDOmInitOrAlways* initOrAlways = new CDOmInitOrAlways(lineNumber, initOrAlwaysType);
  RefCDOmInitOrAlways refInitOrAlways(initOrAlways);
  initOrAlways->m_weakRef = boost::weak_ptr<CDOmBase>( refInitOrAlways);
  refInitOrAlways->setParent(parent); 
  stmt->setParent(refInitOrAlways); // self registration
  return refInitOrAlways;
}

CDOmInitOrAlways::EInitOrAlwaysType CDOmInitOrAlways::getInitOrAlwaysType() const {
  return m_initOrAlwaysType;
}

RefCDOmStmt CDOmInitOrAlways::getStmt() const {
  //return boost::static_pointer_cast<CDOmStmt>(m_children->at(0));
  RefCDOmBase stmtAsBase = getChild(0);
  RefCDOmStmt stmt = CDOmStmt::cast(stmtAsBase);
  return stmt;
}

void CDOmInitOrAlways::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  // !!! to be completed
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmFunctionCall class
// ********************************************************************************
CDOmFunctionCall::CDOmFunctionCall(TLineNumberType lineNumber, EFunctionCallType functionCallType) : CDOmExpr(lineNumber, EXPR_FUNCTION_CALL), m_functionCallType(functionCallType) {}

RefCDOmFunctionCall CDOmFunctionCall::cast (RefCDOmBase object) {
  //ASSERT(object.get());
  if (!object.get()) {
    return RefCDOmFunctionCall();
  }
  ASSERT(object->getType() == TYPE_EXPR, "type check on CDOmFunctionCall::cast failure");
  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  RefCDOmBase cdomexprAsBase = object;
  RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
  RefCDOmExpr obj = cdomexpr;
  ASSERT(obj->getExprType() == CDOmExpr::EXPR_FUNCTION_CALL, "type check on CDOmFunctionCall::cast failure");
  return boost::static_pointer_cast<CDOmFunctionCall>(object);
}

RefCDOmFunctionCall CDOmFunctionCall::build(TLineNumberType lineNumber, RefCDOmExprLink exprLink, RefCDOmListExpr exprList, RefCDOmAttrListCollection attrListCollection) {
  ASSERT(exprLink.get(), "exprLink is NULL");

  EFunctionCallType functionCallType;
  if(exprLink->isHID()) {
    //!!TODO check for $ in hid
    //getNames.t(0)
    ASSERT(exprList.get(), "exprList is NULL");
    functionCallType = FUNCTION_CALL_HID;
  }
  else if(exprLink->getName()->at(0) != '$') {
    ASSERT(exprList.get(), "exprList is NULL");
    functionCallType = FUNCTION_CALL_ID;
  }
  else {
    ASSERT(!attrListCollection.get(), "attrListCollection should be NULL");
    functionCallType = FUNCTION_CALL_SYSTEM;
  }
  CDOmFunctionCall* functionCall = new CDOmFunctionCall(lineNumber, functionCallType);
  RefCDOmFunctionCall refFunctionCall(functionCall);
  functionCall->m_weakRef = boost::weak_ptr<CDOmBase>( refFunctionCall);
  exprLink->setParent(refFunctionCall); // self registration
  if(attrListCollection.get()) {
    attrListCollection->setParent(refFunctionCall); // self registration
  }
  if(exprList.get()) {
    exprList->setParent(refFunctionCall); // self registration
  }
  return refFunctionCall;
}

CDOmFunctionCall::EFunctionCallType CDOmFunctionCall::getFunctionCallType() const {
  return m_functionCallType;
}

TBool CDOmFunctionCall::isConst() const {
  return m_functionCallType == FUNCTION_CALL_ID;
}

TBool CDOmFunctionCall::canBeModulePath() const {
  return true;
}

//RefCDOmEvalRes CDOmFunctionCall::doEval() const {
//  // !!! to be completed
//  return RefCDOmEvalRes();
//}

RefCDOmBase CDOmFunctionCall::doEval() const {
  // !!! to be completed
  return RefCDOmBase();
}

void CDOmFunctionCall::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmDesign class
// ********************************************************************************
// This class is the absolute root of a design.
// It contains all top level modules and UPDs.
CDOmDesign::CDOmDesign() : CDOmBase(TYPE_DESIGN, 0), m_scope() {}

RefCDOmDesign CDOmDesign::cast (RefCDOmBase object) {
  //assert(object.get())  ;
  if (!object.get()) {
    return RefCDOmDesign();
  }
  ASSERT(object->getType() == TYPE_DESIGN, "type check on CDOmDesign::cast failure");
  return boost::static_pointer_cast<CDOmDesign>(object);
  //RefCDOmBase cdomdesignAsBase = object;
  //RefCDOmDesign cdomdesign = CDOmDesign::cast(cdomdesignAsBase);
  //return cdomdesign;
  return boost::static_pointer_cast<CDOmDesign>(object);
}

RefCDOmDesign CDOmDesign::build() {
  CDOmDesign* design = new CDOmDesign();
  RefCDOmDesign refDesign(design);
  design->m_weakRef = boost::weak_ptr<CDOmBase>( refDesign);
  //initialize attached scope
  design->m_scope = CDOmScope::build();
  //initialize CDOmVeriNum static members

  //Tb removed//
  //   std::ostringstream oss;
  //   for(TInt i = 0; i < 16; ++i) {
  //     oss << std::setbase(16) << i;
  //     //initializing hexArr
  //     CDOmVeriNum::hexArr->push_back(RefString(new std::string(oss.str())));
  //     //initializing octArr
  //     if(i < 8) {
  //      CDOmVeriNum::octArr->push_back(RefString(new std::string(oss.str())));
  //     }
  //     oss.str("");
  //   }
  //~Tb removed//
  return refDesign;
}

RefCDOmScope CDOmDesign::getAttachedScope() const {
  return m_scope;
}

RefCDOmModuleDecl CDOmDesign::buildModuleDecl(TLineNumberType lineNumber, const RefString& name, CDOmModuleDecl::EKeywordType keywordType) {
  //return CDOmModuleDecl::build(lineNumber, boost::static_pointer_cast<CDOmDesign>(m_weakRef.lock()), name, keywordType);
  RefCDOmBase cdomdesignAsBase = getThis();
  RefCDOmDesign cdomdesign = CDOmDesign::cast(cdomdesignAsBase);
  return CDOmModuleDecl::build(lineNumber, cdomdesign, name, keywordType);
}

RefCDOmUdpDecl CDOmDesign::buildUdpDecl(TLineNumberType lineNumber, const RefString name) {
  //return CDOmUdpDecl::build(lineNumber, boost::static_pointer_cast<CDOmDesign>(m_weakRef.lock()), name);
  RefCDOmBase cdomdesignAsBase = getThis();
  RefCDOmDesign cdomdesign = CDOmDesign::cast(cdomdesignAsBase);
  return CDOmUdpDecl::build(lineNumber, cdomdesign, name);
}

const RefTVec_RefCDOmBase CDOmDesign::getTops() const {
  return m_children;
}

const RefTVec_RefCDOmModuleDecl CDOmDesign::getModuleDecls() const {
  return getChildren<CDOmModuleDecl>(TYPE_DECL_MODULE);
}

const RefTVec_RefCDOmBase CDOmDesign::getDefineDecls() const {
  return getChildren<CDOmBase>(TYPE_DEFINE);
}

const RefTVec_RefCDOmUdpDecl CDOmDesign::getUdpDecls() const {
  return getChildren<CDOmUdpDecl>(TYPE_DECL_UDP);
}

void CDOmDesign::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());

  //visitor.visit(CDOmDesign::cast(getThis()));
  /*const RefTVec_RefCDOmBase tops = getTops();
    if(! tops.get()) {
    std::cerr << "Deignn does not contain any units " << std::endl;
    return;
    }
    // acceptVisitor(visitor);
    std::cout << "// CDOmDesign::acceptVisitor" << std::endl;

    //visitor.visit(boost::static_pointer_cast<CDOmDesign>(m_weakRef.lock()));

    for(TVec_RefCDOmBase_const_iter iter = tops->begin(); iter != tops->end(); ++iter) {
    std::cout << "// CDOmDesign::acceptVisitor for loop :: type = " << visitor.stringType.getStringType((*iter)->getType()) << std::endl;

    (*iter)->acceptVisitor(visitor);
    std::cout << "// CDOmDesign::acceptVisitor for loop" << std::endl;
    }

    RefTVec_RefCDOmModuleDecl rmdl = getModuleDecls(); */

  //  boost::static_pointer_cast<RefTVec_RefCDOmModuleDecl>(rmdl);
  //  for(RefTVec_RefCDOmModuleDecl_const_iter iter = mod_decls->begin(); iter != mod_decls->end(); ++iter) {
  //  }
}

// ********************************************************************************
// CDOmEvalRes class
// ********************************************************************************
CDOmEvalRes::CDOmEvalRes(const RefCVeriNum& veriNum): m_evalResType(EVAL_RES_VERINUM), m_veriNum(veriNum), m_realNum() {}

CDOmEvalRes::CDOmEvalRes(const RefCRealNum& realNum): m_evalResType(EVAL_RES_REALNUM), m_veriNum(), m_realNum(realNum) {}

RefCDOmEvalRes CDOmEvalRes::build(const RefCVeriNum& veriNum) {
  ASSERT(veriNum.get(), "veriNum is NULL");

  return RefCDOmEvalRes(new CDOmEvalRes(veriNum));
}

RefCDOmEvalRes CDOmEvalRes::build(const RefCRealNum& realNum) {
  ASSERT(realNum.get(), "realNum is NULL");

  return RefCDOmEvalRes(new CDOmEvalRes(realNum));
}

CDOmEvalRes::EEvalResType CDOmEvalRes::getEvalResType() const {
  return m_evalResType;
}

RefCVeriNum CDOmEvalRes::getVeriNum() {
  return m_veriNum;
}

RefCRealNum CDOmEvalRes::getRealNum() {
  return m_realNum;
}

std::ostream& CDOmEvalRes::dump(std::ostream& os) const {
  os << "CDOmEvalRes: ";
  switch (m_evalResType) {
    case EVAL_RES_UNDEF:
      os << "Undefined";
      break;
    case EVAL_RES_VERINUM:
      os << *m_veriNum;
      break;
    case EVAL_RES_REALNUM:
      os << *m_realNum;
      break;
    default:
      ASSERT(FAIL, "[CDOmEvalRes::dump()] bug detected...");
      //throw NSBase::IllegalStateException("[CDOmEvalRes::dump()] bug detected...");
  }
  return os; 
}

// ********************************************************************************
// CDOmNumber class
// ********************************************************************************
//CDOmNumber::CDOmNumber(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& tokenString, const RefCVeriNum& veriNum)
//  : CDOmExpr(lineNumber, EXPR_NUMBER), m_numBaseType(numBaseType), m_tokenString(tokenString), m_veriNum(veriNum) {}
//
//RefCDOmNumber CDOmNumber::cast (RefCDOmBase object) {
//  assert(object.get());
//  assert(object->getType() == TYPE_EXPR);
//  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
//  RefCDOmBase cdomexprAsBase = object;
//  RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
//  RefCDOmExpr obj = cdomexpr;
//  assert(obj->getExprType() == CDOmExpr::EXPR_NUMBER);
//  //return boost::static_pointer_cast<CDOmNumber>(object);
//  RefCDOmBase cdomnumberAsBase = object;
//  RefCDOmNumber cdomnumber = CDOmNumber::cast(cdomnumberAsBase);
//  return cdomnumber;
//}
//
//RefCDOmNumber CDOmNumber::build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& tokenString, const RefString& lightString, TBool isSigned, TUInt size) {
//  assert(tokenString.get());
//  assert(tokenString->size());
//  assert(lightString.get());
//  assert(lightString->size());
//  CVeriNum::TBase base;
//  switch(numBaseType) {
//    case NUM_BASE_BIN:
//      base = CVeriNum::BIN;
//      break;
//    case NUM_BASE_OCT:
//      base = CVeriNum::OCT;
//      break;
//    case NUM_BASE_DEC:
//      base = CVeriNum::DEC;
//      break;
//    case NUM_BASE_HEX:
//      base = CVeriNum::HEX;
//      break;
//    default:
//      throw NSBase::IllegalArgumentException("[CDOmNumber::build()] invalid arguments.", lineNumber);
//  }
//
//  CDOmNumber* number = new CDOmNumber(lineNumber, numBaseType, tokenString, RefCVeriNum(new CVeriNum(base, *lightString, isSigned, size)));
//  RefCDOmNumber refNumber(number);
//  number->m_weakRef = boost::weak_ptr<CDOmBase>( refNumber);
//  return refNumber;
//}
//
//TBool CDOmNumber::isSigned() const {
//  return m_veriNum->hasSign();
//}
//
//TInt CDOmNumber::getSize() const {
//  return m_veriNum->getLen();
//}
//
//CDOmNumber::ENumBaseType CDOmNumber::getNumBaseType() const {
//  return m_numBaseType;
//}
//
//RefString CDOmNumber::getTokenString() const {
//  return m_tokenString;
//}
//
//RefCVeriNum CDOmNumber::getVeriNum() const {
//  return m_veriNum;
//}
//
//TBool CDOmNumber::isConst() const {
//  return true;
//}
//
//TBool CDOmNumber::canBeModulePath() const {
//  return true;
//}
//
//RefCDOmEvalRes CDOmNumber::doEval() const {
//  return CDOmEvalRes::build(m_veriNum);
//}

// ********************************************************************************
// CDOmNumber class
// ********************************************************************************
CDOmNumber::CDOmNumber(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& tokenString, const RefCVeriNum& veriNum)
  : CDOmExpr(lineNumber, CDOmExpr::EXPR_NUMBER), m_numBaseType(numBaseType), m_tokenString(tokenString), m_veriNum(veriNum), m_isVeriNum(true) { }

RefCDOmNumber CDOmNumber::cast(RefCDOmBase object) {
  if (!object.get()) {
    return RefCDOmNumber();
  }
  ASSERT(object->getType() == TYPE_EXPR , "type check on cast failure");
  RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  ASSERT(obj->getExprType() == EXPR_NUMBER, "type mismatch");
  return boost::static_pointer_cast<CDOmNumber>(obj);
}

CDOmNumber::CDOmNumber(TLineNumberType lineNumber, ENumType numType, ENumBaseType numBaseType, TBool hasXZ)
  : CDOmExpr(lineNumber, CDOmExpr::EXPR_NUMBER), m_numType(numType), m_numBaseType(numBaseType),  m_hasXZ(hasXZ), m_overflow(FALSE), 
    m_isConst(TRUE), m_isEvaluated(FALSE), m_isTrunkated(FALSE), m_isRounded(FALSE), m_width(), m_noOfBitsTrunk(), m_noOfBitsRound(), m_isSigned(FALSE),
    m_isVeriNum(FALSE) { }

/**
 * This is the csl_number build method. According to csl_number specification we create a 
 * generic variable that becomes specific as we perform commands on the variable
 */
RefCDOmNumber CDOmNumber::build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TInt width, TBool hasXZ) {
  ASSERT(lightString.get(), "null lightString received");
  ASSERT(lightString->length(), "empty lightString received");

  RefCDOmNumber num = CDOmNum32::build(lineNumber, numBaseType, lightString, width);
  num->m_tokenString = lightString;
  return num;
}

const CDOmNumber::ENumType CDOmNumber::getNumType() const {
  return m_numType;
}

const TBool CDOmNumber::getOverflow() const {
  return m_overflow;
}

const TBool CDOmNumber::hasXZ() const {
  return m_hasXZ;
}

TBool CDOmNumber::isConst() const {
  //return m_isConst;
  return true;
}

TBool CDOmNumber::canBeModulePath() const {
  return true;
}

const TBool CDOmNumber::isEvaluated() const {
  return m_isEvaluated;
}

const TBool CDOmNumber::isTrunkated() const {
  return m_isTrunkated;
}

const TBool CDOmNumber::isRounded() const {
  return m_isRounded;
}

const TInt CDOmNumber::getWidth() const {
  return m_width;
}

const TInt CDOmNumber::getNoOfBitsTrunk() const {
  return m_noOfBitsTrunk;
}

const TInt CDOmNumber::getNoOfBitsRound() const {
  return m_noOfBitsRound;
}

void CDOmNumber::setNumType(CDOmNumber::ENumType numType) {
  m_numType = numType;
}

void CDOmNumber::setOverflow(TBool overflow) {
  m_overflow = overflow;
}

void CDOmNumber::setHasXZ(TBool hasXZ) {
  m_hasXZ = hasXZ;
}

void CDOmNumber::setIsConst(TBool isConst) {
  m_isConst = isConst;
}

void CDOmNumber::setIsSigned(TBool isSigned) {
  m_isSigned = isSigned;
}

void CDOmNumber::setIsEvaluated(TBool isEvaluated) {
  m_isEvaluated = isEvaluated;
}

void CDOmNumber::setIsTrunkated(TBool isTrunkated) {
  m_isTrunkated = isTrunkated;
}

void CDOmNumber::setIsRounded(TBool isRounded) {
  m_isRounded = isRounded;
}

void CDOmNumber::setWidth(TInt width) {
  m_width = width;
}

void CDOmNumber::setNoOfBitsTrunk(TInt noOfBitsTrunk) {
  m_noOfBitsTrunk = noOfBitsTrunk;
}

void CDOmNumber::setNoOfBitsRound(TInt noOfBitsRound) {
  m_noOfBitsRound = noOfBitsRound;
}

void CDOmNumber::setIsVeriNumFlag(TBool isVeriNum) {
  m_isVeriNum = isVeriNum;
}

const TBool CDOmNumber::getIsVeriNumFlag() const {
  return m_isVeriNum;
}
/**
 * Returns if number is signed.
 */
//TODO figure out how to do this for all numerics type
const TBool CDOmNumber::isSigned() const {
  return m_isSigned;
}

/**
 * Returns size of number
 */
//TODO this should be virtual and implemented in all numeric classes
TInt CDOmNumber::getSize() const {
  return 0;
}

/**
 * Returns the base in which the number is represented
 */

CDOmNumber::ENumBaseType CDOmNumber::getNumBaseType() const {
  return m_numBaseType;
}

const RefString CDOmNumber::getTokenString() const {
  return m_tokenString;
}

/**
 * Returns the verilog number that corespondes to current number
 */

RefCVeriNum CDOmNumber::getVeriNum() const {
  return m_veriNum;
}

void CDOmNumber::setVeriNum(RefCVeriNum veriNum) {
  (*m_veriNum) = (*veriNum);
}

/**
 * Eval the number as an expr
 */
//RefCDOmEvalRes CDOmNumber::doEval() const {
//  //return CDOmEvalRes::build(m_veriNum);
//  //  return CDOmEvalRes::build(CDOmNumber::cast(m_weakRef.lock()));
//}

RefCDOmBase CDOmNumber::doEval() const {
  return getThis();
}

// ********************************************************************************
// CDOmNum32 class
// ********************************************************************************
CDOmNum32::CDOmNum32(TLineNumberType lineNumber, CDOmNumber::ENumBaseType base, const TInt value)
  : CDOmNumber(lineNumber, CDOmNumber::NUM_INT32, base), m_value(value) { }

RefCDOmNum32 CDOmNum32::cast(RefCDOmBase object) {
  if (!object.get()) {
    return RefCDOmNum32();
  }
  ASSERT(object->getType() == TYPE_EXPR , "type check on cast failure");
  return boost::static_pointer_cast<CDOmNum32>(object);
}

const TInt CDOmNum32::maxWidth = sizeof(TInt)*8;
RefCDOmNum32 CDOmNum32::build(TLineNumberType lineNumber, TInt value, CDOmNumber::ENumBaseType type, TInt width) {

  //  CDOmNum32 *number = new CDOmNum32(lineNumber, CDOmNumber::NUM_BASE_DEC, value);
  CDOmNum32 *number = new CDOmNum32(lineNumber, type, value);

  RefCDOmNum32 refNumber = RefCDOmNum32(number);
  number->m_weakRef = boost::weak_ptr<CDOmBase>( refNumber);
  if(width) {
    number->m_width = width;
  }
  else {
    number->m_width = number->calcWidth();
  }
  number->setIsEvaluated(TRUE);
  if(type == CDOmNumber::NUM_BASE_BIN) {
    number->m_isVeriNum = TRUE;
  }
  return refNumber;
}

RefCDOmNum32 CDOmNum32::build(TLineNumberType lineNumber, CDOmNumber::ENumBaseType base, RefString num, TInt width) {
  TInt value;
  value = CDOmNum32::converter(base, num);

  CDOmNum32 *number = new CDOmNum32(lineNumber, base, value);
  RefCDOmNum32 refNumber = RefCDOmNum32(number);
  number->m_weakRef = boost::weak_ptr<CDOmBase>( refNumber);
  if (width) {
    number->m_width = width;
  }
  else {
    number->m_width = number->calcWidth();
  }
  if(base == CDOmNumber::NUM_BASE_BIN) {
    number->m_isVeriNum = TRUE;
  }
  number->setIsEvaluated(TRUE);
  return refNumber;
}

TInt CDOmNum32::converter(CDOmNumber::ENumBaseType base, RefString number) {
  std::istringstream in(*number);
  TInt aux = 0;
  TInt aux1 = 0;
  switch(base) {
    case NUM_BASE_BIN: aux = strtol(number->c_str(),NULL,2); break;
    case NUM_BASE_OCT: in >> std::oct >> aux; break;
    case NUM_BASE_DEC: in >> std::dec >> aux; break;
    case NUM_BASE_HEX: in >> std::hex >> aux; break;
    default:
      //args.push_back("");
      //addErr(NSWarningErr::VHE_CSC_NUM_UNKNOWN_NUM_BASE_CSCVH, args, m_lineNumber);
      throw NSBase::IllegalArgumentException("bad base");
  }

  return aux;
}

const TInt CDOmNum32::getValue() const {
  return m_value;
}

void CDOmNum32::setValue(TInt value) {
  m_value = value;
}

void CDOmNum32::changeSign() {
  m_value *= -1;
}

TInt CDOmNum32::calcWidth() {
  TInt value = m_value;
  TInt val = 1<<(maxWidth/2);
  TInt width = maxWidth/2;
  TInt retWidth = maxWidth/2;
  if (value<0) {
    value*=-1;
    retWidth+=1;
  }
  while (width!=0) {
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

TBool CDOmNum32::equals(TInt value) { 
  return value==m_value;
}

RefCDOmNumber CDOmNum32::maxValue() {
  return CDOmNum32::build(m_lineNumber, (1<<m_width)-1);
}

RefCDOmNumber CDOmNum32::plus() {
  return CDOmNum32::build(m_lineNumber, m_value);//CDOmNum32::cast(number)->getValue()+m_value); 
}

RefCDOmNumber CDOmNum32::minus() {
  return CDOmNum32::build(m_lineNumber, (-1)*m_value);//CDOmNum32::cast(number)->getValue()+m_value); 
}

RefCDOmNumber CDOmNum32::logicNot() {
  return CDOmNum32::build(m_lineNumber, !m_value);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::bitwiseNot() {
  return CDOmNum32::build(m_lineNumber, ~m_value);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::reductionAnd() {
  TInt val,result = 1;
  val = m_value;
  for(int i = 0; i < m_width; i++) {
    val = val >> 1;
    result &= val;
  }
  return CDOmNum32::build(m_lineNumber, result);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::reductionNand() {
  TInt val,result = 1;
  val = m_value;
  for(int i = 0; i < m_width; i++) {
    val = val >> 1;
    result &= val;
  }
  return CDOmNum32::build(m_lineNumber, !result);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::reductionOr() {
  TInt val,result = 1;
  val = m_value;
  for(int i = 0; i < m_width; i++) {
    val = val >> 1;
    result |= val;
  }
  return CDOmNum32::build(m_lineNumber, result);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::reductionNor() {
  TInt val,result = 1;
  val = m_value;
  for(int i = 0; i < m_width; i++) {
    val = val >> 1;
    result |= val;
  }
  return CDOmNum32::build(m_lineNumber, !result);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::reductionXor() {
  TInt val,result = 1;
  val = m_value;
  for(int i = 0; i < m_width; i++) {
    val = val >> 1;
    result ^= val;
  }
  return CDOmNum32::build(m_lineNumber, result);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::reductionXnor() {
  TInt val,result = 1;
  val = m_value;
  for(int i = 0; i < m_width; i++) {
    val = val >> 1;
    result ^= val;
  }
  return CDOmNum32::build(m_lineNumber, !result);//CDOmNum32::cast(number)->getValue()+m_value);   
}

RefCDOmNumber CDOmNum32::add(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value + num32->getValue());//CDOmNum32::cast(number)->getValue()+m_value); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::substract(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value-(num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::multiply(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32: return CDOmNum32::build(m_lineNumber, m_value*(num32->getValue()));   break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::divide(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value/ (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::modulo(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value% (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::power(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, (int)pow((float)m_value, (num32->getValue())));//TODO: return NUM_BIGNUM double
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::shiftLeft(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value << (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::shiftRight(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value >> (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::equality(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32: {
      if(m_value == num32->getValue()) {
        return CDOmNum32::build(m_lineNumber, 1);//(CDOmNum32::cast(number)->getValue())); 
      } else {
        return CDOmNum32::build(m_lineNumber, 0);//(CDOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::notEquality(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32: {
      if(m_value != num32->getValue()) {
        return CDOmNum32::build(m_lineNumber, 1);//(CDOmNum32::cast(number)->getValue())); 
      } else {
        return CDOmNum32::build(m_lineNumber, 0);//(CDOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::equalityEqualCase(RefCDOmNumber number) {
  //TODO: verinum equality operation
  return RefCDOmNumber();
}

RefCDOmNumber CDOmNum32::equalityNotEqualCase(RefCDOmNumber number) {
  //TODO: verinum equality operation
  return RefCDOmNumber();
}

RefCDOmNumber CDOmNum32::logicAnd(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value && (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::logicOr(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value || (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::relationalLess(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32: {
      if(m_value < num32->getValue()) {
        return CDOmNum32::build(m_lineNumber, 1);//(CDOmNum32::cast(number)->getValue())); 
      } else {
        return CDOmNum32::build(m_lineNumber, 0);//(CDOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::relationalLessEqual(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32: {
      if(m_value <= num32->getValue()) {
        return CDOmNum32::build(m_lineNumber, 1);//(CDOmNum32::cast(number)->getValue())); 
      } else {
        return CDOmNum32::build(m_lineNumber, 0);//(CDOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::relationalGreater(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32: {
      if(m_value > num32->getValue()) {
        return CDOmNum32::build(m_lineNumber, 1);//(CDOmNum32::cast(number)->getValue())); 
      } else {
        return CDOmNum32::build(m_lineNumber, 0);//(CDOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::relationalGreaterEqual(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32: {
      if(m_value >= num32->getValue()) {
        return CDOmNum32::build(m_lineNumber, 1);//(CDOmNum32::cast(number)->getValue())); 
      } else {
        return CDOmNum32::build(m_lineNumber, 0);//(CDOmNum32::cast(number)->getValue()));
      }
      break;
    }
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::bitwiseAnd(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value & (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::bitwiseNand(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, ~(m_value & (num32->getValue())));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::bitwiseOr(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value | (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::bitwiseNor(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, ~(m_value | (num32->getValue())));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::bitwiseXor(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value ^ (num32->getValue()));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::bitwiseXnor(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, ~(m_value ^ (num32->getValue())));//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::binaryShiftLeft(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value << num32->getValue());//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::binaryShiftRight(RefCDOmNumber number) {
  ASSERT(number.get(), "null pointer received");
  ASSERT(number->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32 = cast(number);
  switch(number->getNumType()) {
    case CDOmNumber::NUM_INT32:  
      return CDOmNum32::build(m_lineNumber, m_value >> num32->getValue());//(CDOmNum32::cast(number)->getValue())); 
      break;
    default:   ASSERT(0, "not implemented yet");
  }
}

RefCDOmNumber CDOmNum32::ternaryCondition(RefCDOmNumber number1, RefCDOmNumber number2) {
  ASSERT(number1.get(), "null pointer received");
  ASSERT(number1->isEvaluated(), "number should already be evaluated");
  ASSERT(number2.get(), "null pointer received");
  ASSERT(number2->isEvaluated(), "number should already be evaluated");

  RefCDOmNum32 num32_1 = cast(number1);
  RefCDOmNum32 num32_2 = cast(number2);
  if(m_value) {
    switch(number1->getNumType()) {
      case CDOmNumber::NUM_INT32:
        return CDOmNum32::build(m_lineNumber, num32_1->getValue());//(CDOmNum32::cast(number)->getValue())); 
        break;
      default:   ASSERT(0, "not implemented yet");
    }
  } else {
    switch(number1->getNumType()) {
      case CDOmNumber::NUM_INT32:
        return CDOmNum32::build(m_lineNumber, num32_2->getValue());//(CDOmNum32::cast(number)->getValue())); 
        break;
      default:   ASSERT(0, "not implemented yet");
    }
  }
}

void CDOmNum32::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

//Tb removed//
// // ********************************************************************************
// // CDOmVeriNum class
// // ********************************************************************************

// RefTVec_RefString CDOmVeriNum::hexArr = RefTVec_RefString(new TVec_RefString());
// RefTVec_RefString CDOmVeriNum::octArr = RefTVec_RefString(new TVec_RefString());

// CDOmVeriNum::CDOmVeriNum(TLineNumberType lineNumber, CDOmBitArray::TBit bit, TInt width) 
//  : CDOmNumber(lineNumber, CDOmNumber::NUM_VERILOG, CDOmNumber::NUM_BASE_BIN) {
//    ASSERT(width > 0, "[CDOmVeriNum::CDOmVeriNum()] received negative width");
   
//    m_isSigned = FALSE;
//    m_bits = CDOmBitArray::build(lineNumber, width);
//    //m_bits->setLen(width);
//    for(TUInt i = 0; i < m_bits->getLen(); ++i) {
//      m_bits->setBit(i, bit);
//    }
// }

// CDOmVeriNum::CDOmVeriNum(TLineNumberType lineNumber, ENumBaseType base, const RefString& lightString, TBool _isSigned, TUInt sz) 
//  : CDOmNumber(lineNumber, CDOmNumber::NUM_VERILOG, base) {
//    ASSERT(lightString.get(), "[CDOmVeriNum::CDOmVeriNum()] received null lightString");
//    ASSERT(sz > 0, "[CDOmVeriNum::CDOmVeriNum()] received negative or zero width");
   
//     TUInt strLen = lightString->length();
//     TUInt size;

//     //TODO : addError
//     if(sz > 0) {
//       if(strLen*3 > sz && base == NUM_BASE_OCT) {
//         args.push_back(intToString(strLen*3));
//         args.push_back(*lightString);
//         args.push_back(intToString(sz));
//         addErr(NSWarningErr::VEW_CDC_PARM_SMALL_SPEC_WIDTH_NUMBER, args, lineNumber);
//         //std::cerr << "Line: " << lineNumber << " WARNING: width " << strLen*3 << " of number " << *lightString 
//         //          << " is greater than the specified width "<< sz << " !"<<std::endl;
//       }
//       else if(strLen > sz && base == NUM_BASE_BIN) {
//         args.push_back(intToString(strLen));
//         args.push_back(*lightString);
//         args.push_back(intToString(sz));
//         addErr(NSWarningErr::VEW_CDC_PARM_SMALL_SPEC_WIDTH_NUMBER, args, lineNumber);
//         //std::cerr << "Line: " << lineNumber << " WARNING: width " << strLen << " of number " << *lightString 
//         //          << " is greater than the specified width "<< sz << " !"<<std::endl;
//       }
//       //else if(strLen*4 > sz && base == NUM_BASE_DEC) {
//       //  std::cerr << "Line: " << lineNumber << " WARNING: width " << strLen*4 << " of number " << *lightString 
//       //            << " is greater than the specified width "<< sz << " !"<<std::endl;
//       //}
//       else if(strLen*4 > sz && base == NUM_BASE_HEX) {
//         args.push_back(intToString(strLen*4));
//         args.push_back(*lightString);
//         args.push_back(intToString(sz));
//         addErr(NSWarningErr::VEW_CDC_PARM_SMALL_SPEC_WIDTH_NUMBER, args, lineNumber);
//         //std::cerr << "Line: " << lineNumber << " WARNING: width " << strLen*4 << " of number " << *lightString 
//         //          << " is greater than the specified width "<< sz << " !"<<std::endl;
//       }
//         size = sz;
//     }

//     m_bits = CDOmBitArray::build(lineNumber, size);
//     //m_bits->setLen(size);
//     TInt i;
//     TInt bi = 0; // bit index
//     for (i = strLen - 1; i >= 0; i--) {
//       TChar ch = (*lightString)[i];
//       switch (base) {
//         case NUM_BASE_BIN:
//           {
//             switch (ch) {
//               case '0':
//                 setBit(bi++, CDOmBitArray::_0);
//                 break;
//               case '1':
//                 setBit(bi++, CDOmBitArray::_1);
//                 break;
//               case 'Z':
//                 setBit(bi++, CDOmBitArray::_Z);
//                 break;
//               case 'X':
//                 setBit(bi++, CDOmBitArray::_X);
//                 break;
//               default:
//                 ASSERT(FAIL, "[CDOmVeriNum::CDOmVeriNum()] received illegal character");
//             }
//             break;
//           }
//         case NUM_BASE_OCT:
//           {
//             CDOmBitArray::TBit b1, b2, b3;
//             switch (ch) {
//               case '0':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_0;
//                 break;
//               case '1':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_1;
//                 break;
//               case '2':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_0;
//                 break;
//               case '3':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_1;
//                 break;
//               case '4':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_0;
//                 break;
//               case '5':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_1;
//                 break;
//               case '6':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_0;
//                 break;
//               case '7':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_1;
//                 break;
//               case 'Z': b1 = CDOmBitArray::_Z; b2 = CDOmBitArray::_Z; b3 = CDOmBitArray::_Z;
//                 break;
//               case 'X':
//                 b1 = CDOmBitArray::_X; b2 = CDOmBitArray::_X; b3 = CDOmBitArray::_X;
//                 break;
//               default:
//                 ASSERT(FAIL, "[CDOmVeriNum::CDOmVeriNum()] received illegal character");
//                 break;
//             }
//             if(bi < size) {
//               setBit(bi++, b3);
//             }
//             if(bi < size) {
//               setBit(bi++, b2);
//             }
//             if(bi < size) {
//               setBit(bi++, b1);
//             }
//             break;
//           }
//         case NUM_BASE_DEC:
//           {
//             if (ch >= '0' && ch <= '9') {
//               TUInt dec = ch - '0';
//               RefCDOmVeriNum vdec = CDOmVeriNum::build(m_lineNumber, dec, 4);
//               RefCDOmVeriNum vExp = CDOmVeriNum::build(m_lineNumber, strLen - i - 1);
//               RefCDOmVeriNum vTen = CDOmVeriNum::build(m_lineNumber, 10, 4);

//               vdec = CDOmVeriNum::cast(vdec->multiply(vTen->power(vExp)));
//             //  if(vdec->getLen() > size) {
//             //    vdec->trunc(size);  
//             //  }
//               addby(vdec);
//             }
//             else if (ch == 'z' || ch == 'Z')
//             {
//               CVeriNum(CDOmBitArray::_Z, size);
//               return;
//             }
//             else if (ch == 'x' || ch == 'X')
//             {
//               CVeriNum(CDOmBitArray::_X, size);
//               return;
//             }
//             else {
//               ASSERT(FAIL, "[CDOmVeriNum::CDOmVeriNum()] received illegal character");
//             }
//         break;
//           }
//         case NUM_BASE_HEX:
//           {
//             CDOmBitArray::TBit b1, b2, b3, b4;
//             switch (ch)
//             {
//               case '0':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_0;
//                 break;
//               case '1':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_1;
//                 break;
//               case '2':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_0;
//                 break;
//               case '3':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_1;
//                 break;
//               case '4':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_0;
//                 break;
//               case '5':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_1;
//                 break;
//               case '6':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_0;
//                 break;
//               case '7':
//                 b1 = CDOmBitArray::_0; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_1;
//                 break;
//               case '8':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_0;
//                 break;
//               case '9':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_1;
//                 break;
//               case 'A':
//               case 'a':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_0;
//                 break;
//               case 'B':
//               case 'b':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_0; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_1;
//                 break;
//               case 'C':
//               case 'c':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_0;
//                 break;
//               case 'D':
//               case 'd':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_0; b4 = CDOmBitArray::_1;
//                 break;
//               case 'E':
//               case 'e':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_0;
//                 break;
//               case 'F':
//               case 'f':
//                 b1 = CDOmBitArray::_1; b2 = CDOmBitArray::_1; b3 = CDOmBitArray::_1; b4 = CDOmBitArray::_1;
//                 break;
//               case 'Z':
//               case 'z':
//                 b1 = CDOmBitArray::_Z; b2 = CDOmBitArray::_Z; b3 = CDOmBitArray::_Z; b4 = CDOmBitArray::_Z;
//                 break;
//               case 'X':
//               case 'x':
//                 b1 = CDOmBitArray::_X; b2 = CDOmBitArray::_X; b3 = CDOmBitArray::_X; b4 = CDOmBitArray::_X;
//                 break;
//               default:
//                 ASSERT(FAIL, "[CDOmVeriNum::CDOmVeriNum()] received illegal character");
//                 break;
//             }
//             if(bi < size) {
//               setBit(bi++, b4);
//             }
//             if(bi < size) {
//               setBit(bi++, b3);
//             }
//             if(bi < size) {
//               setBit(bi++, b2);
//             }
//             if(bi < size) {
//               setBit(bi++, b1);
//             }
//             break;
//           }
//       }
//     }
//    m_isSigned = _isSigned;
// }


// CDOmVeriNum::CDOmVeriNum(TLineNumberType lineNumber, TInt val, TInt width) 
//   : CDOmNumber(lineNumber, CDOmNumber::NUM_VERILOG, CDOmNumber::NUM_BASE_BIN) {
//     ASSERT(width > 0, "[CDOmVeriNum::CDOmVeriNum()] received negative width");

//     TInt necWidth;
//     if(val != 0) {
//       if(val < 0) {
//         m_isSigned = TRUE;
//         necWidth = (TInt)(log(fabs(val))/log(2)) + 2;
//       }
//       else {
//         m_isSigned = FALSE;
//         necWidth = (TInt)(log(fabs(val))/log(2)) + 1;
//       }
//     }
//     else {
//       necWidth = 1;
//     }

//     if(width < necWidth) { 
//       args.push_back(intToString(necWidth));
//       args.push_back(intToString(val));
//       args.push_back(intToString(width));
//       addErr(NSWarningErr::VEW_CDC_PARM_SMALL_SPEC_WIDTH_NUMBER, args, lineNumber);
//       //std::cerr << "Line: " << lineNumber << " WARNING: width " << necWidth << " of number " << val 
//       //  << " is greater than the specified width "<< width << " !"<<std::endl;
//     }
//     m_bits = CDOmBitArray::build(lineNumber, width);
//     //m_bits->setLen(width);
//     for(TUInt i = 0; i < m_bits->getLen(); ++i, val >>= 1) {
//       m_bits->setBit(i, (val & BIT_ONE) ? CDOmBitArray::_1 : CDOmBitArray::_0);
//     }
// }


// RefCDOmVeriNum CDOmVeriNum::build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TBool isSigned, TUInt width) {
//   ASSERT(lightString.get(), "[CDOmVeriNum::build()] received null lightString");
//   ASSERT(width > 0, "[CDOmVeriNum::build()] received negative or zero width");

//   CDOmVeriNum* veriNum;
//   try { 
//     veriNum = new CDOmVeriNum(lineNumber, numBaseType, lightString, isSigned, width);
//   }
//   catch(std::exception &e) {
//     (FAIL, "[CDOmVeriNum::build] new operator failed");
//   }
//   RefCDOmVeriNum refVeriNum = RefCDOmVeriNum(veriNum);
//   refVeriNum->m_weakRef = boost::weak_ptr<CDOmBase>( refVeriNum);
//   refVeriNum->setIsEvaluated(TRUE);

//   if(numBaseType == CDOmNumber::NUM_BASE_DEC && width < refVeriNum->getLen()) {
//     args.push_back(intToString(refVeriNum->getLen()));
//     args.push_back(*lightString);
//     args.push_back(intToString(width));
//     addErr(NSWarningErr::VEW_CDC_PARM_SMALL_SPEC_WIDTH_NUMBER, args, lineNumber);
//     //std::cerr << "Line: " << lineNumber << " WARNING: width " << refVeriNum->getLen() << " of number " << *lightString 
//     //          << " is greater than the specified width "<< width << " !"<<std::endl;
//     refVeriNum->trunc(width);
//   }

//   return refVeriNum;
// }
    
// RefCDOmVeriNum CDOmVeriNum::build(TLineNumberType lineNumber, TInt value, TUInt width) {
//   ASSERT(width > 0, "[CDOmVeriNum::build()] received negative or zero width");
  
//   CDOmVeriNum* veriNum;
//   try {
//     veriNum = new CDOmVeriNum(lineNumber, value, width);
//   }
//   catch(std::exception &e) {
//     (FAIL, "[CDOmVeriNum::build] new operator failed");
//   }
//   RefCDOmVeriNum refVeriNum = RefCDOmVeriNum(veriNum);
//   refVeriNum->m_weakRef = boost::weak_ptr<CDOmBase>( refVeriNum);
//   refVeriNum->setIsEvaluated(TRUE);

//   return refVeriNum;
// }

// RefCDOmVeriNum CDOmVeriNum::build(TLineNumberType lineNumber, CDOmBitArray::TBit bit, TUInt width) {
//   ASSERT(width > 0, "[CDOmVeriNum::build()] received negative or zero width");

//   CDOmVeriNum* veriNum;
//   try {
//     veriNum = new CDOmVeriNum(lineNumber, bit, width);
//   }
//   catch(std::exception &e) {
//     (FAIL, "[CDOmVeriNum::build] new operator failed");
//   }
//   RefCDOmVeriNum refVeriNum = RefCDOmVeriNum(veriNum);
//   refVeriNum->m_weakRef = boost::weak_ptr<CDOmBase>( refVeriNum);
//   refVeriNum->setIsEvaluated(TRUE);

//   return refVeriNum;
// }

// RefCDOmVeriNum CDOmVeriNum::cast(RefCDOmBase object) {
//   if(!object.get()) {
//     return RefCDOmVeriNum();
//   }
//   ASSERT(object->getType() == TYPE_EXPR, "[CDOmVeriNum::cast()] type check on cast failure");
//   RefCDOmExpr expr = boost::static_pointer_cast<CDOmExpr>(object);
//   ASSERT(expr->getExprType() == EXPR_NUMBER, "[CDOmVeriNum::cast()] type check on cast failure");
//   RefCDOmNumber number = boost::static_pointer_cast<CDOmNumber>(expr);
//   ASSERT(number->getNumType() == NUM_VERILOG, "[CDOmVeriNum::cast()] type check on cast failure");
//   return boost::static_pointer_cast<CDOmVeriNum>(object);
// }

// // Truncate the number to width bits. If specified width is greater than number's width
// // then number is not changed
// void CDOmVeriNum::trunc(TUInt width) {
//   ASSERT(m_bits.get(), "[CDOmVeriNum::trunc()] m_bits is null !");
//   if(width < getLen()) {
//     RefCDOmVeriNum temp = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, getLen());
//     temp->assign(getThis());
//     m_bits->setLen(width);
//     for(TUInt i = 0; i < width; ++i) {
//       setBit(i, temp->safeGetBit(i, PAD_ZERO));
//     }
//   }
// }

// // Assign the value of 'other' number to 'this'
// void CDOmVeriNum::assign(RefCDOmVeriNum other) {
//   ASSERT(other.get(), "[CDOmVeriNum::assign()] null poiter received");

//   if(other->getLen() > getLen()) {
//     addErr(NSWarningErr::VEW_CDC_PARM_NUM_ASSGN_LOSS_BITS, args, m_lineNumber);
//     //std::cerr << "Line: " << m_lineNumber << "WARNING: loss of bits in assigment. " << *other->getTokenString() << "'s width is greater than " 
//     //          << *getTokenString() << "'s -> truncation !" << std::endl;
//   }
//   for(TInt i = 0; i < getLen(); ++i) {
//     setBit(i, other->safeGetBit(i));
//   }
//   setSign(other->isSigned());
// }

// // Set bit 'bit' at specified index
// void CDOmVeriNum::setBit(TInt index, CDOmBitArray::TBit bit) {
//   ASSERT(m_bits.get(), "[CDOmVeriNum::setBit()] m_bits is null !");
//   m_bits->setBit(index, bit);
// }

// // Returns the bit at 'index' position
// CDOmBitArray::TBit CDOmVeriNum::getBit(TInt index) const {
//   ASSERT(m_bits.get(), "[CDOmVeriNum::getBit()] m_bits is null !");
//   return m_bits->getBit(index);
// }

// CDOmBitArray::TBit CDOmVeriNum::safeGetBit(TUInt index, TPadType pad) const {
//   if(index < getLen())
//     return getBit(index);
  
//   return padBit(pad);
// }

// // Returns the most significant bit
// CDOmBitArray::TBit CDOmVeriNum::getMsb() const {
//   TUInt l = getLen();

//   if (l > 0) {
//     return getBit(l - 1);
//   }

//   return CDOmBitArray::_0;
// }

// TBool CDOmVeriNum::isNeg() const {
//   return getMsb() == CDOmBitArray::_1 && isSigned();
// }

// TBool CDOmVeriNum::isEven() const {
//   if(getLen() > 0) {
//     return getBit(0) == CDOmBitArray::_0;
//   }
// }

// TBool CDOmVeriNum::isOdd() const {
//   return !isEven();
// }

// // Returns '0' if number is zero
// //         'X' if number is undefined
// //         '1' otherwise
// CDOmBitArray::TBit CDOmVeriNum::logicVal() const {
//   for(TUInt i = 0; i < getLen(); ++i)
//     switch(getBit(i)) {
//       case CDOmBitArray::_0: break;
//       case CDOmBitArray::_1: return CDOmBitArray::_1;
//       case CDOmBitArray::_Z:
//       case CDOmBitArray::_X: return CDOmBitArray::_X;
//     }
//   return CDOmBitArray::_0;
// }

// // Calculates the number of bits necessary to repressent the summ of 'this' and 'number'.
// // If carry is propagated returns TRUE and modifies the 'maxLen'
// TBool CDOmVeriNum::carryLookAhead(RefCDOmVeriNum number, TUInt &maxLen) {
//   ASSERT(number.get(), "[CDOmVeriNum::carryLookAhead()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::carryLookAhead()] 'number' should already be evaluated");

//   if(!isDefined() || !number->isDefined()) {
//     return FALSE;
//   }
//   CDOmBitArray::TBit C = CDOmBitArray::_0, A, B;
//   for(TUInt i = 0; i < maxLen; ++i) {
//     A = safeGetBit(i);
//     B = number->safeGetBit(i);
//     C = (CDOmBitArray::TBit)(A & B | (A | B) & C);
//   }
//   if(C == CDOmBitArray::_1) {
//     maxLen++;
//     return TRUE;
//   }
//   return FALSE;
// }

// TBool CDOmVeriNum::isDefined() const {
//   TUInt i;
 
//   for (i = 0; i < getLen(); i++) {
//     CDOmBitArray::TBit b = getBit(i); //m_bits->getBit()
//     if (b == CDOmBitArray::_X || b == CDOmBitArray::_Z)
//       return FALSE;
//   }
  
//   return TRUE;
// }

// TBool CDOmVeriNum::isZero() const {
//   TUInt i;

//   for(i = 0; i < getLen(); ++i)
//     if(getBit(i) != CDOmBitArray::_0) //m_bits->getBit()
//       return FALSE;

//   return TRUE; 
// }
 
// CDOmBitArray::TBit CDOmVeriNum::padBit(TPadType pad) const {
//   if (pad == PAD_ZERO)
//     return CDOmBitArray::_0;

//   CDOmBitArray::TBit b = getMsb();

//   if (b == CDOmBitArray::_1 && !isSigned())
//     return CDOmBitArray::_0;

//   return b;
// }
                               
// TUInt CDOmVeriNum::getLen() const {
//   ASSERT(m_bits.get(), "[CDOmVeriNum::getlen()] m_bits is null !");
//   return m_bits->getLen();
// }
 
// // Add 'this' number by 'number' and increase the width if necessary
// void CDOmVeriNum::addby(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::addby()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::addby()] 'number' should already be evaluated");

//   RefCDOmVeriNum veriNum;
//   switch(number->getNumType()) {
//     case CDOmNumber::NUM_VERILOG:
//       veriNum = CDOmVeriNum::cast(number);
//       break;
//     case CDOmNumber::NUM_INT32:
//       veriNum = CDOmVeriNum::build(m_lineNumber, number->getValue());
//       break;
//     default:
//       ASSERT(FAIL, "[CDOmVeriNum::addby()] not implemented yet for this number type!");
//   }
//   ASSERT(veriNum.get(), "[CDOmVeriNum::addby()] 'veriNum' should not be null at this point");
//   TPadType thisPad = PAD_ZERO, veriNumPad = PAD_ZERO;
  
//   if(isSigned() && getMsb() == CDOmBitArray::_1) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNum->isSigned() && veriNum->getMsb() == CDOmBitArray::_1) {
//     veriNumPad = PAD_SIGN;
//   }
//   TInt length = getLen();
//   TUInt maxLen = MAX(length, veriNum->getLen());
//   carryLookAhead(veriNum, maxLen);
//   if(maxLen > length) {
//     RefCDOmVeriNum temp = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, maxLen);
//     for(TInt i = 0; i < length; ++i) {
//       temp->setBit(i, getBit(i));//m_bits->getBit()
//     }
//     ASSERT(m_bits.get(), "[CDOmVeriNum::addby()] m_bits is null !");
//     m_bits->setLen(maxLen);
//     for(TUInt i = 0; i < maxLen; ++i) {
//       setBit(i, temp->safeGetBit(i)); //m_bits->setBit()
//     }
//   }
//   setSign(isSigned() || veriNum->isSigned());
//   TUInt i;
//   CDOmBitArray::TBit carry = CDOmBitArray::_0;
//   for(i = 0; i < maxLen; ++i) {
//     CDOmBitArray::TBit aBit = safeGetBit(i, thisPad);
//     CDOmBitArray::TBit bBit = veriNum->safeGetBit(i, veriNumPad);
//       setBit(i, add(aBit, bBit, carry)); //m_bits->setBit()
//   }
// }
          
// void CDOmVeriNum::setSign(TBool signFlag) {
//   m_isSigned = signFlag;
// }

// const TUInt CDOmVeriNum::getValueAsUInt() const {
//   if(getLen() == 0 || !isDefined()) {
//     return 0;
//   }

//   //if(isSigned()) {
//   //  std::cerr << "Line: " << getLineNumber() << " WARNING: conversion from signed to unsigned" << std::endl;
//   //}
//   TUInt res = 0;
//   TInt l = getLen();
//   const TInt sz = sizeof(TUInt) * 8;
//   if(l > sz) {
//     l = sz;
//     std::cerr << "WARNING: value can not be represented as TUInt, truncation!" << std::endl;
//   }
//   for(TInt i = 0; i < l; ++i) {
//     res |= (getBit(i)) << i;
//   }

//   return res;
// }

// // Returns the value as TInt
// const TInt CDOmVeriNum::getValue() const {
//   TInt l = getLen();
//   if (l == 0 || !isDefined()) {
//     return 0;
//   }

//   if (isSigned() && getBit(l - 1) == CDOmBitArray::_1) {
//     const TInt sz = sizeof(TUInt) * 8;
//     if (l > sz) {
//       l = sz;
//       std::cerr << "WARNING: value " << *getValueAsString() << " can not be represented as TInt, truncation!" << std::endl;
//     }
//     TInt res = -1;
//     TInt mask = ~1L;
//     TInt i;
//     for (i = 0; i < l; i++, mask = (mask << 1) | 1L) {
//       if (getBit(i) == CDOmBitArray::_0) {
//         res &= mask;
//       }
//     }
//     return res;
//   }
//   else {
//     return (TInt) getValueAsUInt();
//   }
// }

// // Returns the number's value in binary base as RefString
// RefString CDOmVeriNum::toString() const {
//   RefString res = RefString(new std::string(""));
//   std::string bit;

//   for(TInt i = getLen() - 1; i >= 0; --i) {
//     switch(safeGetBit(i)) {
//       case CDOmBitArray::_0: bit = "0";
//                break;
//       case CDOmBitArray::_1: bit = "1";
//                break;
//       case CDOmBitArray::_X: bit = "X";
//                break;
//       case CDOmBitArray::_Z: bit = "Z";
//                break;
//     }
//     res->append(bit);
//   }
//   return res;
// }


// RefString CDOmVeriNum::getValueAsString() const {
//   RefString res = RefString(new std::string(""));
//   RefString bitZ = RefString(new std::string("Z"));
//   RefString bitX = RefString(new std::string("X"));
//   switch(getNumBaseType()) {
//     case CDOmNumber::NUM_BASE_DEC:
//     //binary output
//     case CDOmNumber::NUM_BASE_BIN: 
//       {
//         std::string bit;

//         for(TInt i = getLen() - 1; i >= 0; --i) {
//           switch(safeGetBit(i)) {
//             case CDOmBitArray::_0: bit = "0";
//                      break;
//             case CDOmBitArray::_1: bit = "1";
//                      break;
//             case CDOmBitArray::_X: bit = "X";
//                      break;
//             case CDOmBitArray::_Z: bit = "Z";
//                      break;
//           }
//           res->append(bit);
//         }
//         break;
//       }
//       //hex output
//     case CDOmNumber::NUM_BASE_HEX:
//       {
//         std::string fourBits;
//         TInt length = getLen() + getLen() % 4;
//         RefCDOmVeriNum num = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, 4);
//         for(TInt i = length - 1; i >= 0; --i) {
//           num->setBit(i % 4, safeGetBit(i));
//           if(i % 4 == ZERO) {
//             TUInt numVal = num->getValueAsUInt();
//             if(num->isDefined() && numVal < HEX_VEC_LEN && numVal >= ZERO) {
//               res->append(*hexArr->at(num->getValueAsUInt()));
//             }
//             else if(!num->isDefined()) {
//               if(num->safeGetBit(i) == CDOmBitArray::_Z) {
//                 res->append(*bitZ);
//               }
//               else {
//                 res->append(*bitX);
//               }
//             }
//             else {
//               ASSERT(FAIL, "[CDOmVeriNum::getValueAsString()] conversion to string failed: numVal is out of range");
//             }
//           }
//         }
//         break;
//       }
//     case CDOmNumber::NUM_BASE_OCT:
//       {
//         std::string threeBits;
//         TInt length = getLen() + getLen() % 3;
//         RefCDOmVeriNum num = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, 3);
//         for(TInt i = length - 1; i >= 0; --i) {
//           num->setBit(i % 3, safeGetBit(i));
//           if(i % 3 == ZERO) {
//             TUInt numVal = num->getValueAsUInt();
//             if(num->isDefined() && numVal < HEX_VEC_LEN && numVal >= ZERO) {
//               res->append(*octArr->at(num->getValueAsUInt()));
//             }
//             else if(!num->isDefined()) {
//               if(num->safeGetBit(i) == CDOmBitArray::_Z) {
//                 res->append(*bitZ);
//               }
//               else {
//                 res->append(*bitX);
//               }
//             }
//             else {
//               ASSERT(FAIL, "[CDOmVeriNum::getValueAsString()] conversion to string failed: numVal is out of range");
//             }
//           }
//         }
//         break;
//       }
//   }
//   return res;
// }

// void CDOmVeriNum::setValue(TInt value) {
//   m_isSigned = (value < ZERO);
//   TInt width;
//   if(value != ZERO) {
//     //calculating the minimum number of bits required for representing the number 'value'
//     width = (TInt)(log(fabs(value))/log(2)) + 1;
//     if(value < ZERO && pow(2, width - 1) < fabs(value)) {
//       width++;
//     }
//   }
//   else {
//     width = 1;
//   }
//   if(width > getLen()) {
//     std::cerr << "WARNING: can't set the value " << value << ": bits lost (getLen() = " << getLen() << ", width = " << width << ")" << std::endl;
//   }
//   width = getLen();
//   for(TUInt i = 0; i < width; ++i, value >>= 1) {
//     setBit(i, (value & 1) ? CDOmBitArray::_1 : CDOmBitArray::_0); //m_bits->setBit()
//   }
// }

// RefCDOmVeriNum CDOmVeriNum::abs() {
//   if(isNeg()) {
//     return CDOmVeriNum::cast(minus());
//   }
//   return getThis();
// }

// void CDOmVeriNum::changeSign() {
//   if(!isSigned()) {
//     //TODO addErr
//     addErr(NSWarningErr::VEW_CDC_PARM_CANNOT_CHANGE_SIGN_NUM, args, m_lineNumber);
//     //std::cerr << "Line: " << getLineNumber() << " WARNING can't change sign for unsigned number!" << std::endl;
//   } 
//   else {
//     if(!isDefined() || isZero())
//       return;
//     RefCDOmVeriNum numThis = getThis();
//     numThis = CDOmVeriNum::cast(numThis->minus());
//     for(int i = 0; i < getLen(); ++i) {
//       setBit(i, numThis->safeGetBit(i));
//     }
//   }
// }

// TBool CDOmVeriNum::equals(TInt other) {
//   if(isNeg() && other > 0 || !isNeg() && other < 0) {
//     return FALSE;
//   }
//   RefCDOmVeriNum otherVeriNum = CDOmVeriNum::build(m_lineNumber, other);
//   TInt maxLen = MAX(getLen(), otherVeriNum->getLen());
//   for(TInt i = maxLen - 1; i >= 0; --i) {
//     if(safeGetBit(i) != otherVeriNum->safeGetBit(i)) {
//       return FALSE;
//     }
//   }

//   return TRUE;
// }

// TInt CDOmVeriNum::calcWidth() {
//   return getLen();
// }

// RefCDOmNumber CDOmVeriNum::maxValue() {
//   return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1, getLen());
// }

// RefCDOmNumber CDOmVeriNum::plus() {
//   if(!isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, getLen());
//   }
  
//   RefCDOmVeriNum plusThis;
//   plusThis = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, getLen());
//   plusThis->assign(getThis());
//   //plusThis = CDOmVeriNum::cast(plusThis->add(getThis()));
//   //plusThis->setSign(isSigned());

//   return plusThis;
// }

// RefCDOmNumber CDOmVeriNum::minus() {
//   if(!isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, getLen());
//   }

//   RefCDOmVeriNum one = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   RefCDOmVeriNum minusThis;
//   if(getMsb() == CDOmBitArray::_1 && !isSigned()) {
//     minusThis = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, getLen() + 1);
//   }
//   else {
//     minusThis = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, getLen());
//   }
//   minusThis = CDOmVeriNum::cast(minusThis->add(getThis()));
//   minusThis = CDOmVeriNum::cast(minusThis->bitwiseNot());
//   minusThis = CDOmVeriNum::cast(minusThis->add(one));
//   minusThis->setSign(TRUE);

//   return minusThis;
// }

// RefCDOmNumber CDOmVeriNum::logicNot() {
//   for(TInt i = 0; i < getLen(); ++i)
//     switch(getBit(i)) {
//       case CDOmBitArray::_0: break;
//       case CDOmBitArray::_1: return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, getLen());
//       case CDOmBitArray::_X:
//       case CDOmBitArray::_Z: return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, getLen());
//     }
//   return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1, getLen());
// }

// RefCDOmNumber CDOmVeriNum::bitwiseNot() {
//   RefCDOmVeriNum negVal = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, getLen());
//   for(TInt i = 0; i < negVal->getLen(); ++i) {
//     negVal->setBit(i, negBit(getBit(i)));
//   }

//   return negVal;
// }

// RefCDOmNumber CDOmVeriNum::reductionAnd() {
//   CDOmBitArray::TBit bit = CDOmBitArray::_1; 
//   for(TInt i = 0; i < getLen(); ++i) {
//     bit = andTBit(bit, getBit(i));
//   }

//   return CDOmVeriNum::build(m_lineNumber, bit);
// }

// RefCDOmNumber CDOmVeriNum::reductionNand() {
//   return reductionAnd()->logicNot();
// }

// RefCDOmNumber CDOmVeriNum::reductionOr() {
//   CDOmBitArray::TBit bit = CDOmBitArray::_0;
//   for(TInt i = 0; i < getLen(); ++i) {
//     bit = orTBit(bit, getBit(i));
//   }

//   return CDOmVeriNum::build(m_lineNumber, bit);
// }

// RefCDOmNumber CDOmVeriNum::reductionNor() {
//   return reductionOr()->logicNot();
// }

// RefCDOmNumber CDOmVeriNum::reductionXor() {
//   TInt i, c = 0;
//   for(i = 0; i < getLen(); ++i) {
//     CDOmBitArray::TBit bit = getBit(i);
//     if(!isDefined(bit)) {
//       return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X);
//     }
//     if(bit == CDOmBitArray::_1) {
//       ++c;
//     }
//   }
//   if(c % 2) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   }

//   return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
// }

// RefCDOmNumber CDOmVeriNum::reductionXnor() {
//   return reductionXor()->logicNot();
// }

// RefCDOmNumber CDOmVeriNum::add(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::add()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::add()] 'number' should already be evaluated");

//   RefCDOmVeriNum veriNum;
//   switch(number->getNumType()) {
//     case CDOmNumber::NUM_INT32:
//       veriNum = CDOmVeriNum::build(m_lineNumber, number->getValue());
//       break;
//     case CDOmNumber::NUM_VERILOG:
//       veriNum = CDOmVeriNum::cast(number);
//       break;
//     default:
//       ASSERT(FAIL, "[CDOmVeriNum::add()] not implemented yet for this number type");
//   }
//   ASSERT(veriNum.get(), "[CDOmVeriNum::add()] veriNum should not be null at this point");
  
//   TPadType thisPad = PAD_ZERO, veriNumPad = PAD_ZERO;
//   if(isSigned() && getMsb() == CDOmBitArray::_1) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNum->isSigned() && veriNum->getMsb() == CDOmBitArray::_1) {
//     veriNumPad = PAD_SIGN;
//   }
//   TUInt maxLen = MAX(getLen(), veriNum->getLen());
//   carryLookAhead(veriNum, maxLen);
//   RefCDOmVeriNum summ = build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   summ->setSign(isSigned() ||  veriNum->isSigned());
//   TUInt i;
//   CDOmBitArray::TBit carry = CDOmBitArray::_0;
//   for(i = 0; i < maxLen; ++i) {
//     CDOmBitArray::TBit aBit = safeGetBit(i, thisPad);
//     CDOmBitArray::TBit bBit = veriNum->safeGetBit(i, veriNumPad);
//     summ->setBit(i, add(aBit, bBit, carry)); 
//   }
  
//   return summ;
// }

// RefCDOmNumber CDOmVeriNum::substract(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::substract()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::substract()] 'number' should already be evaluated");

//   RefCDOmVeriNum veriNum;
//   switch(number->getNumType()) {
//     case CDOmNumber::NUM_INT32:
//       veriNum = CDOmVeriNum::build(m_lineNumber, number->getValue());
//       break;
//     case CDOmNumber::NUM_VERILOG:
//       veriNum = CDOmVeriNum::cast(number);
//       break;
//     default:
//       ASSERT(FAIL, "[CDOmVeriNum::substract()] not implemented yet for this number type!");
//   }
//   ASSERT(veriNum.get(), "[CDOmVeriNum::substract()] 'veriNum' should not be null at this point");
 
//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum res = CDOmVeriNum::cast(a->add(veriNum->minus()));
  
//   if(a->abs()->relationalLess(veriNum->abs())->equals(1)) {
//     res->setSign(TRUE);
//   }

//   return res;
// }

// RefCDOmNumber CDOmVeriNum::multiply(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::multiply()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::multiply()] 'number' should already be evaluated");
  
//   if(equals(0) || number->equals(0)) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
//   }

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TUInt maxLen = MAX(a->getLen(), b->getLen());
  
//   if(!a->isDefined() || !b->isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   }
  
//   RefCDOmVeriNum product = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, maxLen);
//   TBool resIsNeg = FALSE;
//   if(a->isSigned() && a->getMsb() == CDOmBitArray::_1) {
//     a = CDOmVeriNum::cast(a->minus());
//     resIsNeg = !resIsNeg;
//   }
  
//   if(b->isSigned() && b->getMsb() == CDOmBitArray::_1) {
//     b = CDOmVeriNum::cast(b->minus());
//     resIsNeg = !resIsNeg;
//   }
  
//   for(TUInt i = 0; i < b->getLen(); ++i) {
//     if(b->safeGetBit(i) == CDOmBitArray::_1) {
//       RefCDOmVeriNum _i = CDOmVeriNum::build(m_lineNumber, i);
//       product->addby(a->shiftLeft(_i));
//     }
//   }

//   if(resIsNeg) {
//     product = CDOmVeriNum::cast(product->minus());
//   }
  
//   return product;
// }


// RefCDOmNumber CDOmVeriNum::divide(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::divide()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::divide()] 'number' should already be evaluated");

//   RefCDOmVeriNum dividend = getThis();
//   RefCDOmVeriNum divisor = CDOmVeriNum::cast(number);
//   TInt maxLen = MAX(getLen(), divisor->getLen());
//   TBool resIsNeg = FALSE;
//   if(dividend->isNeg()) {
//     dividend = CDOmVeriNum::cast(dividend->minus());
//     resIsNeg = TRUE;
//   }
//   if(divisor->isNeg()) {
//     divisor = CDOmVeriNum::cast(divisor->minus());
//     resIsNeg = !resIsNeg;
//   }
  
//   if(divisor->isZero() || !dividend->isDefined() || !divisor->isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   }

//   if(dividend->relationalLess(divisor)->equals(1)) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, maxLen);
//   }

//   if(divisor->equality(dividend)->equals(1)) {
//     return CDOmVeriNum::build(m_lineNumber, 1, maxLen);
//   }

//   RefCDOmVeriNum quotient = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, maxLen);
//   RefCDOmVeriNum remainder = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, maxLen);
//   TInt nBits = maxLen;
//   CDOmBitArray::TBit bit, q;
//   RefCDOmVeriNum d, r, one = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
  
//   while(remainder->relationalLess(divisor)->equals(1)) {
//     bit = dividend->getMsb();
//     r = remainder;
//     remainder = CDOmVeriNum::cast(remainder->binaryShiftLeft(one));
//     remainder->setBit(0, orTBit(remainder->safeGetBit(0), bit));
//     d = dividend;
//     dividend = CDOmVeriNum::cast(dividend->binaryShiftLeft(one));
//     --nBits;
//   }
//   dividend = d;
//   remainder = r;
//   ++nBits;

//   TInt i;
//   RefCDOmVeriNum t;
//   for(i = 0; i < nBits; ++i) {
//     bit = dividend->getMsb();
//     remainder = CDOmVeriNum::cast(remainder->binaryShiftLeft(one));
//     remainder->setBit(0, orTBit(remainder->safeGetBit(0), bit));
//     t = CDOmVeriNum::cast(remainder->substract(divisor));
//     q = negBit(t->getMsb());
//     dividend = CDOmVeriNum::cast(dividend->binaryShiftLeft(one));
//     quotient = CDOmVeriNum::cast(quotient->binaryShiftLeft(one));
//     quotient->setBit(0, orTBit(quotient->safeGetBit(0), q));
//     if(q == CDOmBitArray::_1) {
//       remainder = t;
//     }
//   }
//   if(resIsNeg) {
//     quotient = CDOmVeriNum::cast(quotient->minus());
//   }

//   return quotient;
// }

// RefCDOmNumber CDOmVeriNum::modulo(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::modulo()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::modulo()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TInt maxLen = MAX(a->getLen(), b->getLen());
//   TBool resIsNeg = FALSE;
  
//   if(b->isZero() || !b->isDefined() || !a->isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   }
  
//   if(a->isNeg()) {
//     a = CDOmVeriNum::cast(a->minus());
//     resIsNeg = TRUE;                     //The result of a modulo operation shall take the sign of the first operand
//   }
//   if(b->isNeg()) {
//     b = CDOmVeriNum::cast(b->minus());
//   }

//   if(a->relationalLess(b)->equals(1)) {
//     return a;
//   }

//   // A % B = A - (A DIV B) * B
//   RefCDOmNumber res;
//   res = a->divide(b)->multiply(b);
//   res = a->substract(res);
//   if(resIsNeg) {
//     res = res->minus();
//   }

//   return res;
// }

// RefCDOmNumber CDOmVeriNum::power(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::power()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::power()] 'number' should already be evaluated");

//   RefCDOmVeriNum exp;
//   switch(number->getNumType()) {
//     case CDOmNumber::NUM_INT32: 
//       exp = CDOmVeriNum::build(m_lineNumber, number->getValue());
//       break;
//     case CDOmNumber::NUM_VERILOG: 
//       exp = CDOmVeriNum::cast(number);
//       break;
//     default:
//       ASSERT(FAIL, "[CDOmVeriNum::power()] not implemented yet for this number type");
//   }
//   ASSERT(exp.get(), "[CDOmVeriNum::power()] exp should not be null at this point");

//   RefCDOmVeriNum veriNum = getThis();
//   if(veriNum->equals(1) || exp->equals(0)) {
//     return CDOmVeriNum::build(m_lineNumber, 1);
//   }

//   if(!veriNum->isDefined() || !exp->isDefined() || veriNum->equals(0) && exp->isNeg()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X);
//   }

//   RefCDOmVeriNum one = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   RefCDOmVeriNum minusOne = CDOmVeriNum::build(m_lineNumber, -1, 2);
//   if(veriNum->equals(0) || exp->isNeg() && (veriNum->relationalLess(minusOne)->equals(1) || veriNum->relationalGreater(one)->equals(1))) {
//     return CDOmVeriNum::build(m_lineNumber, 0);
//   }

//   if(veriNum->equals(-1)) {
//     if(exp->isEven()) {
//       return CDOmVeriNum::build(m_lineNumber, 1);
//     }
//     else {
//       return CDOmVeriNum::build(m_lineNumber, -1);
//     }
//   }

//   if(veriNum->equals(2)) {
//     return veriNum->shiftLeft(exp)->shiftRight(one);
//   }

//   RefCDOmVeriNum i = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   RefCDOmNumber result = veriNum;
//   while(i->relationalLess(exp)->equals(1)) {
//     result = result->multiply(veriNum);
//     i->addby(one);
//   }

//   return result;
// }

// RefCDOmNumber CDOmVeriNum::shiftLeft(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::shiftLeft()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::shiftLeft()] 'number' should be already evaluated");
//   ASSERT(number->getValue() >= 0, "[CDOmVeriNum::shiftLeft()] 'number' should be positive");
  
//   TUInt length = number->getValue();
//   TUInt width = length + getLen();
//   RefCDOmVeriNum result = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, width);
//   result->setSign(isSigned());
//   for(TInt i = 0; i < getLen(); ++i) {
//     result->setBit(i + length, getBit(i));
//   }
  
//   return result;
// }

// RefCDOmNumber CDOmVeriNum::shiftRight(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::shiftRight()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::shiftRight()] 'number' should be already evaluated");
//   ASSERT(number->getValue() >= 0, "[CDOmVeriNum::shiftRight()] 'number' should be positive");
  
//   TUInt length = number->getValue();
//   TUInt width = getLen();
//   RefCDOmVeriNum result;
//   if(isNeg()) {
//     result = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1, width);
//   }
//   else {
//     result = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, width);
//   }
  
//   result->setSign(isSigned());
//   TInt diff = width - length;
//   for(TInt i = 0; i < diff; ++i) {
//     result->setBit(i, getBit(i + length)); //m_bits->getBit()
//   }
  
//   return result;
// }

// RefCDOmNumber CDOmVeriNum::equality(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::equality()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::equality()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TUInt maxLen = MAX(a->getLen(), b->getLen());
  
//   if(!a->isDefined() || !b->isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   }

//   if(a->isNeg() && !b->isNeg() || !a->isNeg() && b->isNeg()) {
//     return CDOmVeriNum::build(m_lineNumber, ZERO);
//   }

//   for(TInt i = maxLen - 1; i >= 0; --i) {
//     if(a->safeGetBit(i) != b->safeGetBit(i)) {
//       return CDOmVeriNum::build(m_lineNumber, ZERO);
//     }
//   }

//   return CDOmVeriNum::build(m_lineNumber, ONE);
// }

// RefCDOmNumber CDOmVeriNum::notEquality(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::notEquality()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::notEquality()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TUInt maxLen = MAX(a->getLen(), b->getLen());
  
//   if(!a->isDefined() || !b->isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   }

//   if(a->isNeg() && !b->isNeg() || !a->isNeg() && b->isNeg()) {
//     return CDOmVeriNum::build(m_lineNumber, ONE);
//   }

//   for(TInt i = maxLen - 1; i >= 0; --i) {
//     if(a->safeGetBit(i) != b->safeGetBit(i)) {
//       return CDOmVeriNum::build(m_lineNumber, ONE);
//     }
//   }

//   return CDOmVeriNum::build(m_lineNumber, ZERO);
// }

// RefCDOmNumber CDOmVeriNum::equalityEqualCase(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::equalityEqualCase()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::equalityEqualCase()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TUInt maxLen = MAX(a->getLen(), b->getLen());
  
//   if(a->isNeg() && !b->isNeg() || !a->isNeg() && b->isNeg()) {
//     return CDOmVeriNum::build(m_lineNumber, ZERO);
//   }

//   for(TInt i = maxLen - 1; i >= 0; --i) {
//     if(a->safeGetBit(i) != b->safeGetBit(i)) {
//       return CDOmVeriNum::build(m_lineNumber, ZERO);
//     }
//   }

//   return CDOmVeriNum::build(m_lineNumber, ONE);
// }

// RefCDOmNumber CDOmVeriNum::equalityNotEqualCase(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::equalityNotEqualCase()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::equalityNotEqualCase()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TUInt maxLen = MAX(a->getLen(), b->getLen());
  
//   if(a->isNeg() && !b->isNeg() || !a->isNeg() && b->isNeg()) {
//     return CDOmVeriNum::build(m_lineNumber, ONE);
//   }

//   for(TInt i = maxLen - 1; i >= 0; --i) {
//     if(a->safeGetBit(i) != b->safeGetBit(i)) {
//       return CDOmVeriNum::build(m_lineNumber, ONE);
//     }
//   }

//   return CDOmVeriNum::build(m_lineNumber, ZERO);
// }

// RefCDOmNumber CDOmVeriNum::logicAnd(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::logicAnd()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::logicAnd()] 'number' should already be evaluated");
 
//   CDOmBitArray::TBit bit = andTBit(logicVal(), CDOmVeriNum::cast(number)->logicVal());  

//   return CDOmVeriNum::build(m_lineNumber, bit);
// }

// RefCDOmNumber CDOmVeriNum::logicOr(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::logicOr()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::logicOr()] 'number' should already be evaluated");
  
//   CDOmBitArray::TBit bit = orTBit(logicVal(), CDOmVeriNum::cast(number)->logicVal());  

//   return CDOmVeriNum::build(m_lineNumber, bit);
// }

// RefCDOmNumber CDOmVeriNum::relationalLess(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::relationalLess()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::relationalLess()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TUInt maxLen = MAX(a->getLen(), b->getLen());
  
//   if(!a->isDefined() || !b->isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   }
  
//   if(a->isNeg() && (b->isZero() || !b->isNeg())) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   }

//   if(b->isNeg() && (a->isZero() || !a->isNeg())) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
//   }

//   for(TInt i = maxLen - 1; i >= 0; --i) {
//     CDOmBitArray::TBit aBit = a->safeGetBit(i);
//     CDOmBitArray::TBit bBit = b->safeGetBit(i);

//     if(aBit == CDOmBitArray::_0 && bBit == CDOmBitArray::_1) {
//       return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//     }
//     if(aBit == CDOmBitArray::_1 && bBit == CDOmBitArray::_0) {
//       return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
//     }
//   }
//   //numbers are equal
//   return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
// }

// RefCDOmNumber CDOmVeriNum::relationalLessEqual(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::relationalLessEqual()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::relationalLessEqual()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum aux = CDOmVeriNum::cast(a->relationalLess(number));
  
//   if(!aux->isDefined()) {
//     return aux;
//   }
 
//   if(aux->equals(1) || a->equality(number)->equals(1)) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   }
  
//   return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
// }

// RefCDOmNumber CDOmVeriNum::relationalGreater(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::relationalGreater()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::relationalGreater()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum b = CDOmVeriNum::cast(number);
//   TUInt maxLen = MAX(a->getLen(), b->getLen());
  
//   if(!a->isDefined() || !b->isDefined()) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   }
  
//   if(a->isNeg() && (b->isZero() || !b->isNeg())) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
//   }

//   if(b->isNeg() && (a->isZero() || !a->isNeg())) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   }

//   for(TInt i = maxLen - 1; i >= 0; --i) {
//     CDOmBitArray::TBit aBit = a->safeGetBit(i);
//     CDOmBitArray::TBit bBit = b->safeGetBit(i);

//     if(aBit == CDOmBitArray::_0 && bBit == CDOmBitArray::_1) {
//       return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
//     }
//     if(aBit == CDOmBitArray::_1 && bBit == CDOmBitArray::_0) {
//       return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//     }
//   }
 
//   //numbers are equal 
//   return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
// }

// RefCDOmNumber CDOmVeriNum::relationalGreaterEqual(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::relationalGreaterEqual()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::relationalGreaterEqual()] 'number' should already be evaluated");

//   RefCDOmVeriNum a = getThis();
//   RefCDOmVeriNum aux = CDOmVeriNum::cast(a->relationalGreater(number));
  
//   if(!aux->isDefined()) {
//     return aux;
//   }
 
//   if(aux->equals(1) || a->equality(number)->equals(1)) {
//     return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_1);
//   }
  
//   return CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0);
// }

// RefCDOmNumber CDOmVeriNum::bitwiseAnd(RefCDOmNumber mask) {
//   ASSERT(mask.get(), "[CDOmVeriNum::bitwiseAnd()] null pointer received");
//   ASSERT(mask->isEvaluated(), "[CDOmVeriNum::bitwiseAnd()] 'number' should already be evaluated");
  
//   RefCDOmVeriNum veriNumMask = CDOmVeriNum::cast(mask);
//   TUInt maxLen = MAX(getLen(), veriNumMask->getLen());
//   RefCDOmVeriNum res = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   TPadType thisPad = PAD_ZERO, maskPad = PAD_ZERO;
//   if(isNeg()) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNumMask->isNeg()) {
//     maskPad = PAD_SIGN;
//   }
  
//   for(TUInt i = 0; i < maxLen; ++i) {
//     res->setBit(i, andTBit(safeGetBit(i, thisPad), veriNumMask->safeGetBit(i, maskPad)));
//   }

//   return res;
// }

// RefCDOmNumber CDOmVeriNum::bitwiseNand(RefCDOmNumber mask) {
//   ASSERT(mask.get(), "[CDOmVeriNum::bitwiseNand()] null pointer received");
//   ASSERT(mask->isEvaluated(), "[CDOmVeriNum::bitwiseNand()] 'number' should already be evaluated");
  
//   RefCDOmVeriNum veriNumMask = CDOmVeriNum::cast(mask);
//   TUInt maxLen = MAX(getLen(), veriNumMask->getLen());
//   RefCDOmVeriNum res = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   TPadType thisPad = PAD_ZERO, maskPad = PAD_ZERO;
//   if(isNeg()) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNumMask->isNeg()) {
//     maskPad = PAD_SIGN;
//   }

//   for(TUInt i = 0; i < maxLen; ++i) {
//     res->setBit(i, negBit(andTBit(safeGetBit(i, thisPad), veriNumMask->safeGetBit(i, maskPad))));
//   }

//   return res;
// }

// RefCDOmNumber CDOmVeriNum::bitwiseOr(RefCDOmNumber mask) {
//   ASSERT(mask.get(), "[CDOmVeriNum::bitwiseOr()] null pointer received");
//   ASSERT(mask->isEvaluated(), "[CDOmVeriNum::bitwiseOr()] 'number' should already be evaluated");

//   RefCDOmVeriNum veriNumMask = CDOmVeriNum::cast(mask);
//   TUInt maxLen = MAX(getLen(), veriNumMask->getLen());
//   RefCDOmVeriNum res = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   TPadType thisPad = PAD_ZERO, maskPad = PAD_ZERO;
//   if(isSigned() && getMsb() == CDOmBitArray::_1) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNumMask->isSigned() && veriNumMask->getMsb() == CDOmBitArray::_1) {
//     maskPad = PAD_SIGN;
//   }
//   for(TUInt i = 0; i < maxLen; ++i) {
//     res->setBit(i, orTBit(safeGetBit(i, thisPad), veriNumMask->safeGetBit(i, maskPad)));
//   }

//   return res;
// }


// RefCDOmNumber CDOmVeriNum::bitwiseNor(RefCDOmNumber mask) {
//   ASSERT(mask.get(), "[CDOmVeriNum::bitwiseNor()] null pointer received");
//   ASSERT(mask->isEvaluated(), "[CDOmVeriNum::bitwiseNor()] 'number' should already be evaluated");

//   RefCDOmVeriNum veriNumMask = CDOmVeriNum::cast(mask);
//   TUInt maxLen = MAX(getLen(), veriNumMask->getLen());
//   RefCDOmVeriNum res = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   TPadType thisPad = PAD_ZERO, maskPad = PAD_ZERO;
//   if(isSigned() && getMsb() == CDOmBitArray::_1) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNumMask->isSigned() && veriNumMask->getMsb() == CDOmBitArray::_1) {
//     maskPad = PAD_SIGN;
//   }
//   for(TUInt i = 0; i < maxLen; ++i) {
//     res->setBit(i, negBit(orTBit(safeGetBit(i, thisPad), veriNumMask->safeGetBit(i, maskPad))));
//   }

//   return res;
// }



// RefCDOmNumber CDOmVeriNum::bitwiseXor(RefCDOmNumber mask) {
//   ASSERT(mask.get(), "[CDOmVeriNum::bitwiseXor()] null pointer received");
//   ASSERT(mask->isEvaluated(), "[CDOmVeriNum::bitwiseXor()] 'number' should already be evaluated");

//   RefCDOmVeriNum veriNumMask = CDOmVeriNum::cast(mask);
//   TUInt maxLen = MAX(getLen(), veriNumMask->getLen());
//   RefCDOmVeriNum res = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   TPadType thisPad = PAD_ZERO, maskPad = PAD_ZERO;
//   if(isNeg()) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNumMask->isNeg()) {
//     maskPad = PAD_SIGN;
//   }

//   for(TUInt i = 0; i < maxLen; ++i) {
//     res->setBit(i, xorTBit(safeGetBit(i, thisPad), veriNumMask->safeGetBit(i, maskPad)));
//   }

//   return res;
// }
 

// RefCDOmNumber CDOmVeriNum::bitwiseXnor(RefCDOmNumber mask) {
//   ASSERT(mask.get(), "[CDOmVeriNum::bitwiseXnor()] null pointer received");
//   ASSERT(mask->isEvaluated(), "[CDOmVeriNum::bitwiseXnor()] 'number' should already be evaluated");

//   RefCDOmVeriNum veriNumMask = CDOmVeriNum::cast(mask);
//   TUInt maxLen = MAX(getLen(), veriNumMask->getLen());
//   RefCDOmVeriNum res = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//   TPadType thisPad = PAD_ZERO, maskPad = PAD_ZERO;
//   if(isNeg()) {
//     thisPad = PAD_SIGN;
//   }
//   if(veriNumMask->isNeg()) {
//     maskPad = PAD_SIGN;
//   }

//   for(TUInt i = 0; i < maxLen; ++i) {
//     res->setBit(i, negBit(xorTBit(safeGetBit(i, thisPad), veriNumMask->safeGetBit(i, maskPad))));
//   }

//   return res;
// }

// RefCDOmNumber CDOmVeriNum::binaryShiftLeft(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::binaryShiftLeft()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::binaryShiftLeft()] number should already be evaluated");
//   ASSERT(number->getValue() >= 0, "[CDOmVeriNum::binaryShiftLeft()] number should be positive");
  
//   TUInt length = number->getValue();
//   TUInt width = getLen();
//   RefCDOmVeriNum result = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, width);
  
//   for(TInt i = length; i < width; ++i)
//     result->setBit(i, getBit(i - length)); //m_bits->getBit()

  
//   return result;
// }

// RefCDOmNumber CDOmVeriNum::binaryShiftRight(RefCDOmNumber number) {
//   ASSERT(number.get(), "[CDOmVeriNum::binaryShiftRight()] null pointer received");
//   ASSERT(number->isEvaluated(), "[CDOmVeriNum::binaryShiftRight()] number should be already evaluated");
//   ASSERT(number->getValue() >= 0, "[CDOmVeriNum::binaryShiftRight()] number should be positive");
  
//   TUInt length = number->getValue();
//   TUInt width = getLen();
//   RefCDOmVeriNum result;
//   result = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_0, width);

//   TInt diff = width - length;
//   for(TInt i = 0; i < diff; ++i) {
//     result->setBit(i, getBit(i + length)); //m_bits->getBit()

//   }
  
//   return result;
// }

// RefCDOmNumber CDOmVeriNum::ternaryCondition(RefCDOmNumber number1, RefCDOmNumber number2) {
//   ASSERT(number1.get(), "[CDOmVeriNum::ternaryCondition()] null pointer received");
//   ASSERT(number1->isEvaluated(), "[CDOmVeriNum::ternaryCondition()] 'number1' should already be evaluated");
//   ASSERT(number2.get(), "[CDOmVeriNum::ternaryCondition()] null pointer received");
//   ASSERT(number2->isEvaluated(), "[CDOmVeriNum::ternaryCondition()] 'number2' should already be evaluated");

//   if(logicVal() == CDOmBitArray::_1) {
//     switch(number1->getNumType()) {
//       case CDOmNumber::NUM_INT32:
//         return CDOmNum32::build(m_lineNumber, number1->getValue());
//         break;
//       case CDOmNumber::NUM_VERILOG: 
//         {
//           RefCDOmVeriNum vnum1 = CDOmVeriNum::cast(number1);
//           return CDOmVeriNum::build(m_lineNumber, vnum1->logicVal()); 
//           break;
//         }
//       default:   ASSERT(FAIL, "[CDOmVeriNum::ternaryCondition()] not implemented yet for this number type");
//     }
//   } else if(logicVal() == CDOmBitArray::_0) {
//     switch(number1->getNumType()) {
//       case CDOmNumber::NUM_INT32:
//         return CDOmNum32::build(m_lineNumber, number2->getValue());
//         break;
//       case CDOmVeriNum::NUM_VERILOG: 
//         {
//           RefCDOmVeriNum vnum2 = CDOmVeriNum::cast(number2);
//           return CDOmVeriNum::build(m_lineNumber, vnum2->logicVal());
//           break;
//         }
//       default:   ASSERT(FAIL, "[CDOmVeriNum::ternaryCondition()] not implemented yet");
//     }
//   }
//   else {
//     RefCDOmVeriNum vnum1, vnum2, res;
//     TInt maxLen;
//     switch(number1->getNumType()) {
//       case CDOmNumber::NUM_INT32:
//         vnum1 = CDOmVeriNum::build(m_lineNumber, number1->getValue());
//         break;
//       case CDOmNumber::NUM_VERILOG:
//         vnum1 = CDOmVeriNum::cast(number1);
//         break;
//       default:
//         ASSERT(FAIL, "[CDOmVeriNum::ternaryCondition()] not implemented yet for this number type!");
//     }
    
//     switch(number2->getNumType()) {
//       case CDOmNumber::NUM_INT32:
//         vnum2 = CDOmVeriNum::build(m_lineNumber, number2->getValue());
//         break;
//       case CDOmNumber::NUM_VERILOG:
//         vnum2 = CDOmVeriNum::cast(number2);
//         break;
//       default:
//         ASSERT(FAIL, "[CDOmVeriNum::ternaryCondition()] not implemented yet for this number type!");
//     }
    
//     maxLen = MAX(vnum1->getLen(), vnum2->getLen());
//     res = CDOmVeriNum::build(m_lineNumber, CDOmBitArray::_X, maxLen);
//     for(TUInt i = 0; i < maxLen; ++i) {
//       CDOmBitArray::TBit a = vnum1->safeGetBit(i, PAD_ZERO);
//       CDOmBitArray::TBit b = vnum2->safeGetBit(i, PAD_ZERO);
//       res->setBit(i, combine(a, b));
//     }
//     return res;
//   }
// }

// // combine operation is used in "a ? b : c" operation, when "a" is undefined
// // (X or Z). then values of "b" and "c" are combined.
// CDOmBitArray::TBit CDOmVeriNum::combine(CDOmBitArray::TBit a, CDOmBitArray::TBit b) {
//   static CDOmBitArray::TBit tbl[4][4] =
//   {
//     { CDOmBitArray::_0, CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_X, CDOmBitArray::_1, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X }
//   };

//   return tbl[a][b];
// }

// TBool CDOmVeriNum::isDefined(CDOmBitArray::TBit bit) {
//   switch(bit) {
//     case CDOmBitArray::_0:
//     case CDOmBitArray::_1: break;
//     case CDOmBitArray::_X:
//     case CDOmBitArray::_Z: return FALSE;
//   }
  
//   return TRUE;
// }

// CDOmBitArray::TBit CDOmVeriNum::add(CDOmBitArray::TBit a, CDOmBitArray::TBit b, CDOmBitArray::TBit& carry) {
//     if (!isDefined(a) || !isDefined(b) || !isDefined(carry)) {
//       return (carry = CDOmBitArray::_X);
//     }

//     CDOmBitArray::TBit tmp = carry;
//     if (a == CDOmBitArray::_0 && b == CDOmBitArray::_0) {
//       carry = CDOmBitArray::_0;
//       return tmp;
//     }
//     else if ((a == CDOmBitArray::_0) && (b == CDOmBitArray::_1) || (a == CDOmBitArray::_1) && (b == CDOmBitArray::_0)) {
//       if (carry == CDOmBitArray::_0) {
//         return CDOmBitArray::_1;
//       }
//       else {
//         return CDOmBitArray::_0;
//       }
//     }
//     else {
//       carry = CDOmBitArray::_1;
//       return tmp;
//     }
// }
  


// CDOmBitArray::TBit CDOmVeriNum::negBit(CDOmBitArray::TBit bit) {
//   CDOmBitArray::TBit bitTable[4] = { CDOmBitArray::_1, CDOmBitArray::_0, CDOmBitArray::_X, CDOmBitArray::_X };
  
//   return bitTable[bit];
// }


// CDOmBitArray::TBit CDOmVeriNum::andTBit(CDOmBitArray::TBit a, CDOmBitArray::TBit b) {
//   CDOmBitArray::TBit bitTable[4][4] = {
//     { CDOmBitArray::_0, CDOmBitArray::_0, CDOmBitArray::_0, CDOmBitArray::_0 },
//     { CDOmBitArray::_0, CDOmBitArray::_1, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_0, CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_0, CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X }
//   };
  
//   return bitTable[a][b];     
// }


// CDOmBitArray::TBit CDOmVeriNum::orTBit(CDOmBitArray::TBit a, CDOmBitArray::TBit b) {
//   CDOmBitArray::TBit bitTable[4][4] = {
//     { CDOmBitArray::_0, CDOmBitArray::_1, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_1, CDOmBitArray::_1, CDOmBitArray::_1, CDOmBitArray::_1 },
//     { CDOmBitArray::_X, CDOmBitArray::_1, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_X, CDOmBitArray::_1, CDOmBitArray::_X, CDOmBitArray::_X }
//   };
  
//   return bitTable[a][b];     
// }


// CDOmBitArray::TBit CDOmVeriNum::xorTBit(CDOmBitArray::TBit a, CDOmBitArray::TBit b) {
//   CDOmBitArray::TBit bitTable[4][4] = {
//     { CDOmBitArray::_0, CDOmBitArray::_1, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_1, CDOmBitArray::_0, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X },
//     { CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X, CDOmBitArray::_X }
//   };
  
//   return bitTable[a][b];     
// }



// void CDOmVeriNum::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
// //  visitor.visit(getThis());
// }


// // ********************************************************************************
// // CDOmBitArray class
// // ********************************************************************************

// CDOmBitArray::CDOmBitArray(TLineNumberType lineNumber) : CDOmBase(TYPE_BIT_ARRAY, lineNumber) {
//   m_len = 0;
//   m_blockCount = 0;
//   m_blocks = RefTVec_TUInt(); 
// }


// CDOmBitArray::CDOmBitArray(TLineNumberType lineNumber, TUInt len) : CDOmBase(TYPE_BIT_ARRAY, lineNumber) {
//   m_len = 0;
//   m_blockCount = 0;
//   m_blocks = RefTVec_TUInt();
// }


// CDOmBitArray::CDOmBitArray(TLineNumberType lineNumber, const RefCDOmBitArray other) : CDOmBase(TYPE_BIT_ARRAY, lineNumber) {
//   m_len = 0;
//   m_blockCount = 0;
//   m_blocks = RefTVec_TUInt();
// }


// RefCDOmBitArray CDOmBitArray::cast(RefCDOmBase object) {
//   if(!object.get()) {
//      return RefCDOmBitArray();
//   }
//   ASSERT(object->getType() == TYPE_BIT_ARRAY , "[CDOmBitArray::cast()] type check on cast failure");
//   return boost::static_pointer_cast<CDOmBitArray>(object);
// }


// RefCDOmBitArray CDOmBitArray::build(TLineNumberType lineNumber) {
//   CDOmBitArray* bitArray;
//   try {
//     bitArray = new CDOmBitArray(lineNumber);
//   }
//   catch(std::exception &e) {
//     ASSERT(FAIL, "[CDOmBitArray::build()] new operator failed");
//   }
//   RefCDOmBitArray refBitArray = RefCDOmBitArray(bitArray);
//   refBitArray->m_weakRef = boost::weak_ptr<CDOmBase>( refBitArray);
//   //refBitArry->setIsEvaluated(TRUE);

//   return refBitArray;
// }


// RefCDOmBitArray CDOmBitArray::build(TLineNumberType lineNumber, TUInt len) {
//   CDOmBitArray* bitArray;
//   try {
//     bitArray = new CDOmBitArray(lineNumber, len);
//   }
//   catch(std::exception &e) {
//     ASSERT(FAIL, "[CDOmBitArray::build()] new operator failed");
//   }
//   RefCDOmBitArray refBitArray = RefCDOmBitArray(bitArray);
//   refBitArray->m_weakRef = boost::weak_ptr<CDOmBase>( refBitArray);
//   //refBitArry->setIsEvaluated(TRUE);
//   refBitArray->setLen(len);

//   return refBitArray;
// }


// RefCDOmBitArray CDOmBitArray::build(TLineNumberType lineNumber, const RefCDOmBitArray other) {
//   ASSERT(other.get(), "[CDOmBitArray::build()] null poiter received");
  
//   CDOmBitArray* bitArray;
//   try {
//     bitArray = new CDOmBitArray(lineNumber, other->getLen());
//   }
//   catch(std::exception &e) {
//     ASSERT(FAIL, "[CDOmBitArray::build()] new operator failed");
//   }
//   RefCDOmBitArray refBitArray = RefCDOmBitArray(bitArray);
//   refBitArray->m_weakRef = boost::weak_ptr<CDOmBase>( refBitArray);
//   //refBitArry->setIsEvaluated(TRUE);
//   refBitArray->setLen(other->getLen());

//   for(TUInt i = 0; i < refBitArray->getLen(); ++i) {
//     refBitArray->setBit(i, other->getBit(i));
//   }

//   return refBitArray;
// }


// void CDOmBitArray::bitPos(TInt bitIndex, TInt& blkNum, TInt& blkOffset) {
//   blkNum = bitIndex / (blockSize / 2);
//   blkOffset = bitIndex % (blockSize / 2);
// }


// TBool CDOmBitArray::validateIndex(TUInt index) const {
//   if (index < 0 || index >= getLen()) {
//     addErr(NSWarningErr::VHE_CDC_NUM_TOO_MANY_DIGITS_IN_SIZED_NUM_CDCVH, args, m_lineNumber);
//     cdomHasErrors = TRUE;
//     return FALSE;
//     //throw NSBase::IllegalArgumentException("[CDOmBitArray::validateIndex()] - Index out of range");
//   }
//   return TRUE;
// }

// void CDOmBitArray::setLen(TUInt l) {
//   m_blockCount = 0;
//   m_len = 0;
//   if (l > 0) {
//     TInt bc = (l / (sizeof(TUInt) * 8 / 2)) + 1;
//     m_blocks = RefTVec_TUInt(new TVec_TUInt());
//     for(TInt i = 0; i < bc; ++i) {
//       m_blocks->push_back(0);
//     }
//     m_len = l;
//     m_blockCount = bc;
//   }
// }

// void CDOmBitArray::setBit(TInt index, TBit b) {
//   if(validateIndex(index)) {
//     TInt blkNum;
//     TInt blkOffset;
//     bitPos(index, blkNum, blkOffset);
//     m_blocks->at(blkNum) = m_blocks->at(blkNum) &
//       ~(((TUInt)3) << (blkOffset * 2))
//       | ((TUInt)b << (blkOffset * 2));
//   }
// }

// CDOmBitArray::TBit CDOmBitArray::getBit(TInt index) const {
//   if(validateIndex(index)) {
//     TInt blkNum;
//     TInt blkOffset;
//     bitPos(index, blkNum, blkOffset);
//     return (TBit)((m_blocks->at(blkNum) & (((TUInt)3) << (blkOffset * 2)))
//         >> (blkOffset * 2));
//   }
// }
//~Tb removed//

//added by Tb
// ********************************************************************************
// CDOmVeriNum class
// ********************************************************************************
/**
 * Most of the code in the constructor should be moved to the build function, but since the code is working
 * as it is, this matter should be taken in consideration later on...
 */
CDOmVeriNum::CDOmVeriNum(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TBool isSigned, TInt width)
  : CDOmNumber(lineNumber, NUM_VERILOG, numBaseType),
    m_sign(VERINUM_POS),
    m_blocks(new TVec_TUInt) {

  ASSERT(((numBaseType > NUM_BASE_UNDEFINED) && (numBaseType < NUM_BASE_MAX)), "Invalid radix");
  ASSERT(lightString.get(), "NULL string received");
  ASSERT(!lightString->empty(), "Empty string received");
  ASSERT(width > 0, "Invalid size(<=0)");
  //the m_hasXZ is FALSE as received form CDOmNumber class
  //ASSERT(m_hasXZ, "The number has no X or Z bits");

  setIsSigned(isSigned);
  setWidth(width);

  TUInt strLen = lightString->size();
  EVeriNumRatio ratio;

  if (numBaseType == NUM_BASE_BIN) {
    if (width < strLen) {
      //TODO: add warning message
      DCERR("Width smaller than the number representation(BIN)\n");
    }

    ratio = VERINUM_BIN_TO_BIN_RATIO;
  }
  else if (numBaseType == NUM_BASE_OCT) {
    if (width < (strLen * VERINUM_OCT_TO_BIN_RATIO)) {
      //TODO: add warning message
      DCERR("Width smaller than the number representation(OCT)\n");
    }

    ratio = VERINUM_OCT_TO_BIN_RATIO;
  }
  else if (numBaseType == NUM_BASE_HEX) {
    if (width < (strLen * VERINUM_HEX_TO_BIN_RATIO)) {
      //TODO: add warning message
      DCERR("Width smaller than the number representation(HEX)\n");
    }

    ratio = VERINUM_HEX_TO_BIN_RATIO;
  }

  TUInt currentPosition = 0;
  TUInt currentDigit;
  EVeriNumBit veriNumBit;

  for (int i = strLen - 1; i >= 0; i--) {
    currentDigit = toDec(lightString->at(i));

    for (int j = 0; j < ratio; j++) {
      if (currentDigit == VERINUM_DEC_Z) {
        veriNumBit = _Z;
      }
      else if (currentDigit == VERINUM_DEC_X) {
        veriNumBit = _X;
      }
      else {
        veriNumBit = static_cast<EVeriNumBit>(currentDigit % VERINUM_BIT_SIZE);
        currentDigit /= VERINUM_BIT_SIZE;
      }

      setBitAt(currentPosition++, veriNumBit);
      if (currentPosition == m_width) {
        j = ratio;
        i = -1;
      }
    }
  }

  if (m_width > currentPosition) {
    for (int i = currentPosition; i < m_width; i++) {
      if (veriNumBit == _Z) {
        setBitAt(i, _Z);
      }
      else if (veriNumBit == _X) {
        setBitAt(i, _X);
      }
      else {
        setBitAt(i, _0);
      }
    }
  }

  if ((veriNumBit == _1) && (m_isSigned)) {
    m_sign = VERINUM_NEG;
  }

  printBlocks();
}

CDOmVeriNum::~CDOmVeriNum() {}

const TInt CDOmVeriNum::getValue() const { 
  return ZERO; 
}

RefCDOmVeriNum CDOmVeriNum::build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& tokenString, const RefString& lightString, TBool isSigned, TInt width) {
  ASSERT(tokenString.get(), "NULL string received");
  ASSERT(!tokenString->empty(), "Empty string received");

  CDOmVeriNum* veriNum;
  try {
    veriNum = new CDOmVeriNum(lineNumber, numBaseType, lightString, isSigned, width);
    veriNum->m_tokenString = tokenString;
  }
  catch (std::exception& e) {
    ASSERT(FAIL, "New operator failed : " << e.what());
  }
  return RefCDOmVeriNum(veriNum);
}

RefCDOmVeriNum CDOmVeriNum::build(TLineNumberType lineNumber, ENumBaseType numBaseType, const RefString& lightString, TBool isSigned, TInt width) {
  CDOmVeriNum* veriNum;
  try {
    veriNum = new CDOmVeriNum(lineNumber, numBaseType, lightString, isSigned, width);
  }
  catch (std::exception& e) {
    ASSERT(FAIL, "New operator failed : " << e.what());
  }
  return RefCDOmVeriNum(veriNum);
}

RefCDOmVeriNum CDOmVeriNum::cast(RefCDOmBase object) {
  ASSERT(object.get(), "NULL object received");
  ASSERT(object->getType() == TYPE_EXPR, "Type check failed");
  RefCDOmExpr expr = boost::static_pointer_cast<CDOmExpr>(object);
  ASSERT(expr->getExprType() == EXPR_NUMBER, "Type check failed");
  RefCDOmNumber number = boost::static_pointer_cast<CDOmNumber>(expr);
  ASSERT(number->getNumType() == NUM_VERILOG, "Type check failed");
  return boost::static_pointer_cast<CDOmVeriNum>(number);
}

void CDOmVeriNum::setBitAt(TUInt currentPosition, EVeriNumBit veriNumBit) {
  ASSERT(currentPosition >= 0, "Illegal index received(<0)");
  ASSERT(currentPosition < m_width, "Index out of range");

  TUInt atBlock = currentPosition / VERINUM_BLOCK_SIZE;
  TUInt atOffset = currentPosition % VERINUM_BLOCK_SIZE;

  if ((m_blocks->empty()) || (atBlock > (m_blocks->size()) - 1)) {
    m_blocks->push_back(0);
  }

  TUInt mask = (0 | veriNumBit) << (atOffset * VERINUM_BIT_SIZE);
  m_blocks->at(atBlock) |= mask;
}

TUInt CDOmVeriNum::toDec(TChar c) {
  TUInt decDigit;

  if ((c >= '0') && (c <= '9')) {
    decDigit = c - '0';
  }
  else if ((c >= 'a') && (c <= 'f')) {
    decDigit = 10 + c - 'a';
  }
  else if ((c >= 'A') && (c <= 'F')) {
    decDigit = 10 + c - 'A';
  }
  else if ((c == 'z') || (c == 'Z')) {
    return VERINUM_DEC_Z;
  }
  else if ((c == 'x') || (c == 'X')) {
    return VERINUM_DEC_X;
  }
  else {
    ASSERT(FAIL, "Illegal digit received");
  }

  ASSERT(!((m_numBaseType == NUM_BASE_BIN) && ((decDigit < 0) || (decDigit > 1))), "Illegal digit for base BIN");
  ASSERT(!((m_numBaseType == NUM_BASE_OCT) && ((decDigit < 0) || (decDigit > 7))), "Illegal digit for base OCT");
  ASSERT(!((m_numBaseType == NUM_BASE_HEX) && ((decDigit < 0) || (decDigit > 15))), "Illegal digit for base HEX");

  return decDigit;
}

//just for testing purposes
void CDOmVeriNum::printBlocks() {
  TInt toGo = m_width - 1;
  TInt currentBlock;
  TInt currentOffset;

  while (toGo >= 0) {
    currentBlock = toGo / VERINUM_BLOCK_SIZE;
    currentOffset = toGo % VERINUM_BLOCK_SIZE;
    DCOUT((((m_blocks->at(currentBlock)) >> (currentOffset * VERINUM_BIT_SIZE)) & _X)  << ".");
    toGo--;
  }
  DCOUT("\n");
}
//---

void CDOmVeriNum::changeSign() {}

TBool CDOmVeriNum::equals(TInt) { return FALSE; }
TInt CDOmVeriNum::calcWidth() { return ZERO; }
RefCDOmNumber CDOmVeriNum::maxValue() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::plus() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::minus() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::logicNot() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::bitwiseNot() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::reductionAnd() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::reductionNand() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::reductionOr() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::reductionNor() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::reductionXor() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::reductionXnor() {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::add(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::substract(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::multiply(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::divide(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::modulo(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::power(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::shiftLeft(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::shiftRight(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::equality(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::notEquality(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::equalityEqualCase(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::equalityNotEqualCase(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::logicAnd(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::logicOr(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::relationalLess(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::relationalLessEqual(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::relationalGreater(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::relationalGreaterEqual(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::bitwiseAnd(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::bitwiseNand(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::bitwiseOr(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::bitwiseNor(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::bitwiseXor(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::bitwiseXnor(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::binaryShiftLeft(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::binaryShiftRight(RefCDOmNumber) {return RefCDOmNumber();}
RefCDOmNumber CDOmVeriNum::ternaryCondition(RefCDOmNumber, RefCDOmNumber) {return RefCDOmNumber();}

void CDOmVeriNum::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  //when compiled it throws an error: call of overloaded 'visit(NSCdom::RefCDOmVeriNum)' is ambiguous
  //visitor.visit(getThis());
}
//~added by Tb

// ********************************************************************************
// CDOmReal class
// ********************************************************************************
CDOmReal::CDOmReal(TLineNumberType lineNumber, const RefString& tokenString, const RefCRealNum& realNum)
  : CDOmExpr(lineNumber, EXPR_REAL_NUMBER), m_tokenString(tokenString), m_realNum(realNum) {}

RefCDOmReal CDOmReal::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmReal();
  }
  ASSERT(object->getType() == TYPE_EXPR, "type check on CDOmReal::cast failure");
  //RefCDOmExpr obj = boost::static_pointer_cast<CDOmExpr>(object);
  RefCDOmBase cdomexprAsBase = object;
  RefCDOmExpr cdomexpr = CDOmExpr::cast(cdomexprAsBase);
  RefCDOmExpr obj = cdomexpr;
  ASSERT(obj->getExprType() == CDOmExpr::EXPR_REAL_NUMBER, "type check on CDOmReal::cast failure");
  return boost::static_pointer_cast<CDOmReal>(object);
}

RefCDOmReal CDOmReal::build(TLineNumberType lineNumber, const RefString& tokenString, const RefString& lightString) {
  ASSERT(tokenString.get(), "tokenString is NULL");
  ASSERT(tokenString->size(), "tokenString is empty");
  ASSERT(lightString.get(), "lightString is NULL");
  ASSERT(lightString->size(), "lightString is empty");

  CDOmReal* real = new CDOmReal(lineNumber, tokenString, RefCRealNum(new CRealNum(*lightString)));
  RefCDOmReal refReal(real);
  real->m_weakRef = boost::weak_ptr<CDOmBase>( refReal);
  return refReal;
}

RefString CDOmReal::getTokenString() const {
  return m_tokenString;
}

RefCRealNum CDOmReal::getRealNum() const {
  return m_realNum;
}

TBool CDOmReal::isConst() const {
  return true;
}

TBool CDOmReal::canBeModulePath() const {
  return true;
}

//RefCDOmEvalRes CDOmReal::doEval() const {
//  return CDOmEvalRes::build(m_realNum);
//}

RefCDOmBase CDOmReal::doEval() const {
  return RefCDOmBase();
}

void CDOmReal::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmString class
// ********************************************************************************
CDOmString::CDOmString(TLineNumberType lineNumber, const RefString& tokenString, const RefCVeriNum& veriNum)
  : CDOmExpr(lineNumber, EXPR_STRING), m_tokenString(tokenString), m_veriNum(veriNum) {}

RefCDOmString CDOmString::cast(RefCDOmBase object) {
  if (!object.get()) {
    return RefCDOmString();
  }
  ASSERT(object->getType() == TYPE_EXPR, "type check on CDOmString::cast failure");
  RefCDOmExpr exprObj = CDOmExpr::cast(object);
  ASSERT(exprObj->getExprType() == CDOmExpr::EXPR_STRING, "type check on CDOmString::cast failure");
  return boost::static_pointer_cast<CDOmString>(object);
}

RefCDOmString CDOmString::build(TLineNumberType lineNumber, const RefString& tokenString, const RefString& strVal) {
  ASSERT(tokenString.get(), "tokenString is NULL");
  ASSERT(strVal.get(), "strVal is NULL");

  CDOmString* str = new CDOmString(lineNumber, tokenString, RefCVeriNum(new CVeriNum(*strVal)));
  RefCDOmString refStr(str);
  str->m_weakRef = boost::weak_ptr<CDOmBase>( refStr);
  return refStr;
}

RefCDOmString CDOmString::build(TLineNumberType lineNumber, const RefString& tokenString) {
  ASSERT(tokenString.get(), "tokenString is NULL");

  CDOmString* str = new CDOmString(lineNumber, tokenString, RefCVeriNum());
  RefCDOmString refStr(str);
  str->m_weakRef = boost::weak_ptr<CDOmBase>( refStr);
  return refStr;
}

RefString CDOmString::getTokenString() const {
  return m_tokenString;
}

RefCVeriNum CDOmString::getVeriNum() const {
  return m_veriNum;
}

TBool CDOmString::isConst() const {
  return true;
}

TBool CDOmString::canBeModulePath() const {
  return false;
}

RefCDOmBase CDOmString::doEval() const {
  return RefCDOmBase();
}

void CDOmString::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmSpecifyBlock class
// ********************************************************************************
CDOmSpecifyBlock::CDOmSpecifyBlock(TLineNumberType lineNumber) : CDOmBase(TYPE_SPEC_BLOCK, lineNumber) { }

RefCDOmSpecifyBlock CDOmSpecifyBlock::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmSpecifyBlock();
  }
  ASSERT(object->getType() == TYPE_SPEC_BLOCK, "type check on CDOmSpecifyBlock::cast failure");
  return boost::static_pointer_cast<CDOmSpecifyBlock>(object);
}

RefCDOmSpecifyBlock CDOmSpecifyBlock::build(TLineNumberType lineNumber, RefCDOmModuleDecl parent) {
  ASSERT(parent.get(), "parent is NULL");

  CDOmSpecifyBlock *specifyBlock = new CDOmSpecifyBlock(lineNumber);
  RefCDOmSpecifyBlock refSpecifyBlock(specifyBlock);

  specifyBlock->m_weakRef = boost::weak_ptr<CDOmBase>( refSpecifyBlock);
  specifyBlock->setParent(parent); // self registration

  return refSpecifyBlock;
}

void CDOmSpecifyBlock::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmPulseStyleOrShowCancelledDecl class
// ********************************************************************************
CDOmPulseStyleOrShowCancelledDecl::CDOmPulseStyleOrShowCancelledDecl(TLineNumberType lineNumber, EDeclType declType) : CDOmBase(TYPE_PULSESTYLE_SHOWCANCELLED, lineNumber), m_declType(declType) { }

RefCDOmPulseStyleOrShowCancelledDecl CDOmPulseStyleOrShowCancelledDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmPulseStyleOrShowCancelledDecl();
  }
  ASSERT(object->getType() == TYPE_PULSESTYLE_SHOWCANCELLED, "type check on RefCDOmPulseStyleOrShowCancelledDecl::cast failure");
  return boost::static_pointer_cast<CDOmPulseStyleOrShowCancelledDecl>(object);
}

RefCDOmPulseStyleOrShowCancelledDecl CDOmPulseStyleOrShowCancelledDecl::build(TLineNumberType lineNumber, RefCDOmSpecifyBlock parent, EDeclType type, RefCDOmSpecifyTerminalList listOfPathOutputs) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(listOfPathOutputs.get(), "listOfPathOutputs is NULL");
  CDOmPulseStyleOrShowCancelledDecl *psoscd = new CDOmPulseStyleOrShowCancelledDecl(lineNumber, type);
  RefCDOmPulseStyleOrShowCancelledDecl refPsoscd(psoscd);
  psoscd->m_weakRef = boost::weak_ptr<CDOmBase>( refPsoscd);

  psoscd->setParent(parent);
  //listOfPathOutputs->setParent(psoscd->m_weakRef.lock()); //self registration
  listOfPathOutputs->setParent(psoscd->getThis()); //self registration

  return refPsoscd;
}

const CDOmPulseStyleOrShowCancelledDecl::EDeclType CDOmPulseStyleOrShowCancelledDecl::getDeclType() const {
  return m_declType;
}

void CDOmPulseStyleOrShowCancelledDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmPathDelayValue class
// ********************************************************************************
CDOmPathDelayValue::CDOmPathDelayValue(TLineNumberType lineNumber, const EPathStyle pathStyle) : CDOmBase(TYPE_PATH_DELAY_VALUE, lineNumber), m_style(pathStyle) { }

RefCDOmPathDelayValue CDOmPathDelayValue::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmPathDelayValue();
  }
  ASSERT(object->getType() == TYPE_PATH_DELAY_VALUE, "type check on CDOmPathDelayValue::cast failure");
  return boost::static_pointer_cast<CDOmPathDelayValue>(object);
}

RefCDOmPathDelayValue CDOmPathDelayValue::build(TLineNumberType lineNumber,  const EPathStyle style, RefCDOmMinTypMaxList minTypMaxList ) {
  ASSERT(minTypMaxList.get(), "minTypMaxList is NULL");
  TUInt tmp;
  
  ASSERT( (tmp=minTypMaxList->getNumberOfChildren()) != 1
          || tmp != 2
          || tmp != 3
          || tmp != 6
          || tmp != 9
          , "this class requires the list to be of size 1,2,3,6 or 9 according to the verilog grammar rule list_of_path_delay_expressions");
  CDOmPathDelayValue *pathDelayValue = new CDOmPathDelayValue(lineNumber, style);
  RefCDOmPathDelayValue refPathDelayValue = RefCDOmPathDelayValue(pathDelayValue);
  pathDelayValue->m_weakRef = boost::weak_ptr<CDOmBase>( refPathDelayValue);

  //minTypMaxList->setParent(pathDelayValue->m_weakRef.lock()); //self registration
  minTypMaxList->setParent(pathDelayValue->getThis()); //self registration

  return refPathDelayValue;
}

CDOmPathDelayValue::EPathStyle CDOmPathDelayValue::getStyle() const { 
  return m_style;
}

const RefCDOmMinTypMaxList CDOmPathDelayValue::getMinTypMaxList() const {
  return boost::static_pointer_cast<CDOmMinTypMaxList>(m_children->at(0));
  /*RefCDOmBase mintypmaxlistAsBase = getChild(0);
    RefCDOmMinTypMaxList mintypmaxlist = CDOmMinTypMaxList::cast(mintypmaxlistAsBase);
    return mintypmaxlist;*/
}

void CDOmPathDelayValue::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const { 
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGenInst class
// ********************************************************************************
CDOmGenInst::CDOmGenInst(TLineNumberType lineNumber) : CDOmBase(TYPE_GEN_INST, lineNumber) { }

RefCDOmGenInst CDOmGenInst::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmGenInst();
  }
  ASSERT(object->getType() == TYPE_GEN_INST, "type check on CDOmGenInst::cast failure");
  return boost::static_pointer_cast<CDOmGenInst>(object);
}

RefCDOmGenInst CDOmGenInst::build(TLineNumberType lineNumber, RefCDOmModuleDecl parent) {
  ASSERT(parent.get(), "parent is NULL");

  CDOmGenInst *genInst = new CDOmGenInst(lineNumber);
  RefCDOmGenInst refGenInst(genInst);

  genInst->m_weakRef = boost::weak_ptr<CDOmBase>( refGenInst);
  genInst->setParent(parent);

  return refGenInst;
}

void CDOmGenInst::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGenItemNull class
// ********************************************************************************
CDOmGenItemNull::CDOmGenItemNull(TLineNumberType lineNumber) : CDOmBase(TYPE_GEN_ITEM_NULL, lineNumber) { }

RefCDOmGenItemNull CDOmGenItemNull::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmGenItemNull();
  }
  ASSERT(object->getType() == TYPE_GEN_ITEM_NULL, "type check on CDOmGenItemNull::cast failure");
  return boost::static_pointer_cast<CDOmGenItemNull>(object);
}

RefCDOmGenItemNull CDOmGenItemNull::build(TLineNumberType lineNumber, RefCDOmBase parent) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_GEN_ITEM_IF
         || parent->getType() == TYPE_GEN_ITEM_CASE
         , "illegal parent type");

  CDOmGenItemNull *genItem = new CDOmGenItemNull(lineNumber);
  RefCDOmGenItemNull refGenItem(genItem);

  genItem->m_weakRef = boost::weak_ptr<CDOmBase>( refGenItem);
  genItem->setParent(parent);

  return refGenItem;
}

void CDOmGenItemNull::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGenItemIf class
// ********************************************************************************
/**
 * This class models a generated conditional item according to the grammar rules. <br/> <br/>
 *
 * <b>GRAMMAR RULES: </b> <br/>
 * <pre><code>
 * generate_conditional_statement ::=
 *    if ( constant_expression ) generate_item_or_null [ else generate_item_or_null ]
 * </code></pre>
 */
CDOmGenItemIf::CDOmGenItemIf(TLineNumberType lineNumber) : CDOmBase(TYPE_GEN_ITEM_IF, lineNumber) { }

RefCDOmGenItemIf CDOmGenItemIf::cast (RefCDOmBase object) {
  //ASSERT(object.get());
  if (!object.get()) {
    return RefCDOmGenItemIf();
  }
  ASSERT(object->getType() == TYPE_GEN_ITEM_IF, "type check on CDOmGenItemIf::cast failure");
  return boost::static_pointer_cast<CDOmGenItemIf>(object);
}

void CDOmGenItemIf::beforeAddingGenItemOrNull() {
  ASSERT(!m_children.get() || m_children->size() != 3, "this object should have 3 children");
}

RefCDOmGenItemIf CDOmGenItemIf::build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExpr ifCondExpr) {
  ASSERT(ifCondExpr.get(), "ifCondExpr is NULL");
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_GEN_INST
         || parent->getType() == TYPE_GEN_ITEM_IF
         || parent->getType() == TYPE_GEN_ITEM_CASE
         || parent->getType() == TYPE_GEN_ITEM_LOOP
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_NAMED
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED
         , "parent has illegal type");

  CDOmGenItemIf *genItem = new CDOmGenItemIf(lineNumber);
  RefCDOmGenItemIf refGenItem(genItem);

  genItem->m_weakRef = boost::weak_ptr<CDOmBase>( refGenItem);
  genItem->setParent(parent);

  ifCondExpr->setParent(refGenItem);

  return refGenItem;
}
  
RefCDOmExpr CDOmGenItemIf::getIfCondExpr() const { 
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0));
  RefCDOmBase exprAsBase = getChild(0);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

RefCDOmBase CDOmGenItemIf::getIfItem() const {
  ASSERT(m_children->size() != 1, "[CDOmGenItemIf::getIfItem()] illegal state for this method call.");
  //if( m_children->size() == 1 ) {
  //  throw NSBase::IllegalStateException("[CDOmGenItemIf::getIfItem()] illegal state for this method call.", m_lineNumber);
  //}
  //return m_children->at(1);
  return getChild(1);
}

RefCDOmBase CDOmGenItemIf::getElseItem() const {
  ASSERT(m_children->size() != 1, "[CDOmGenItemIf::getIfItem()] illegal state for this method call.");
  //if( m_children->size() == 1 ) {
  //  throw NSBase::IllegalStateException("[CDOmGenItemIf::getIfItem()] illegal state for this method call.", m_lineNumber);
  //}
  if( m_children->size() == 3 )
    //return m_children->at(2);
    return getChild(2);
  else
    return RefCDOmBase();
}

void CDOmGenItemIf::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGenItemCase class
// ********************************************************************************
CDOmGenItemCase::CDOmGenItemCase(TLineNumberType lineNumber) : CDOmBase(TYPE_GEN_ITEM_CASE, lineNumber), m_hasDefault(false) { }

RefCDOmGenItemCase CDOmGenItemCase::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmGenItemCase();
  }
  ASSERT(object->getType() == TYPE_GEN_ITEM_CASE, "type check on CDOmGenItemCase::cast failure");
  return boost::static_pointer_cast<CDOmGenItemCase>(object);
}

void CDOmGenItemCase::beforeAddingGenItemOrNull() {
  if( m_hasDefault ) {
    ASSERT(m_children->back()->getType() != TYPE_LIST_EXPR, "type check on beforeAddingGenItemOrNull failure");
  }
  else if( m_children.get() && !m_hasDefault && m_children->back()->getType() != TYPE_LIST_EXPR ) 
    m_hasDefault = true;
}

RefCDOmGenItemCase CDOmGenItemCase::build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExpr expr, RefCDOmListExpr exprList) {
  ASSERT(expr.get(), "expr is NULL");
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_GEN_INST
         || parent->getType() == TYPE_GEN_ITEM_IF
         || parent->getType() == TYPE_GEN_ITEM_CASE
         || parent->getType() == TYPE_GEN_ITEM_LOOP
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_NAMED
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED
         , "parent has illegal type");
  ASSERT(expr->isConst(), "expr should be const");

  CDOmGenItemCase *genItemCase = new CDOmGenItemCase(lineNumber);
  RefCDOmGenItemCase refGenItemCase(genItemCase);

  genItemCase->m_weakRef = boost::weak_ptr<CDOmBase>( refGenItemCase);
  genItemCase->setParent(parent);

  expr->setParent(refGenItemCase);

  if(exprList.get())
    genItemCase->addCaseItem(exprList);

  return refGenItemCase;
}

TBool CDOmGenItemCase::hasDefault() const {
  return m_hasDefault;
}

void CDOmGenItemCase::addCaseItem(RefCDOmListExpr exprList) {
  ASSERT(exprList.get(), "exprList is NULL");
  //exprList->setParent(m_weakRef.lock());
  exprList->setParent(getThis());
}

void CDOmGenItemCase::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGenItemLoop class
// ********************************************************************************
CDOmGenItemLoop::CDOmGenItemLoop(TLineNumberType lineNumber) : CDOmBase(TYPE_GEN_ITEM_LOOP, lineNumber) { }

RefCDOmGenItemLoop CDOmGenItemLoop::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmGenItemLoop();
  }
  ASSERT(object->getType() == TYPE_GEN_ITEM_LOOP, "type check on CDOmGenItemLoop:cast failure");
  return boost::static_pointer_cast<CDOmGenItemLoop>(object);
}

void CDOmGenItemLoop::beforeAddingGenItemBlock(ECDOmType type) {
  ASSERT(!m_children.get() || m_children->size() < 6, "this object should have less that 6 children");
  if(m_children.get() && m_children->size() == 5)
    ASSERT(type == TYPE_GEN_ITEM_BLOCK_NAMED, "illegal type");
}

RefCDOmGenItemLoop CDOmGenItemLoop::build(TLineNumberType lineNumber, RefCDOmBase parent, RefCDOmExprLink initAssnIdentifier, RefCDOmExpr initAssnExpr, RefCDOmExpr condExpr,
                                          RefCDOmExprLink incAssnIdentifier, RefCDOmExpr incAssnExpr) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_GEN_INST
         || parent->getType() == TYPE_GEN_ITEM_IF
         || parent->getType() == TYPE_GEN_ITEM_CASE
         || parent->getType() == TYPE_GEN_ITEM_LOOP
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_NAMED
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED
         , "parent has illegal type");

  ASSERT(initAssnIdentifier.get(), "initAssnIdentifier is NULL");
  ASSERT(initAssnExpr.get(), "initAssnExpr is NULL");
  ASSERT(condExpr.get(), "condExpr is NULL");
  ASSERT(incAssnIdentifier.get(), "incAssnIdentifier is NULL");
  ASSERT(incAssnExpr.get(), "incAssnExpr is NULL");
  ASSERT(!initAssnIdentifier->isHID() && initAssnIdentifier->getArrayIndexes() == RefCDOmListExpr() && initAssnIdentifier->getRangeExpr() == RefCDOmRangeExpr(), "the following logical expression is not true: !initAssnIdentifier->isHID() && initAssnIdentifier->getArrayIndexes() == RefCDOmListExpr() && initAssnIdentifier->getRangeExpr() == RefCDOmRangeExpr()");
  ASSERT(!incAssnIdentifier->isHID() && incAssnIdentifier->getArrayIndexes() == RefCDOmListExpr() && incAssnIdentifier->getRangeExpr() == RefCDOmRangeExpr(), "the following logical expression is not true: !incAssnIdentifier->isHID() && incAssnIdentifier->getArrayIndexes() == RefCDOmListExpr() && incAssnIdentifier->getRangeExpr() == RefCDOmRangeExpr()");

  CDOmGenItemLoop *genItemLoop = new CDOmGenItemLoop(lineNumber);
  RefCDOmGenItemLoop refGenItemLoop(genItemLoop);

  genItemLoop->m_weakRef = boost::weak_ptr<CDOmBase>( refGenItemLoop);
  genItemLoop->setParent(parent);

  initAssnIdentifier->setParent(refGenItemLoop);
  initAssnExpr->setParent(refGenItemLoop);
  condExpr->setParent(refGenItemLoop);
  incAssnIdentifier->setParent(refGenItemLoop);
  incAssnExpr->setParent(refGenItemLoop);

  return refGenItemLoop;
}

void CDOmGenItemLoop::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGenItemBlock class
// ********************************************************************************
CDOmGenItemBlock::CDOmGenItemBlock(TLineNumberType lineNumber, TBool isNamed) 
  : CDOmBase(isNamed ? TYPE_GEN_ITEM_BLOCK_NAMED : TYPE_GEN_ITEM_BLOCK_UNNAMED, lineNumber), m_scope(RefCDOmScope()) { }
  
RefCDOmGenItemBlock CDOmGenItemBlock::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmGenItemBlock();
  }
  ASSERT(object->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED || object->getType() == TYPE_GEN_ITEM_BLOCK_NAMED, "type check on CDOmGenItemBlock::cast failure");
  return boost::static_pointer_cast<CDOmGenItemBlock>(object);
}

RefCDOmGenItemBlock CDOmGenItemBlock::build(TLineNumberType lineNumber, RefCDOmBase parent, const RefString name) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_GEN_INST
         || parent->getType() == TYPE_GEN_ITEM_IF
         || parent->getType() == TYPE_GEN_ITEM_CASE
         || parent->getType() == TYPE_GEN_ITEM_LOOP
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_NAMED
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED
         , "illegal parent type");

  CDOmGenItemBlock *genItemBlock = new CDOmGenItemBlock(lineNumber, name.get() ? true : false);
  RefCDOmGenItemBlock refGenItemBlock(genItemBlock);
  genItemBlock->m_weakRef = boost::weak_ptr<CDOmBase>( refGenItemBlock);

  genItemBlock->setParent(parent);
  if( name.get()) {
    RefCDOmIdentifier id = CDOmIdentifier::build(lineNumber, refGenItemBlock, CDOmIdentifier::ID_GEN_ITEM_NAMED_BLOCK, name);
    genItemBlock->m_scope = CDOmScope::build(id);
  }

  return refGenItemBlock;
}

TBool CDOmGenItemBlock::isNamed() const {
  return m_type == TYPE_GEN_ITEM_BLOCK_NAMED;
}

RefCDOmScope CDOmGenItemBlock::getAttachedScope() const {
  ASSERT(isNamed(), "[CDOmGenItemBlock::getAttachedScope()] illegal state for this method call.");
  //if(!isNamed()) {
  //  throw NSBase::IllegalStateException("[CDOmGenItemBlock::getAttachedScope()] illegal state for this method call.", m_lineNumber);
  //}

  return m_scope;
}

const RefTVec_RefCDOmBase CDOmGenItemBlock::getItems() const {
  return getChildren<CDOmBase>(TYPE_ALL_TYPES);
}

void CDOmGenItemBlock::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmSystemTimingCheck class
// ********************************************************************************
CDOmSystemTimingCheck::CDOmSystemTimingCheck(TLineNumberType lineNumber, ETimingCheckType timingCheckType, TInt flag[8]) : CDOmBase(TYPE_SYSTEM_TIMING_CHECK, lineNumber), m_timingCheckType(timingCheckType) {
  for(TInt i=0; i<8; ++i)
    m_optional[i]=flag[i];
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmSystemTimingCheck();
  }
  ASSERT(object->getType() == TYPE_SYSTEM_TIMING_CHECK, "type check on CDOmSystemTimingCheck::cast failure");
  return boost::static_pointer_cast<CDOmSystemTimingCheck>(object);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::build(TLineNumberType lineNumber, 
                                                      RefCDOmSpecifyBlock parent, 
                                                      ETimingCheckType timingCheckType, 
                                                      RefCDOmTimingCheckEvent referenceEvent, 
                                                      RefCDOmTimingCheckEvent dataEvent, 
                                                      RefCDOmExpr timingCheckLimit1, 
                                                      RefCDOmTimingCheckEvent controlledReferenceEvent,
                                                      RefCDOmMinTypMax startEdgeOffset, 
                                                      RefCDOmMinTypMax endEdgeOffset,
                                                      RefCDOmExpr threshold,
                                                      RefCDOmExpr timingCheckLimit2, 
                                                      RefCDOmExprLink notifyReg, 
                                                      RefCDOmMinTypMax stampTimeCondition, 
                                                      RefCDOmMinTypMax checkTimeCondition, 
                                                      RefCDOmDelayedDataOrReference delayedReference, 
                                                      RefCDOmDelayedDataOrReference delayedData, 
                                                      RefCDOmExpr eventBasedFlag, 
                                                      RefCDOmMinTypMax remainActiveFlag
                                                      ) {
  ASSERT(parent.get(), "parent is NULL");

  TInt flag[8];
  for(TInt i=0; i<8; ++i)
    flag[i]=0;
  if(notifyReg.get())
    flag[0]=1;
  if(stampTimeCondition.get())
    flag[1]=1;
  if(checkTimeCondition.get())
    flag[2]=1;
  if(delayedReference.get())
    flag[3]=1;
  if(delayedData.get())
    flag[4]=1;
  if(eventBasedFlag.get())
    flag[5]=1;
  if(remainActiveFlag.get())
    flag[6]=1;
  if(threshold.get())
    flag[7]=1;
  
  CDOmSystemTimingCheck *systemTimingCheck = new CDOmSystemTimingCheck(lineNumber, timingCheckType,flag);
  RefCDOmSystemTimingCheck refSystemTimingCheck = RefCDOmSystemTimingCheck(systemTimingCheck);
  systemTimingCheck->m_weakRef = boost::weak_ptr<CDOmBase>( refSystemTimingCheck);
  refSystemTimingCheck->setParent(parent);//self registration
  
  if(referenceEvent.get())
    referenceEvent->setParent(refSystemTimingCheck);
  if(dataEvent.get())
    dataEvent->setParent(refSystemTimingCheck);  
  if(timingCheckLimit1.get())
    timingCheckLimit1->setParent(refSystemTimingCheck);
  if(timingCheckLimit2.get())
    timingCheckLimit2->setParent(refSystemTimingCheck); 
  if(controlledReferenceEvent.get())    
    controlledReferenceEvent->setParent(refSystemTimingCheck);
  if(startEdgeOffset.get())
    startEdgeOffset->setParent(refSystemTimingCheck); 
  if(endEdgeOffset.get())
    endEdgeOffset->setParent(refSystemTimingCheck);
  if(threshold.get())
    threshold->setParent(refSystemTimingCheck);
  if(notifyReg.get()) 
    notifyReg->setParent(refSystemTimingCheck);
  if(stampTimeCondition.get()) 
    stampTimeCondition->setParent(refSystemTimingCheck);
  if(checkTimeCondition.get()) 
    checkTimeCondition->setParent(refSystemTimingCheck); 
  if(delayedReference.get()) 
    delayedReference->setParent(refSystemTimingCheck);
  if(delayedData.get()) 
    delayedData->setParent(refSystemTimingCheck); 
  if(eventBasedFlag.get()) 
    eventBasedFlag->setParent(refSystemTimingCheck);
  if(remainActiveFlag.get()) 
    remainActiveFlag->setParent(refSystemTimingCheck);

  return refSystemTimingCheck;
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildSetup(TLineNumberType lineNumber, 
                                                           RefCDOmSpecifyBlock parent,
                                                           RefCDOmTimingCheckEvent referenceEvent,
                                                           RefCDOmTimingCheckEvent dataEvent,
                                                           RefCDOmExpr timingCheckLimit, 
                                                           RefCDOmExprLink notifyReg
                                                           ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  
  return build(lineNumber, parent, TIMING_CHECK_SETUP, referenceEvent, dataEvent, timingCheckLimit, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), RefCDOmExpr(), notifyReg);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildHold(TLineNumberType lineNumber, 
                                                          RefCDOmSpecifyBlock parent, 
                                                          RefCDOmTimingCheckEvent referenceEvent,
                                                          RefCDOmTimingCheckEvent dataEvent,
                                                          RefCDOmExpr timingCheckLimit, 
                                                          RefCDOmExprLink notifyReg
                                                          ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  
  return build(lineNumber, parent, TIMING_CHECK_HOLD, referenceEvent, dataEvent, timingCheckLimit, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), RefCDOmExpr(), notifyReg);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildSetuphold(TLineNumberType lineNumber, 
                                                               RefCDOmSpecifyBlock parent, 
                                                               RefCDOmTimingCheckEvent referenceEvent, 
                                                               RefCDOmTimingCheckEvent dataEvent,
                                                               RefCDOmExpr timingCheckLimit1,
                                                               RefCDOmExpr timingCheckLimit2, 
                                                               RefCDOmExprLink notifyReg, 
                                                               RefCDOmMinTypMax stampTimeCondition, 
                                                               RefCDOmMinTypMax checkTimeCondition, 
                                                               RefCDOmDelayedDataOrReference delayedReference, 
                                                               RefCDOmDelayedDataOrReference delayedData
                                                               ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit1.get(), "timingCheckLimit1 is NULL");
  ASSERT(timingCheckLimit2.get(), "timingCheckLimit2 is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  
  return build(lineNumber, parent, TIMING_CHECK_SETUPHOLD, referenceEvent, dataEvent, timingCheckLimit1, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), timingCheckLimit2, notifyReg, stampTimeCondition, checkTimeCondition,
               delayedReference, delayedData);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildRecovery(TLineNumberType lineNumber, 
                                                              RefCDOmSpecifyBlock parent, 
                                                              RefCDOmTimingCheckEvent referenceEvent, 
                                                              RefCDOmTimingCheckEvent dataEvent,
                                                              RefCDOmExpr timingCheckLimit, 
                                                              RefCDOmExprLink notifyReg
                                                              ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  
  return build(lineNumber, parent, TIMING_CHECK_RECOVERY, referenceEvent, dataEvent, timingCheckLimit, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), RefCDOmExpr(), notifyReg);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildRemoval(TLineNumberType lineNumber, 
                                                             RefCDOmSpecifyBlock parent, 
                                                             RefCDOmTimingCheckEvent referenceEvent, 
                                                             RefCDOmTimingCheckEvent dataEvent,
                                                             RefCDOmExpr timingCheckLimit, 
                                                             RefCDOmExprLink notifyReg
                                                             ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  
  return build(lineNumber, parent, TIMING_CHECK_REMOVAL, referenceEvent, dataEvent, timingCheckLimit, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), RefCDOmExpr(), notifyReg);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildRecrem(TLineNumberType lineNumber, 
                                                            RefCDOmSpecifyBlock parent,   
                                                            RefCDOmTimingCheckEvent referenceEvent, 
                                                            RefCDOmTimingCheckEvent dataEvent,
                                                            RefCDOmExpr timingCheckLimit1,
                                                            RefCDOmExpr timingCheckLimit2, 
                                                            RefCDOmExprLink notifyReg, 
                                                            RefCDOmMinTypMax stampTimeCondition, 
                                                            RefCDOmMinTypMax checkTimeCondition, 
                                                            RefCDOmDelayedDataOrReference delayedReference, 
                                                            RefCDOmDelayedDataOrReference delayedData
                                                            ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit1.get(), "timingCheckLimit1 is NULL");
  ASSERT(timingCheckLimit2.get(), "timingCheckLimit2 is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  return build(lineNumber, parent, TIMING_CHECK_RECREM, referenceEvent, dataEvent, timingCheckLimit1, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), timingCheckLimit2, notifyReg, stampTimeCondition, checkTimeCondition,
               delayedReference, delayedData);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildSkew(TLineNumberType lineNumber, 
                                                          RefCDOmSpecifyBlock parent,  
                                                          RefCDOmTimingCheckEvent referenceEvent, 
                                                          RefCDOmTimingCheckEvent dataEvent,
                                                          RefCDOmExpr timingCheckLimit, 
                                                          RefCDOmExprLink notifyReg
                                                          ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  
  return build(lineNumber, parent, TIMING_CHECK_SKEW, referenceEvent, dataEvent, timingCheckLimit, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), RefCDOmExpr(), notifyReg);
}
RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildTimeskew(TLineNumberType lineNumber, 
                                                              RefCDOmSpecifyBlock parent, 
                                                              RefCDOmTimingCheckEvent referenceEvent, 
                                                              RefCDOmTimingCheckEvent dataEvent, 
                                                              RefCDOmExpr timingCheckLimit, 
                                                              RefCDOmExprLink notifyReg, 
                                                              RefCDOmExpr eventBasedFlag, 
                                                              RefCDOmMinTypMax remainActiveFlag
                                                              ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }
  

  return build(lineNumber, parent, TIMING_CHECK_TIMESKEW, referenceEvent, dataEvent, timingCheckLimit, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), RefCDOmExpr(), notifyReg, RefCDOmMinTypMax(),RefCDOmMinTypMax(),
               RefCDOmDelayedDataOrReference(), RefCDOmDelayedDataOrReference(), eventBasedFlag, remainActiveFlag);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildFullskew(TLineNumberType lineNumber, 
                                                              RefCDOmSpecifyBlock parent,  
                                                              RefCDOmTimingCheckEvent referenceEvent, 
                                                              RefCDOmTimingCheckEvent dataEvent, 
                                                              RefCDOmExpr timingCheckLimit1, 
                                                              RefCDOmExpr timingCheckLimit2, 
                                                              RefCDOmExprLink notifyReg, 
                                                              RefCDOmExpr eventBasedFlag, 
                                                              RefCDOmMinTypMax remainActiveFlag
                                                              ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(timingCheckLimit1.get(), "timingCheckLimit1 is NULL");
  ASSERT(timingCheckLimit2.get(), "timingCheckLimit2 is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }

  return build(lineNumber, parent, TIMING_CHECK_FULLSKEW, referenceEvent, dataEvent, timingCheckLimit1, RefCDOmTimingCheckEvent(),
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), timingCheckLimit2, notifyReg, RefCDOmMinTypMax(),RefCDOmMinTypMax(),
               RefCDOmDelayedDataOrReference(), RefCDOmDelayedDataOrReference(), eventBasedFlag, remainActiveFlag);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildPeriod(TLineNumberType lineNumber, 
                                                            RefCDOmSpecifyBlock parent, 
                                                            RefCDOmTimingCheckEvent controlledReferenceEvent, 
                                                            RefCDOmExpr timingCheckLimit, 
                                                            RefCDOmExprLink notifyReg
                                                            ) {
  ASSERT(controlledReferenceEvent.get(), "controlledReferenceEvent is NULL");
  ASSERT(controlledReferenceEvent->canBeControlled(), "[CDOmSystemTimingCheck::buildPeriod()] illegal state for this method call.");
  //if(!controlledReferenceEvent->canBeControlled())
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::buildPeriod()] illegal state for this method call.", lineNumber);
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }

  return build(lineNumber, parent, TIMING_CHECK_PERIOD, RefCDOmTimingCheckEvent(), RefCDOmTimingCheckEvent(), timingCheckLimit, controlledReferenceEvent,
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), RefCDOmExpr(), RefCDOmExpr(), notifyReg);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildWidth(TLineNumberType lineNumber, 
                                                           RefCDOmSpecifyBlock parent,  
                                                           RefCDOmTimingCheckEvent controlledReferenceEvent, 
                                                           RefCDOmExpr timingCheckLimit, 
                                                           RefCDOmExpr threshold, 
                                                           RefCDOmExprLink notifyReg
                                                           ) {
  ASSERT(controlledReferenceEvent.get(), "controlledReferenceEvent is NULL");
  ASSERT(controlledReferenceEvent->canBeControlled(), "[CDOmSystemTimingCheck::buildWidth()] illegal state for this method call.");
  //if(!controlledReferenceEvent->canBeControlled())
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::buildWidth()] illegal state for this method call.", lineNumber);
  ASSERT(timingCheckLimit.get(), "timingCheckLimit is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }

  return build(lineNumber, parent, TIMING_CHECK_WIDTH, RefCDOmTimingCheckEvent(), RefCDOmTimingCheckEvent(), timingCheckLimit, controlledReferenceEvent,
               RefCDOmMinTypMax(), RefCDOmMinTypMax(), threshold, RefCDOmExpr(), notifyReg);
}

RefCDOmSystemTimingCheck CDOmSystemTimingCheck::buildNochange(TLineNumberType lineNumber, 
                                                              RefCDOmSpecifyBlock parent,  
                                                              RefCDOmTimingCheckEvent referenceEvent, 
                                                              RefCDOmTimingCheckEvent dataEvent, 
                                                              RefCDOmMinTypMax startEdgeOffset, 
                                                              RefCDOmMinTypMax endEdgeOffset, 
                                                              RefCDOmExprLink notifyReg
                                                              ) {
  ASSERT(referenceEvent.get(), "referenceEvent is NULL");
  ASSERT(dataEvent.get(), "dataEvent is NULL");
  ASSERT(startEdgeOffset.get(), "startEdgeOffset is NULL");
  ASSERT(endEdgeOffset.get(), "endEdgeOffset is NULL");
  if(notifyReg.get()) {
    ASSERT(!notifyReg->isHID(), "notifyReg should not be HID");
    ASSERT(notifyReg->getRangeExpr() == RefCDOmRangeExpr(), "notifyReg should has NULL RangeExpr");
    ASSERT(notifyReg->getArrayIndexes() == RefCDOmListExpr(), "notifyReg should has NULL ArrayIndexes");
  }

  return build(lineNumber, parent, TIMING_CHECK_NOCHANGE, referenceEvent, dataEvent, RefCDOmExpr(), RefCDOmTimingCheckEvent(),
               startEdgeOffset, endEdgeOffset, RefCDOmExpr(), RefCDOmExpr(), notifyReg);
}

CDOmSystemTimingCheck::ETimingCheckType CDOmSystemTimingCheck::getTimingCheckType() const {
  return m_timingCheckType;
}

const RefCDOmTimingCheckEvent CDOmSystemTimingCheck::getDataEvent() const {
  ASSERT(m_timingCheckType != TIMING_CHECK_PERIOD && m_timingCheckType != TIMING_CHECK_WIDTH, "[CDOmSystemTimingCheck::getDataEvent()] illegal state for this method call.");
  //if(m_timingCheckType == TIMING_CHECK_PERIOD || m_timingCheckType == TIMING_CHECK_WIDTH )
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getDataEvent()] illegal state for this method call.", m_lineNumber);
  //return boost::static_pointer_cast<CDOmTimingCheckEvent>(m_children->at(1));     
  RefCDOmBase timingcheckeventAsBase = getChild(1);
  RefCDOmTimingCheckEvent timingcheckevent = CDOmTimingCheckEvent::cast(timingcheckeventAsBase);
  return timingcheckevent;
}
  
const RefCDOmTimingCheckEvent CDOmSystemTimingCheck::getReferenceEvent() const {
  ASSERT(m_timingCheckType != TIMING_CHECK_PERIOD && m_timingCheckType != TIMING_CHECK_WIDTH, "[CDOmSystemTimingCheck::getReferenceEvent()] illegal state for this method call.");
  //if(m_timingCheckType == TIMING_CHECK_PERIOD || m_timingCheckType == TIMING_CHECK_WIDTH )
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getReferenceEvent()] illegal state for this method call.", m_lineNumber);
  //return boost::static_pointer_cast<CDOmTimingCheckEvent>(m_children->at(0)); 
  RefCDOmBase timingcheckeventAsBase = getChild(0);
  RefCDOmTimingCheckEvent timingcheckevent = CDOmTimingCheckEvent::cast(timingcheckeventAsBase);
  return timingcheckevent;
}

const RefCDOmExpr CDOmSystemTimingCheck::getTimingCheckLimit1() const {
  ASSERT(m_timingCheckType != TIMING_CHECK_NOCHANGE, "[CDOmSystemTimingCheck::getTimingCheckLimit1()] illegal state for this method call.");
  //if(m_timingCheckType == TIMING_CHECK_NOCHANGE)
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getTimingCheckLimit1()] illegal state for this method call.", m_lineNumber);
  if(m_timingCheckType == TIMING_CHECK_PERIOD || m_timingCheckType == TIMING_CHECK_WIDTH){
    //return boost::static_pointer_cast<CDOmExpr>(m_children->at(0)); 
    RefCDOmBase exprAsBase = getChild(0);
    RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
    return expr;
  }
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(2)); 
  RefCDOmBase expr2AsBase = getChild(2);
  RefCDOmExpr expr2 = CDOmExpr::cast(expr2AsBase);
  return expr2;
}

const RefCDOmExpr CDOmSystemTimingCheck::getTimingCheckLimit2() const {
  ASSERT(m_timingCheckType == TIMING_CHECK_SETUPHOLD || m_timingCheckType == TIMING_CHECK_RECREM || m_timingCheckType == TIMING_CHECK_FULLSKEW, "[CDOmSystemTimingCheck::getTimingCheckLimit2()] illegal state for this method call.");
  //if(m_timingCheckType != TIMING_CHECK_SETUPHOLD && m_timingCheckType!= TIMING_CHECK_RECREM && m_timingCheckType!= TIMING_CHECK_FULLSKEW)
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getTimingCheckLimit2()] illegal state for this method call.", m_lineNumber);
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(3)); 
  RefCDOmBase exprAsBase = getChild(3);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

const RefCDOmExprLink CDOmSystemTimingCheck::getNotifyReg() const {
  if(m_optional[0]) {
    if(m_timingCheckType == TIMING_CHECK_PERIOD){
      //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(2)); 
      RefCDOmBase exprlinkAsBase = getChild(2);
      RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
      return exprlink;
    }
    if(m_timingCheckType == TIMING_CHECK_SETUPHOLD || m_timingCheckType == TIMING_CHECK_RECREM 
       || m_timingCheckType == TIMING_CHECK_FULLSKEW || m_timingCheckType == TIMING_CHECK_NOCHANGE){
      //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(4)); 
      RefCDOmBase exprlinkAsBase = getChild(4);
      RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
      return exprlink;
    }
    //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(3)); 
    RefCDOmBase exprlinkAsBase = getChild(3);
    RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
    return exprlink;
  }
  else {
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getNotifyReg()] optional parameter not set.", m_lineNumber);
    return RefCDOmExprLink();
  }
}

const RefCDOmMinTypMax CDOmSystemTimingCheck::getStampTimeCondition() const {
  if(m_optional[1]) {
    ASSERT(m_timingCheckType == TIMING_CHECK_SETUPHOLD || m_timingCheckType == TIMING_CHECK_RECREM, "[CDOmSystemTimingCheck::getStampTimeCondition()] illegal state for this method call.");
    //if(m_timingCheckType!= TIMING_CHECK_SETUPHOLD && m_timingCheckType!= TIMING_CHECK_RECREM )
    //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getStampTimeCondition()] illegal state for this method call.", m_lineNumber);
    if(m_optional[0]){
      //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(5)); 
      RefCDOmBase mintypmaxAsBase = getChild(5);
      RefCDOmMinTypMax mintypmax = CDOmMinTypMax::cast(mintypmaxAsBase);
      return mintypmax;
    }
    else {
      //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(4)); 
      RefCDOmBase mintypmaxAsBase = getChild(4);
      RefCDOmMinTypMax mintypmax = CDOmMinTypMax::cast(mintypmaxAsBase);
      return mintypmax;
    }
  }
  else
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getStampTimeCondition()] optional parameter not set.", m_lineNumber);
    return RefCDOmMinTypMax();
}

const RefCDOmMinTypMax CDOmSystemTimingCheck::getCheckTimeCondition() const {
  if(m_optional[2]) {
    ASSERT(m_timingCheckType == TIMING_CHECK_SETUPHOLD || m_timingCheckType == TIMING_CHECK_RECREM, "[CDOmSystemTimingCheck::getCheckTimeCondition()] illegal state for this method call.");
    //if(m_timingCheckType!= TIMING_CHECK_SETUPHOLD && m_timingCheckType!= TIMING_CHECK_RECREM )
    //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getCheckTimeCondition()] illegal state for this method call.", m_lineNumber);
    int s=0;
    for(int i=0; i<2; ++i)    
      s+=m_optional[i];//s=number of set parameters ahead of checkTimeCondition
    //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(s+4));
    TInt idx=s+4;
    RefCDOmBase minTypMaxAsBase = getChild(idx);
    RefCDOmMinTypMax minTypMax = CDOmMinTypMax::cast(minTypMaxAsBase);
    return minTypMax;
  }
  else
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getCheckTimeCondition()] optional parameter not set.", m_lineNumber);
    return RefCDOmMinTypMax();
}

const RefCDOmDelayedDataOrReference CDOmSystemTimingCheck::getDelayedReference() const {
  if(m_optional[3]) {
    ASSERT(m_timingCheckType == TIMING_CHECK_SETUPHOLD || m_timingCheckType == TIMING_CHECK_RECREM, "[CDOmSystemTimingCheck::getDelayedReference()] illegal state for this method call.");
    //if(m_timingCheckType!= TIMING_CHECK_SETUPHOLD && m_timingCheckType!= TIMING_CHECK_RECREM )
    //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getDelayedReference()] illegal state for this method call.", m_lineNumber);
    int s=0;
    for(int i=0; i<3; ++i)    
      s+=m_optional[i];//s=number of set parameters ahead of delayedReference
    //return boost::static_pointer_cast<CDOmDelayedDataOrReference>(m_children->at(s+4)); 
    TInt idx=s+4;
    RefCDOmBase delayDataOrReferenceAsBase = getChild(idx);
    RefCDOmDelayedDataOrReference delayDataOrReference = CDOmDelayedDataOrReference::cast(delayDataOrReferenceAsBase);
    return delayDataOrReference;
  }
  else
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getDelayedReference()] optional parameter not set.", m_lineNumber);
    return RefCDOmDelayedDataOrReference();
}

const RefCDOmDelayedDataOrReference CDOmSystemTimingCheck::getDelayedData() const {
  if(m_optional[4]) {
    ASSERT(m_timingCheckType == TIMING_CHECK_SETUPHOLD || m_timingCheckType == TIMING_CHECK_RECREM, "[CDOmSystemTimingCheck::getDelayedData()] illegal state for this method call.");
    //if(m_timingCheckType!= TIMING_CHECK_SETUPHOLD && m_timingCheckType!= TIMING_CHECK_RECREM )
    //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getDelayedData()] illegal state for this method call.", m_lineNumber);
    int s=0;
    for(int i=0; i<4; ++i)    
      s+=m_optional[i];//s=number of set parameters ahead of delayedData
    //return boost::static_pointer_cast<CDOmDelayedDataOrReference>(m_children->at(s+4)); 
    TInt idx=s+4;
    RefCDOmBase delayDataOrReferenceAsBase = getChild(idx);
    RefCDOmDelayedDataOrReference delayDataOrReference = CDOmDelayedDataOrReference::cast(delayDataOrReferenceAsBase);
    return delayDataOrReference;
  }
  else
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getDelayedData()] optional parameter not set.", m_lineNumber);
    return RefCDOmDelayedDataOrReference();
}

const RefCDOmExpr CDOmSystemTimingCheck::getEventBasedFlag() const {
  if(m_optional[5]) {
    if(m_timingCheckType == TIMING_CHECK_TIMESKEW ) {
      if(m_optional[0]){
        //return boost::static_pointer_cast<CDOmExpr>(m_children->at(4)); 
        RefCDOmBase exprAsBase = getChild(4);
        RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
        return expr;
      }
      else {
        //return boost::static_pointer_cast<CDOmExpr>(m_children->at(3)); 
        RefCDOmBase exprAsBase = getChild(3);
        RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
        return expr;
      }
    }
    if(m_timingCheckType == TIMING_CHECK_FULLSKEW ) {
      if(m_optional[0]){
        //return boost::static_pointer_cast<CDOmExpr>(m_children->at(5)); 
        RefCDOmBase exprAsBase = getChild(5);
        RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
        return expr;
      }
      else{
        //return boost::static_pointer_cast<CDOmExpr>(m_children->at(4)); 
        RefCDOmBase exprAsBase = getChild(4);
        RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
        return expr;
      }
    }
    ASSERT(FAIL, "[CDOmSystemTimingCheck::getEventBasedFlag()] illegal state for this method call.");
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getEventBasedFlag()] illegal state for this method call.", m_lineNumber);
  }
  else
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getEventBasedFlag()] optional parameter not set.", m_lineNumber);
    return RefCDOmExpr();
}

const RefCDOmMinTypMax CDOmSystemTimingCheck::getRemainActiveFlag() const {
  if(m_optional[6]) {
    if(m_timingCheckType == TIMING_CHECK_TIMESKEW ){
      //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(m_optional[0] + m_optional[5] + 3));
      TInt idx = m_optional[0] + m_optional[5] + 3;
      RefCDOmBase minTypMaxAsBase = getChild(idx);
      RefCDOmMinTypMax minTypMax = CDOmMinTypMax::cast(minTypMaxAsBase);
      return minTypMax;
    }
    if(m_timingCheckType == TIMING_CHECK_FULLSKEW ){
      //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(m_optional[0]+m_optional[5]+4)); 
      TInt idx = m_optional[0]+m_optional[5]+4;
      RefCDOmBase minTypMaxAsBase = getChild(idx);
      RefCDOmMinTypMax minTypMax = CDOmMinTypMax::cast(minTypMaxAsBase);
      return minTypMax;
    }
    ASSERT(FAIL, "[CDOmSystemTimingCheck::getRemainActiveFlag()] illegal state for this method call.");
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getRemainActiveFlag()] illegal state for this method call.", m_lineNumber);
  }
  else
    //throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getRemainActiveFlag()] optional parameter not set.", m_lineNumber);
    return RefCDOmMinTypMax();
}

const RefCDOmTimingCheckEvent CDOmSystemTimingCheck::getControlledReferenceEvent() const {
  ASSERT(m_timingCheckType == TIMING_CHECK_PERIOD || m_timingCheckType == TIMING_CHECK_WIDTH, "[CDOmSystemTimingCheck::getControlledReferenceEvent()] illegal state for this method call.");
  //if(m_timingCheckType!= TIMING_CHECK_PERIOD && m_timingCheckType!= TIMING_CHECK_WIDTH )
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getControlledReferenceEvent()] illegal state for this method call.", m_lineNumber);
  //return boost::static_pointer_cast<CDOmTimingCheckEvent>(m_children->at(1)); 
  RefCDOmBase timingCheckEventAsBase = getChild(1);
  RefCDOmTimingCheckEvent timingCheckEvent = CDOmTimingCheckEvent::cast(timingCheckEventAsBase);
  return timingCheckEvent;
}

const RefCDOmExpr CDOmSystemTimingCheck::getThreshold() const {
  if(m_optional[7]) {
    ASSERT(m_timingCheckType == TIMING_CHECK_WIDTH, "[CDOmSystemTimingCheck::getThreshold()] illegal state for this method call.");
    //if(m_timingCheckType!= TIMING_CHECK_WIDTH )
    //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getThreshold()] illegal state for this method call.", m_lineNumber);
    //return boost::static_pointer_cast<CDOmExpr>(m_children->at(2)); 
    RefCDOmBase exprAsBase = getChild(2);
    RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
    return expr;
  }
  else {
    return RefCDOmExpr();
  }
}

const RefCDOmMinTypMax CDOmSystemTimingCheck::getStartEdgeOffset() const {
  ASSERT(m_timingCheckType == TIMING_CHECK_NOCHANGE, "[CDOmSystemTimingCheck::getStartEdgeOffset()] illegal state for this method call.");
  //if(m_timingCheckType!= TIMING_CHECK_NOCHANGE )
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getStartEdgeOffset()] illegal state for this method call.", m_lineNumber);
  //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(2)); 
  RefCDOmBase mintypmaxAsBase = getChild(2);
  RefCDOmMinTypMax mintypmax = CDOmMinTypMax::cast(mintypmaxAsBase);
  return mintypmax;
}

const RefCDOmMinTypMax CDOmSystemTimingCheck::getEndEdgeOffset() const {
  ASSERT(m_timingCheckType == TIMING_CHECK_NOCHANGE, "[CDOmSystemTimingCheck::getEndEdgeOffset()] illegal state for this method call.");
  //if(m_timingCheckType!= TIMING_CHECK_NOCHANGE )
  //  throw NSBase::IllegalStateException("[CDOmSystemTimingCheck::getEndEdgeOffset()] illegal state for this method call.", m_lineNumber);
  //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(3)); 
  RefCDOmBase mintypmaxAsBase = getChild(3);
  RefCDOmMinTypMax mintypmax = CDOmMinTypMax::cast(mintypmaxAsBase);
  return mintypmax;
}

void CDOmSystemTimingCheck::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmDelayedDataOrReference class
// ********************************************************************************
CDOmDelayedDataOrReference::CDOmDelayedDataOrReference(TLineNumberType lineNumber) : CDOmBase(TYPE_DELAYED_DATA_OR_REFERENCE, lineNumber) { };

RefCDOmDelayedDataOrReference CDOmDelayedDataOrReference::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmDelayedDataOrReference();
  }
  ASSERT(object->getType() == TYPE_DELAYED_DATA_OR_REFERENCE, "type check on CDOmDelayedDataOrReference::cast failure");
  return boost::static_pointer_cast<CDOmDelayedDataOrReference>(object);
}

RefCDOmDelayedDataOrReference CDOmDelayedDataOrReference::build(TLineNumberType lineNumber, RefCDOmExprLink terminalIdentifier, RefCDOmMinTypMax minTypMax) {
  ASSERT(terminalIdentifier.get(), "terminalIdentifier is NULL");
  ASSERT(!terminalIdentifier->isHID(), "terminalIdentifier should not be HID");
  ASSERT(terminalIdentifier->getRangeExpr() == RefCDOmRangeExpr(), "terminalIdentifier should has NULL RangeExpr");
  ASSERT(terminalIdentifier->getArrayIndexes() == RefCDOmListExpr(), "terminalIdentifier should has NULL ArrayIndexes");

  CDOmDelayedDataOrReference *delayedDataOrReference = new CDOmDelayedDataOrReference(lineNumber);
  RefCDOmDelayedDataOrReference refDelayedDataOrReference = RefCDOmDelayedDataOrReference(delayedDataOrReference);
  delayedDataOrReference->m_weakRef = boost::weak_ptr<CDOmBase>( refDelayedDataOrReference);
  
  terminalIdentifier->setParent(refDelayedDataOrReference);
  if(minTypMax.get())
    minTypMax->setParent(refDelayedDataOrReference);

  return refDelayedDataOrReference;
}

const RefCDOmExprLink CDOmDelayedDataOrReference::getTerminalIdentifier() const {
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprlinkAsBase = getChild(0);
  RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
  return exprlink;
}
const RefCDOmMinTypMax CDOmDelayedDataOrReference::getMinTypMax() const {
  //if((m_children->at(1)).get()){
  if(getChildrenSize() > 1){   
    //if((getChild(1)).get()){
    //return boost::static_pointer_cast<CDOmMinTypMax>(m_children->at(1));
    RefCDOmBase mintypmaxAsBase = getChild(1);
    RefCDOmMinTypMax mintypmax = CDOmMinTypMax::cast(mintypmaxAsBase);
    return mintypmax;
  }
  else
    //throw NSBase::IllegalStateException("[CDOmDelayedDataOrReference::getMinTypMax()] optional parameter not set.", m_lineNumber);
    return RefCDOmMinTypMax();
}

void CDOmDelayedDataOrReference::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmTimingCheckEventControl class
// ********************************************************************************
CDOmTimingCheckEventControl::CDOmTimingCheckEventControl(TLineNumberType lineNumber, ETimingCheckType timingCheckType) 
  : CDOmBase(TYPE_TIMING_CHECK_EVENT_CONTROL, lineNumber), m_timingCheckType(timingCheckType), m_edgeDescriptor(RefTVec_TInt(new TVec_TInt())) { }
  
RefCDOmTimingCheckEventControl CDOmTimingCheckEventControl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmTimingCheckEventControl();
  }
  ASSERT(object->getType() == TYPE_TIMING_CHECK_EVENT_CONTROL, "type check on CDOmTimingCheckEventControl::cast failure");
  return boost::static_pointer_cast<CDOmTimingCheckEventControl>(object);
}

RefCDOmTimingCheckEventControl CDOmTimingCheckEventControl::build(TLineNumberType lineNumber, ETimingCheckType timingCheckType) {
  CDOmTimingCheckEventControl *timingCheckEventControl = new CDOmTimingCheckEventControl(lineNumber, timingCheckType);
  RefCDOmTimingCheckEventControl refTimingCheckEventControl = RefCDOmTimingCheckEventControl(timingCheckEventControl);
  timingCheckEventControl->m_weakRef = boost::weak_ptr<CDOmBase>( refTimingCheckEventControl);
    
  return refTimingCheckEventControl;
}

RefCDOmTimingCheckEventControl CDOmTimingCheckEventControl::buildPosedge(TLineNumberType lineNumber) {
  return build(lineNumber, TIMING_CHECK_EV_POSEDGE);
}

RefCDOmTimingCheckEventControl CDOmTimingCheckEventControl::buildNegedge(TLineNumberType lineNumber) {
  return build(lineNumber, TIMING_CHECK_EV_NEGEDGE);
}

RefCDOmTimingCheckEventControl CDOmTimingCheckEventControl::buildEdge(TLineNumberType lineNumber) {
  return build(lineNumber, TIMING_CHECK_EV_EDGE);
}
  
CDOmTimingCheckEventControl::ETimingCheckType CDOmTimingCheckEventControl::getTimingCheckType() const {
  return m_timingCheckType;
}

void CDOmTimingCheckEventControl::addEdgeDescriptor(EEdgeDescriptor edgeDescriptor) {
  ASSERT(m_timingCheckType == TIMING_CHECK_EV_EDGE, "[CDOmTimingCheckEventControl::addEdgeDescriptor()] illegal state for this method call.");
  //if(m_timingCheckType!=TIMING_CHECK_EV_EDGE)
  //  throw NSBase::IllegalStateException("[CDOmTimingCheckEventControl::addEdgeDescriptor()] illegal state for this method call.", m_lineNumber);
  m_edgeDescriptor->push_back(edgeDescriptor);
}

RefTVec_TInt CDOmTimingCheckEventControl::getEdgeDescriptors() const {
  ASSERT(m_timingCheckType == TIMING_CHECK_EV_EDGE, "[CDOmTimingCheckEventControl::getEdgeDescriptor()] illegal state for this method call.");
  //if(m_timingCheckType!=TIMING_CHECK_EV_EDGE)
  //  throw NSBase::IllegalStateException("[CDOmTimingCheckEventControl::getEdgeDescriptor()] illegal state for this method call.", m_lineNumber);
  return m_edgeDescriptor;
}

void CDOmTimingCheckEventControl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmTimingCheckEvent class
// ********************************************************************************
CDOmTimingCheckEvent::CDOmTimingCheckEvent(TLineNumberType lineNumber,  TInt hasTimingCheckEventControl,TInt hasTimingCheckCondition) 
  : CDOmBase(TYPE_TIMING_CHECK_EVENT, lineNumber), m_hasTimingCheckCondition(hasTimingCheckCondition), m_hasTimingCheckEventControl(hasTimingCheckEventControl) { } 
  
RefCDOmTimingCheckEvent CDOmTimingCheckEvent::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmTimingCheckEvent();
  }
  ASSERT(object->getType() == TYPE_TIMING_CHECK_EVENT, "type check on CDOmTimingCheckEvent::cast failure");
  return boost::static_pointer_cast<CDOmTimingCheckEvent>(object);
}

RefCDOmTimingCheckEvent CDOmTimingCheckEvent::build(TLineNumberType lineNumber, 
                                                    RefCDOmExprLink specifyTerminalDescriptor, 
                                                    RefCDOmTimingCheckEventControl timingCheckEventControl, 
                                                    RefCDOmExpr timingCheckCondition
                                                    ) {
  ASSERT(specifyTerminalDescriptor.get(), "specifyTerminalDescriptor is NULL");
  TInt flag1 = 0;
  TInt flag2 = 0;
  if(timingCheckEventControl.get())
    flag1=1;
  if(timingCheckCondition.get())
    flag2=1;
  
  CDOmTimingCheckEvent *timingCheckEvent = new CDOmTimingCheckEvent(lineNumber,flag1,flag2);
  RefCDOmTimingCheckEvent refTimingCheckEvent= RefCDOmTimingCheckEvent(timingCheckEvent);
  timingCheckEvent->m_weakRef = boost::weak_ptr<CDOmBase>( refTimingCheckEvent);

  if(timingCheckEventControl.get()) 
    timingCheckEventControl->setParent(refTimingCheckEvent);
  specifyTerminalDescriptor->setParent(refTimingCheckEvent);
  if(timingCheckCondition.get()) 
    timingCheckCondition->setParent(refTimingCheckEvent);
  
  return refTimingCheckEvent;  
}

TBool CDOmTimingCheckEvent::canBeControlled() const {
  return (m_hasTimingCheckEventControl) ? true : false;
}

TBool CDOmTimingCheckEvent::hasTimingCheckCondition() const {
  return (m_hasTimingCheckCondition) ? true : false;
}

const RefCDOmExprLink CDOmTimingCheckEvent::getSpecifyTerminalDescriptor() const {
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprlinkAsBase = getChild(0);
  RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
  return exprlink;
}

const RefCDOmTimingCheckEventControl CDOmTimingCheckEvent::getTimingCheckEventControl() const {
  ASSERT(m_hasTimingCheckEventControl, "[CDOmTimingCheckEvent::getTimingCheckEventControl()] optional parameter not set.");
  //return boost::static_pointer_cast<CDOmTimingCheckEventControl>(m_children->at(1));
  RefCDOmBase timingcheckeventcontrolAsBase = getChild(1);
  RefCDOmTimingCheckEventControl timingcheckeventcontrol = CDOmTimingCheckEventControl::cast(timingcheckeventcontrolAsBase);
  return timingcheckeventcontrol;
}

const RefCDOmExpr CDOmTimingCheckEvent::getTimingCheckCondition() const {
  ASSERT(m_hasTimingCheckCondition, "[CDOmTimingCheckEvent::getTimingCheckCondition()] optional parameter not set.");
  if(m_hasTimingCheckEventControl){
    //return boost::static_pointer_cast<CDOmExpr>(m_children->at(2));
    RefCDOmBase exprAsBase = getChild(2);
    RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
    return expr;
  }
  else{
    //return boost::static_pointer_cast<CDOmExpr>(m_children->at(1));
    RefCDOmBase exprAsBase = getChild(1);
    RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
    return expr;
  }
}

void CDOmTimingCheckEvent::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmPathDecl class
// ********************************************************************************
CDOmPathDecl::CDOmPathDecl(TLineNumberType lineNumber, unsigned char type) : CDOmBase(TYPE_PATH_DECL, lineNumber), m_type(type) { }
const unsigned char CDOmPathDecl::PATH_DECL_TYPE_MASK            = 0x07;
const unsigned char CDOmPathDecl::PATH_DECL_RANGE_MASK           = 0x08;
const unsigned char CDOmPathDecl::PATH_DECL_EDGE_IDENTIFIER_MASK = 0x30;
const unsigned char CDOmPathDecl::PATH_DECL_POLARY_OP_MASK       = 0xC0;

RefCDOmPathDecl CDOmPathDecl::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmPathDecl();
  }
  ASSERT(object->getType() == TYPE_PATH_DECL, "type check on CDOmPathDecl::cast failure");
  return boost::static_pointer_cast<CDOmPathDecl>(object);
}

RefCDOmPathDecl CDOmPathDecl::build(TLineNumberType lineNumber, 
                                    RefCDOmSpecifyBlock   parent,
                                    EPathDeclType         type,
                                    RefCDOmBase           specInptTermDesc,
                                    RefCDOmBase           specOutTermDesc,
                                    RefCDOmPathDelayValue pathDelayValue,
                                    EPathDeclPolarityOp   polOp,
                                    EPathDeclEdgeIdenfier edge,
                                    RefCDOmExpr           dataSourceExpr,
                                    RefCDOmExpr           modulePathExpr
                                    ) {
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(specInptTermDesc.get(), "specInptTermDesc is NULL");
  ASSERT(specOutTermDesc.get(), "specOutTermDesc is NULL");
  ASSERT(pathDelayValue.get(), "pathDelayValue is NULL");
  ASSERT( specInptTermDesc->getType() == TYPE_EXPR 
          && boost::static_pointer_cast<CDOmExpr>(specInptTermDesc)->getExprType() == CDOmExpr::EXPR_HID
          && specOutTermDesc->getType() == TYPE_EXPR 
          && boost::static_pointer_cast<CDOmExpr>(specOutTermDesc)->getExprType() == CDOmExpr::EXPR_HID
          && (validateSpecifyTerminal(boost::static_pointer_cast<CDOmExprLink>(specInptTermDesc)), validateSpecifyTerminal(boost::static_pointer_cast<CDOmExprLink>(specOutTermDesc)), true)
          || specInptTermDesc->getType() == TYPE_SPEC_TERM_LIST
          && specOutTermDesc->getType() == TYPE_SPEC_TERM_LIST
          , "type check on CDOmPathDecl::build failure");

  switch(type) {
    case PATH_DECL_SIMPLE:
      ASSERT(edge == PATH_DECL_NOEDGE, "edge has illegal type");
      ASSERT(!dataSourceExpr.get(), "dataSourceExpr should be NULL");
      ASSERT(!modulePathExpr.get(), "modulePathExpr should be NULL");
      break;
    case PATH_DECL_EDGE:
      ASSERT(dataSourceExpr.get(), "dataSourceExpr is NULL");
      ASSERT(!modulePathExpr.get(), "modulePathExpr should be NULL");
      break;
    case PATH_DECL_SIMPLE_IF:
      ASSERT(edge == PATH_DECL_NOEDGE, "edge has illegal type");
      ASSERT(!dataSourceExpr.get(), "dataSourceExpr should be NULL");
      ASSERT(modulePathExpr.get(), "modulePathExpr is NULL");
      ASSERT(modulePathExpr->canBeModulePath(), "modulePathExpr is not module path");
      break;
    case PATH_DECL_EDGE_IF:
      ASSERT(dataSourceExpr.get(), "dataSourceExpr is NULL");
      ASSERT(modulePathExpr.get(), "modulePathExpr is NULL");
      ASSERT(modulePathExpr->canBeModulePath(), "modulePathExpr is not module path");
      break;
    case PATH_DECL_SIMPLE_IFNONE:
      ASSERT(edge == PATH_DECL_NOEDGE, "edge has illegal type");
      ASSERT(!dataSourceExpr.get(), "dataSourceExpr should be NULL");
      ASSERT(!modulePathExpr.get(), "modulePathExpr should be NULL");
      break;
    default:
      ASSERT(0, "");
  }
  EPathDeclRange range;
  if(specInptTermDesc->getType() == TYPE_SPEC_TERM_LIST)
    range = PATH_DECL_FULL;
  else
    range = PATH_DECL_PARALLEL;
  
  CDOmPathDecl *pathDeclaration = new CDOmPathDecl(lineNumber,type | polOp | edge | range);
  RefCDOmPathDecl refPathDeclaration = RefCDOmPathDecl(pathDeclaration);
  pathDeclaration->m_weakRef = boost::weak_ptr<CDOmBase>( refPathDeclaration);
  pathDeclaration->setParent(parent);//self registration

  //changed the order of calls to match ebnf
  if(modulePathExpr.get())
    modulePathExpr->setParent(refPathDeclaration);

  specInptTermDesc->setParent(refPathDeclaration);
  specOutTermDesc->setParent(refPathDeclaration);
  
  if(dataSourceExpr.get())
    dataSourceExpr->setParent(refPathDeclaration);

  pathDelayValue->setParent(refPathDeclaration);

  return refPathDeclaration;
}

CDOmPathDecl::EPathDeclType CDOmPathDecl::getType() const {
  return EPathDeclType(m_type & PATH_DECL_TYPE_MASK);
}

CDOmPathDecl::EPathDeclRange CDOmPathDecl::getRange() const {
  return EPathDeclRange(m_type & PATH_DECL_RANGE_MASK);
}

CDOmPathDecl::EPathDeclEdgeIdenfier CDOmPathDecl::getEdgeIdentifier() const {
  ASSERT(getType() == PATH_DECL_EDGE_IF || getType() == PATH_DECL_EDGE, "[CDOmPathDecl::getEdgeIdentifier() const] illegal state for this method call");
  //if( getType() != PATH_DECL_EDGE_IF && getType() != PATH_DECL_EDGE)
  //  throw NSBase::IllegalStateException("[CDOmPathDecl::getEdgeIdentifier() const] illegal state for this method call", m_lineNumber);
  return EPathDeclEdgeIdenfier(m_type & PATH_DECL_EDGE_IDENTIFIER_MASK);
}

CDOmPathDecl::EPathDeclPolarityOp CDOmPathDecl::getPolarityOp() const {
  return EPathDeclPolarityOp(m_type & PATH_DECL_POLARY_OP_MASK);
}

const RefCDOmExprLink CDOmPathDecl::getInputTerminalDescriptor() const {
  ASSERT(getRange() == PATH_DECL_PARALLEL, "[CDOmPathDecl::getInputTerminalDescriptor() const] illegal state for this method call");
  //if(getRange() != PATH_DECL_PARALLEL)
  //  throw NSBase::IllegalStateException("[CDOmPathDecl::getInputTerminalDescriptor() const] illegal state for this method call", m_lineNumber);
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(0));
  RefCDOmBase exprlinkAsBase = getChild(0);
  RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
  return exprlink;
}

const RefCDOmExprLink CDOmPathDecl::getOutputTerminalDescriptor() const {
  ASSERT(getRange() == PATH_DECL_PARALLEL, "[CDOmPathDecl::getOutputTerminalDescriptor() const] illegal state for this method call");
  //if(getRange() != PATH_DECL_PARALLEL)
  //  throw NSBase::IllegalStateException("[CDOmPathDecl::getOutputTerminalDescriptor() const] illegal state for this method call", m_lineNumber);
  //return boost::static_pointer_cast<CDOmExprLink>(m_children->at(1));
  RefCDOmBase exprlinkAsBase = getChild(1);
  RefCDOmExprLink exprlink = CDOmExprLink::cast(exprlinkAsBase);
  return exprlink;
  
}

const RefCDOmSpecifyTerminalList CDOmPathDecl::getListOfPathInputs() const {
  ASSERT(getRange() == PATH_DECL_FULL, "[CDOmPathDecl::getListOfPathInputs() const] illegal state for this method call");
  //if(getRange() != PATH_DECL_FULL)
  //  throw NSBase::IllegalStateException("[CDOmPathDecl::getListOfPathInputs() const] illegal state for this method call", m_lineNumber);
  return boost::static_pointer_cast<CDOmSpecifyTerminalList>(m_children->at(0));
  /*RefCDOmBase specifyterminallistAsBase = getChild(0);
    RefCDOmSpecifyTerminalList specifyterminallist = CDOmSpecifyTerminalList::cast(specifyterminallistAsBase);
    return specifyterminallist;*/
}

const RefCDOmSpecifyTerminalList CDOmPathDecl::getListOfPathOutputs() const {
  ASSERT(getRange() == PATH_DECL_FULL, "[CDOmPathDecl::getListOfPathOutputs() const] illegal state for this method call");
  //if(getRange() != PATH_DECL_FULL)
  //  throw NSBase::IllegalStateException("[CDOmPathDecl::getListOfPathOutputs() const] illegal state for this method call", m_lineNumber);
  return boost::static_pointer_cast<CDOmSpecifyTerminalList>(m_children->at(1));
  /*RefCDOmBase specifyterminallistAsBase = getChild(1);
    RefCDOmSpecifyTerminalList specifyterminallist = CDOmSpecifyTerminalList::cast(specifyterminallistAsBase);
    return specifyterminallist;*/
}

const RefCDOmPathDelayValue CDOmPathDecl::getPathDelayValue() const {
  //return boost::static_pointer_cast<CDOmPathDelayValue>(m_children->at(2));
  RefCDOmBase pathdelayvalueAsBase = getChild(2);
  RefCDOmPathDelayValue pathdelayvalue = CDOmPathDelayValue::cast(pathdelayvalueAsBase);
  return pathdelayvalue;
}

const RefCDOmExpr CDOmPathDecl::getDataSourceExpression() const {
  ASSERT(getType() == PATH_DECL_EDGE || getType() == PATH_DECL_EDGE_IF, "[CDOmPathDecl::getDataSourceExpression() const] illegal state for this method call");
  //if(getType() != PATH_DECL_EDGE && getType() != PATH_DECL_EDGE_IF)
  //  throw NSBase::IllegalStateException("[CDOmPathDecl::getDataSourceExpression() const] illegal state for this method call", m_lineNumber);
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(3));
  RefCDOmBase exprAsBase = getChild(3);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

const RefCDOmExpr CDOmPathDecl::getModulePathExpr() const {
  ASSERT(getType() == PATH_DECL_SIMPLE_IF || getType() == PATH_DECL_EDGE_IF, "[CDOmPathDecl::getModulePathExpr() const] illegal state for this method call");
  //if(getType() != PATH_DECL_SIMPLE_IF && getType() != PATH_DECL_EDGE_IF)
  //  throw NSBase::IllegalStateException("[CDOmPathDecl::getModulePathExpr() const] illegal state for this method call", m_lineNumber);
  if( getType() == PATH_DECL_EDGE_IF ){
    //return boost::static_pointer_cast<CDOmExpr>(m_children->at(4));
    RefCDOmBase exprAsBase = getChild(4);
    RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
    return expr;
  }
  //return boost::static_pointer_cast<CDOmExpr>(m_children->at(3));
  RefCDOmBase exprAsBase = getChild(3);
  RefCDOmExpr expr = CDOmExpr::cast(exprAsBase);
  return expr;
}

void CDOmPathDecl::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

// ********************************************************************************
// CDOmGateInstantiation class
// ********************************************************************************
CDOmGateInstantiation::CDOmGateInstantiation(TLineNumberType lineNumber, EGateType gateType, EPrimitiveType primitiveType) 
  : CDOmAttrHolder(lineNumber, TYPE_GATE_INSTANTIATION), m_gateType(gateType),m_primitiveType(primitiveType), 
    m_trans(), m_delay2(RefCDOmDelay()),  
    m_delay3(RefCDOmDelay()), m_firstDriveStrength(DRIVE_STRENGTH_UNDEFINED), m_secondDriveStrength(DRIVE_STRENGTH_UNDEFINED) { }
    
RefCDOmGateInstantiation CDOmGateInstantiation::cast (RefCDOmBase object) {
  //assert(object.get());
  if (!object.get()) {
    return RefCDOmGateInstantiation();
  }
  ASSERT(object->getType() == TYPE_GATE_INSTANTIATION, "type check on CDOmGateInstantiation::cast failure");
  return boost::static_pointer_cast<CDOmGateInstantiation>(object);
}
                                       
RefCDOmGateInstantiation CDOmGateInstantiation::build(TLineNumberType lineNumber, RefCDOmBase parent, EPrimitiveType primitiveType) {
  std::cerr << "built a gate instantiation" << std::endl;
  ASSERT(parent.get(), "parent is NULL");
  ASSERT(parent->getType() == TYPE_DECL_MODULE 
         || parent->getType() == TYPE_GEN_INST
         || parent->getType() == TYPE_GEN_ITEM_IF
         || parent->getType() == TYPE_GEN_ITEM_CASE
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_NAMED
         || parent->getType() == TYPE_GEN_ITEM_BLOCK_UNNAMED
         , "parent has illegal type");

  CDOmGateInstantiation *gateInstantiation = new CDOmGateInstantiation(lineNumber, (EGateType)(primitiveType & GATE_MASK), primitiveType);
  RefCDOmGateInstantiation refGateInstantiation = RefCDOmGateInstantiation(gateInstantiation);
  gateInstantiation->m_weakRef = boost::weak_ptr<CDOmBase>( refGateInstantiation);
  //added this because it wouldn't set it's parent
  gateInstantiation->setParent(parent);//self registration
  return refGateInstantiation;
}

void CDOmGateInstantiation::addID(RefString name, RefCDOmRange range) {
  if(m_trans == 0 || (m_gateType == GATE_INST_N_INPUT_GATE && m_trans == 3) || (m_gateType == GATE_INST_N_OUTPUT_GATE && m_trans == 3)){
    //if(!m_children.get() || (m_children->size() == 1 && m_children->at(0)->getType() == TYPE_DELAY))
    if(!m_children.get() || (m_children->size() == 1 && getChild(0)->getType() == TYPE_DELAY))
      m_instances = RefTVec_TVec_RefCDOmBase_size_type(new TVec_TVec_RefCDOmBase_size_type());
    else
      m_instances->push_back(m_children->size());
    ASSERT(name.get(), "name is NULL");
    RefCDOmIdentifier id = CDOmIdentifier::build(getThis()->getLineNumber(), getThis(), CDOmIdentifier::ID_GATE_INST, name);
    if(range.get())
      //range->setParent(m_weakRef.lock());
      range->setParent(getThis());
    m_trans = 1;
  }
  else
    ASSERT(FAIL, "[CDOmGateInstantiation::addID()] illegal state for this method call.");
  //throw NSBase::IllegalStateException("[CDOmGateInstantiation::addID()] illegal state for this method call.", m_lineNumber);    
}

void CDOmGateInstantiation::addLvalue(RefCDOmExpr lvalue) {
  ASSERT(lvalue.get(), "lvalue is NULL");
  ASSERT(lvalue->canBeLvalue(), "lvalue can't be left value expr");
  if(m_trans == 0 || (m_gateType == GATE_INST_N_INPUT_GATE && m_trans == 3) || (m_gateType == GATE_INST_N_OUTPUT_GATE && m_trans == 3))
    //if(!m_children.get() || (m_children->size() == 1 && m_children->at(0)->getType() == TYPE_DELAY))
    if(!m_children.get() || (m_children->size() == 1 && getChild(0)->getType() == TYPE_DELAY))
      m_instances = RefTVec_TVec_RefCDOmBase_size_type(new TVec_TVec_RefCDOmBase_size_type());
    else
      m_instances->push_back(m_children->size());
  switch(m_gateType) {
    case GATE_INST_CMOS_SWITCH:
    case GATE_INST_MOS_SWITCH:
    case GATE_INST_ENABLE_GATE:
      ASSERT(m_trans == 0 || m_trans == 1, "[CDOmGateInstantiation::addLvalue()] illegal state for this method call.");
      //if(m_trans!=0 && m_trans!=1)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addLvalue()] illegal state for this method call.", m_lineNumber);    
      //lvalue->setParent(m_weakRef.lock());
      lvalue->setParent(getThis());
      m_trans = 2;
      break;
    case GATE_INST_N_INPUT_GATE:
      ASSERT(m_trans == 0 || m_trans == 1 || m_trans == 3, "[CDOmGateInstantiation::addLvalue()] illegal state for this method call.");
      //if(m_trans!=0 && m_trans!=1 && m_trans!=3)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addLvalue()] illegal state for this method call.", m_lineNumber);    
      //lvalue->setParent(m_weakRef.lock());
      lvalue->setParent(getThis());
      m_trans = 2;
      break;
    case GATE_INST_N_OUTPUT_GATE:
      ASSERT(m_trans == 0 || m_trans == 1 || m_trans == 2 || m_trans == 3, "[CDOmGateInstantiation::addLvalue()] illegal state for this method call."); 
      //if(m_trans!=0 && m_trans!=1 && m_trans!=2 && m_trans!=3)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addLvalue()] illegal state for this method call.", m_lineNumber);    
      //lvalue->setParent(m_weakRef.lock());
      lvalue->setParent(getThis());
      m_trans = 2;
      break;
    case GATE_INST_PASS_SWITCH:
      ASSERT(m_trans == 0 || m_trans == 1 || m_trans == 2, "[CDOmGateInstantiation::addLvalue()] illegal state for this method call.");
      //if(m_trans!=0 && m_trans!=1 && m_trans!=2)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addLvalue()] illegal state for this method call.", m_lineNumber);    
      //lvalue->setParent(m_weakRef.lock());
      lvalue->setParent(getThis());
      if(m_trans == 0 || m_trans == 1)
        m_trans = 2;
      else
        m_trans = 0;
      break;
    case GATE_INST_PASS_ENABLE_SWITCH:
      ASSERT(m_trans == 0 || m_trans == 1 || m_trans == 2, "[CDOmGateInstantiation::addLvalue()] illegal state for this method call.");
      //if(m_trans!=0 && m_trans!=1 && m_trans!=2)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addLvalue()] illegal state for this method call.", m_lineNumber);    
      //lvalue->setParent(m_weakRef.lock());
      lvalue->setParent(getThis());
      if(m_trans == 0 || m_trans == 1) 
        m_trans = 2;
      else
        m_trans = 3;
      break;
    case GATE_INST_PULLGATE:
      ASSERT(m_trans == 0 || m_trans == 1, "[CDOmGateInstantiation::addLvalue()] illegal state for this method call.");
      //if(m_trans!=0 && m_trans!= 1)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addLvalue()] illegal state for this method call.", m_lineNumber);    
      //lvalue->setParent(m_weakRef.lock());
      lvalue->setParent(getThis());
      if(m_trans == 1)  
        m_trans = 0;
      break;
    default:
      ASSERT(FAIL, "[CDOmGateInstantiation::addLvalue()] invalid type.");
      //throw NSBase::IllegalStateException("[CDOmGateInstantiation::addLvalue()] invalid type.", m_lineNumber);    
  }    
}

void CDOmGateInstantiation::addExpr(RefCDOmExpr expr) {
  ASSERT(expr.get(), "expr is NULL");
  switch(m_gateType) {
    case GATE_INST_CMOS_SWITCH:
      ASSERT(m_trans == 2 || m_trans == 3 || m_trans == 4, "[CDOmGateInstantiation::addExpr()] illegal state for this method call.");
      //if(m_trans!=2 && m_trans!=3 && m_trans!=4)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addExpr()] illegal state for this method call.", m_lineNumber);    
      //expr->setParent(m_weakRef.lock());
      expr->setParent(getThis());
      if(m_trans == 2 || m_trans == 3)
        m_trans++;
      else
        m_trans = 0;
      break;
    case GATE_INST_ENABLE_GATE:
    case GATE_INST_MOS_SWITCH:
      ASSERT(m_trans == 2 || m_trans == 3, "[CDOmGateInstantiation::addExpr()] illegal state for this method call.");
      //if(m_trans!=2 && m_trans!=3)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addExpr()] illegal state for this method call.", m_lineNumber);    
      //expr->setParent(m_weakRef.lock());
      expr->setParent(getThis());
      if(m_trans == 2) 
        m_trans = 3;
      else
        m_trans = 0;
      break;
    case GATE_INST_N_INPUT_GATE:
      ASSERT(m_trans == 2 || m_trans == 3, "[CDOmGateInstantiation::addExpr()] illegal state for this method call.");
      //if(m_trans!=2 && m_trans!=3)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addExpr()] illegal state for this method call.", m_lineNumber);    
      //expr->setParent(m_weakRef.lock());
      expr->setParent(getThis());
      m_trans = 3; 
      break;
    case GATE_INST_N_OUTPUT_GATE:
      ASSERT(m_trans == 2 || m_trans == 3, "[CDOmGateInstantiation::addExpr()] illegal state for this method call.");
      //if(m_trans!=2 && m_trans!=3)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addExpr()] illegal state for this method call.", m_lineNumber);    
      ASSERT(boost::static_pointer_cast<CDOmExpr>(m_children->back())->canBeLvalue(), "[CDOmGateInstantiation::addExpr()] illegal state for this method call,previous must be lvalue.");
      //if(!boost::static_pointer_cast<CDOmExpr>(m_children->back())->canBeLvalue())
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addExpr()] illegal state for this method call,previous must be lvalue.", m_lineNumber);    
      //expr->setParent(m_weakRef.lock());
      expr->setParent(getThis());
      m_trans = 3;
      break;
    case GATE_INST_PASS_ENABLE_SWITCH:
      ASSERT(m_trans == 3, "[CDOmGateInstantiation::addExpr()] illegal state for this method call.");
      //if(m_trans!=3)
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::addExpr()] illegal state for this method call.", m_lineNumber);    
      //expr->setParent(m_weakRef.lock());
      expr->setParent(getThis());
      m_trans = 0;

  }
}

bool CDOmGateInstantiation::isAttrListColOrDelay(RefCDOmBase item) {
  return (item->getType() == TYPE_ATTR_LIST_COLLECTION || item->getType() == TYPE_DELAY);
}
TInt CDOmGateInstantiation::getNrOfInstances() {
  return (m_instances->size()+1);
}
RefTVec_RefCDOmBase CDOmGateInstantiation::getInstance(TVec_TVec_RefCDOmBase_size_type::size_type index) {
  TVec_RefCDOmBase::size_type ibegin, iend;
  TVec_RefCDOmBase::iterator iter;
  if(index >= 0 && index <= m_instances->size()) {
    if( index == 0 ) {
      ibegin = 0;
      if( m_instances->size() == index )
        iend = m_children->size();
      else 
        iend = m_instances->at(index);
    }
    else {
      ibegin = m_instances->at(index-1);
      if( m_instances->size() == index )
        iend = m_children->size();
      else
        iend = m_instances->at(index);

    }

    RefTVec_RefCDOmBase temp = RefTVec_RefCDOmBase(new TVec_RefCDOmBase());
    remove_copy_if ((m_children->begin())+ibegin , (m_children->begin())+iend , std::back_insert_iterator<TVec_RefCDOmBase>(*temp), 
                    NSCdom::CDOmGateInstantiation::isAttrListColOrDelay);
    return temp;
  }
  else
    ASSERT(FAIL, "[CDOmGateInstantiation::getInstance()] index is out of range.");
  //throw NSBase::IllegalStateException("[CDOmGateInstantiation::getInstance()] index is out of range.", m_lineNumber);    
}

void CDOmGateInstantiation::checkFinalState () {
  ASSERT(!(m_trans || !m_children.get() || (m_gateType == GATE_INST_N_OUTPUT_GATE && m_trans!=3) || 
           (m_gateType == GATE_INST_N_INPUT_GATE && m_trans!=3)), "[CDOmGateInstantiation::checkFinalState()] gate construction incomplete.");
  //if(m_trans || !m_children.get() ||
  //    (m_gateType == GATE_INST_N_OUTPUT_GATE && m_trans!=3) || (m_gateType == GATE_INST_N_INPUT_GATE && m_trans!=3))
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::checkFinalState()] gate construction incomplete.", m_lineNumber);    
}

CDOmGateInstantiation::EGateType CDOmGateInstantiation::getGateType() const {
  return m_gateType;
}

CDOmGateInstantiation::EPrimitiveType CDOmGateInstantiation::getPrimitiveType() const{
  return m_primitiveType;
}

void CDOmGateInstantiation::buildDelay(TLineNumberType lineNumber) {
  ASSERT(m_gateType != GATE_INST_PASS_SWITCH && m_gateType != GATE_INST_PULLGATE, "[CDOmGateInstantiation::buildDelay()] illegal state for this method call.");
  //if(m_gateType == GATE_INST_PASS_SWITCH || m_gateType == GATE_INST_PULLGATE)  
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::buildDelay()] illegal state for this method call.", m_lineNumber);
  if(m_gateType == GATE_INST_N_INPUT_GATE || m_gateType == GATE_INST_N_OUTPUT_GATE || m_gateType == GATE_INST_PASS_ENABLE_SWITCH) {
    if(!m_delay2.get()) {
      ASSERT(!getChildren<CDOmBase>(TYPE_ALL_TYPES).get(), "[CDOmGateInstantiation::buildDelay()] parameter delay should be the first to be set.");
      //if(getChildren<CDOmBase>(TYPE_ALL_TYPES).get())
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::buildDelay()] parameter delay should be the first to be set.", m_lineNumber);
      //m_delay2 = CDOmDelay::build(lineNumber, m_weakRef.lock(),CDOmDelay::DELAY_2);
      m_delay2 = CDOmDelay::build(lineNumber, getThis(),CDOmDelay::DELAY_2);
    }
    else
      ASSERT(FAIL, "[CDOmGateInstantiation::buildDelay()] parameter delay already set.");
    //throw NSBase::IllegalStateException("[CDOmGateInstantiation::buildDelay()] parameter delay already set.", m_lineNumber);
  }
  if(m_gateType == GATE_INST_CMOS_SWITCH || m_gateType == GATE_INST_ENABLE_GATE || m_gateType == GATE_INST_MOS_SWITCH) {
    if(!m_delay3.get()) {
      ASSERT(!getChildren<CDOmBase>(TYPE_ALL_TYPES).get(), "[CDOmGateInstantiation::buildDelay()] parameter delay should be the first to be set.");
      //if(getChildren<CDOmBase>(TYPE_ALL_TYPES).get())
      //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::buildDelay()] parameter delay should be the first to be set.", m_lineNumber);
      //m_delay3 = CDOmDelay::build(lineNumber, m_weakRef.lock(),CDOmDelay::DELAY_3);
      m_delay3 = CDOmDelay::build(lineNumber, getThis(),CDOmDelay::DELAY_3);
    }
    else
      ASSERT(FAIL, "[CDOmGateInstantiation::buildDelay()] parameter delay already set.");
    //throw NSBase::IllegalStateException("[CDOmGateInstantiation::buildDelay()] parameter delay already set.", m_lineNumber);
      
  }
}
const RefCDOmDelay CDOmGateInstantiation::getDelay() const {
  ASSERT(m_gateType != GATE_INST_PASS_SWITCH && m_gateType != GATE_INST_PULLGATE, "[CDOmGateInstantiation::buildDelay()] illegal state for this method call.");
  //if(m_gateType == GATE_INST_PASS_SWITCH || m_gateType == GATE_INST_PULLGATE)  
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::buildDelay()] illegal state for this method call.", m_lineNumber);
  if(m_gateType == GATE_INST_N_INPUT_GATE || m_gateType == GATE_INST_N_OUTPUT_GATE || m_gateType == GATE_INST_PASS_ENABLE_SWITCH) 
    return m_delay2;
  if(m_gateType == GATE_INST_CMOS_SWITCH || m_gateType == GATE_INST_ENABLE_GATE || m_gateType == GATE_INST_MOS_SWITCH) 
    return m_delay3;
} 

RefCDOmDelay CDOmGateInstantiation::getDelay() {
  ASSERT(m_gateType != GATE_INST_PASS_SWITCH && m_gateType != GATE_INST_PULLGATE, "[CDOmGateInstantiation::buildDelay()] illegal state for this method call.");
  //if(m_gateType == GATE_INST_PASS_SWITCH || m_gateType == GATE_INST_PULLGATE)  
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::buildDelay()] illegal state for this method call.", m_lineNumber);
  if(m_gateType == GATE_INST_N_INPUT_GATE || m_gateType == GATE_INST_N_OUTPUT_GATE || m_gateType == GATE_INST_PASS_ENABLE_SWITCH) 
    return m_delay2;
  if(m_gateType == GATE_INST_CMOS_SWITCH || m_gateType == GATE_INST_ENABLE_GATE || m_gateType == GATE_INST_MOS_SWITCH) 
    return m_delay3;
}

TBool CDOmGateInstantiation::hasDelay3() const {
  return (m_delay3.get() ? true : false);
}

TBool CDOmGateInstantiation::hasDelay2() const {
  return (m_delay2.get() ? true : false);
}

void CDOmGateInstantiation::setDriveStrength(ECDOmDriveStrength firstDriveStrength, ECDOmDriveStrength secondDriveStrength) {
  if(m_gateType == GATE_INST_ENABLE_GATE || m_gateType == GATE_INST_N_INPUT_GATE || m_gateType == GATE_INST_N_OUTPUT_GATE || m_gateType == GATE_INST_PULLGATE) {
    if(m_gateType == GATE_INST_PULLGATE && (firstDriveStrength == DRIVE_STRENGTH_HIGHZ_0 || firstDriveStrength == DRIVE_STRENGTH_HIGHZ_1 ||
                                            secondDriveStrength == DRIVE_STRENGTH_HIGHZ_0 || secondDriveStrength == DRIVE_STRENGTH_HIGHZ_1))
      throw NSBase::IllegalStateException("[CDOmGateInstantiation1::setDriveStrength()] illegal state for this method call.", m_lineNumber);
    else {
      if(firstDriveStrength != DRIVE_STRENGTH_UNDEFINED && secondDriveStrength != DRIVE_STRENGTH_UNDEFINED) {
        if(checkDriveStrength(firstDriveStrength, secondDriveStrength, m_lineNumber)) {
          m_firstDriveStrength = firstDriveStrength;
          m_secondDriveStrength = secondDriveStrength;
        } 
      } 
      else {
        addErr(NSWarningErr::VEE_CSA_DRST_DRVS_ILLEGAL_CSVE, args, m_lineNumber);
        cdomHasErrors = TRUE;
      }
    }
  }
  else
    throw NSBase::IllegalStateException("[CDOmGateInstantiation::setDriveStrength()] illegal state for this method call.", m_lineNumber);
}

void CDOmGateInstantiation::setSingleDriveStrength(ECDOmDriveStrength firstDriveStrength) {
  if( (m_primitiveType == GATE_INST_PULLUP   && (firstDriveStrength & DRIVE_STRENGTH_1_MASK)) 
      ||(m_primitiveType == GATE_INST_PULLDOWN && (firstDriveStrength & DRIVE_STRENGTH_0_MASK))
      )
    m_firstDriveStrength = firstDriveStrength;
  else
    throw NSBase::IllegalStateException("[CDOmGateInstantiation::setSingleDriveStrength()] illegal state for this method call.", m_lineNumber);
}

ECDOmDriveStrength CDOmGateInstantiation::getFirstDriveStrength() const {
  ASSERT(m_firstDriveStrength != DRIVE_STRENGTH_UNDEFINED, "[CDOmGateInstantiation::getFirstDriveStrength()] illegal state for this method call.");
  ASSERT(!(m_gateType != GATE_INST_ENABLE_GATE && m_gateType != GATE_INST_N_INPUT_GATE && m_gateType != GATE_INST_N_OUTPUT_GATE && m_gateType!=GATE_INST_PULLGATE), "[CDOmGateInstantiation::getFirstDriveStrength()] illegal state for this method call.");
  //if(m_firstDriveStrength == DRIVE_STRENGTH_UNDEFINED)
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::getFirstDriveStrength()] illegal state for this method call.", m_lineNumber);
  //if(m_gateType != GATE_INST_ENABLE_GATE && m_gateType != GATE_INST_N_INPUT_GATE && m_gateType != GATE_INST_N_OUTPUT_GATE && m_gateType!=GATE_INST_PULLGATE)
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::getFirstDriveStrength()] illegal state for this method call.", m_lineNumber);
  return m_firstDriveStrength;
}

ECDOmDriveStrength CDOmGateInstantiation::getSecondDriveStrength() const {
  ASSERT(m_secondDriveStrength != DRIVE_STRENGTH_UNDEFINED, "[CDOmGateInstantiation::getSecondDriveStrength()] illegal state for this method call.");
  ASSERT(!(m_gateType != GATE_INST_ENABLE_GATE && m_gateType != GATE_INST_N_INPUT_GATE && m_gateType != GATE_INST_N_OUTPUT_GATE && m_gateType!=GATE_INST_PULLGATE), "[CDOmGateInstantiation::getSecondDriveStrength()] illegal state for this method call.");
  //if(m_secondDriveStrength == DRIVE_STRENGTH_UNDEFINED)
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::getSecondDriveStrength()] illegal state for this method call.", m_lineNumber);
  //if(m_gateType != GATE_INST_ENABLE_GATE && m_gateType != GATE_INST_N_INPUT_GATE && m_gateType != GATE_INST_N_OUTPUT_GATE && m_gateType!=GATE_INST_PULLGATE )
  //  throw NSBase::IllegalStateException("[CDOmGateInstantiation::getSecondDriveStrength()] illegal state for this method call.", m_lineNumber);
  return m_secondDriveStrength;
}

void CDOmGateInstantiation::acceptVisitor(NSCdomVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

//gcc has a problem with instantiating templates inside a template
//this is why we have to instantiate templates by hand
//all the templates instantiations are in this file


#include "templateInitCDOM.cpp"
} // end namespace NSCdom
