//----------------------------------------------------------------------
// Copyright (c) 2005-2008 Fastpathlogic
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
//Author: Tb

#include "cslcCLI.h"
#include "cslcCLI_Support.h"

namespace NSCLi {

// *********************************************************************
// CLiArgumentBase class
// *********************************************************************
CLiArgumentBase::CLiArgumentBase(CLiTool::ECLiArgumentType argType,
                                 const RefCLiArgumentList& parent,
                                 const RefTVec_RefString& keyWordList,
                                 const THandler& handler,
                                 TBool multiple)

  : m_argType(argType),
    m_parent(parent),
    m_keyWordList(keyWordList),
    m_handler(handler),
    m_multiple(multiple),
    m_selected(FALSE) {}

CLiArgumentBase::~CLiArgumentBase() {
}

TBool CLiArgumentBase::isEmpty() const {
  return m_argType == CLiTool::Instance()->ARG_EMPTY;
}

TBool CLiArgumentBase::isNumber() const {
  return m_argType == CLiTool::Instance()->ARG_NUMBER;
}

TBool CLiArgumentBase::isOption() const {
  return m_argType == CLiTool::Instance()->ARG_OPTION;
}

TBool CLiArgumentBase::isFileName() const {
  return m_argType == CLiTool::Instance()->ARG_FILE_NAME;
}

TBool CLiArgumentBase::isDirName() const {
  return m_argType == CLiTool::Instance()->ARG_DIR_NAME;
}

TBool CLiArgumentBase::isCslDefine() const {
  return m_argType == CLiTool::Instance()->ARG_CSL_DEFINE;
}

TBool CLiArgumentBase::isVerilogDefine() const {
  return m_argType == CLiTool::Instance()->ARG_VER_DEFINE;
}

TBool CLiArgumentBase::isVerilogDirList() const {
  return m_argType == CLiTool::Instance()->ARG_VER_DIR_LIST;
}

TBool CLiArgumentBase::isVerilogExtList() const {
  return m_argType == CLiTool::Instance()->ARG_VER_EXT_LIST;
}

TBool CLiArgumentBase::isVerilogSpecial() const {
  return (isVerilogDefine()
          || isVerilogDirList()
          || isVerilogExtList());
}

TVec_RefString_iter CLiArgumentBase::findKeyWord(const std::string& token) {
  TVec_RefString_iter result = m_keyWordList->begin();
  for (;
       result != m_keyWordList->end();
       ++result) {

    if ((**result == token)
        || (isVerilogSpecial()
            && token.find(**result) == CLiTool::Instance()->START_POSITION)) {

      return result;
    }
  }

  return result;;
}

TBool CLiArgumentBase::isKeyWord(const std::string& token) {
  TVec_RefString_iter keyWord = findKeyWord(token);
  if (keyWord != m_keyWordList->end()) {
    m_argToken = RefString(new std::string(**keyWord));
    return TRUE;
  }
  else {
    return FALSE;
  }
}

CLiTool::ECLiError CLiArgumentBase::execHandler(const RefTVec_RefCLiToken& tokenList,
                                       TVec_RefCLiToken_iter& tokenIndex) {

  if (m_selected
      && !m_multiple) {

    CLiError::buildError(CLiTool::Instance()->APARSE_DUPLICATE_ARGUMENT, *m_argToken);
    return CLiTool::Instance()->APARSE_DUPLICATE_ARGUMENT;
  }
  else {
    CLiTool::ECLiError result = parseParams(tokenList, tokenIndex);
    if (result != CLiTool::Instance()->APARSE_SUCCESS) {
      return result;
    }
    else {
      m_selected = TRUE;
      RefCLiArgumentList parent = getParent();
      RefCLiArgumentBase argBase = getThis();

      return (parent.get()->*m_handler)(argBase);
    }
  }
}

RefString CLiArgumentBase::getArgToken() const {
  ASSERT(m_argToken.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return m_argToken;
}

RefCLiArgumentList CLiArgumentBase::getParent() const {
  RefCLiArgumentList strongRef = m_parent.lock();

  ASSERT(strongRef.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return strongRef;
}

RefCLiArgumentBase CLiArgumentBase::getThis() const {
  RefCLiArgumentBase strongRef = m_selfRef.lock();

  ASSERT(strongRef.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return strongRef;
}

// *********************************************************************
// CLiArgumentEmpty class
// *********************************************************************
CLiArgumentEmpty::CLiArgumentEmpty(const RefCLiArgumentList& parent,
                                   const RefTVec_RefString& keyWordList,
                                   const THandler& handler,
                                   TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_EMPTY, parent, keyWordList, handler, multiple) {}

CLiArgumentEmpty::~CLiArgumentEmpty() {
}

RefCLiArgumentEmpty CLiArgumentEmpty::build(const RefCLiArgumentList& parent,
                                            const RefTVec_RefString& keyWordList,
                                            const THandler& handler,
                                            TBool multiple) {

  RefCLiArgumentEmpty argEmpty(new CLiArgumentEmpty(parent, keyWordList, handler, multiple));

  argEmpty->m_selfRef = WeakRefCLiArgumentBase(argEmpty);

  return argEmpty;
}

RefCLiArgumentEmpty CLiArgumentEmpty::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isEmpty(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentEmpty>(argBase);
}

CLiTool::ECLiError CLiArgumentEmpty::parseParams(const RefTVec_RefCLiToken& tokenList,
                                        TVec_RefCLiToken_iter& tokenIndex) {

  ++tokenIndex;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

// *********************************************************************
// CLiArgumentNumber class
// *********************************************************************
CLiArgumentNumber::CLiArgumentNumber(const RefCLiArgumentList& parent,
                                     const RefTVec_RefString& keyWordList,
                                     const THandler& handler,
                                     TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_NUMBER, parent, keyWordList, handler, multiple) {}

CLiArgumentNumber::~CLiArgumentNumber() {
}

RefCLiArgumentNumber CLiArgumentNumber::build(const RefCLiArgumentList& parent,
                                              const RefTVec_RefString& keyWordList,
                                              const THandler& handler,
                                              TBool multiple,
                                              TInt lowerBound,
                                              TInt upperBound) {

  RefCLiArgumentNumber argNumber(new CLiArgumentNumber(parent, keyWordList, handler, multiple));

  argNumber->m_selfRef = WeakRefCLiArgumentBase(argNumber);

  argNumber->m_lowerBound = lowerBound;
  argNumber->m_upperBound = upperBound;

  return argNumber;
}

RefCLiArgumentNumber CLiArgumentNumber::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isNumber(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentNumber>(argBase);
}

CLiTool::ECLiError CLiArgumentNumber::parseParams(const RefTVec_RefCLiToken& tokenList,
                                         TVec_RefCLiToken_iter& tokenIndex) {

  if (++tokenIndex == tokenList->end()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    TInt num;
    std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN);
    CLiTool::ECLiError stoi = CLiCommon::Instance()->stringToInt(token, num);
    if (stoi != CLiTool::Instance()->APARSE_SUCCESS) {
      CLiError::buildError(stoi, *m_argToken, token);
      return stoi;
    }
    else if (num < m_lowerBound) {
      CLiError::buildError(CLiTool::Instance()->APARSE_NUMBER_TOO_SMALL, *m_argToken, num);
      return CLiTool::Instance()->APARSE_NUMBER_TOO_SMALL;
    }
    else if (num > m_upperBound) {
      CLiError::buildError(CLiTool::Instance()->APARSE_NUMBER_TOO_BIG, *m_argToken, num);
      return CLiTool::Instance()->APARSE_NUMBER_TOO_BIG;
    }
    else {
      m_value = num;
      ++tokenIndex;
      return CLiTool::Instance()->APARSE_SUCCESS;
    }
  }
}

TInt CLiArgumentNumber::getValue() const {
  return m_value;
}

// *********************************************************************
// CLiArgumentOption class
// *********************************************************************
CLiArgumentOption::CLiArgumentOption(const RefCLiArgumentList& parent,
                                     const RefTVec_RefString& keyWordList,
                                     const THandler& handler,
                                     TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_OPTION, parent, keyWordList, handler, multiple) {}

CLiArgumentOption::~CLiArgumentOption() {
}

RefCLiArgumentOption CLiArgumentOption::build(const RefCLiArgumentList& parent,
                                              const RefTVec_RefString& keyWordList,
                                              const THandler& handler,
                                              TBool multiple,
                                              const RefTVec_RefString& optionList) {

  RefCLiArgumentOption argOption(new CLiArgumentOption(parent, keyWordList, handler, multiple));

  argOption->m_selfRef = WeakRefCLiArgumentBase(argOption);

  argOption->m_optionList = optionList;

  return argOption;
}

RefCLiArgumentOption CLiArgumentOption::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isOption(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentOption>(argBase);
}

CLiTool::ECLiError CLiArgumentOption::parseParams(const RefTVec_RefCLiToken& tokenList,
                                         TVec_RefCLiToken_iter& tokenIndex) {

  if (++tokenIndex == tokenList->end()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN);
    if (!isValidOption(token)) {
      CLiError::buildError(CLiTool::Instance()->APARSE_INVALID_ARGUMENT, *m_argToken, token);
      return CLiTool::Instance()->APARSE_INVALID_ARGUMENT;
    }
    else {
      m_selOption = RefString(new std::string(token));
      ++tokenIndex;
      return CLiTool::Instance()->APARSE_SUCCESS;
    }
  }
}

RefString CLiArgumentOption::getSelOption() const {
  return m_selOption;
}

TBool CLiArgumentOption::isValidOption(const std::string& opt) const {
  for (TVec_RefString_iter result = m_optionList->begin();
       result != m_optionList->end();
       ++result) {

    if (**result == opt) {
      return TRUE;
    }
  }

  return FALSE;
}

// *********************************************************************
// CLiArgumentFileName class
// *********************************************************************
CLiArgumentFileName::CLiArgumentFileName(const RefCLiArgumentList& parent,
                                         const RefTVec_RefString& keyWordList,
                                         const THandler& handler,
                                         TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_FILE_NAME, parent, keyWordList, handler, multiple) {}

CLiArgumentFileName::~CLiArgumentFileName() {
}

RefCLiArgumentFileName CLiArgumentFileName::build(const RefCLiArgumentList& parent,
                                                  const RefTVec_RefString& keyWordList,
                                                  const THandler& handler,
                                                  TBool multiple,
                                                  TBool mustExist,
                                                  const RefString& fileExt) {

  RefCLiArgumentFileName argFileName(new CLiArgumentFileName(parent, keyWordList, handler, multiple));

  argFileName->m_selfRef = WeakRefCLiArgumentBase(argFileName);

  argFileName->m_mustExist = mustExist;
  argFileName->m_fileExt = fileExt;

  return argFileName;
}

RefCLiArgumentFileName CLiArgumentFileName::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isFileName(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentFileName>(argBase);
}

CLiTool::ECLiError CLiArgumentFileName::parseParams(const RefTVec_RefCLiToken& tokenList,
                                           TVec_RefCLiToken_iter& tokenIndex) {

  if (++tokenIndex == tokenList->end()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_PATH);
    token.append((*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN));
    boost::filesystem::path fsPath(token, boost::filesystem::native);

    CLiTool::TAccessRights fileAccessRights;
    CLiTool::ECLiFileStat result = CLiCommon::Instance()->fileStat(fsPath, fileAccessRights);
    if (result == CLiTool::Instance()->FS_DENIED) {
      CLiError::buildError(CLiTool::Instance()->APARSE_ACCESS_DENIED, CLiCommon::Instance()->m_failedPath);
      return CLiTool::Instance()->APARSE_ACCESS_DENIED;
    }
    else if (result == CLiTool::Instance()->FS_FAIL) {
      CLiError::buildError(CLiTool::Instance()->APARSE_FAIL, CLiCommon::Instance()->m_errorMessage.str());
      return CLiTool::Instance()->APARSE_FAIL;
    }
    else if (result == CLiTool::Instance()->FS_IS_DIRECTORY) {
      CLiError::buildError(CLiTool::Instance()->APARSE_EXPECTED_FILE, *m_argToken, token);
      return CLiTool::Instance()->APARSE_EXPECTED_FILE;
    }
    else if (m_fileExt.get()
             && !CLiCommon::Instance()->isFileExtension(fsPath, *m_fileExt)) {

      CLiError::buildError(CLiTool::Instance()->APARSE_EXPECTED_FILE_EXTENSION, *m_argToken, token);
      return CLiTool::Instance()->APARSE_EXPECTED_FILE_EXTENSION;
    }
    else if (m_mustExist
             && result != CLiTool::Instance()->FS_NOT_DIRECTORY) {

      CLiError::buildError(CLiTool::Instance()->APARSE_FILE_NOT_EXISTS, *m_argToken, token);
      return CLiTool::Instance()->APARSE_FILE_NOT_EXISTS;
    }

    m_fileName = RefString(new std::string(token));
    ++tokenIndex;
    return CLiTool::Instance()->APARSE_SUCCESS;
  }
}

RefString CLiArgumentFileName::getFileName() const {
  ASSERT(m_fileName.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return m_fileName;
}

// *********************************************************************
// CLiArgumentDirName class
// *********************************************************************
CLiArgumentDirName::CLiArgumentDirName(const RefCLiArgumentList& parent,
                                       const RefTVec_RefString& keyWordList,
                                       const THandler& handler,
                                       TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_DIR_NAME, parent, keyWordList, handler, multiple) {}

CLiArgumentDirName::~CLiArgumentDirName() {
}

RefCLiArgumentDirName CLiArgumentDirName::build(const RefCLiArgumentList& parent,
                                                const RefTVec_RefString& keyWordList,
                                                const THandler& handler,
                                                TBool multiple,
                                                TBool mustExist) {

  RefCLiArgumentDirName argDirName(new CLiArgumentDirName(parent, keyWordList, handler, multiple));

  argDirName->m_selfRef = WeakRefCLiArgumentBase(argDirName);

  argDirName->m_mustExist = mustExist;

  return argDirName;
}

RefCLiArgumentDirName CLiArgumentDirName::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isDirName(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentDirName>(argBase);
}

CLiTool::ECLiError CLiArgumentDirName::parseParams(const RefTVec_RefCLiToken& tokenList,
                                          TVec_RefCLiToken_iter& tokenIndex) {

  if (++tokenIndex == tokenList->end()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_PATH);
    token.append((*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN));
    boost::filesystem::path fsPath(token, boost::filesystem::native);

    CLiTool::TAccessRights fileAccessRights;
    CLiTool::ECLiFileStat result = CLiCommon::Instance()->fileStat(fsPath, fileAccessRights);
    if (result == CLiTool::Instance()->FS_DENIED) {
      CLiError::buildError(CLiTool::Instance()->APARSE_ACCESS_DENIED, CLiCommon::Instance()->m_failedPath);
      return CLiTool::Instance()->APARSE_ACCESS_DENIED;
    }
    else if (result == CLiTool::Instance()->FS_FAIL) {
      CLiError::buildError(CLiTool::Instance()->APARSE_FAIL, CLiCommon::Instance()->m_errorMessage.str());
      return CLiTool::Instance()->APARSE_FAIL;
    }
    else if (m_mustExist
             && result != CLiTool::Instance()->FS_IS_DIRECTORY) {

      CLiError::buildError(CLiTool::Instance()->APARSE_EXPECTED_DIR, *m_argToken, token);
      return CLiTool::Instance()->APARSE_EXPECTED_DIR;
    }
    else if (!m_mustExist) {
      result = CLiCommon::Instance()->canCreateDirectory(fsPath);
      if (result != CLiTool::Instance()->FS_CAN_CREATE
          && result != CLiTool::Instance()->FS_IS_DIRECTORY) {

        CLiError::buildError(CLiTool::Instance()->APARSE_EXPECTED_DIR, *m_argToken, CLiCommon::Instance()->m_failedPath);
        return CLiTool::Instance()->APARSE_EXPECTED_DIR;
      }
    }

    m_dirName = RefString(new std::string(fsPath.string()));
    m_mustCreate = result == CLiTool::Instance()->FS_CAN_CREATE;
    ++tokenIndex;
    return CLiTool::Instance()->APARSE_SUCCESS;
  }
}

RefString CLiArgumentDirName::getDirName() const {
  ASSERT(m_dirName.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return m_dirName;
}

TBool CLiArgumentDirName::getMustCreate() const {
  return m_mustCreate;
}

// *********************************************************************
// CLiArgumentCslDefine class
// *********************************************************************
CLiArgumentCslDefine::CLiArgumentCslDefine(const RefCLiArgumentList& parent,
                                           const RefTVec_RefString& keyWordList,
                                           const THandler& handler,
                                           TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_CSL_DEFINE, parent, keyWordList, handler, multiple) {}

CLiArgumentCslDefine::~CLiArgumentCslDefine() {
}

RefCLiArgumentCslDefine CLiArgumentCslDefine::build(const RefCLiArgumentList& parent,
                                                    const RefTVec_RefString& keyWordList,
                                                    const THandler& handler,
                                                    TBool multiple) {

  RefCLiArgumentCslDefine argCslDefine(new CLiArgumentCslDefine(parent, keyWordList, handler, multiple));

  argCslDefine->m_selfRef = WeakRefCLiArgumentBase(argCslDefine);

  return argCslDefine;
}

RefCLiArgumentCslDefine CLiArgumentCslDefine::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isCslDefine(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentCslDefine>(argBase);
}

CLiTool::ECLiError CLiArgumentCslDefine::parseParams(const RefTVec_RefCLiToken& tokenList,
                                            TVec_RefCLiToken_iter& tokenIndex) {

  if (++tokenIndex == tokenList->end()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN);
    m_macroDef = RefString(new std::string(token));
    ++tokenIndex;
    return CLiTool::Instance()->APARSE_SUCCESS;
  }
}

RefString CLiArgumentCslDefine::getMacroDef() const {
  return m_macroDef;
}

// *********************************************************************
// CLiArgumentVerilogDefine class
// *********************************************************************
CLiArgumentVerilogDefine::CLiArgumentVerilogDefine(const RefCLiArgumentList& parent,
                                                     const RefTVec_RefString& keyWordList,
                                                     const THandler& handler,
                                                     TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_VER_DEFINE, parent, keyWordList, handler, multiple) {}

CLiArgumentVerilogDefine::~CLiArgumentVerilogDefine() {
}

RefCLiArgumentVerilogDefine CLiArgumentVerilogDefine::build(const RefCLiArgumentList& parent,
                                                            const RefTVec_RefString& keyWordList,
                                                            const THandler& handler,
                                                            TBool multiple) {

  RefCLiArgumentVerilogDefine argVerDefine(new CLiArgumentVerilogDefine(parent, keyWordList, handler, multiple));

  argVerDefine->m_selfRef = WeakRefCLiArgumentBase(argVerDefine);

  return argVerDefine;
}

RefCLiArgumentVerilogDefine CLiArgumentVerilogDefine::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isVerilogDefine(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentVerilogDefine>(argBase);
}

CLiTool::ECLiError CLiArgumentVerilogDefine::parseParams(const RefTVec_RefCLiToken& tokenList,
                                                TVec_RefCLiToken_iter& tokenIndex) {

  std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN);
  std::string verilogArg = token.substr(m_argToken->size(), token.size());
  if (verilogArg.empty()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    m_verilogDefine = RefString(new std::string(verilogArg));
    ++tokenIndex;
    return CLiTool::Instance()->APARSE_SUCCESS;
  }
}

RefString CLiArgumentVerilogDefine::getVerilogDefine() const {
  return m_verilogDefine;
}

// *********************************************************************
// CLiArgumentVerilogDirList class
// *********************************************************************
CLiArgumentVerilogDirList::CLiArgumentVerilogDirList(const RefCLiArgumentList& parent,
                                                     const RefTVec_RefString& keyWordList,
                                                     const THandler& handler,
                                                     TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_VER_DIR_LIST, parent, keyWordList, handler, multiple) {}

CLiArgumentVerilogDirList::~CLiArgumentVerilogDirList() {
}

RefCLiArgumentVerilogDirList CLiArgumentVerilogDirList::build(const RefCLiArgumentList& parent,
                                                              const RefTVec_RefString& keyWordList,
                                                              const THandler& handler,
                                                              TBool multiple,
                                                              TBool mustExist) {

  RefCLiArgumentVerilogDirList argDirList(new CLiArgumentVerilogDirList(parent, keyWordList, handler, multiple));

  argDirList->m_selfRef = WeakRefCLiArgumentBase(argDirList);

  argDirList->m_mustExist = mustExist;

  return argDirList;
}

RefCLiArgumentVerilogDirList CLiArgumentVerilogDirList::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isVerilogDirList(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentVerilogDirList>(argBase);
}

CLiTool::ECLiError CLiArgumentVerilogDirList::parseParams(const RefTVec_RefCLiToken& tokenList,
                                                 TVec_RefCLiToken_iter& tokenIndex) {

  std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN);
  std::string verilogArg = token.substr(m_argToken->size(), token.size());
  if (verilogArg.empty()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    m_verilogDirList = RefTVec_RefString(new TVec_RefString());

    while (!verilogArg.empty()) {
      std::string::size_type pos = verilogArg.find(CLiTool::Instance()->VER_PLUS);
      pos = (pos != std::string::npos
             ? pos
             : verilogArg.size());

      std::string dirName = verilogArg.substr(CLiTool::Instance()->START_POSITION, pos);
      if (dirName.empty()) {
        CLiError::buildWarning(CLiTool::Instance()->AWARN_EMPTY_NAME, *m_argToken);
      }
      else {
        dirName.insert(CLiTool::Instance()->START_POSITION, (*tokenIndex)->getString(CLiTool::Instance()->TK_PATH));
        boost::filesystem::path fsPath(dirName, boost::filesystem::native);

        CLiTool::TAccessRights fileAccessRights;
        CLiTool::ECLiFileStat result = CLiCommon::Instance()->fileStat(fsPath, fileAccessRights);
        if (result == CLiTool::Instance()->FS_DENIED) {
          CLiError::buildError(CLiTool::Instance()->APARSE_ACCESS_DENIED, CLiCommon::Instance()->m_failedPath);
          return CLiTool::Instance()->APARSE_ACCESS_DENIED;
        }
        else if (result == CLiTool::Instance()->FS_FAIL) {
          CLiError::buildError(CLiTool::Instance()->APARSE_FAIL, CLiCommon::Instance()->m_errorMessage.str());
          return CLiTool::Instance()->APARSE_FAIL;
        }
        else if (m_mustExist
                 && result != CLiTool::Instance()->FS_IS_DIRECTORY) {

          CLiError::buildError(CLiTool::Instance()->APARSE_EXPECTED_DIR, *m_argToken, dirName);
          return CLiTool::Instance()->APARSE_EXPECTED_DIR;
        }
        else {
          m_verilogDirList->push_back(RefString(new std::string(fsPath.string())));
        }
      }

      verilogArg.erase(CLiTool::Instance()->START_POSITION, pos + 1);
    }
    
    ++tokenIndex;
    return CLiTool::Instance()->APARSE_SUCCESS;
  }
}

