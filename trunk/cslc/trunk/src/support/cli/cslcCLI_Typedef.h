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
//Author: Tb/Derek

#ifndef INC_GUARD_cslcCLI_Typedef_h_
#define INC_GUARD_cslcCLI_Typedef_h_
#include "cslcCLI_Include.h"
#include "../singleton.h"

namespace NSCLi {

// *********************************************************************
// macro definitions
// *********************************************************************
#ifndef __RELEASE_VERSION

#undef INTERNAL_ERROR_MSG
#undef INTERNAL_ERROR_NULL_REFERENCE
#undef INTERNAL_ERROR_INVALID_CAST
#undef INTERNAL_ERROR_INVALID_ITERATOR
#undef INTERNAL_ERROR_UNKNOWN

#define INTERNAL_ERROR_MSG                      \
  "cslcCLI.cpp INTERNAL ERROR : "
#define INTERNAL_ERROR_NULL_REFERENCE           \
  INTERNAL_ERROR_MSG << "NULL reference"
#define INTERNAL_ERROR_INVALID_CAST             \
  INTERNAL_ERROR_MSG << "invalid cast"
#define INTERNAL_ERROR_INVALID_ITERATOR         \
  INTERNAL_ERROR_MSG << "invalid iterator"
#define INTERNAL_ERROR_UNKNOWN                  \
  INTERNAL_ERROR_MSG << "unknown"

#else

#define INTERNAL_ERROR_MSG
#define INTERNAL_ERROR_NULL_REFERENCE
#define INTERNAL_ERROR_INVALID_CAST
#define INTERNAL_ERROR_INVALID_ITERATOR
#define INTERNAL_ERROR_UNKNOWN

#endif




  // *********************************************************************
  // predeclarations
  // *********************************************************************
  class CLiArgumentBase;
  class CLiArgumentEmpty;
  class CLiArgumentNumber;
  class CLiArgumentOption;
  class CLiArgumentFileName;
  class CLiArgumentDirName;
  class CLiArgumentCslDefine;
  class CLiArgumentVerilogDefine;
  class CLiArgumentVerilogDirList;
  class CLiArgumentVerilogExtList;
  class CLiToken;
  class CLiArgumentList;
  class CLiError;

  // *********************************************************************
  // Ref typedefs
  // *********************************************************************
  typedef boost::weak_ptr<CLiArgumentBase>                        WeakRefCLiArgumentBase;
  typedef boost::weak_ptr<CLiArgumentList>                        WeakRefCLiArgumentList;

  typedef boost::shared_ptr<CLiArgumentBase>                      RefCLiArgumentBase;
  typedef boost::shared_ptr<CLiArgumentEmpty>                     RefCLiArgumentEmpty;
  typedef boost::shared_ptr<CLiArgumentNumber>                    RefCLiArgumentNumber;
  typedef boost::shared_ptr<CLiArgumentOption>                    RefCLiArgumentOption;
  typedef boost::shared_ptr<CLiArgumentFileName>                  RefCLiArgumentFileName;
  typedef boost::shared_ptr<CLiArgumentDirName>                   RefCLiArgumentDirName;
  typedef boost::shared_ptr<CLiArgumentCslDefine>                 RefCLiArgumentCslDefine;
  typedef boost::shared_ptr<CLiArgumentVerilogDefine>             RefCLiArgumentVerilogDefine;
  typedef boost::shared_ptr<CLiArgumentVerilogDirList>            RefCLiArgumentVerilogDirList;
  typedef boost::shared_ptr<CLiArgumentVerilogExtList>            RefCLiArgumentVerilogExtList;
  typedef boost::shared_ptr<CLiArgumentList>                      RefCLiArgumentList;
  typedef boost::shared_ptr<CLiError>                             RefCLiError;

  typedef boost::shared_ptr<CLiToken>                             RefCLiToken;

  typedef std::vector<RefString>                                  TVec_RefString;
  typedef std::vector<RefCLiToken>                                TVec_RefCLiToken;
  typedef std::vector<RefCLiArgumentBase>                         TVec_RefCLiArgumentBase;

  typedef TVec_RefString::iterator                                TVec_RefString_iter;
  typedef TVec_RefCLiToken::iterator                              TVec_RefCLiToken_iter;
  typedef TVec_RefCLiToken::reverse_iterator                      TVec_RefCLiToken_reverse_iter;
  typedef TVec_RefCLiArgumentBase::const_iterator                 TVec_RefCLiArgumentBase_const_iter;

