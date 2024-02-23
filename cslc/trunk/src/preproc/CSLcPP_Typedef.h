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

#ifndef INC_GUARD_CSLcPP_Typedef_h_
#define INC_GUARD_CSLcPP_Typedef_h_

#include "CSLcPP_Include.h"

namespace NSCSLcPP {

// *********************************************************************
// macro definitions
// *********************************************************************
#define CHAR_EMPTY                      '\0'
#define CHAR_SPACE                      ' '
#define CHAR_TAB                        '\t'
#define CHAR_NEW_LINE                   '\n'
#define CHAR_DOUBLE_QUOTE               '\"'
#define CHAR_BACKSLASH                  '\\'
#define CHAR_SLASH                      '/'
#define CHAR_STAR                       '*'
#define CHAR_UNDERSCORE                 '_'
#define CHAR_BACKQUOTE                  '`'
#define CHAR_POUND                      '#'

#undef INTERNAL_ERROR_MSG
#undef INTERNAL_ERROR_NULL_REFERENCE
#undef INTERNAL_ERROR_CLOSED_FILE_STREAM

#ifndef __RELEASE_VERSION

#define INTERNAL_ERROR_MSG                      \
  "CSLcPP.cpp INTERNAL ERROR : "
#define INTERNAL_ERROR_NULL_REFERENCE           \
  INTERNAL_ERROR_MSG << "NULL reference."
#define INTERNAL_ERROR_CLOSED_FILE_STREAM       \
  INTERNAL_ERROR_MSG << "closed file stream."

#endif

// *********************************************************************
// consts
// *********************************************************************
#ifndef __RELEASE_VERSION
#endif

const std::string EMPTY_STRING                  = "";

const TChar *const __DIRECTIVE_INCLUDE          = "include";
const TChar *const __DIRECTIVE_LINE             = "line";
const TChar *const __DIRECTIVE_DEFINE           = "define";
const TChar *const __DIRECTIVE_UNDEF            = "undef";
const TChar *const __DIRECTIVE_IFDEF            = "ifdef";
const TChar *const __DIRECTIVE_IFNDEF           = "ifndef";
const TChar *const __DIRECTIVE_ELSE             = "else";
const TChar *const __DIRECTIVE_ENDIF            = "endif";

const TUInt __MAX_IGNORED_LINES                 = 8;
const TUInt __MAX_INCLUDE_DEPTH                 = 100;

// *********************************************************************
// typedefs
// *********************************************************************
typedef std::fstream*                           TFileStream;
typedef std::fstream::traits_type::char_type    TFileStreamChar;
typedef std::stringstream                       TStringStream;
typedef TUInt                                   TPpFlag;
typedef boost::filesystem::path                 TPath;

// *********************************************************************
// enum typedefs
// *********************************************************************
typedef enum _EPpFlow {
  PPFL_CSL,
  PPFL_VERILOG
} EPpFlow;

typedef enum _EPpFlag {
  PP_FLAG_NONE = (TPpFlag)1 << 0
} EPpFlag;

// *********************************************************************
// predeclarations
// *********************************************************************
class CSLcPp;
class CSLcPpFile;
class CSLcPpCommon;

struct SLessRefString;

// *********************************************************************
// Ref typedefs
// *********************************************************************
typedef boost::weak_ptr<CSLcPpFile>             WeakCSLcPpFile;

typedef boost::shared_ptr<CSLcPp>               RefCSLcPp;
typedef boost::shared_ptr<CSLcPpFile>           RefCSLcPpFile;
typedef boost::shared_ptr<CSLcPpCommon>         RefCSLcPpCommon;

typedef std::vector<RefString>                  TVec_RefString;
typedef std::vector<RefCSLcPpFile>              TVec_RefCSLcPpFile;
typedef std::vector<TPath>                      TVec_TPath;

typedef TVec_RefString::const_iterator          TVec_RefString_const_iter;
typedef TVec_RefCSLcPpFile::const_iterator      TVec_RefCSLcPpFile_const_iter;
typedef TVec_TPath::const_iterator              TVec_TPath_const_iter;

typedef boost::shared_ptr<TVec_RefString>       RefTVec_RefString;
typedef boost::shared_ptr<TVec_RefCSLcPpFile>   RefTVec_RefCSLcPpFile;
typedef boost::shared_ptr<TVec_TPath>           RefTVec_TPath;

} //NSCSLcPP namespace

#endif //INC_GUARD_CSLcPP_Typedef_h_
