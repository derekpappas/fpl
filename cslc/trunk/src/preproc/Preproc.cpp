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

#include "Preproc.h"

namespace NSPreproc {

  namespace NSPPDebug {

  //TODO: remove it after the Verilog parser gets fixed
  int __flow;

  std::string printBinary(TInt flag) {
    std::stringstream ss;

    for (int i = 6;
         i >= 0;
         --i) {

      ss << ((flag >> i) & 1);
    }

    return ss.str();
  }

  std::string printFile(std::fstream* file) {
    std::stringstream ss;

    std::string line;
    while (getline(*file, line)) {
      ss << line << std::endl;
    }

    return ss.str();
  }

  } //NSPPDebug

// **********************************************
// PpFile class
// **********************************************
PpFile::PpFile(TChar directiveStart,
               const RefString& fileName,
               std::fstream *const fileStream,
               const RefPpFile& includedFrom)

  : m_directiveStart(directiveStart),
    m_fileName(fileName),
    m_fileStream(fileStream),
    m_includedFrom(includedFrom),
    m_includeDepth(includedFrom.get()
                   ? includedFrom->incrementIncludeDepth()
                   : ZERO),
    m_lineNumber(ZERO),
    m_parserFlags(PF_LINE_START),
    m_ignoredLines(ZERO),
    m_emptyLines(ZERO) {}

PpFile::~PpFile() {
  delete m_fileStream;
}

RefPpFile PpFile::build(EPpFlow ppFlow,
                        const RefString& fileName,
                        std::fstream *const fileStream) {

  //TODO: see @ begin
  NSPPDebug::__flow = ppFlow;

  TChar directiveStart = (ppFlow == PP_FLOW_CSL
                          ? CHAR_GRAVE_ACCENT
                          : CHAR_GRAVE_ACCENT);
  RefPpFile ppFile(new PpFile(directiveStart, fileName, fileStream));

  ppFile->m_selfRef = WeakRefPpFile(ppFile);

  return ppFile;
}

RefPpFile PpFile::build(const RefString& fileName,
                        std::fstream *const fileStream,
                        const RefPpFile& includedFrom) {

  TChar directiveStart = includedFrom->getDirectiveStart();
  RefPpFile ppFile(new PpFile(directiveStart, fileName, fileStream, includedFrom));

  ppFile->m_selfRef = WeakRefPpFile(ppFile);

  return ppFile;
}

void PpFile::checkString() {
  if (!IS_FLAG_SET(PF_IGNORE_READ | PF_IGNORE_LINE)
      && (m_previousChar == CHAR_DQUOTE)) {

    SWITCH_FLAG(PF_STR_READ);
  }
}

void PpFile::checkWS() {
  if (!IS_FLAG_SET(PF_IGNORE_READ | PF_IGNORE_LINE | PF_STR_READ)
      && (m_previousChar == CHAR_SPACE
          || m_previousChar == CHAR_TAB)) {

    WRITE(m_wsBuffer, m_previousChar);
    SET_FLAG_ON(PF_WS_READ);
  }
  else {
    SET_FLAG_OFF(PF_WS_READ);
  }
}

void PpFile::checkComment() {
  if (!IS_FLAG_SET(PF_IGNORE_READ | PF_IGNORE_LINE | PF_WS_READ | PF_STR_READ)
      && m_previousChar == CHAR_COMMENT_START) {

    if (m_currentChar == CHAR_COMMENT_REGION) {
      WRITE(m_wsBuffer, CHAR_SPACE);

      SET_FLAG_ON(PF_IGNORE_READ);
      m_fileStream->get(m_previousChar);
      if (m_fileStream->eof()) {
        m_previousChar = CHAR_EMPTY;
        m_currentChar = CHAR_EMPTY;
        SET_FLAG_ON(PF_EOF_REACHED);
        return;
      }

      m_fileStream->get(m_currentChar);
      if (m_fileStream->eof()) {
        m_currentChar = m_previousChar;
        SET_FLAG_ON(PF_EOF_REACHED);
        return;
      }

      m_ignoredLines = ZERO;
    }
    else if (m_currentChar == CHAR_COMMENT_LINE) {
      SET_FLAG_ON(PF_IGNORE_LINE);
    }
  }
  else if (IS_FLAG_SET(PF_IGNORE_READ)) {
    if (m_previousChar == CHAR_COMMENT_REGION
        && m_currentChar == CHAR_COMMENT_START) {

      SET_FLAG_OFF(PF_IGNORE_READ);
      m_fileStream->get(m_previousChar);
      if (m_fileStream->eof()) {
        m_previousChar = CHAR_EMPTY;
        m_currentChar = CHAR_EMPTY;
        SET_FLAG_ON(PF_EOF_REACHED);
        return;
      }

      m_fileStream->get(m_currentChar);
      if (m_fileStream->eof()) {
        m_currentChar = m_previousChar;
        SET_FLAG_ON(PF_EOF_REACHED);
        return;
      }

      m_emptyLines += m_ignoredLines;
      WRITE(m_wsBuffer, CHAR_SPACE);
    }

    if (m_previousChar != CHAR_NEW_LINE) {
      WRITE(m_wsBuffer, (m_previousChar == CHAR_TAB
                         ? CHAR_TAB
                         : CHAR_SPACE));
    }
    else if (!IS_FLAG_SET(PF_LINE_START)) {
      SET_FLAG_ON(PF_LINE_START);
    }
    else {
      ++m_ignoredLines;
    }
  }
}

void PpFile::checkDirective() {
  if (!IS_FLAG_SET(PF_IGNORE_READ | PF_IGNORE_LINE | PF_WS_READ | PF_STR_READ | PF_EOF_REACHED)
      && IS_FLAG_SET(PF_LINE_START)
      && m_previousChar == m_directiveStart) {

    m_previousChar = m_currentChar;
    m_fileStream->get(m_currentChar);

    ignoreWS();
    readToken(m_directiveToken);
    TDirectiveHandler handler = validateDirective();
    (m_selfRef.lock().get()->*handler)();
  }
}

void PpFile::writeChar() {
  if (!IS_FLAG_SET(PF_IGNORE_LINE | PF_IGNORE_READ | PF_WS_READ | PF_EOF_REACHED)
      && m_previousChar != CHAR_NEW_LINE) {

    WRITE(m_lineContent, m_wsBuffer.str() <<  m_previousChar);
    m_wsBuffer.str(EMPTY_STRING);
    SET_FLAG_OFF(PF_LINE_START);
  }
}

void PpFile::writeEmptyLines() {
  if (m_emptyLines > ZERO) {
    m_lineNumber += m_emptyLines;

    if (m_emptyLines < MAX_IGNORED_LINES) {
      WRITE_N(*m_outputFileStream, CHAR_NEW_LINE, m_emptyLines);
    }
    else {
      WRITE_FILE_NAME(*m_outputFileStream, *m_fileName, m_lineNumber);
    }

    m_emptyLines = ZERO;
  }

  WRITE(*m_outputFileStream, m_lineContent.str() << CHAR_NEW_LINE);
  m_lineContent.str(EMPTY_STRING);
  m_wsBuffer.str(EMPTY_STRING);
  SET_FLAG_ON(PF_LINE_START);
  SET_FLAG_OFF(PF_IGNORE_LINE);
}

void PpFile::writeLine() {
  if (m_previousChar == CHAR_NEW_LINE
      && !IS_FLAG_SET(PF_IGNORE_READ)) {

    if (!m_lineContent.str().empty()) {
      writeEmptyLines();
      ++m_lineNumber;
    }
    else if (!IS_FLAG_SET(PF_EOF_REACHED)) {
      ++m_emptyLines;

      m_wsBuffer.str(EMPTY_STRING);
      SET_FLAG_OFF(PF_IGNORE_LINE);
      SET_FLAG_ON(PF_LINE_START);
    }
  }
}

void PpFile::ignoreWS() {
  SET_FLAG_OFF(PF_KEEP_LINE);
  while (!m_fileStream->eof()) {
    if (m_previousChar == CHAR_KEEP_LINE) {
      SET_FLAG_ON(PF_KEEP_LINE);
    }
    else if (m_previousChar == CHAR_NEW_LINE
             && IS_FLAG_SET(PF_KEEP_LINE)) {

      ++m_emptyLines;
    }
    else if (m_previousChar != CHAR_SPACE
             && m_previousChar != CHAR_TAB) {

      return;
    }

    m_previousChar = m_currentChar;
    m_fileStream->get(m_currentChar);
  }
}

void PpFile::consumeRead() {
  SET_FLAG_OFF(PF_KEEP_LINE);
  while (!m_fileStream->eof()) {
    if (m_previousChar == CHAR_KEEP_LINE) {
      SET_FLAG_ON(PF_KEEP_LINE);
    }
    else if (m_previousChar != CHAR_NEW_LINE) {
      if (m_previousChar != CHAR_SPACE
          && m_previousChar != CHAR_TAB) {

        SET_FLAG_OFF(PF_KEEP_LINE);
      }
    }
    else if (IS_FLAG_SET(PF_KEEP_LINE)) {
      ++m_emptyLines;
    }
    else {
      return;
    }

    m_previousChar = m_currentChar;
    m_fileStream->get(m_currentChar);
  }
}

void PpFile::consumeCommentWS() {
  if (m_previousChar == CHAR_COMMENT_START
      && m_currentChar == CHAR_COMMENT_REGION) {

    SET_FLAG_ON(PF_IGNORE_READ);
  }
  else if (m_previousChar == CHAR_SPACE
           || m_previousChar == CHAR_TAB) {

    SET_FLAG_ON(PF_WS_READ);
  }
}

void PpFile::readWord(std::stringstream& wordBuffer) {
  wordBuffer.str(EMPTY_STRING);

  while (!m_fileStream->eof()
         && IS_ID_CHAR(m_previousChar)) {

    WRITE(wordBuffer, m_previousChar);
    m_previousChar = m_currentChar;
    m_fileStream->get(m_currentChar);
  }
}

void PpFile::readToken(std::stringstream& tokenBuffer) {
  tokenBuffer.str(EMPTY_STRING);

  while (!m_fileStream->eof()
         && m_previousChar != CHAR_SPACE
         && m_previousChar != CHAR_TAB
         && m_previousChar != CHAR_NEW_LINE
         && m_previousChar != CHAR_KEEP_LINE
         && (m_previousChar != CHAR_COMMENT_START
             && (m_currentChar != CHAR_COMMENT_LINE
                 || m_currentChar != CHAR_COMMENT_REGION))) {

    WRITE(tokenBuffer, m_previousChar);
    m_previousChar = m_currentChar;
    m_fileStream->get(m_currentChar);
  }
}

void PpFile::readString(std::stringstream& stringBuffer,
                        const TChar chBegin,
                        const TChar chEnd) {

  if (m_previousChar == chBegin) {
    m_previousChar = m_currentChar;
    m_fileStream->get(m_currentChar);
  }
  else {
    return;
  }

  stringBuffer.str(EMPTY_STRING);
  while (!m_fileStream->eof()) {
    if (m_previousChar == CHAR_NEW_LINE) {
      stringBuffer.str(EMPTY_STRING);
      return;
    }
    else if (m_previousChar == chEnd) {
      m_previousChar = m_currentChar;
      m_fileStream->get(m_currentChar);
      return;
    }

    WRITE(stringBuffer, m_previousChar);
    m_previousChar = m_currentChar;
    m_fileStream->get(m_currentChar);
  }

  stringBuffer.str(EMPTY_STRING);
}

TDirectiveHandler PpFile::validateDirective() {
  ignoreWS();
  if (m_directiveToken.str().empty()) {
    return &PpFile::execEmptyDirective;
  }
  else if (m_directiveToken.str() == _INCLUDE) {
    return &PpFile::execIncludeDirective;
  }
  else {
    return &PpFile::execInvalidDirective;
  }
}

void PpFile::execEmptyDirective() {
  return;
}

void PpFile::execIncludeDirective() {
  std::stringstream includeFile;
  readString(includeFile, CHAR_DQUOTE, CHAR_DQUOTE);

  if (includeFile.str().empty()) {
    //TODO: ERROR - include files most be delimited by " "
    backTraceInclude(m_emptyLines);

    DCERR("ERROR - include files most be delimited by \" \"");
    consumeRead();
  }
  else {
    ignoreWS();

    if (m_previousChar != CHAR_NEW_LINE) {
      //TODO: WARNING - extra tokens at end of 'include' directive
      backTraceInclude(m_emptyLines);

      DCERR("WARNING - extra tokens at end of \'" << _INCLUDE << "\' directive");
      consumeRead();
    }

    std::fstream* incFile;
    std::string includeFileFullPath = EMPTY_STRING;
    searchIncludeFile(includeFile, incFile, includeFileFullPath);

    if (incFile == static_cast<std::fstream*>(NULL)) {
      //TODO: ERROR - could not open file
      backTraceInclude(m_emptyLines);

      DCERR("ERROR - could not open file \'" << includeFile.str() << "\'.");
    }
    else if (m_includeDepth < MAX_INCLUDE_DEPTH) {
      writeEmptyLines();
      RefPpFile ifile = PpFile::build(RefString(new std::string(includeFileFullPath)), incFile, m_selfRef.lock());
      ifile->parsePpFile(m_outputFileStream);
      WRITE_FILE_NAME(*m_outputFileStream, *m_fileName, m_lineNumber);
    }
    else {
      //TODO: ERROR - #include nested too deeply
      backTraceInclude(m_emptyLines);

      DCERR("ERROR - \'" << _INCLUDE << "\' nested too deeply.");
      delete incFile;
    }
  }
}

void PpFile::execInvalidDirective() {
  //TODO: ERROR - unknown directive
  backTraceInclude(m_emptyLines);

  DCERR("ERROR - unknown directive '" << m_directiveToken.str() << "'");
  consumeRead();
}

void PpFile::searchIncludeFile(const std::stringstream& includeFile,
                               std::fstream*& incFile,
                               std::string& includeFileFullPath) {

  incFile = new std::fstream;
  includeFileFullPath = includeFile.str();

  if (NSCLi::CLiCommon::Instance()->isAbsolutePath(includeFileFullPath)) {
    NSCLi::CLiTool::ECLiFileStat fstat = NSCLi::CLiCommon::Instance()->openFile(includeFileFullPath, *incFile, std::ios::in | std::ios::binary);
    if (fstat != NSCLi::CLiTool::Instance()->FS_SUCCESS) {
      delete incFile;
      incFile = static_cast<std::fstream*>(NULL);
    }

    return;
  }
  else {
    RefString  rsBaseDir = NSCLi::CLiCommon::Instance()->getRelativePath(*m_fileName);
    std::string baseDir = *rsBaseDir;
    includeFileFullPath.insert(NSCLi::CLiTool::Instance()->START_POSITION, baseDir);

    NSCLi::CLiTool::ECLiFileStat fstat = NSCLi::CLiCommon::Instance()->openFile(includeFileFullPath, *incFile, std::ios::in | std::ios::binary);
    if (fstat != NSCLi::CLiTool::Instance()->FS_SUCCESS) {
      //TODO: search include paths
      delete incFile; 
      incFile = static_cast<std::fstream*>(NULL);
    }

    return;
  }
}

void PpFile::backTraceInclude(TUInt lineOffset) {
  RefPpFile incFile = m_includedFrom.lock();
  if (incFile.get()) {
    DCERR("In file \'" << *m_fileName << "\':" << m_lineNumber + lineOffset << " included");

    while (incFile.get()) {
      DCERR("\t\tfrom \'" << *incFile->m_fileName << "\':" << incFile->m_lineNumber - 1 << ",");
      incFile = incFile->m_includedFrom.lock();
    }
  }
  else {
    DCERR("In file \'" << *m_fileName << "\':" << m_lineNumber + lineOffset);
  }
}

TUInt PpFile::incrementIncludeDepth() {
  return m_includeDepth + 1;
}

void PpFile::parsePpFile(std::fstream* outputFileStream) {

  ASSERT(m_fileName.get(), INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(m_fileStream->is_open(), INTERNAL_ERROR_CLOSED_FILE_STREAM);
  ASSERT(outputFileStream, INTERNAL_ERROR_NULL_REFERENCE);
  ASSERT(outputFileStream->is_open(), INTERNAL_ERROR_CLOSED_FILE_STREAM);

  m_outputFileStream = outputFileStream;
  WRITE_FILE_NAME(*m_outputFileStream, *m_fileName, ++m_lineNumber);

  m_fileStream->get(m_previousChar);
  while (!m_fileStream->eof()) {
    m_fileStream->get(m_currentChar);

//     DCERR("'" << m_previousChar << "'");

    checkString();
    checkWS();
    checkComment();
    checkDirective();

    writeChar();
    writeLine();

//     DCERR("\tprev=\'" << m_previousChar << "\'"
//           << "\tcurr=\'" << m_currentChar << "\'"
//           << "\te_lines=" << m_emptyLines
//           << "\ti_lines=" << m_ignoredLines
//           << "\tline_n=" << m_lineNumber
//           << "\tflags=" << printBinary(m_parserFlags)
//           << "\tws=\'" << m_wsBuffer.str() << "\'"
//           << "\tline=\'" << m_lineContent.str() << "\'");
    m_previousChar = m_currentChar;
  }

//   DCERR("\tprev=\'" << m_previousChar << "\'"
//         << "\tcurr=\'" << m_currentChar << "\'"
//         << "\te_lines=" << m_emptyLines
//         << "\ti_lines=" << m_ignoredLines
//         << "\tline_n=" << m_lineNumber
//         << "\tflags=" << printBinary(m_parserFlags)
//         << "\tws=\'" << m_wsBuffer.str() << "\'"
//         << "\tline=\'" << m_lineContent.str() << "\'");

  if (IS_FLAG_SET(PF_IGNORE_READ)) { 
    if (!m_lineContent.str().empty()) {
      writeEmptyLines();
    }
    else {
      ++m_lineNumber;
    }

    //TODO: add an error
    backTraceInclude();

    DCERR("ERROR - comment reached end of file ");
  }
  else if (m_previousChar != CHAR_NEW_LINE) {
    m_previousChar = CHAR_NEW_LINE;
    writeLine();
    //TODO: add a warning that the file does not contain '\n' at end
    backTraceInclude(m_emptyLines);

    DCERR("WARNING - no new line at end of file.");
//     DCERR(m_lineContent.str());
  }
}

TChar PpFile::getDirectiveStart() const {
  return m_directiveStart;
}

RefPpFile PpFile::getIncludedFrom() const {
  return m_includedFrom.lock();
}

// **********************************************
// CSLcPreprocessor class
// **********************************************
CSLcPreprocessor::CSLcPreprocessor(std::fstream* outputFileStream,
                                   const RefTVec_RefPpFile& sourceFiles)

  : m_outputFileStream(outputFileStream),
    m_sourceFiles(sourceFiles) {}

CSLcPreprocessor::~CSLcPreprocessor() {
}

void CSLcPreprocessor::runPreprocessor() {
  ASSERT(m_sourceFiles.get(), INTERNAL_ERROR_NULL_REFERENCE);

  for (TVec_RefPpFile_const_iter ppFile = m_sourceFiles->begin();
       ppFile != m_sourceFiles->end();
       ++ppFile) {

    (*ppFile)->parsePpFile(m_outputFileStream);
  }

  m_outputFileStream->flush();
}

} //NSPreproc