RefTVec_RefString CLiArgumentVerilogDirList::getVerilogDirList() const {
  return m_verilogDirList;
}

// *********************************************************************
// CLiArgumentVerilogExtList class
// *********************************************************************
CLiArgumentVerilogExtList::CLiArgumentVerilogExtList(const RefCLiArgumentList& parent,
                                                     const RefTVec_RefString& keyWordList,
                                                     const THandler& handler,
                                                     TBool multiple)

  : CLiArgumentBase(CLiTool::Instance()->ARG_VER_EXT_LIST, parent,keyWordList, handler, multiple) {}

CLiArgumentVerilogExtList::~CLiArgumentVerilogExtList() {
}

RefCLiArgumentVerilogExtList CLiArgumentVerilogExtList::build(const RefCLiArgumentList& parent,
                                                              const RefTVec_RefString& keyWordList,
                                                              const THandler& handler,
                                                              TBool multiple) {

  RefCLiArgumentVerilogExtList argExtList(new CLiArgumentVerilogExtList(parent, keyWordList, handler, multiple));

  argExtList->m_selfRef = WeakRefCLiArgumentBase(argExtList);

  return argExtList;
}

RefCLiArgumentVerilogExtList CLiArgumentVerilogExtList::cast(const RefCLiArgumentBase& argBase) {
  ASSERT(argBase.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(argBase->isVerilogExtList(), INTERNAL_ERROR_INVALID_CAST);

  return boost::static_pointer_cast<CLiArgumentVerilogExtList>(argBase);
}

CLiTool::ECLiError CLiArgumentVerilogExtList::parseParams(const RefTVec_RefCLiToken& tokenList,
                                                 TVec_RefCLiToken_iter& tokenIndex) {

  std::string token = (*tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN);
  std::string verilogArg = token.substr(m_argToken->size(), token.size());
  if (verilogArg.empty()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS, *m_argToken);
    return CLiTool::Instance()->APARSE_TOO_FEW_ARGUMENTS;
  }
  else {
    m_verilogExtList = RefTVec_RefString(new TVec_RefString());

    while (!verilogArg.empty()) {
      std::string::size_type pos = verilogArg.find(CLiTool::Instance()->VER_PLUS);
      pos = (pos != std::string::npos
             ? pos
             : verilogArg.size());

      std::string extName = verilogArg.substr(CLiTool::Instance()->START_POSITION, pos);
      if (extName.empty()) {
        CLiError::buildWarning(CLiTool::Instance()->AWARN_EMPTY_NAME, *m_argToken);
      }
      else {
        if (extName[CLiTool::Instance()->START_POSITION] != '.') {
          CLiError::buildWarning(CLiTool::Instance()->AWARN_INCOMPLETE_EXTENSION, extName);
          extName.insert(CLiTool::Instance()->START_POSITION, ".");
        }
        m_verilogExtList->push_back(RefString(new std::string(extName)));
      }

      verilogArg.erase(CLiTool::Instance()->START_POSITION, pos + 1);
    }

    ++tokenIndex;
    return CLiTool::Instance()->APARSE_SUCCESS;
  }
}

