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

#ifndef INC_GUARD_cslc_Typedef_h_
#define INC_GUARD_cslc_Typedef_h_

#include "cslc_Include.h"

namespace NSCslc {

  class CslcTool {
  public:
      static CslcTool* Instance();
    static void DestroyInstance() {
      delete pinstance;
      pinstance = NULL;
    };

  protected:
      CslcTool();
      CslcTool(const CslcTool&);
      CslcTool& operator= (const CslcTool&);
  private:
      static CslcTool* pinstance;

  public:

    const TBool IS_RELEASE;

     TBool isRelease ( void ) { return   IS_RELEASE; }
     TBool notRelease( void ) { return ! IS_RELEASE; }

  // *********************************************************************
  // consts
  // *********************************************************************
#ifndef __RELEASE_VERSION
     const std::string DISP_FILE;
     const std::string DISP_STAGE;
     const std::string DISP_BEGIN;
     const std::string DISP_END;
     const std::string DISP_LINE;
     const std::string DISP_AST;
     const std::string DISP_HEAD;

     const std::string CSL_PP;
     const std::string CSL_L;
     const std::string CSL_P;
     const std::string CSL_TW;
     const std::string CSL_IT;
     const std::string CSL_AM;
     const std::string CSL_AR;
     const std::string CSL_CS_CK;
     const std::string CSL_CC;
     const std::string CSL_CS_CG;
     const std::string CSL_A;
     // const std::string CSL_VTB;
     const std::string CSL_CD_CK;
     const std::string CSL_CD_CG;

     const std::string VER_PP;
     const std::string VER_L;
     const std::string VER_P;
     const std::string VER_TW;
     const std::string VER_CD_CK;
     const std::string VER_CD_CG;

     const std::string CG_PDF;
     const std::string CG_CPP;
     const std::string CG_CSIM;
     const std::string CG_XML;
     const std::string CG_GUI_XML_GENERATOR;
     const std::string CG_GUI_CSL_GENERATOR;
     const std::string CG_VERILOG_DEFINE;
     const std::string CG_VERILOG;
     const std::string CG_VERILOG_MEM;
     const std::string CG_VERILOGTB;
     const std::string CG_CSLGEN;
     const std::string CG_VHDL;
     const std::string CG_SYSC;
     const std::string CG_SchemC;

#endif

     const std::string CSL_AST_ID;
     const std::string VER_AST_ID;

     const std::string CURRENT_DIR;
     const std::string CHAR_START_DIR;
     const std::string END_GEN_DIR;
     const std::string END_VGEN_DIR;
     const std::string DEFAULT_GEN_DIR;
     const std::string GEN_CODE_DIR;
     const std::string GEN_DOCS_DIR;
     const std::string GEN_PDF_DIR;
     const std::string GEN_CPP_DIR;
     const std::string GEN_CSIM_DIR;
     const std::string GEN_CSIM_SUBDIR;
     const std::string GEN_XML_DIR;
     const std::string GEN_GUI_XML_GENERATOR_DIR;
     const std::string GEN_GUI_CSL_GENERATOR_DIR;
     const std::string GEN_SYSC_DIR;
     const std::string GEN_SchemC_DIR;
     const std::string GEN_VER_DIR;
     const std::string GEN_VHDL_DIR;
     const std::string GEN_CSL_DIR;

    // *********************************************************************
    // enum typedefs
    // *********************************************************************
    typedef enum _ECSLcComponent {
      COMP_NONE                          = 0,
      COMP_INTERCONNECT                  = 1 << 0,
      COMP_VERIFICATION_COMPONENTS       = 1 << 1,
      COMP_TESTBENCH                     = 1 << 2,
      COMP_ALL                           = 0xffff
    } ECSLcComponent;

    typedef enum _ECSLcError {
      ERR_NONE                           = 0,
      /*
       * Avoided exit code 9 because it seems to indicate some sort of kernel fatal error
       */
      ERR_ARG_PARSE                      = 10,
      ERR_COULD_NOT_OPEN_FILE            ,
      ERR_FILE_NOT_EXISTS                ,
      ERR_CSL                            ,
      ERR_VER                            ,
      ERR_TEMP_FILE_FAILURE              ,
      ERR_EXECUTE_WRITE_PERMISSION_NEEDED,
      ERR_WRITE_PERMISSION_NEEDED        ,
      ERR_READ_PERMISSION_NEEDED         ,
      ERR_BOOST_FILESYSYTEM              ,
      ERR_WE                             ,
      ERR_CAUGHT_EXCEPTION
    } ECSLcError;