  typedef boost::shared_ptr<TVec_RefString>                       RefTVec_RefString;
  typedef boost::shared_ptr<TVec_RefCLiToken>                     RefTVec_RefCLiToken;
  typedef boost::shared_ptr<TVec_RefCLiArgumentBase>              RefTVec_RefCLiArgumentBase;

  // *********************************************************************
  // class 
  // *********************************************************************




  // *********************************************************************
  // class CLiTool
  // *********************************************************************

  class CLiTool : public CSingleton<CLiTool> {
    friend class CSingleton<CLiTool>;  

  public:
    CLiTool();
    ~CLiTool();

  public:
    // static vars of integral types are declared inside the class
    // static vars of non-integral types are declared outside the class
     const std::string INVALID_CHARS;
     const std::string DIR_DELIMITER;
     const std::string BACK_DIR;
     const std::string CURRENT_DIR;
     const std::string BEGIN_ENV_VAR_NAME;
     const std::string END_ENV_VAR_NAME;

     const TChar CDIR_DELIMITER;

     const TUInt TMP_NAME_SIZE               ;
     const TUInt TMP_MAX_GEN_ATTEMPTS        ;
     const TUInt ASCII_ALPHA_COUNT           ;

    const TInt MIN_DIGIT                    ;
    const TInt MAX_DIGIT                    ;
    const TInt BASE_DEC                     ;

    const TInt FIRST_ARGC                   ;

    const TUInt START_POSITION              ;

     const TUInt DEFAULT_ERR_WARN            ;

     const std::string EMPTY_STRING;
  

     const std::string TMP_NAME_PREFIX;
     const std::string LINE_COMMENT;
     const std::string REGION_COMMENT_BEGIN;
     const std::string REGION_COMMENT_END;
     const std::string WHITE_SPACE;

     const std::string CSL_EXTENSION;
     const std::string XML_EXTENSION;
     const std::string CF_EXTENSION;
     const std::string VF_EXTENSION;

     const std::string PP_OPTION_ON;
     const std::string PP_OPTION_ONLY;
    //  const std::string PP_OPTION_OFF;

     const std::string VER_PLUS;

    /*  consts for argument key words
     */
     const std::string HELP_;
     const std::string DIR_;
     const std::string CONFIG_FILE_;

     const std::string CSL_PRINT_IT_;
     const std::string CSL_PRINT_IT_FILENANME_;
     const std::string CSL_PP_;
     const std::string CSL_PP_FILENAME_;
     const std::string CSL_CPP_GEN_;
     const std::string CSL_CSIM_GEN_;
     const std::string CSL_VERILOG_TB_GEN_;
     const std::string CSL_VERILOG_STIM_EXP_GEN_;
     const std::string CSL_MAX_ERROR_;
     const std::string CSL_MAX_WARN_;
     const std::string CSL_I_;
     const std::string CSL_DEFINE_;
     const std::string CSL_VF_INCDIR_;
     const std::string CSL_INCLUDE_VF_;
     const std::string CSL_INCLUDE_VERILOG_;
     const std::string CSL_F_;

     const std::string VER_PP_;
     const std::string VER_PP_FILENAME_;
     const std::string VER_PRJ_;
     const std::string VER_Y_;
     const std::string VER_V_;
     const std::string VER_DEFINE_;
     const std::string VER_INCDIR_;
     const std::string VER_LIBEXT_;
     const std::string VER_LIBNONAMEHIDE_;
     const std::string VER_LIBORDER_;
     const std::string VER_LIBRESCAN_;
     const std::string VER_F_;

#ifndef __RELEASE_VERSION
     const std::string INFO_;
     const std::string CSLOM_AST_;
     const std::string EXEC_STAGE_;
     const std::string CDOM_AST_;
     const std::string VEXEC_STAGE_;
#endif

    // *********************************************************************
    // typedefs
    // *********************************************************************
    typedef TUInt                                                   TAccessRights;

    // *********************************************************************
    // enum typedefs
    // *********************************************************************
    typedef enum _ECLiFileStat {
      FS_SUCCESS             = 0,
      FS_NOT_EXISTS          ,
      FS_IS_DIRECTORY        ,
      FS_NOT_DIRECTORY       ,
      FS_CAN_CREATE          ,
      FS_READ_DENIED         ,
      FS_WRITE_DENIED        ,
      FS_EXECUTE_WRITE_DENIED,
      FS_COULD_NOT_OPEN      ,
      FS_FAIL                ,
      FS_DENIED
    } ECLiFileStat;

