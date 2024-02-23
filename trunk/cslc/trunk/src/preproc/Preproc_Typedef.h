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

#ifndef INC_GUARD_Preproc_Typedef_h_
#define INC_GUARD_Preproc_Typedef_h_

#include "Preproc_Include.h"

namespace NSPreproc {

// *********************************************************************
// macro definitions
// *********************************************************************
#define CHAR_EMPTY                              '\0'
#define CHAR_GRAVE_ACCENT                       '`'
#define CHAR_POUND                              '#'
#define CHAR_SPACE                              ' '
#define CHAR_TAB                                '\t'
#define CHAR_NEW_LINE                           '\n'
#define CHAR_DQUOTE                             '\"'
#define CHAR_QUOTE                              '\''
#define CHAR_KEEP_LINE                          '\\'
#define CHAR_COMMENT_START                      '/'
#define CHAR_COMMENT_LINE                       '/'
#define CHAR_COMMENT_REGION                     '*'

//TODO: see Preproc.cpp @ begin
#define WRITE_FILE_NAME(_out, _name, _line)     \
  if (NSPPDebug::__flow == PP_FLOW_CSL) {       \
  _out << CHAR_POUND                            \
       << CHAR_SPACE                            \
       << CHAR_DQUOTE                           \
       << _name                                 \
       << CHAR_DQUOTE                           \
       << CHAR_SPACE                            \
       << _line                                 \
       << CHAR_NEW_LINE;                        \
  }

#define WRITE(_out, _what)                      \
  _out << _what

#define WRITE_N(_out, _what, _no)               \
  for (TInt i = ZERO;                           \
       i < _no;                                 \
       ++i) {                                   \
                                                \
    _out << _what;                              \
  }

#define IS_ID_CHAR(_char)                       \
  (_char == '_'                                 \
   || (_char >= 'A'                             \
       && _char <= 'Z')                         \
   || (_char >= 'a'                             \
       && _char <= 'z')                         \
   || (_char >= '0'                             \
       && _char <= '9'))

#define IS_FLAG_SET(_flag)                      \
  ((_flag) & m_parserFlags)

#define SET_FLAG_ON(_flag)                      \
  m_parserFlags |= (_flag)

#define SET_FLAG_OFF(_flag)                     \
  m_parserFlags &= ~(_flag)

#define SWITCH_FLAG(_flag)                      \
  m_parserFlags ^= (_flag)

#undef INTERNAL_ERROR_MSG
#undef INTERNAL_ERROR_NULL_REFERENCE
#undef INTERNAL_ERROR_CLOSED_FILE_STREAM

#ifndef __RELEASE_VERSION

#define INTERNAL_ERROR_MSG                      \
  "Preproc.cpp INTERNAL ERROR : "
#define INTERNAL_ERROR_NULL_REFERENCE           \
  INTERNAL_ERROR_MSG << "NULL reference."
#define INTERNAL_ERROR_CLOSED_FILE_STREAM       \
  INTERNAL_ERROR_MSG << "closed file stream."

#else

#define INTERNAL_ERROR_NULL_REFERENCE
#define INTERNAL_ERROR_CLOSED_FILE_STREAM

#endif

// *********************************************************************
// consts
// *********************************************************************
const std::string EMPTY_STRING                  = "";

const char *const _INCLUDE                      = "include";
const char *const _LINE                         = "line";
const char *const _DEFINE                       = "define";
const char *const _UNDEF                        = "undef";
const char *const _IFDEF                        = "ifdef";
const char *const _IFNDEF                       = "ifndef";
const char *const _ELSE                         = "else";
const char *const _ENDIF                        = "endif";

const TInt MAX_IGNORED_LINES                    = 8;
const TUInt MAX_INCLUDE_DEPTH                   = 100;

// *********************************************************************
// enum typedefs
// *********************************************************************
typedef enum _EPpFlow {
  PP_FLOW_CSL,
  PP_FLOW_VER
} EPpFlow;

typedef enum _EPpParserFlags {
  PF_LINE_START  = (TInt)1 << 0,
  PF_STR_READ    = (TInt)1 << 1,
  PF_WS_READ     = (TInt)1 << 2,
  PF_IGNORE_LINE = (TInt)1 << 3,
  PF_IGNORE_READ = (TInt)1 << 4,
  PF_EOF_REACHED = (TInt)1 << 5,
  PF_KEEP_LINE   = (TInt)1 << 6
} EPpParserFlags;

// *********************************************************************
// predeclarations
// *********************************************************************
class PpFile;
class CSLcPreprocessor;

// *********************************************************************
// Ref typedefs
// *********************************************************************
typedef boost::weak_ptr<PpFile>                                 WeakRefPpFile;

typedef boost::shared_ptr<PpFile>                               RefPpFile;
typedef boost::shared_ptr<CSLcPreprocessor>                     RefCSLcPreprocessor;

typedef std::stack<RefPpFile>                                   TStack_RefPpFile;
typedef std::vector<RefPpFile>                                  TVec_RefPpFile;
typedef std::vector<std::fstream*>                              TVec_FStream;
typedef std::vector<RefString>                                  TVec_RefString;

typedef TVec_RefPpFile::const_iterator                          TVec_RefPpFile_const_iter;
typedef TVec_FStream::const_iterator                            TVec_FStream_const_iter;
typedef TVec_RefString::const_iterator                          TVec_RefString_const_iter;

typedef boost::shared_ptr<TStack_RefPpFile>                     RefTStack_RefPpFile;
typedef boost::shared_ptr<TVec_RefPpFile>                       RefTVec_RefPpFile;
typedef boost::shared_ptr<TVec_FStream>                         RefTVec_FStream;
typedef boost::shared_ptr<TVec_RefString>                       RefTVec_RefString;

// *********************************************************************
// function pointers
// *********************************************************************
typedef void (PpFile::*TDirectiveHandler)();

} //NSPreproc

#endif //INC_GUARD_Preproc_Typedef_h_
