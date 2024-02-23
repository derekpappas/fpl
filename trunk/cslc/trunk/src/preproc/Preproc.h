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

#ifndef INC_GUARD_Preproc_h_
#define INC_GUARD_Preproc_h_

#include "Preproc_Typedef.h"

namespace NSPreproc {

// **********************************************
// PpFile class
// **********************************************
class PpFile {
  private:
    WeakRefPpFile                               m_selfRef;
    TChar                                       m_directiveStart;

    RefString                                   m_fileName;
    std::fstream *const                         m_fileStream;
    WeakRefPpFile                               m_includedFrom;
    TUInt                                       m_includeDepth;
    TUInt                                       m_lineNumber;
    TInt                                        m_parserFlags;
    TInt                                        m_ignoredLines;
    TInt                                        m_emptyLines;
    std::fstream*                               m_outputFileStream;
    std::fstream::traits_type::char_type        m_currentChar;
    std::fstream::traits_type::char_type        m_previousChar;
    std::stringstream                           m_wsBuffer;
    std::stringstream                           m_lineContent;
    std::stringstream                           m_directiveToken;
    std::stringstream                           m_wordBuffer;

  public:
    static RefPpFile build(EPpFlow ppFlow,
                           const RefString& fileName,
                           std::fstream *const fileStream);
    static RefPpFile build(const RefString& fileName,
                           std::fstream *const fileStream,
                           const RefPpFile& includedFrom);

    ~PpFile();

    void parsePpFile(std::fstream* outputFileStream);

    TChar getDirectiveStart() const;
    RefPpFile getIncludedFrom() const;

    TUInt incrementIncludeDepth();

  private:
    PpFile(TChar directiveStart,
           const RefString& fileName,
           std::fstream *const fileStream,
           const RefPpFile& includedFrom = RefPpFile(static_cast<PpFile*>(NULL)));

    void checkString();
    void checkComment();
    void checkWS();
    void checkDirective();

    void writeChar();
    void writeEmptyLines();
    void writeLine();
    void ignoreWS();
    void consumeRead();
    void consumeCommentWS();
    void readWord(std::stringstream& wordBuffer);
    void readToken(std::stringstream& tokenBuffer);
    void readString(std::stringstream& stringBuffer,
                    const TChar chBegin,
                    const TChar chEnd);
    TDirectiveHandler validateDirective();

    void execEmptyDirective();
    void execIncludeDirective();
    void execInvalidDirective();

    void searchIncludeFile(const std::stringstream& includeFile,
                           std::fstream*& incFile,
                           std::string& includeFileFullPath);
    void backTraceInclude(TUInt lineOffset = ZERO);
};

// **********************************************
// CSLcPreprocessor class
// **********************************************
class CSLcPreprocessor {
  private:
    std::fstream*                               m_outputFileStream;
    RefTVec_RefPpFile                           m_sourceFiles;

  public:
    CSLcPreprocessor(std::fstream* outputFileStream,
                     const RefTVec_RefPpFile& sourceFiles);
    ~CSLcPreprocessor();

    void runPreprocessor();
};

} //NSPreproc

#endif //INC_GUARD_Preproc_h_