    typedef enum _ECSLcExceptionCode {
# ifndef __RELEASE_VERSION
      E_FATAL_ERROR                 = 1,
# else
      E_FATAL_ERROR                 = FATAL_ERROR,
# endif

      E_STD_BAD_EXCEPTION             , // 2 
      E_STD_BAD_ALLOC                 , // 3 
      E_STD_BAD_CAST                  , // 4 
      E_STD_BAD_TYPEID                , // 5 
      E_STD_IOS_BASE_FAILURE          , // 6 
      E_STD_DOMAIN_ERROR              , // 7 
      E_STD_INVALID_ARGUMENT          , // 8 
      E_STD_LENGTH_ERROR              , // 9 
      E_STD_OUT_OF_RANGE              , // 10
      E_STD_LOGIC_ERROR               , // 11
      E_STD_OVERFLOW_ERROR            , // 12
      E_STD_RANGE_ERROR               , // 13
      E_STD_UNDERFLOW_ERROR           , // 14
      E_STD_RUNTIME_ERROR             , // 15
      E_STD                           , // 16
      E_BASE_ILLEGAL_ARGUMENT         , // 17
      E_BASE_ILLEGAL_STATE            , // 18
      E_BASE_UNSUPPORTED_OPERATION    , // 19
      E_BASE_NO_SUCH_ELEMENT          , // 20
      E_BASE_CONCURRENT_MODIFICATION  , // 21
      E_BASE_NOT_IMPLEMENTED          , // 22
      E_BASE                          , // 23
      E_VERINUM                       , // 24
      E_GEN_BASE                      , // 25
      E_GEN_CSL_LEXER                 , // 26
      E_GEN_VER_LEXER                 , // 27
      E_XER_NO_VALUE                  , // 28
      E_XER_ILLEGAL_VALUE             , // 29
      E_XER                           , // 30
      E_ANTLR_CHAR_STREAM_IO          , // 31
      E_ANTLR_CHAR_STREAM             , // 32
      E_ANTLR_IO                      , // 33
      E_ANTLR_MISMATCHED_CHAR         , // 34
      E_ANTLR_MISMATCHED_TOKEN        , // 35
      E_ANTLR_NO_VIABLE_ALT           , // 36
      E_ANTLR_NO_VIABLE_ALT_FOR_CHAR  , // 37
      E_ANTLR_SEMANTIC                , // 38
      E_ANTLR_RECOGNITION             , // 39
      E_ANTLR_TOKEN_STREAM_IO         , // 40
      E_ANTLR_TOKEN_STREAM_RECOGNITION, // 41
      E_ANTLR_TOKEN_STREAM_RETRY      , // 42
      E_ANTLR_TOKEN_STREAM            , // 43
      E_ANTLR                         , // 44
      E_SIGINT                        , // 45
      E_UNKNOWN                         // 46
    } ECSLcExceptionCode;


  };

// *********************************************************************
// predeclarations
// *********************************************************************
class CSLcMain;
class CSLcMessages;

// *********************************************************************
// Ref typedefs
// *********************************************************************
typedef boost::shared_ptr<CSLcMain>                                               RefCSLcMain;
typedef boost::shared_ptr<CSLcMessages>                                           RefCSLcMessages;
typedef boost::shared_ptr<CslLexer>                                               RefCslLexer;
typedef boost::shared_ptr<CslParser>                                              RefCslParser;
typedef boost::shared_ptr<ASTFactory>                                             RefASTFactory;
typedef boost::shared_ptr<CslTreeWalker>                                          RefCslTreeWalker;
typedef boost::shared_ptr<NSCInstTreeVisitor::CInstTreeTraversal>                 RefCInstTreeTraversal;
typedef boost::shared_ptr<NSCSLOmDesignChecker::CSLOmDesignChecker>               RefCSLOmDesignChecker;
typedef boost::shared_ptr<NSAdapter::CAdapterToCDOM>                              RefCAdapterToCDOM;
//------------------MS added-------------------------
typedef boost::shared_ptr<NSCSLOmVerilogTbGenerator::CSLOmVerilogTbGenerator>     RefCVerilogTbGenerator;
typedef boost::shared_ptr<NSCSLOmCslCodeGenerator::CSLOmCslCodeGenerator>         RefCCslCodeGenerator;
//---------------------------------------------------
typedef boost::shared_ptr<NSCdomChecker::CDOmChecker>                             RefCDOmChecker;
typedef boost::shared_ptr<NSCdomVerilogGenerator::CVerilogGenerator>              RefCVerilogGenerator;
//-------------MS added----------
typedef boost::shared_ptr<NSCdomStimExpGenerator::CStimExpGenerator>              RefCStimExpGenerator;
//------OB added----start
typedef boost::shared_ptr<NSCdomSystemCGenerator::CSystemCGenerator>              RefCSystemCGenerator;
typedef boost::shared_ptr<NSCdomSchematicCodeGenerator::CSchematicCodeGenerator>  RefCSchematicCodeGenerator;
//------end
typedef boost::shared_ptr<NSCdomVHDLGenerator::CVHDLGenerator>                    RefCVHDLGenerator;
typedef boost::shared_ptr<NSCCPPGenerator::CCPPGenerator>                         RefCCPPGenerator;
typedef boost::shared_ptr<NSCsimCppGenerator::CsimCppGenerator>                   RefCsimCppGenerator;
//typedef boost::shared_ptr<NSCSLOmXmlGenerator::CSLOmXmlGenerator>                 RefCSLOmXmlGenerator;
typedef boost::shared_ptr<NSCSLOmGuiXmlGenerator::CSLOmGuiXmlGenerator>           RefCSLOmGuiXmlGenerator;
typedef boost::shared_ptr<NSCSLOmGuiCslGenerator::CSLOmGuiCslGenerator>           RefCSLOmGuiCslGenerator;
typedef boost::shared_ptr<NSCVerilogDefineGenerator::CVerilogDefineGenerator>     RefCVerilogDefineGenerator;
typedef boost::shared_ptr<NSCPDFGenerator::CPDFGenerator>                         RefCPDFGenerator;
typedef boost::shared_ptr<VerilogLexer>                                           RefVerilogLexer;
typedef boost::shared_ptr<VerilogParser>                                          RefVerilogParser;
typedef boost::shared_ptr<VerilogTreeWalker>                                      RefVerilogTreeWalker;


typedef std::vector<RefString> TVec_RefString;
typedef boost::shared_ptr<TVec_RefString> Ref_TVec_RefString;
typedef std::map<RefString,Ref_TVec_RefString> map_RefStr_TVec;
typedef boost::shared_ptr<map_RefStr_TVec> RefMap_RefStr_TVec;



