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

#include "CSLcPP.h"

namespace NSCSLcPP {

// *********************************************************************
// CSLcPp class
// *********************************************************************
CSLcPp::CSLcPp(EPpFlow ppFlow,
               TFileStream outputFStream,
               const RefTVec_RefString& includeDirectories,
               const RefTVec_RefString& macroDefinitions) {

  ASSERT(outputFStream, INTERNAL_ERROR_NULL_REFERENCE);

  TChar directiveSymbol = (ppFlow == PPFL_CSL
                           ? CHAR_BACKQUOTE
                           : CHAR_BACKQUOTE);
  CSLcPpCommon::build(outputFStream,directiveSymbol, includeDirectories, macroDefinitions);
}

CSLcPp::~CSLcPp() {
}

void CSLcPp::runCSLcPp(const RefTVec_RefCSLcPpFile& sourceFiles) {
  ASSERT(sourceFiles.get(), INTERNAL_ERROR_NULL_REFERENCE);

  for (TVec_RefCSLcPpFile_const_iter ppFile = sourceFiles->begin();
       ppFile < sourceFiles->end();
       ++ppFile) {

    (*ppFile)->processFile();
  }
}

// *********************************************************************
// CSLcPpFile class
// *********************************************************************
CSLcPpFile::CSLcPpFile(TFileStream fileStream,
                       const RefString& fileName,
                       const RefCSLcPpFile& includedFrom)