RefTVec_RefString CLiArgumentVerilogExtList::getVerilogExtList() const {
  return m_verilogExtList;
}

// *********************************************************************
// CLiToken class
// *********************************************************************
CLiToken::CLiToken(const std::string& token,
                   const std::string& relativePath)

  : m_token(new std::string(token)),
    m_relativePath(!relativePath.empty()
                   ? new std::string(relativePath)
                   : static_cast<std::string*>(NULL)) {}

const std::string& CLiToken::getString(CLiTool::ETokenGet what) const {
  if (what == CLiTool::Instance()->TK_TOKEN) {
    ASSERT(m_token.get(), INTERNAL_ERROR_NULL_REFERENCE);

    return *m_token;
  }
  else if (what == CLiTool::Instance()->TK_PATH) {
    return (m_relativePath.get()
            ? *m_relativePath
            : CLiTool::Instance()->EMPTY_STRING);
  }
  else {
    ASSERT(FAIL, INTERNAL_ERROR_UNKNOWN);
  }
}

// *********************************************************************
// CLiArgumentList class
// *********************************************************************
CLiArgumentList::CLiArgumentList()
  : m_acceptedArguments(),
    m_outputDirectory(),
    m_mustCreateOutputDirectory(FALSE),
    m_configFile(),
    m_cliFiles(),

    m_cslSourceFiles(),
    m_cslPp(CLiTool::Instance()->PP_ON),
    m_cslPpFile(),
    m_cslItFile(),
    m_cslPrintIt(FALSE),
    m_cppGen(FALSE),
    m_csimGen(FALSE),
    m_verilogTbGen(FALSE),
    m_cslMaxErr(CLiTool::Instance()->DEFAULT_ERR_WARN),
    m_cslMaxWarn(CLiTool::Instance()->DEFAULT_ERR_WARN),
    m_cslIncludeDirectories(),
    m_cslMacroDefinitions(),
    m_cslVfIncludeDirectories(),
    m_cslVfIncludeFiles(),
    m_cslVerilogIncludeFiles(),

    m_verilogSourceFiles(),
    m_verilogPp(CLiTool::Instance()->PP_ON),
    m_verilogPpFile(),
    m_verilogLibraryDirectories(),
    m_verilogLibraryFiles(),
    m_verilogMacroDefinitions(),
    m_verilogIncludeDirectories(),
    m_verilogLibraryExtensions(),
    m_verilogLibNoNameHide(FALSE),
    m_verilogLibOrder(FALSE),
    m_verilogLibRescan(FALSE)

#   ifndef __RELEASE_VERSION
  ,
    m_execStage(CLiTool::Instance()->EXEC_STAGE_NO_SELECTION),
    m_vExecStage(CLiTool::Instance()->VEXEC_STAGE_NO_SELECTION),
    m_displayInfo(FALSE),
    m_displayCslomAst(FALSE),
    m_displayCdomAst(FALSE)
#   endif
{}