  // *********************************************************************
  // macro definitions
  // *********************************************************************
//#define CHECK_ERR(_err)                         \
//  if (_err != CslcTool::ERR_NONE) {                       \
//    return _err;                                \
//  }

#define CATCH_ALL_EXCEPTIONS(_e, _ret)                  \
  catch(NSWarnError::CslException& _e) {                \
    m_cslcMessages->display(_e.what());                 \
    return CslcTool::ERR_WE;                                      \
  }                                                     \
  catch(std::exception& _e) {                           \
    catchStdException(_e);                              \
  }                                                     \
  catch(antlr::ANTLRException& _e) {                    \
    catchAntlrException(_e);                            \
  }                                                     \
  catch(CSLcSignal& _e) {                               \
    throw CslcTool::E_SIGINT;                                     \
  }                                                     \
  catch(CslcTool::ECSLcExceptionCode _e) {                        \
    m_cslcMessages->displayException(_e);               \
    return CslcTool::ERR_CAUGHT_EXCEPTION;                        \
  }                                                     \
  catch(...) {                                          \
    m_cslcMessages->displayException(CslcTool::E_UNKNOWN);        \
    return CslcTool::ERR_CAUGHT_EXCEPTION;                        \
  }                                                     \
    return _ret

  /*
#define CATCH_BOOST_EXCEPTION(_e, _path)                                \
  catch(boost::filesystem::filesystem_error& _e) {                      \
    // DEP 2010-060-06 to get boost 1.42 and gcc 4.3 to work boost::filesystem::system_error_type errCode = _e.system_error(); \
    std::string errString = _path + " : ";                              \
    // DEP 2010-060-06 to get boost 1.42 and gcc 4.3 to workboost::filesystem::system_message(errCode, errString);              \
    m_cslcMessages->displayError(CslcTool::ERR_BOOST_FILESYSYTEM, errString);     \
    return CslcTool::ERR_BOOST_FILESYSYTEM;                                       \
  }
  */

#define CATCH_BOOST_EXCEPTION(_e, _path)                                \
  catch(boost::filesystem::filesystem_error& _e) {                      \
    std::string errString = _path + " : ";                              \
    m_cslcMessages->displayError(CslcTool::ERR_BOOST_FILESYSYTEM, errString);     \
    return CslcTool::ERR_BOOST_FILESYSYTEM;                                       \
  }

#define CAST_STD_EXCEPTION(_base, _e, _code)    \
  if (downCastException<_base>(_e)) {           \
    DCERR(_e.what());                           \
    throw _code;                                \
  }

#define CAST_ANTLR_EXCEPTION(_base, _e, _code)  \
  if (downCastException<_base>(_e)) {           \
    DCERR(_e.toString());                       \
    throw _code;                                \
  }

#undef INTERNAL_ERROR_MSG
#undef INTERNAL_ERROR_NULL_REFERENCE
#undef INTERNAL_ERROR_EMPTY_STRING
#undef DISPLAY_FILE
#undef DISPLAY_INFO_BEGIN
#undef DISPLAY_INFO_END
#undef DISPLAY_AST
#undef DISPLAY_CGEN_BEGIN
#undef DISPLAY_CGEN_END
#undef IF_BEGIN
#undef IF_VBEGIN
#undef IF_END

#ifndef __RELEASE_VERSION


#define INTERNAL_ERROR_MSG                      \
  "cslc.cpp INTERNAL ERROR : "
#define INTERNAL_ERROR_NULL_REFERENCE           \
  INTERNAL_ERROR_MSG << "NULL reference"
#define INTERNAL_ERROR_EMPTY_STRING             \
  INTERNAL_ERROR_MSG << "empty string"