    typedef enum _ECLiAccess {
      ACCESS_EXECUTE = 1,
      ACCESS_READ    = 2,
      ACCESS_WRITE   = 4
    } ECLiAccess;

    typedef enum _ECLiArgumentType {
      ARG_EMPTY       = 0,
      ARG_NUMBER      ,
      ARG_OPTION      ,
      ARG_FILE_NAME   ,
      ARG_DIR_NAME    ,
      ARG_CSL_DEFINE  ,
      ARG_VER_DEFINE  ,
      ARG_VER_DIR_LIST,
      ARG_VER_EXT_LIST
    } ECLiArgumentType;

    typedef enum _ETokenGet {
      TK_TOKEN,
      TK_PATH
    } ETokenGet;

    typedef enum _ECLiError {
      APARSE_SUCCESS                 = 0,
      APARSE_HELP                    ,
      APARSE_DUPLICATE_ARGUMENT      ,
      APARSE_INVALID_ARGUMENT        ,
      APARSE_TOO_FEW_ARGUMENTS       ,
      APARSE_FILE_NOT_EXISTS         ,
      APARSE_DIR_NOT_EXISTS          ,
      APARSE_EXPECTED_FILE           ,
      APARSE_EXPECTED_FILE_EXTENSION ,
      APARSE_EXPECTED_DIR            ,
      APARSE_NUMBER_TOO_SMALL        ,
      APARSE_NUMBER_TOO_BIG          ,
      APARSE_NOT_NUMERIC             ,
      APARSE_NO_SOURCE_FILE_SPECIFIED,
      APARSE_DUPLICATE_CLI_FILE      ,
      APARSE_COULD_NOT_OPEN_FILE     ,
      APARSE_READ_PERMISION_DENIED   ,
      APARSE_FAIL                    ,
      APARSE_ACCESS_DENIED
    } ECLiError;

    typedef enum _ECLiWarning {
      AWARN_FILE_ALREADY_IN_LIST            = 0,
      AWARN_CSL_INCLUDE_DIR_ALREADY_IN_LIST ,
      AWARN_VER_LIBRARY_DIR_ALREADY_IN_LIST ,
      AWARN_VER_LIBRARY_FILE_ALREADY_IN_LIST,
      AWARN_INCOMPLETE_EXTENSION            ,
      AWARN_EMPTY_NAME                      ,
      AWARN_NO_PP_FILENAME
    } ECLiWarning;

    typedef enum _ECSLcPpOption {
      PP_ON   = 0,
      PP_ONLY
      //   PP_OFF ,
    } ECSLcPpOption;

#ifndef __RELEASE_VERSION
    typedef enum _ECSLcExecStage {
      EXEC_STAGE_PREPROCESSOR      = 0,
      EXEC_STAGE_LEXER             ,
      EXEC_STAGE_PARSER            ,
      EXEC_STAGE_TREE_WALKER       ,
      EXEC_STAGE_INST_TREE         ,
      EXEC_STAGE_AUTOROUTER        ,
      EXEC_STAGE_AUTOMAPPER        ,
      EXEC_STAGE_CSLOM_CHECKER     ,
      EXEC_STAGE_CONNECTION_CHECKER,
      EXEC_STAGE_CSLOM_CODE_GENS   ,
      EXEC_STAGE_ADAPTER           ,
      EXEC_STAGE_VERILOG_TB        ,
      EXEC_STAGE_VERILOG_STIM_EXP  ,
      EXEC_STAGE_CDOM_CHECKER      ,
      EXEC_STAGE_CDOM_CODE_GENS    ,
      EXEC_STAGE_NO_SELECTION
    } ECSLcExecStage;

    typedef enum _ECSLcVExecStage {
      VEXEC_STAGE_PREPROCESSOR  = 0,
      VEXEC_STAGE_LEXER         ,
      VEXEC_STAGE_PARSER        ,
      VEXEC_STAGE_TREE_WALKER   ,
      VEXEC_STAGE_CDOM_CHECKER  ,
      VEXEC_STAGE_CDOM_CODE_GENS,
      VEXEC_STAGE_NO_SELECTION
    } ECSLcVExecStage;
#endif


  };

  // *********************************************************************
  // function pointers
  // *********************************************************************
  // the type name is THandler

  typedef CLiTool::ECLiError (CLiArgumentList::*THandler)(const RefCLiArgumentBase&);





} //NSCLi

#endif //INC_GUARD_cslcCLI_Typedef_h_