  : m_fileStream(fileStream),
    m_fileName(fileName),
    m_includedFrom(includedFrom),
    m_lineNumber(ZERO),
    m_emptyLinesBefore(ZERO),
    m_emptyLinesAfter(ZERO),
    m_charRead(CHAR_EMPTY),
    m_ppFlag(PP_FLAG_NONE) {}

CSLcPpFile::~CSLcPpFile() {
  delete m_fileStream;
}

RefCSLcPpFile CSLcPpFile::build(TFileStream fileStream,
                                const RefString& fileName,
                                const RefCSLcPpFile& includedFrom) {

  ASSERT(fileStream, INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(fileStream->is_open(), INTERNAL_ERROR_CLOSED_FILE_STREAM);
  ASSERT(fileName.get(), INTERNAL_ERROR_NULL_REFERENCE);

  RefCSLcPpFile file(new CSLcPpFile(fileStream, fileName, includedFrom));

  file->m_selfRef = WeakCSLcPpFile(file);

  return file;
}

void CSLcPpFile::processFile() {
  m_cslcPpCommon = CSLcPpCommon::getCSLcPpCommonInstance();
  m_directiveSymbol = m_cslcPpCommon->getDirectiveSymol();
  m_outputFStream = m_cslcPpCommon->getOutputFStream();

  writeLN(m_testOutput, ++m_lineNumber);

  m_fileStream->get(m_charRead);
  while (!m_fileStream->eof()) {
    if (isWhiteSpace(m_charRead)) {
      whiteSpaceReader();
    }
    else if (isIdentifierStart(m_charRead)) {
      identifierReader();
    }
    else if (isLineConcat(m_charRead)) {
      lineConcatReader();
    }
    else if (isLineFeed(m_charRead)) {
      lineFeedReader();
    }
    else if (isStringLiteral(m_charRead)) {
      stringLiteralReader();
    }
    else if (isDirectiveSymbol(m_charRead)) {
      directiveReader();
    }
    else {
      defaultReader();
    }
  }

  DCERR("---------------------------\n" << m_testOutput.str() << "---------------------------");
}

void CSLcPpFile::whiteSpaceReader() {
  write(m_whiteSpaceBuffer, m_charRead);

  while (!m_fileStream->eof()
         && isWhiteSpace(m_charRead)) {

    write(m_whiteSpaceBuffer, m_charRead);
  }

  DCERR("white space:\t\'" << m_whiteSpaceBuffer.str() << "\'");
}

void CSLcPpFile::identifierReader() {
  write(m_identifierBuffer, m_charRead);

  while (!m_fileStream->eof()
         && isIdentifierChar(m_charRead)) {

    write(m_identifierBuffer, m_charRead);
  }

  DCERR("identifier:\t\'" << m_identifierBuffer.str() << "\'");
  write(m_lineBuffer, m_whiteSpaceBuffer);
  write(m_lineBuffer, m_identifierBuffer);
}

void CSLcPpFile::lineConcatReader() {
  TStringStream ss;

  m_fileStream->get(m_charRead);
  while (!m_fileStream->eof()
         && isWhiteSpace(m_charRead)) {

    write(ss, m_charRead);
  }

  if (isLineFeed(m_charRead)) {
    ++m_emptyLinesAfter;
    m_fileStream->get(m_charRead);
  }
  else {
    write(m_lineBuffer, m_whiteSpaceBuffer);
    write(m_whiteSpaceBuffer, ss);
    m_lineBuffer << CHAR_BACKSLASH;
  }
}

void CSLcPpFile::lineFeedReader() {
  writeLineBuffer();

  m_fileStream->get(m_charRead);
}

void CSLcPpFile::stringLiteralReader() {
  write(m_stringLiteralBuffer, m_charRead);

  while (!m_fileStream->eof()
         && !isLineFeed(m_charRead)) {

    if (isStringLiteral(m_charRead)) {
      write(m_stringLiteralBuffer, m_charRead);

      DCERR("string literal:\t\'" << m_stringLiteralBuffer.str() << "\'");
      write(m_lineBuffer, m_whiteSpaceBuffer);
      write(m_lineBuffer, m_stringLiteralBuffer);
      return;
    }

    write(m_stringLiteralBuffer, m_charRead);
  }

  DCERR("string literal:\t\'" << m_stringLiteralBuffer.str() << "\'");
  write(m_lineBuffer, m_whiteSpaceBuffer);
  write(m_lineBuffer, m_stringLiteralBuffer);
}

void CSLcPpFile::directiveReader() {
  DCERR("\'" << m_charRead << "\'");
  m_fileStream->get(m_charRead);
}

void CSLcPpFile::lineCommentReader() {
  while (!m_fileStream->eof()
         && !isLineFeed(m_charRead)) {

    m_fileStream->get(m_charRead);
  }
}

void CSLcPpFile::blockCommentReader() {
  m_whiteSpaceBuffer << CHAR_SPACE << CHAR_SPACE;

  TFileStreamChar nextRead;
  m_fileStream->get(m_charRead);
  m_fileStream->get(nextRead);

  while (!m_fileStream->eof()) {
    if (isStar(m_charRead)
        && isSlash(nextRead)) {

      m_whiteSpaceBuffer << CHAR_SPACE << CHAR_SPACE;
      m_fileStream->get(m_charRead);
      return;
    }
    else if (isLineFeed(nextRead)) {
      writeLineBuffer();
    }

    m_whiteSpaceBuffer << (m_charRead == CHAR_TAB
                           ? CHAR_TAB
                           : CHAR_SPACE);
    m_charRead = nextRead;
    m_fileStream->get(nextRead);
  }
}

void CSLcPpFile::defaultReader() {
  if (isSlash(m_charRead)) {
    TFileStreamChar nextRead;
    m_fileStream->get(nextRead);
    if (!m_fileStream->eof()) {
      if (isSlash(nextRead)) {
        lineCommentReader();
        return;
      }
      else if (isStar(nextRead)) {
        blockCommentReader();
        return;
      }

      m_charRead = nextRead;
      m_identifierBuffer << CHAR_SLASH;
    }
    else {
      return;
    }
  }
  else {
    write(m_identifierBuffer, m_charRead);
  }

  while (!m_fileStream->eof()
         && isDefaultChar(m_charRead)) {

    write(m_identifierBuffer, m_charRead);
  }

  DCERR("default:\t\t\'" << m_identifierBuffer.str() << "\'");
  write(m_lineBuffer, m_whiteSpaceBuffer);
  write(m_lineBuffer, m_identifierBuffer);
}

void CSLcPpFile::writeLineBuffer() {
  if (m_lineBuffer.str().empty()) {
    ++m_emptyLinesBefore;
  }
  else if (m_emptyLinesBefore > __MAX_IGNORED_LINES) {
    m_lineNumber += m_emptyLinesBefore;
    writeLN(m_testOutput, m_lineNumber);
    write(m_testOutput, m_lineBuffer);
    m_testOutput << CHAR_NEW_LINE;

    m_emptyLinesBefore = m_emptyLinesAfter;
    m_emptyLinesAfter = ZERO;
    ++m_lineNumber;
  }
  else {
    m_lineNumber += m_emptyLinesBefore;
    writeN(m_testOutput, CHAR_NEW_LINE, m_emptyLinesBefore);
    write(m_testOutput, m_lineBuffer);
    m_testOutput << CHAR_NEW_LINE;

    m_emptyLinesBefore = m_emptyLinesAfter;
    m_emptyLinesAfter = ZERO;
    ++m_lineNumber;
  }
}

// *********************************************************************
// CSLcPpCommon class
// *********************************************************************
RefCSLcPpCommon CSLcPpCommon::m_instance(static_cast<CSLcPpCommon*>(NULL));

CSLcPpCommon::CSLcPpCommon(TFileStream outputFStream,
                           TChar directiveSymbol,
                           TUInt includeDepth)

  : m_outputFStream(outputFStream),
    m_includeDepth(includeDepth),
    m_directiveSymbol(directiveSymbol),
    m_defaultIncludeDirectories(static_cast<TVec_TPath*>(NULL)) {}

CSLcPpCommon::~CSLcPpCommon() {
}

void CSLcPpCommon::build(TFileStream outputFStream,
                         TChar directiveSymbol,
                         const RefTVec_RefString& includeDirectories,
                         const RefTVec_RefString& macroDefinitions,
                         TUInt includeDepth) {

  ASSERT(!m_instance.get(), INTERNAL_ERROR_NULL_REFERENCE);

  m_instance = RefCSLcPpCommon(new CSLcPpCommon(outputFStream, directiveSymbol, includeDepth));

  if (includeDirectories.get()) {
    m_instance->m_defaultIncludeDirectories = RefTVec_TPath(new TVec_TPath());
    for (TVec_RefString_const_iter includePath = includeDirectories->begin();
         includePath < includeDirectories->end();
         ++includePath) {

      TPath fsPath(**includePath, boost::filesystem::native);
      m_instance->m_defaultIncludeDirectories->push_back(fsPath);
      DCERR("default search path \'" << fsPath.string() << "\' added");
    }
  }

  if (macroDefinitions.get()) {
    for (TVec_RefString_const_iter macro = macroDefinitions->begin();
         macro < macroDefinitions->end();
         ++macro) {

      DCERR("defined \'" << **macro << "\'");
    }
  }
}

RefCSLcPpCommon CSLcPpCommon::getCSLcPpCommonInstance() {
  ASSERT(m_instance.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return m_instance;
}

// *********************************************************************
// SLessRefString struct
// *********************************************************************
TBool SLessRefString::operator() (const RefString& s1,
                                  const RefString& s2) const {

  ASSERT(s1.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(s2.get(), INTERNAL_ERROR_NULL_REFERENCE);

  return s1->compare(*s2) < ZERO;
}

} //NSCSLcPP namespace