  //#define DISPLAY_FILE(_file)                     \
  //  displayInfo(CslcTool::DISP_FILE                         \
  //              + "\'"                            \
  //              + _file                           \
  //              + "\'"                            \
  //              + CslcTool::DISP_LINE)
  //#define DISPLAY_INFO_BEGIN(_nr, _msg)           \
  //  displayInfo(CslcTool::DISP_STAGE                        \
  //              + intToString(_nr)                \
  //              + _msg                            \
  //              + CslcTool::DISP_BEGIN)
  //#define DISPLAY_INFO_END(_nr, _msg)             \
  //  displayInfo(CslcTool::DISP_STAGE                        \
  //              + intToString(_nr)                \
  //              + _msg                            \
  //              + CslcTool::DISP_END)
  //#define DISPLAY_AST(_ast, _msg)                 \
  //  displayAST(_ast, _msg)
  //#define DISPLAY_CGEN_BEGIN(_msg)                \
  //  displayInfo(CslcTool::DISP_HEAD                         \
  //              + _msg                            \
  //              + CslcTool::DISP_BEGIN)
  //#define DISPLAY_CGEN_END(_msg)                  \
  //  displayInfo(CslcTool::DISP_HEAD                         \
  //              + _msg                            \
  //              + DISP_END)

  //#define IF_BEGIN(_nr)                           \
  //  if (m_execStage >= _nr) {
  //#define IF_VBEGIN(_nr)                          \
  //  if (m_vExecStage >= _nr) {
  //#define IF_END                                  \
  //  }                                             \
  //  else {                                        \
  //    return CslcTool::ERR_NONE;                            \
  //  }

#else

#define INTERNAL_ERROR_NULL_REFERENCE
#define INTERNAL_ERROR_EMPTY_STRING
  //#define DISPLAY_FILE(_file)
  //#define DISPLAY_DLINE
  //#define DISPLAY_INFO_BEGIN(_nr, _msg)
  //#define DISPLAY_INFO_END(_nr, _msg)
  //#define DISPLAY_AST(_ast, _msg)
  //#define DISPLAY_CGEN_BEGIN(_msg)
  //#define DISPLAY_CGEN_END(_msg)
  //#define IF_BEGIN(_nr)
  //#define IF_VBEGIN(_nr)
  //#define IF_END

#endif


} //NSCslc

#endif //INC_GUARD_cslc_Typedef_h_
