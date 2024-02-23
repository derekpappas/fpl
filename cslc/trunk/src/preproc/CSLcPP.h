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

#ifndef INC_GUARD_CSLcPP_h_
#define INC_GUARD_CSLcPP_h_

#include "CSLcPP_Typedef.h"

namespace NSCSLcPP {

// *********************************************************************
// CSLcPp class
// *********************************************************************
class CSLcPp {
  public:
    CSLcPp(EPpFlow ppFlow,
           TFileStream outputFStream,
           const RefTVec_RefString& includeDirectories,
           const RefTVec_RefString& macroDefinitions);
    ~CSLcPp();

    void runCSLcPp(const RefTVec_RefCSLcPpFile& sourceFiles);
};

// *********************************************************************
// CSLcPpFile class
// *********************************************************************
class CSLcPpFile {
  private:
    WeakCSLcPpFile                      m_selfRef;

    TFileStream                         m_fileStream;
    RefString                           m_fileName;
    RefCSLcPpFile                       m_includedFrom;
    TUInt                               m_lineNumber;
    TUInt                               m_emptyLinesBefore;
    TUInt                               m_emptyLinesAfter;
    TFileStreamChar                     m_charRead;
    TPpFlag                             m_ppFlag;

    TStringStream                       m_whiteSpaceBuffer;
    TStringStream                       m_identifierBuffer; 
    TStringStream                       m_stringLiteralBuffer;
    TStringStream                       m_lineBuffer;

    TStringStream                       m_testOutput;

    RefCSLcPpCommon                     m_cslcPpCommon;
    TFileStream                         m_outputFStream;
    TChar                               m_directiveSymbol;

  public:
    ~CSLcPpFile();

    static RefCSLcPpFile build(TFileStream fileStream,
                               const RefString& fileName,
                               const RefCSLcPpFile& includedFrom = RefCSLcPpFile(static_cast<CSLcPpFile*>(NULL)));

    void processFile();

  private:
    CSLcPpFile(TFileStream fileStream,
               const RefString& fileName,
               const RefCSLcPpFile& includedFrom);

    void whiteSpaceReader();
    void identifierReader();
    void lineConcatReader();
    void lineFeedReader();
    void stringLiteralReader();
    void directiveReader();
    void lineCommentReader();
    void blockCommentReader();
    void defaultReader();

    void writeLineBuffer();

    void setFlag(EPpFlag flag)     { m_ppFlag |= flag;}
    void resetFlag(EPpFlag flag)   { m_ppFlag &= ~flag; }
    void reverseFlag(EPpFlag flag) { m_ppFlag ^= flag; }

    TBool isFlagSet(EPpFlag flag)               { return (m_ppFlag & flag); }
    TBool isWhiteSpace(TFileStreamChar ch)      { return (ch == CHAR_SPACE || ch == CHAR_TAB); }
    TBool isLineConcat(TFileStreamChar ch)      { return (ch == CHAR_BACKSLASH); }
    TBool isLineFeed(TFileStreamChar ch)        { return (ch == CHAR_NEW_LINE); }
    TBool isStringLiteral(TFileStreamChar ch)   { return (ch == CHAR_DOUBLE_QUOTE); }
    TBool isSlash(TFileStreamChar ch)           { return (ch == CHAR_SLASH); }
    TBool isStar(TFileStreamChar ch)            { return (ch == CHAR_STAR); }
    TBool isDirectiveSymbol(TFileStreamChar ch) { return (ch == m_directiveSymbol); }
    TBool isIdentifierStart(TFileStreamChar ch) { return (ch == CHAR_UNDERSCORE
                                                          || (ch >= 'a' && ch <= 'z')
                                                          || (ch >= 'A' && ch <= 'Z')); }
    TBool isIdentifierChar(TFileStreamChar ch)  { return (isIdentifierStart(ch)
                                                          || (ch >= '0' && ch <= '9')); }
    TBool isDefaultChar(TFileStreamChar ch)     { return (!isLineFeed(ch)
                                                          && !isLineConcat(ch)
                                                          && !isWhiteSpace(ch)
                                                          && !isStringLiteral(ch)
                                                          && !isSlash(ch)); }

    void write(TStringStream& ss, TFileStreamChar& ch) { ss << ch; m_fileStream->get(ch); }
    void write(TStringStream& ss, TStringStream& iss) { ss << iss.str(); iss.str(EMPTY_STRING); }
    void writeN(TStringStream& ss, TChar ch, TUInt count) { for (TUInt i = ZERO; i < count; ++i) ss << ch;}
    void writeLN(TStringStream& ss, TUInt count) { ss << CHAR_POUND << CHAR_SPACE << CHAR_DOUBLE_QUOTE << *m_fileName << CHAR_DOUBLE_QUOTE << CHAR_SPACE << count << CHAR_NEW_LINE; }
};

// *********************************************************************
// CSLcPpCommon class
// *********************************************************************
class CSLcPpCommon {
    friend class CSLcPp;
    friend class CSLcPpFile;

  private:
    static RefCSLcPpCommon              m_instance;

    TFileStream                         m_outputFStream;
    TUInt                               m_includeDepth;
    TChar                               m_directiveSymbol;
    RefTVec_TPath                       m_defaultIncludeDirectories;

  public:
    ~CSLcPpCommon();

  private:
    CSLcPpCommon(TFileStream outputFStream,
                 TChar directiveSymbol,
                 TUInt includeDepth);

    static void build(TFileStream outputFStream,
                      TChar directiveSymbol,
                      const RefTVec_RefString& includeDirectories,
                      const RefTVec_RefString& macroDefinitions,
                      TUInt includeDepth = ZERO);

    static RefCSLcPpCommon getCSLcPpCommonInstance();

    void incrementIncludeDepth() { ++m_includeDepth; }
    void decrementIncludeDepth() { --m_includeDepth; }

    TFileStream getOutputFStream() const               { return m_outputFStream; }
    TUInt getIncludeDepth() const                      { return m_includeDepth; }
    TChar getDirectiveSymol() const                    { return m_directiveSymbol; }
    RefTVec_TPath getDefaultIncludeDirectories() const { return m_defaultIncludeDirectories; }
};

// *********************************************************************
// SLessRefString struct
// *********************************************************************
struct SLessRefString {
    TBool operator() (const RefString& s1,
                      const RefString& s2) const;
};

} //NSCSLcPP namespace

#endif //INC_GUARD_CSLcPP_h_