RefCLiArgumentList CLiArgumentList::getThis() {
  RefCLiArgumentList strongRef = m_selfRef.lock();

  ASSERT(strongRef.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return strongRef;
}

RefCLiArgumentList CLiArgumentList::build() {
  RefCLiArgumentList refArgList(new CLiArgumentList());

  refArgList->m_selfRef = WeakRefCLiArgumentList(refArgList);

  refArgList->m_acceptedArguments = RefTVec_RefCLiArgumentBase(new TVec_RefCLiArgumentBase());
  refArgList->m_cslSourceFiles = RefTVec_RefString(new TVec_RefString());
  refArgList->m_verilogSourceFiles = RefTVec_RefString(new TVec_RefString());

  refArgList->buildArgumentList();

  return refArgList;
}


/** CSL specific get functions
 */
RefString CLiArgumentList::getVfIncdir() const {
  std::string result = CLiTool::Instance()->EMPTY_STRING;

  if (m_cslVfIncludeDirectories.get()) {
    for (TVec_RefString_iter dir = m_cslVfIncludeDirectories->begin();
         dir != m_cslVfIncludeDirectories->end();
         ++dir) {

      result.append(**dir);
      result.append(CLiTool::Instance()->VER_PLUS);
    }
  }

  return RefString(!result.empty()
                   ? new std::string(result)
                   : static_cast<std::string*>(NULL));
}


/** parser related functions
 */
TVec_RefCLiArgumentBase_const_iter CLiArgumentList::findArgument(const std::string& token) {
  TVec_RefCLiArgumentBase_const_iter result = m_acceptedArguments->begin();
  for (;
       result != m_acceptedArguments->end();
       ++result) {

    if ((*result)->isKeyWord(token)) {
      return result;
    }
  }

  return result;
}

TBool CLiArgumentList::isCslFile(const boost::filesystem::path& fileName) const {
  return CLiCommon::Instance()->isFileExtension(fileName, CLiTool::Instance()->CSL_EXTENSION);
}

TBool CLiArgumentList::isVerFile(const boost::filesystem::path& fileName) const {
  return CLiCommon::Instance()->isFileExtension(fileName, CLiTool::Instance()->EMPTY_STRING);
}

TBool CLiArgumentList::isSourceFile(const boost::filesystem::path& fileName) const {
  return (isCslFile(fileName)
          || isVerFile(fileName));
}

TVec_RefCLiToken_iter CLiArgumentList::findToken(const RefTVec_RefCLiToken& tokenList,
                                                 const std::string& token) {

  TVec_RefCLiToken_iter result = tokenList->begin();

  for (;
       result != tokenList->end();
       ++result) {

    std::string tk = (*result)->getString(CLiTool::Instance()->TK_TOKEN);
    if (tk == token) {
      return result;
    }
  }

  return result;
}

TVec_RefString_iter CLiArgumentList::findToken(const RefTVec_RefString& tokenList,
                                               const std::string& token) {

  TVec_RefString_iter result = tokenList->begin();

  for (;
       result != tokenList->end();
       ++result) {

    if (**result == token) {
      return result;
    }
  }

  return result;
}

void CLiArgumentList::addCslFile(const std::string& fileName) {
  RefString refStr(new std::string(fileName));

  TVec_RefString_iter file = findToken(m_cslSourceFiles, fileName);
  if (file == m_cslSourceFiles->end()) {
    m_cslSourceFiles->push_back(refStr);
  }
  else {
    CLiError::buildWarning(CLiTool::Instance()->AWARN_FILE_ALREADY_IN_LIST, fileName);
  }
}

void CLiArgumentList::addVerFile(const std::string& fileName) {
  RefString refStr(new std::string(fileName));

  TVec_RefString_iter file = findToken(m_verilogSourceFiles, fileName);
  if (file == m_verilogSourceFiles->end()) {
    m_verilogSourceFiles->push_back(refStr);
  }
  else {
    CLiError::buildWarning(CLiTool::Instance()->AWARN_FILE_ALREADY_IN_LIST, fileName);
  }
}

void CLiArgumentList::addSourceFile(const std::string& filename) {
  if (isCslFile(filename)) {
    addCslFile(filename);
  }
  else {
    addVerFile(filename);
  }
}

void CLiArgumentList::addCliFileArguments(const RefTVec_RefCLiToken& argumentList) {
  for (TVec_RefCLiToken_reverse_iter index = argumentList->rbegin();
       index != argumentList->rend();
       ++index) {

    m_tokenIndex = m_tokenList->insert(m_tokenIndex, *index);
  }
}

CLiTool::ECLiError CLiArgumentList::parseCliFile(const std::string& fileName) {
  TVec_RefString_iter file = findToken(m_cliFiles, fileName);
  if (file != m_cliFiles->end()) {
    CLiError::buildError(CLiTool::Instance()->APARSE_DUPLICATE_CLI_FILE, fileName);
    return CLiTool::Instance()->APARSE_DUPLICATE_CLI_FILE;
  }
  else {
    m_cliFiles->push_back(RefString(new std::string(fileName)));
    // DEP changed
    RefString relativeStr = CLiCommon::Instance()->getRelativePath(fileName);

    std::string relativePath = *relativeStr;

    RefTVec_RefCLiToken argList(new TVec_RefCLiToken());

    std::fstream inputFile;
    CLiTool::ECLiFileStat result = CLiCommon::Instance()->openFile(fileName, inputFile, std::ios::in);
    if (result == CLiTool::Instance()->FS_READ_DENIED) {
      CLiError::buildError(CLiTool::Instance()->APARSE_READ_PERMISION_DENIED, fileName);
      return CLiTool::Instance()->APARSE_READ_PERMISION_DENIED;
    }
    else if (result == CLiTool::Instance()->FS_FAIL) {
      CLiError::buildError(CLiTool::Instance()->APARSE_FAIL, CLiCommon::Instance()->m_errorMessage.str());
      return CLiTool::Instance()->APARSE_FAIL;
    }
    else if (result == CLiTool::Instance()->FS_COULD_NOT_OPEN) {
      CLiError::buildError(CLiTool::Instance()->APARSE_COULD_NOT_OPEN_FILE, fileName);
      return CLiTool::Instance()->APARSE_COULD_NOT_OPEN_FILE;
    }
    else {
      std::string tokenLine;
      TBool ignoreRegion = FALSE;
      while (getline(inputFile, tokenLine)) {

        TBool stop;
        std::string::size_type lineComment;
        std::string::size_type regionCommentBegin;
        std::string::size_type regionCommentEnd;
        do {

          std::string::size_type eraseFrom = CLiTool::Instance()->START_POSITION;
          std::string::size_type eraseAmount = CLiTool::Instance()->START_POSITION;
          stop = FALSE;
          lineComment = tokenLine.find(CLiTool::Instance()->LINE_COMMENT);
          regionCommentBegin = tokenLine.find(CLiTool::Instance()->REGION_COMMENT_BEGIN);
          regionCommentEnd = tokenLine.find(CLiTool::Instance()->REGION_COMMENT_END);

          if (!ignoreRegion) {
            if (lineComment < regionCommentBegin) {
              stop = TRUE;
              eraseFrom = lineComment;
              eraseAmount = tokenLine.size() - lineComment;
            }
            else if (regionCommentBegin != std::string::npos) {
              if (regionCommentEnd != std::string::npos
                  && regionCommentBegin < regionCommentEnd) {

                eraseFrom = regionCommentBegin;
                eraseAmount = regionCommentEnd - regionCommentBegin + CLiTool::Instance()->REGION_COMMENT_END.size();
              }
              else {
                stop = TRUE;
                ignoreRegion = TRUE;
                eraseFrom = regionCommentBegin;
                eraseAmount = tokenLine.size() - regionCommentBegin;
              }
            }
          }
          else if (regionCommentEnd != std::string::npos) {
            eraseFrom = CLiTool::Instance()->START_POSITION;
            eraseAmount = regionCommentEnd + CLiTool::Instance()->REGION_COMMENT_END.size();
            ignoreRegion = FALSE;
          }
          else {
            eraseFrom = CLiTool::Instance()->START_POSITION;
            eraseAmount = tokenLine.size();
            stop = TRUE;
          }

          tokenLine.erase(eraseFrom, eraseAmount);
          if (eraseFrom != CLiTool::Instance()->START_POSITION
              && eraseAmount != tokenLine.size()) {

            tokenLine.insert(eraseFrom, CLiTool::Instance()->WHITE_SPACE);
          }

        } while (!stop
                 && (lineComment != std::string::npos
                     || regionCommentBegin != std::string::npos
                     || (regionCommentEnd != std::string::npos
                         && ignoreRegion)));

        std::stringstream ss(tokenLine);
        std::string token;
        while (ss >> token) {
          RefCLiToken cliToken;
          CLiCommon::Instance()->resolveEnvironmentVars(token);

          if (CLiCommon::Instance()->isAbsolutePath(token)) {
            cliToken = RefCLiToken(new CLiToken(token));
          }
          else {
            cliToken = RefCLiToken(new CLiToken(token, relativePath));
          }

          argList->push_back(cliToken);
        }
      }

      addCliFileArguments(argList);

      inputFile.close();
    }
  }

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::parseArgumentList(TInt argc,
                                             TChar** argv) {

  if (argc <= CLiTool::Instance()->FIRST_ARGC) {
    execArgHelp(RefCLiArgumentBase());
    return CLiTool::Instance()->APARSE_HELP;
  }

  m_tokenList = RefTVec_RefCLiToken(new TVec_RefCLiToken());
  for (TInt index = CLiTool::Instance()->FIRST_ARGC;
       index < argc;
       ++index) {

    m_tokenList->push_back(RefCLiToken(new CLiToken(std::string(argv[index]))));
  }

  m_tokenIndex = m_tokenList->begin();
  while (m_tokenIndex != m_tokenList->end()) {

    std::string token = (*m_tokenIndex)->getString(CLiTool::Instance()->TK_TOKEN);

    TVec_RefCLiArgumentBase_const_iter arg = findArgument(token);
    if (arg != m_acceptedArguments->end()) {
      CLiTool::ECLiError parseResult = (*arg)->execHandler(m_tokenList, m_tokenIndex);
      if (parseResult != CLiTool::Instance()->APARSE_SUCCESS) {
        return parseResult;
      }
    }
    else {
      std::string fileName = (*m_tokenIndex)->getString(CLiTool::Instance()->TK_PATH);
      fileName.append(token);
      boost::filesystem::path fsPath(fileName, boost::filesystem::native);

      CLiTool::TAccessRights fileAccessRights;
      CLiTool::ECLiFileStat result = CLiCommon::Instance()->fileStat(fsPath, fileAccessRights);
      if (result == CLiTool::Instance()->FS_DENIED) {
        CLiError::buildError(CLiTool::Instance()->APARSE_ACCESS_DENIED, CLiCommon::Instance()->m_failedPath);
        return CLiTool::Instance()->APARSE_ACCESS_DENIED;
      }
      else if (result == CLiTool::Instance()->FS_FAIL) {
        CLiError::buildError(CLiTool::Instance()->APARSE_FAIL, CLiCommon::Instance()->m_errorMessage.str());
        return CLiTool::Instance()->APARSE_FAIL;
      }
      else if (result == CLiTool::Instance()->FS_NOT_EXISTS) {
        CLiError::buildError(CLiTool::Instance()->APARSE_FILE_NOT_EXISTS, fileName);
        return CLiTool::Instance()->APARSE_FILE_NOT_EXISTS;
      }
      else if (result == CLiTool::Instance()->FS_IS_DIRECTORY) {
        CLiError::buildError(CLiTool::Instance()->APARSE_EXPECTED_FILE, fileName);
        return CLiTool::Instance()->APARSE_EXPECTED_FILE;
      }
      else if (!isSourceFile(fsPath)) {
        CLiError::buildError(CLiTool::Instance()->APARSE_INVALID_ARGUMENT, fileName);
        return CLiTool::Instance()->APARSE_INVALID_ARGUMENT;
      }
      else {
        addSourceFile(fileName);
        ++m_tokenIndex;
      }
    }
  }

  if (m_cslPp == CLiTool::Instance()->PP_ONLY
      && !m_cslPpFile.get()) {

    CLiError::buildWarning(CLiTool::Instance()->AWARN_NO_PP_FILENAME, CLiTool::Instance()->EMPTY_STRING);
  }

  if (!m_cslSourceFiles->size()
      && !m_verilogSourceFiles->size()) {

    CLiError::buildError(CLiTool::Instance()->APARSE_NO_SOURCE_FILE_SPECIFIED);
    return CLiTool::Instance()->APARSE_NO_SOURCE_FILE_SPECIFIED;
  }
  else {
    return CLiTool::Instance()->APARSE_SUCCESS;
  }
}

RefTVec_RefString CLiArgumentList::buildKeyWordList(const std::string& keyWord1,
                                                    const std::string& keyWord2) {

  RefTVec_RefString result = RefTVec_RefString(new TVec_RefString());
  result->push_back(RefString(new std::string(keyWord1)));
  if (!keyWord2.empty()) {
    result->push_back(RefString(new std::string(keyWord2)));
  }

  return result;
}

void CLiArgumentList::buildArgumentEmpty(const THandler& handler,
                                         TBool multiple,
                                         const std::string& keyWord1,
                                         const std::string& keyWord2) {

  RefCLiArgumentList _this = getThis();

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);
  RefCLiArgumentEmpty argEmpty = CLiArgumentEmpty::build(_this, keyWordList, handler, multiple);

  m_acceptedArguments->push_back(argEmpty);
}

void CLiArgumentList::buildArgumentNumber(const THandler& handler,
                                          TBool multiple,
                                          TInt lowerBound,
                                          TInt upperBound,
                                          const std::string& keyWord1,
                                          const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentNumber argNumber = CLiArgumentNumber::build(_this, keyWordList, handler, multiple, lowerBound, upperBound);

  m_acceptedArguments->push_back(argNumber);
}

void CLiArgumentList::buildArgumentFileName(const THandler& handler,
                                            TBool multiple,
                                            TBool mustExist,
                                            const std::string& fileExt,
                                            const std::string& keyWord1,
                                            const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefString refFileExt = RefString();
  if (!fileExt.empty()) {
    refFileExt = RefString(new std::string(fileExt));
  }

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentFileName argFileName = CLiArgumentFileName::build(_this, keyWordList, handler, multiple, mustExist, refFileExt);

  m_acceptedArguments->push_back(argFileName);
}

void CLiArgumentList::buildArgumentDirName(const THandler& handler,
                                           TBool multiple,
                                           TBool mustExist,
                                           const std::string& keyWord1,
                                           const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentDirName argDirName = CLiArgumentDirName::build(_this, keyWordList, handler, multiple, mustExist);

  m_acceptedArguments->push_back(argDirName);
}

void CLiArgumentList::buildArgumentOptionList(const THandler& handler,
                                              TBool multiple,
                                              const RefTVec_RefString& optionList,
                                              const std::string& keyWord1,
                                              const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentOption argOption = CLiArgumentOption::build(_this, keyWordList, handler, multiple, optionList);

  m_acceptedArguments->push_back(argOption);
}

void CLiArgumentList::buildArgumentCslDefine(const THandler& handler,
                                             TBool multiple,
                                             const std::string& keyWord1,
                                             const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentCslDefine argCslDefine = CLiArgumentCslDefine::build(_this, keyWordList, handler, multiple);

  m_acceptedArguments->push_back(argCslDefine);
}

void CLiArgumentList::buildArgumentVerilogDefine(const THandler& handler,
                                                 TBool multiple,
                                                 const std::string& keyWord1,
                                                 const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentVerilogDefine argVerDefine = CLiArgumentVerilogDefine::build(_this, keyWordList, handler, multiple);

  m_acceptedArguments->push_back(argVerDefine);
}

void CLiArgumentList::buildArgumentVerilogDirList(const THandler& handler,
                                                  TBool multiple,
                                                  TBool mustExist,
                                                  const std::string& keyWord1,
                                                  const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentVerilogDirList argVerDirList = CLiArgumentVerilogDirList::build(_this, keyWordList, handler, multiple, mustExist);

  m_acceptedArguments->push_back(argVerDirList);
}

void CLiArgumentList::buildArgumentVerilogExtList(const THandler& handler,
                                                  TBool multiple,
                                                  const std::string& keyWord1,
                                                  const std::string& keyWord2) {

  RefTVec_RefString keyWordList = buildKeyWordList(keyWord1, keyWord2);

  RefCLiArgumentList _this = getThis();
  RefCLiArgumentVerilogExtList argVerExtList = CLiArgumentVerilogExtList::build(_this, keyWordList, handler, multiple);

  m_acceptedArguments->push_back(argVerExtList);
}

void CLiArgumentList::buildArgumentList() {
  RefTVec_RefString ppOptions(new TVec_RefString());
  ppOptions->push_back(RefString(new std::string(CLiTool::Instance()->PP_OPTION_ON)));
  ppOptions->push_back(RefString(new std::string(CLiTool::Instance()->PP_OPTION_ONLY)));
//   ppOptions->push_back(RefString(new std::string(PP_OPTION_OFF)));

  //---------------general purpose-----------------------------------------//
  /** --help
   */
  buildArgumentEmpty(&CLiArgumentList::execArgHelp, FALSE, CLiTool::Instance()->HELP_);

  /** --dir
   */
  buildArgumentDirName(&CLiArgumentList::execArgDir, FALSE, FALSE, CLiTool::Instance()->DIR_);

  /** --config_file
   */
  buildArgumentFileName(&CLiArgumentList::execArgConfigFile, FALSE, TRUE, CLiTool::Instance()->XML_EXTENSION, CLiTool::Instance()->CONFIG_FILE_);

  //---------------CSL specific-----------------------------------------//
  /** --csl_pp
   */
  buildArgumentOptionList(&CLiArgumentList::execArgCslPp, FALSE, ppOptions, CLiTool::Instance()->CSL_PP_);

  /** --csl_pp_filename
   */
  buildArgumentFileName(&CLiArgumentList::execArgCslPpFileName, FALSE, FALSE, CLiTool::Instance()->EMPTY_STRING, CLiTool::Instance()->CSL_PP_FILENAME_);

  /** --print_it
   */
  buildArgumentEmpty(&CLiArgumentList::execArgCslPrintIt, FALSE, CLiTool::Instance()->CSL_PRINT_IT_);

  /** --print_it_to
   */
  buildArgumentFileName(&CLiArgumentList::execArgCslPrintItFileName, FALSE, FALSE, CLiTool::Instance()->EMPTY_STRING, CLiTool::Instance()->CSL_PRINT_IT_FILENANME_);

  /** --cpp_gen
   */
  buildArgumentEmpty(&CLiArgumentList::execArgCppGen, FALSE, CLiTool::Instance()->CSL_CPP_GEN_);

  /** --csim_gen
   */
  buildArgumentEmpty(&CLiArgumentList::execArgCsimGen, FALSE, CLiTool::Instance()->CSL_CSIM_GEN_);
  
  /** --verilog_tb_gen
   */
  buildArgumentEmpty(&CLiArgumentList::execArgVerilogTbGen, FALSE, CLiTool::Instance()->CSL_VERILOG_TB_GEN_);

 /** --verilog_stim_exp_gen
   */
  buildArgumentEmpty(&CLiArgumentList::execArgVerilogStimExpGen, FALSE, CLiTool::Instance()->CSL_VERILOG_STIM_EXP_GEN_);

  /** --csl_max_error
   */
  buildArgumentNumber(&CLiArgumentList::execArgCslMaxError, FALSE, ZERO, MAX_INT, CLiTool::Instance()->CSL_MAX_ERROR_);

  /** --csl_max_warning
   */
  buildArgumentNumber(&CLiArgumentList::execArgCslMaxWarning, FALSE, ZERO, MAX_INT, CLiTool::Instance()->CSL_MAX_WARN_);

  /** --I
   */
  buildArgumentDirName(&CLiArgumentList::execArgI, TRUE, TRUE, CLiTool::Instance()->CSL_I_);

  /** --D
   */
  buildArgumentCslDefine(&CLiArgumentList::execArgD, TRUE, CLiTool::Instance()->CSL_DEFINE_);

  /** --vf_incdir+
   */
  buildArgumentVerilogDirList(&CLiArgumentList::execArgVfIncdir, FALSE, TRUE, CLiTool::Instance()->CSL_VF_INCDIR_);

  /** --include_vf
   */
  buildArgumentFileName(&CLiArgumentList::execArgCslIncludeVf, TRUE, TRUE, CLiTool::Instance()->VF_EXTENSION, CLiTool::Instance()->CSL_INCLUDE_VF_);

  /** --include_verilog
   */
  buildArgumentFileName(&CLiArgumentList::execArgCslIncludeVerilog, TRUE, TRUE, CLiTool::Instance()->EMPTY_STRING, CLiTool::Instance()->CSL_INCLUDE_VERILOG_);

  /** --f
   */
  buildArgumentFileName(&CLiArgumentList::execArgCslF, TRUE, TRUE, CLiTool::Instance()->CF_EXTENSION, CLiTool::Instance()->CSL_F_);

  //---------------Verilog specific-----------------------------------------//
  

  /** -verilog_pp
   */
  buildArgumentOptionList(&CLiArgumentList::execArgVerilogPp, FALSE, ppOptions, CLiTool::Instance()->VER_PP_);

  /** -verilog_pp_filename
   */
  buildArgumentFileName(&CLiArgumentList::execArgVerilogPpFileName, FALSE, FALSE, CLiTool::Instance()->EMPTY_STRING, CLiTool::Instance()->VER_PP_FILENAME_);

  /** -y
   */
  buildArgumentDirName(&CLiArgumentList::execArgY, TRUE, TRUE, CLiTool::Instance()->VER_Y_);

  /** -v
   */
  buildArgumentFileName(&CLiArgumentList::execArgV, TRUE, TRUE, CLiTool::Instance()->EMPTY_STRING, CLiTool::Instance()->VER_V_);

  /** +define+
   */
  buildArgumentVerilogDefine(&CLiArgumentList::execArgDefine, TRUE, CLiTool::Instance()->VER_DEFINE_);

  /** +incdir+
   */
  buildArgumentVerilogDirList(&CLiArgumentList::execArgIncdir, FALSE, TRUE, CLiTool::Instance()->VER_INCDIR_);

  /** +libext+
   */
  buildArgumentVerilogExtList(&CLiArgumentList::execArgLibExt, FALSE, CLiTool::Instance()->VER_LIBEXT_);

  /** +libnonamehide
   */
  buildArgumentEmpty(&CLiArgumentList::execArgLibNoNameHide, FALSE, CLiTool::Instance()->VER_LIBNONAMEHIDE_);

  /** +liborder
   */
  buildArgumentEmpty(&CLiArgumentList::execArgLibOrder, FALSE, CLiTool::Instance()->VER_LIBORDER_);

  /** +librescan
   */
  buildArgumentEmpty(&CLiArgumentList::execArgLibRescan, FALSE, CLiTool::Instance()->VER_LIBRESCAN_);

  /** -f
   */
  buildArgumentFileName(&CLiArgumentList::execArgVerF, TRUE, TRUE, CLiTool::Instance()->VF_EXTENSION, CLiTool::Instance()->VER_F_);

# ifndef __RELEASE_VERSION
  //---------------Debug only-----------------------------------------//
  /** --info
   */
  buildArgumentEmpty(&CLiArgumentList::execArgInfo, FALSE, CLiTool::Instance()->INFO_);

  /** --cslom_ast
   */
  buildArgumentEmpty(&CLiArgumentList::execArgCslomAst, FALSE, CLiTool::Instance()->CSLOM_AST_);

  /** -cdom_ast
   */
  buildArgumentEmpty(&CLiArgumentList::execArgCdomAst, FALSE, CLiTool::Instance()->CDOM_AST_);

  /** --exec_stage
   */
  buildArgumentNumber(&CLiArgumentList::execArgExecutionStage, FALSE, CLiTool::Instance()->EXEC_STAGE_PREPROCESSOR, CLiTool::Instance()->EXEC_STAGE_CDOM_CODE_GENS, CLiTool::Instance()->EXEC_STAGE_);

  /** -exec_stage
   */
  buildArgumentNumber(&CLiArgumentList::execArgVExecutionStage, FALSE, CLiTool::Instance()->VEXEC_STAGE_PREPROCESSOR, CLiTool::Instance()->VEXEC_STAGE_CDOM_CODE_GENS, CLiTool::Instance()->VEXEC_STAGE_);
# endif
}


//---------------general purpose-----------------------------------------//
CLiTool::ECLiError CLiArgumentList::execArgHelp(const RefCLiArgumentBase& argBase) {
  CLiError::buildHelp();
  return CLiTool::Instance()->APARSE_HELP;
}

CLiTool::ECLiError CLiArgumentList::execArgDir(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentDirName refDir = CLiArgumentDirName::cast(argBase);
  m_outputDirectory = refDir->getDirName();
  m_mustCreateOutputDirectory = refDir->getMustCreate();
  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgConfigFile(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  m_configFile = refFile->getFileName();

  return CLiTool::Instance()->APARSE_SUCCESS;
}


//---------------CSL specific-----------------------------------------//
CLiTool::ECLiError CLiArgumentList::execArgCslPp(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentOption refOpt = CLiArgumentOption::cast(argBase);
  RefString opt = refOpt->getSelOption();
  m_cslPp = getPpOption(opt);

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslPpFileName(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  m_cslPpFile = refFile->getFileName();

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslPrintIt(const RefCLiArgumentBase& argBase) {
  m_cslPrintIt = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslPrintItFileName(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  m_cslItFile = refFile->getFileName();

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCppGen(const RefCLiArgumentBase& argBase) {
  m_cppGen = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCsimGen(const RefCLiArgumentBase& argBase) {
  m_csimGen = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgVerilogTbGen(const RefCLiArgumentBase& argBase) {
  m_verilogTbGen = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgVerilogStimExpGen(const RefCLiArgumentBase& argBase) {
  m_verilogStimExpGen = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslMaxError(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentNumber refNum = CLiArgumentNumber::cast(argBase);
  TInt maxErr = refNum->getValue();
  m_cslMaxErr = maxErr;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslMaxWarning(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentNumber refNum = CLiArgumentNumber::cast(argBase);
  TInt maxWarn = refNum->getValue();
  m_cslMaxWarn = maxWarn;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgI(const RefCLiArgumentBase& argBase) {
  if (!m_cslIncludeDirectories.get()) {
    m_cslIncludeDirectories = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentDirName refDir = CLiArgumentDirName::cast(argBase);
  RefString dirName = refDir->getDirName();
  TVec_RefString_iter dir = findToken(m_cslIncludeDirectories, *dirName);
  if (dir == m_cslIncludeDirectories->end()) {
    m_cslIncludeDirectories->push_back(dirName);
  }
  else {
    CLiError::buildWarning(CLiTool::Instance()->AWARN_CSL_INCLUDE_DIR_ALREADY_IN_LIST, *dirName);
  }

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgD(const RefCLiArgumentBase& argBase) {
  if (!m_cslMacroDefinitions.get()) {
    m_cslMacroDefinitions = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentCslDefine refCslDefine = CLiArgumentCslDefine::cast(argBase);
  RefString macroDef = refCslDefine->getMacroDef();
  m_cslMacroDefinitions->push_back(macroDef);

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgVfIncdir(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentVerilogDirList refDirList = CLiArgumentVerilogDirList::cast(argBase);
  m_cslVfIncludeDirectories = refDirList->getVerilogDirList();

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslIncludeVf(const RefCLiArgumentBase& argBase) {
  if (!m_cslVfIncludeFiles.get()) {
    m_cslVfIncludeFiles = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  RefString fileName = refFile->getFileName();
  m_cslVfIncludeFiles->push_back(fileName);

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslIncludeVerilog(const RefCLiArgumentBase& argBase) {
  if (!m_cslVerilogIncludeFiles.get()) {
    m_cslVerilogIncludeFiles = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  RefString fileName = refFile->getFileName();
  m_cslVerilogIncludeFiles->push_back(fileName);

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslF(const RefCLiArgumentBase& argBase) {
  if (!m_cliFiles.get()) {
    m_cliFiles = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  RefString fileName = refFile->getFileName();
  return parseCliFile(*fileName);
}


//---------------Verilog specific-----------------------------------------//
  CLiTool::ECLiError CLiArgumentList::execArgVerilogPp(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentOption refOpt = CLiArgumentOption::cast(argBase);
  RefString opt = refOpt->getSelOption();
  m_verilogPp = getPpOption(opt);

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgVerilogPpFileName(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  m_verilogPpFile = refFile->getFileName();

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgY(const RefCLiArgumentBase& argBase) {
  if (!m_verilogLibraryDirectories.get()) {
    m_verilogLibraryDirectories = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentDirName refDir = CLiArgumentDirName::cast(argBase);
  RefString dirName = refDir->getDirName();
  TVec_RefString_iter dir = findToken(m_verilogLibraryDirectories, *dirName);
  if (dir == m_verilogLibraryDirectories->end()) {
    m_verilogLibraryDirectories->push_back(dirName);
  }
  else {
    CLiError::buildWarning(CLiTool::Instance()->AWARN_VER_LIBRARY_DIR_ALREADY_IN_LIST, *dirName);
  }

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgV(const RefCLiArgumentBase& argBase) {
  if (!m_verilogLibraryFiles.get()) {
    m_verilogLibraryFiles = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  RefString fileName = refFile->getFileName();
  TVec_RefString_iter file = findToken(m_verilogLibraryFiles, *fileName);
  if (file == m_verilogLibraryFiles->end()) {
    m_verilogLibraryFiles->push_back(fileName);
  }
  else {
    CLiError::buildWarning(CLiTool::Instance()->AWARN_VER_LIBRARY_FILE_ALREADY_IN_LIST, *fileName);
  }

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgPrj(const RefCLiArgumentBase& argBase) {
  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgDefine(const RefCLiArgumentBase& argBase) {
  if (!m_verilogMacroDefinitions.get()) {
    m_verilogMacroDefinitions = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentVerilogDefine refDef = CLiArgumentVerilogDefine::cast(argBase);
  RefString verilogDefine = refDef->getVerilogDefine();
  m_verilogMacroDefinitions->push_back(verilogDefine);

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgIncdir(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentVerilogDirList refDirList = CLiArgumentVerilogDirList::cast(argBase);
  m_verilogIncludeDirectories = refDirList->getVerilogDirList();

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgLibExt(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentVerilogExtList refExtList = CLiArgumentVerilogExtList::cast(argBase);
  m_verilogLibraryExtensions = refExtList->getVerilogExtList();

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgLibNoNameHide(const RefCLiArgumentBase& argBase) {
  m_verilogLibNoNameHide = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgLibOrder(const RefCLiArgumentBase& argBase) {
  m_verilogLibOrder = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgLibRescan(const RefCLiArgumentBase& argBase) {
  m_verilogLibRescan = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgVerF(const RefCLiArgumentBase& argBase) {
  if (!m_cliFiles.get()) {
    m_cliFiles = RefTVec_RefString(new TVec_RefString());
  }

  RefCLiArgumentFileName refFile = CLiArgumentFileName::cast(argBase);
  RefString fileName = refFile->getFileName();
  return parseCliFile(*fileName);
}

#ifndef __RELEASE_VERSION
//---------------Debug only-----------------------------------------//
CLiTool::ECLiError CLiArgumentList::execArgInfo(const RefCLiArgumentBase& argBase) {
  m_displayInfo = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCdomAst(const RefCLiArgumentBase& argBase) {
  m_displayCdomAst = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgCslomAst(const RefCLiArgumentBase& argBase) {
  m_displayCslomAst = TRUE;

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgExecutionStage(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentNumber refNum = CLiArgumentNumber::cast(argBase);
  TInt execStage = refNum->getValue();
  // RM DEP m_execStage = static_cast<CLiTool::ECSLcExecStage>(execStage);

  CLiTool::ECSLcExecStage e = static_cast<CLiTool::ECSLcExecStage>(execStage);

  switch(e){
  case  CLiTool::EXEC_STAGE_PREPROCESSOR        : m_execStage = CLiTool::EXEC_STAGE_PREPROCESSOR        ;
  case  CLiTool::EXEC_STAGE_LEXER               : m_execStage = CLiTool::EXEC_STAGE_LEXER               ;
  case  CLiTool::EXEC_STAGE_PARSER              : m_execStage = CLiTool::EXEC_STAGE_PARSER              ;
  case  CLiTool::EXEC_STAGE_TREE_WALKER         : m_execStage = CLiTool::EXEC_STAGE_TREE_WALKER         ;
  case  CLiTool::EXEC_STAGE_INST_TREE           : m_execStage = CLiTool::EXEC_STAGE_INST_TREE           ;
  case  CLiTool::EXEC_STAGE_AUTOROUTER          : m_execStage = CLiTool::EXEC_STAGE_AUTOROUTER          ;
  case  CLiTool::EXEC_STAGE_AUTOMAPPER          : m_execStage = CLiTool::EXEC_STAGE_AUTOMAPPER          ;
  case  CLiTool::EXEC_STAGE_CSLOM_CHECKER       : m_execStage = CLiTool::EXEC_STAGE_CSLOM_CHECKER       ;
  case  CLiTool::EXEC_STAGE_CONNECTION_CHECKER  : m_execStage = CLiTool::EXEC_STAGE_CONNECTION_CHECKER  ;
  case  CLiTool::EXEC_STAGE_CSLOM_CODE_GENS     : m_execStage = CLiTool::EXEC_STAGE_CSLOM_CODE_GENS     ;
  case  CLiTool::EXEC_STAGE_VERILOG_TB          : m_execStage = CLiTool::EXEC_STAGE_VERILOG_TB          ;
  case  CLiTool::EXEC_STAGE_VERILOG_STIM_EXP    : m_execStage = CLiTool::EXEC_STAGE_VERILOG_STIM_EXP    ;
  case  CLiTool::EXEC_STAGE_ADAPTER             : m_execStage = CLiTool::EXEC_STAGE_ADAPTER             ;
  case  CLiTool::EXEC_STAGE_CDOM_CHECKER        : m_execStage = CLiTool::EXEC_STAGE_CDOM_CHECKER        ;
  case  CLiTool::EXEC_STAGE_CDOM_CODE_GENS      : m_execStage = CLiTool::EXEC_STAGE_CDOM_CODE_GENS      ;

  default: {
    ASSERT(0, "bad exec stage argument"); 
  }
  }

  return CLiTool::Instance()->APARSE_SUCCESS;
}

CLiTool::ECLiError CLiArgumentList::execArgVExecutionStage(const RefCLiArgumentBase& argBase) {
  RefCLiArgumentNumber refNum = CLiArgumentNumber::cast(argBase);
  TInt execStage = refNum->getValue();
  // RM DEP   m_vExecStage = static_cast<CLiTool::ECSLcVExecStage>(execStage);

  CLiTool::ECSLcVExecStage e = static_cast<CLiTool::ECSLcVExecStage>(execStage);

  switch(e){
  case  CLiTool::VEXEC_STAGE_PREPROCESSOR  : m_vExecStage = CLiTool::VEXEC_STAGE_PREPROCESSOR  ;
  case  CLiTool::VEXEC_STAGE_LEXER         : m_vExecStage = CLiTool::VEXEC_STAGE_LEXER         ;         
  case  CLiTool::VEXEC_STAGE_PARSER        : m_vExecStage = CLiTool::VEXEC_STAGE_PARSER        ;        
  case  CLiTool::VEXEC_STAGE_TREE_WALKER   : m_vExecStage = CLiTool::VEXEC_STAGE_TREE_WALKER   ;   
  case  CLiTool::VEXEC_STAGE_CDOM_CHECKER  : m_vExecStage = CLiTool::VEXEC_STAGE_CDOM_CHECKER  ;  
  case  CLiTool::VEXEC_STAGE_CDOM_CODE_GENS: m_vExecStage = CLiTool::VEXEC_STAGE_CDOM_CODE_GENS;
    //  case  CLiTool::VEXEC_STAGE_NO_SELECTION  : m_vExecStage = CLiTool::VEXEC_STAGE_NO_SELECTION  ;
  default: {
    ASSERT(0, "bad vexec stage argument"); 
  }
  }

  return CLiTool::Instance()->APARSE_SUCCESS;
}
#endif

CLiTool::ECSLcPpOption CLiArgumentList::getPpOption(RefString opt) const {
  ASSERT(opt.get(), INTERNAL_ERROR_NULL_REFERENCE);

  if (*opt == CLiTool::Instance()->PP_OPTION_ON) {
    return CLiTool::Instance()->PP_ON;
  }
  else if (*opt == CLiTool::Instance()->PP_OPTION_ONLY) {
    return CLiTool::Instance()->PP_ONLY;
  }
//   else if (*opt == PP_OPTION_OFF) {
//     return PP_OFF;
//   }

  ASSERT(FAIL, INTERNAL_ERROR_UNKNOWN);
}

// *********************************************************************
// CLiError error
// *********************************************************************
std::stringstream CLiError::m_errMessage;
std::stringstream CLiError::m_warnMessage;
std::stringstream CLiError::m_helpMessage;

CLiError::CLiError() {}

std::string CLiError::getError() {
  return m_errMessage.str();
}

std::string CLiError::getWarning() {
  return m_warnMessage.str();
}

std::string CLiError::getHelp() {
  return m_helpMessage.str();
}

void CLiError::buildHelp() {
  m_helpMessage << std::endl
                << "=================" << std::endl
                << "|cslc help/usage|" << std::endl
                << "=================" << std::endl
         
                << std::endl
                << "General purpose" << std::endl
                << "\t" << CLiTool::Instance()->HELP_                              << "\t\t\t\t: " << "displays help"                                                   << std::endl
                << "\t" << CLiTool::Instance()->DIR_          << " <dir_name>"     << "\t\t: "     << "sets the generated code path (default the current directory)"    << std::endl
                << "\t" << CLiTool::Instance()->CONFIG_FILE_  << " <xml_filename>" << "\t: "       << "a configuration file which the user can put cslc arguments into" << std::endl
         
                << std::endl
                << "CSL specific" << std::endl
                << "\t" << CLiTool::Instance()->CSL_PP_                 << " on|only"          << "\t\t: "   << "enables/only runs the CSL preprocessor (default on)"                                    << std::endl
                << "\t" << CLiTool::Instance()->CSL_PP_FILENAME_        << " <filename>"       << "\t: "     << "sets the output file for the CSL preprocessor (default random filenames are generated)" << std::endl
                << "\t" << CLiTool::Instance()->CSL_MAX_ERROR_          << " <value>"          << "\t\t: "   << "sets the maximum number of errors encountered before the cslc aborts (default 30)"      << std::endl
                << "\t" << CLiTool::Instance()->CSL_MAX_WARN_           << " <value>"          << "\t: "     << "sets the maximum number of warnings encountered before the cslc aborts (default 30)"    << std::endl
                << "\t" << CLiTool::Instance()->CSL_I_                  << " <dir_name>"       << "\t\t\t: " << "includes all the .csl files in the specified directory"                                 << std::endl
                << "\t" << CLiTool::Instance()->CSL_DEFINE_             << " <id>=\"<macro>\"" << "\t\t: "   << "command line define"                                                                    << std::endl
                << "\t" << CLiTool::Instance()->CSL_VF_INCDIR_          << " <dir_name1>+..."  << "\t: "     << "specify the directories in which the Verilog to search for an included file"            << std::endl
                << "\t" << CLiTool::Instance()->CSL_INCLUDE_VF_         << " <vf_filename>"    << "\t: "     << "a cslc .vf file with a list of cslc command line arguments"                             << std::endl
                << "\t" << CLiTool::Instance()->CSL_INCLUDE_VERILOG_    << " <filename>"       << "\t: "     << "a Verilog filename to include"                                                          << std::endl
                << "\t" << CLiTool::Instance()->CSL_F_                  << " <cf_filename>"    << "\t\t: "   << "a cslc .cf file with a list of cslc command line arguments"                             << std::endl
                << "\t" << CLiTool::Instance()->CSL_PRINT_IT_                                  << "\t\t\t: " << "prints the instance tree (default off)"                                                 << std::endl
                << "\t" << CLiTool::Instance()->CSL_PRINT_IT_FILENANME_ << " <filename>"       << "\t: "     << "prints the instance tree to the specified file (default prints to standard output)"     << std::endl
                << "\t" << CLiTool::Instance()->CSL_CPP_GEN_                                   << "\t\t\t: " << "enables cpp code generator (default off)"                                               << std::endl
                << "\t" << CLiTool::Instance()->CSL_CSIM_GEN_                                  << "\t\t\t: " << "enables csim code generator (default off)"                                              << std::endl
         
                << std::endl
                << "Verilog specific" << std::endl
                << "\t" << CLiTool::Instance()->VER_PP_            << " on|only"          << "\t\t: "     << "enables/only runs the Verilog preprocessor (default on)"                                    << std::endl
                << "\t" << CLiTool::Instance()->VER_PP_FILENAME_   << " <filename>"       << "\t: "       << "sets the output file for the Verilog preprocessor (default random filenames are generated)" << std::endl
                << "\t" << CLiTool::Instance()->VER_PRJ_           << " <prj_filename>"   << "\t\t: "     << "compile the Verilog project specified"                                                      << std::endl
                << "\t" << CLiTool::Instance()->VER_Y_             << " <dir_name>"       << "\t\t\t: "   << "sets a path to a Verilog library directory"                                                 << std::endl
                << "\t" << CLiTool::Instance()->VER_V_             << " <filename>"       << "\t\t\t: "   << "sets a Verilog library file"                                                                << std::endl
                << "\t" << CLiTool::Instance()->VER_DEFINE_        << " <id>=\"<macro>\"" << "\t\t: "     << "command line define"                                                                        << std::endl
                << "\t" << CLiTool::Instance()->VER_INCDIR_        << " <dir_name1>+..."  << "\t: "       << "specify the directories in which the cslc to search for an included file"                   << std::endl
                << "\t" << CLiTool::Instance()->VER_LIBEXT_        << " <ext1>+..."       << "\t\t: "     << "specify the Verilog library files extensions"                                               << std::endl
                << "\t" << CLiTool::Instance()->VER_F_             << " <vf_filename>"    << "\t\t: "     << "a cslc .vf file with a list of cslc command line arguments"                                 << std::endl
                << "\t" << CLiTool::Instance()->VER_LIBNONAMEHIDE_                        << "\t\t\t: "   << "reads only the necessary module and UDP definitions"                                        << std::endl
                << "\t" << CLiTool::Instance()->VER_LIBORDER_                             << "\t\t\t: "   << "scans library files and directories as they follow on the command line"                     << std::endl
                << "\t" << CLiTool::Instance()->VER_LIBRESCAN_                            << "\t\t\t: "   << "scans library files and directories to resolve all undefined module and UDP instances"      << std::endl;
         
# ifndef __RELEASE_VERSION
  m_helpMessage << std::endl
                << "Debug only" << std::endl
                << "\t" << CLiTool::Instance()->INFO_                 << "\t\t\t\t: " << "displays additional info" << std::endl
                << "\t" << CLiTool::Instance()->CSLOM_AST_            << "\t\t\t: "   << "displays the CSLOM AST"   << std::endl
                << "\t" << CLiTool::Instance()->EXEC_STAGE_           << " <value>"                                 << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_PREPROCESSOR    << "  : run CSL Preprocessor"          << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_LEXER           << "  : run CSL Lexer"                 << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_PARSER          << "  : run CSL Parser"                << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_TREE_WALKER     << "  : run CSL Tree Walker"           << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_INST_TREE       << "  : run CSL Instance Tree"         << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_AUTOMAPPER      << "  : run CSL Automapper"            << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_AUTOROUTER      << "  : run CSL Autorouter"            << std::endl
		<< "\t\t" << CLiTool::Instance()->EXEC_STAGE_CSLOM_CHECKER   << "  : run CSLOM Checker"             << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_CSLOM_CODE_GENS << "  : run CSLOM Code Generators"     << std::endl
		<< "\t\t" << CLiTool::Instance()->EXEC_STAGE_VERILOG_TB      << "  : run CSL Verilog TB Generator"  << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_ADAPTER         << "  : run CSL Adapter"               << std::endl
		<< "\t\t" << CLiTool::Instance()->EXEC_STAGE_VERILOG_STIM_EXP << "  : run Stim Exp Memory Generator"     << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_CDOM_CHECKER    << "  : run CDOM Checker"              << std::endl
                << "\t\t" << CLiTool::Instance()->EXEC_STAGE_CDOM_CODE_GENS  << "  : run CDOM Code Generators"      << std::endl
                << "\t" << CLiTool::Instance()->CDOM_AST_             << "\t\t\t: "   << "displays the CDOM AST"    << std::endl
                << "\t" << CLiTool::Instance()->VEXEC_STAGE_          << " <value>"                                 << std::endl
                << "\t\t" << CLiTool::Instance()->VEXEC_STAGE_PREPROCESSOR   << " : run Verilog Preprocessor"       << std::endl
                << "\t\t" << CLiTool::Instance()->VEXEC_STAGE_LEXER          << " : run Verilog Lexer"              << std::endl
                << "\t\t" << CLiTool::Instance()->VEXEC_STAGE_PARSER         << " : run Verilog Parser"             << std::endl
                << "\t\t" << CLiTool::Instance()->VEXEC_STAGE_TREE_WALKER    << " : run Verilog Tree Walker"        << std::endl
                << "\t\t" << CLiTool::Instance()->VEXEC_STAGE_CDOM_CHECKER   << " : run CDOM Checker"               << std::endl
                << "\t\t" << CLiTool::Instance()->VEXEC_STAGE_CDOM_CODE_GENS << " : run CDOM Code Generators"       << std::endl;
# endif
}

void CLiError::buildWarning(CLiTool::ECLiWarning warn,
                            const std::string& token) {

  switch(warn) {
    case CLiTool::AWARN_FILE_ALREADY_IN_LIST            : m_warnMessage << "Warning : file \'"                                               << token << "\' already in use."      << std::endl; break;
    case CLiTool::AWARN_CSL_INCLUDE_DIR_ALREADY_IN_LIST : m_warnMessage << "Warning : CSL include directory \'"                              << token << "\' already in use."      << std::endl; break;
    case CLiTool::AWARN_VER_LIBRARY_DIR_ALREADY_IN_LIST : m_warnMessage << "Warning : Verilog library directory \'"                          << token << "\' already in use."      << std::endl; break;
    case CLiTool::AWARN_VER_LIBRARY_FILE_ALREADY_IN_LIST: m_warnMessage << "Warning : Verilog library file \'"                               << token << "\' already in use."      << std::endl; break;
    case CLiTool::AWARN_INCOMPLETE_EXTENSION            : m_warnMessage << "Warning : Extension \'"                                          << token << "\' incomplete."          << std::endl; break;
    case CLiTool::AWARN_EMPTY_NAME                      : m_warnMessage << "Warning : For argument \'"                                       << token << "\' received empty name." << std::endl; break;
    case CLiTool::AWARN_NO_PP_FILENAME                  : m_warnMessage << "Warning : Only preprocessor runs, but no output file specified."                                       << std::endl; break;

    default:
      ASSERT(FAIL, INTERNAL_ERROR_UNKNOWN);
      break;
  }
}

void CLiError::buildError(CLiTool::ECLiError err) {
  switch(err) {
    case CLiTool::APARSE_NO_SOURCE_FILE_SPECIFIED: m_errMessage << "No source file specified."; break;

    default:
      ASSERT(FAIL, INTERNAL_ERROR_UNKNOWN);
      break;
  }
}

void CLiError::buildError(CLiTool::ECLiError err,
                          const std::string& token) {

  switch(err) {
    case CLiTool::APARSE_INVALID_ARGUMENT   : m_errMessage << "Invalid argument \'"    << token << "\'."                             << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage." ; break;
    case CLiTool::APARSE_TOO_FEW_ARGUMENTS  : m_errMessage << "For argument \'"        << token << "\' invalid number of parameters" << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage." ; break;
    case CLiTool::APARSE_EXPECTED_FILE      : m_errMessage << "Argument \'"            << token << "\' is a directory."                                                                         ; break;
    case CLiTool::APARSE_FILE_NOT_EXISTS    : m_errMessage << "File \'"                << token << "\' does not exist."                                                                         ; break;
    case CLiTool::APARSE_DIR_NOT_EXISTS     : m_errMessage << "Directory \'"           << token << "\' does not exist."                                                                         ; break;
    case CLiTool::APARSE_DUPLICATE_ARGUMENT : m_errMessage << "Duplicate argument \'"  << token << "\'."                                                                                        ; break;
    case CLiTool::APARSE_DUPLICATE_CLI_FILE : m_errMessage << "Duplicate CLI file \'"  << token << "\'."                                                                                        ; break;
    case CLiTool::APARSE_COULD_NOT_OPEN_FILE: m_errMessage << "Could not open file \'" << token << "\'."                                                                                        ; break;
    case CLiTool::APARSE_FAIL               : m_errMessage                             << token                                                                                                 ; break;
    case CLiTool::APARSE_ACCESS_DENIED      : m_errMessage << "\'"                     << token << "\' permission denied."                                                                      ; break;

    default:
      ASSERT(FAIL, INTERNAL_ERROR_UNKNOWN);
      break;
  }
}

void CLiError::buildError(CLiTool::ECLiError err,
                          const std::string& token1,
                          const std::string& token2) {

  switch(err) {
    case CLiTool::APARSE_INVALID_ARGUMENT       : m_errMessage << "For argument \'" << token1 << "\' invalid parameter \'" << token2 << "\'."                         << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage."; break;
    case CLiTool::APARSE_NOT_NUMERIC            : m_errMessage << "For argument \'" << token1 << "\' parameter \'"         << token2 << "\' is not numeric."          << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage."; break;
    case CLiTool::APARSE_EXPECTED_FILE          : m_errMessage << "For argument \'" << token1 << "\' parameter \'"         << token2 << "\' is not a filename."       << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage."; break;
    case CLiTool::APARSE_EXPECTED_FILE_EXTENSION: m_errMessage << "For argument \'" << token1 << "\' file \'"              << token2 << "\' has the wrong extension." << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage."; break;
    case CLiTool::APARSE_EXPECTED_DIR           : m_errMessage << "For argument \'" << token1 << "\' parameter \'"         << token2 << "\' is not a directory."      << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage."; break;
    case CLiTool::APARSE_FILE_NOT_EXISTS        : m_errMessage << "For argument \'" << token1 << "\' file \'"              << token2 << "\' does not exist."                                                                    ; break;

    default:
      ASSERT(FAIL, INTERNAL_ERROR_UNKNOWN);
      break;
  }
}

void CLiError::buildError(CLiTool::ECLiError err,
                          const std::string& token1,
                          const TInt token2) {
  switch(err) {
    case CLiTool::APARSE_NUMBER_TOO_SMALL       : m_errMessage << "For argument \'" << token1 << "\' number \'" << intToString(token2) << "\' too small."               << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage."; break;
    case CLiTool::APARSE_NUMBER_TOO_BIG         : m_errMessage << "For argument \'" << token1 << "\' number \'" << intToString(token2) << "\' too big."                 << std::endl << "Type \'cslc " << CLiTool::Instance()->HELP_ << "\' for usage."; break;

    default:
      ASSERT(FAIL, INTERNAL_ERROR_UNKNOWN);
      break;
  }
}

} //NSCLi
