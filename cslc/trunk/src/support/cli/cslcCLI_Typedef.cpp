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
//Author: Tb/derek

#include "cslcCLI_Support.h"
 
namespace NSCLi {

  //  RefCLiTool CLiTool::pinstance;// initialize pointer

  CLiTool::~CLiTool() {
    //    pinstance.reset(); 
  }

//  RefCLiTool CLiTool::Instance() {
////    if (pinstance == 0) { // is it the first call?
////      pinstance = new CLiTool; // create sole instance
////    }
////    return pinstance; // address of sole instance
//
//   std::cout << "[INFO]BEFORE CLiTool::Instance singleton. refcount = " << pinstance.use_count()  << std::endl;
//
//    if (NULL == pinstance.get()) { // is it the first call?
//      pinstance.reset(new CLiTool()); // create sole instance
//      std::cout << "[INFO] CLiTool::Instance created the singleton. refcount = " << pinstance.use_count()  << std::endl;
//    }
//       std::cout << "[INFO]AFTER CLiTool::Instance singleton. refcount = " << pinstance.use_count()  << std::endl;
//    return pinstance; // address of sole instance
//  }
//
//  void CLiTool::PrepareToDie(){
//    //    std::cout << "[INFO]BEFORE CLiTool::PrepareToDie singleton. refcount = " << pinstance.use_count()  << std::endl;    
//    if( pinstance.unique() ) {
//      pinstance.reset();
//      std::cout << "[INFO] CLiTool::PrepareToDie killed the singleton" << std::endl;
//    }
//    else {
//      std::cout << "[INFO] CLiTool::PrepareToDie did not kill the singleton. refcount = " << pinstance.use_count() << std::endl;
//    }
//    //    std::cout << "[INFO]AFTER CLiTool::PrepareToDie singleton. refcount = " << pinstance.use_count()  << std::endl;    
//
//  }

  CLiTool::CLiTool() :
    TMP_NAME_SIZE                                       (20),
    TMP_MAX_GEN_ATTEMPTS                                (100),
    ASCII_ALPHA_COUNT                                   (26),

    MIN_DIGIT                                            (0),
    MAX_DIGIT                                            (9),
    BASE_DEC                                             (10),

    FIRST_ARGC                                           (1),

    START_POSITION                                      (0),

    DEFAULT_ERR_WARN                                    (30),

    EMPTY_STRING (""),

    // *********************************************************************
    // CLiTool
    // *********************************************************************

#ifdef CSLC_POSIX
    INVALID_CHARS ("\""
                   "#"
                   "$"
                   "&"
                   "\'"
                   "("
                   ")"
                   "*"
                   "),"
                   "<"
                   "="
                   ">"
                   "?"
                   "\\"
                   "["
                   "]"
                   "`"
                   "|"
                   "!"
                   ","
                   "+"),

    DIR_DELIMITER ("/"),
    BACK_DIR ("../"),
    CURRENT_DIR ("./"),
    BEGIN_ENV_VAR_NAME ("$"),
    END_ENV_VAR_NAME("/"),

#else

    INVALID_CHARS ("\""
                   "#"
                   "$"
                   "&"
                   "\'"
                   "("
                   ")"
                   "*"
                   "),"
                   "<"
                   "="
                   ">"
                   "?"
                   "/"
                   "["
                   "]"
                   "`"
                   "|"
                   "!"
                   ","
                   "+"),

    DIR_DELIMITER ("\\"),
    BACK_DIR ("..\\"),
    CURRENT_DIR (".\\"),
    BEGIN_ENV_VAR_NAME ("%"),
    END_ENV_VAR_NAME ("%"),

#endif
#ifdef CSLC_POSIX
    CDIR_DELIMITER ('/'),
#else
    CDIR_DELIMITER ('\\'),
#endif

    TMP_NAME_PREFIX                              ("cslc_tmp"),
    LINE_COMMENT                                  ("//"),
    REGION_COMMENT_BEGIN                          ("/*"),
    REGION_COMMENT_END                            ("*/"),
    WHITE_SPACE                                   (" "),

    CSL_EXTENSION                                 (".csl"),
    XML_EXTENSION                                 (".xml"),
    CF_EXTENSION                                  (".cf"),
    VF_EXTENSION                                  (".vf"),

    PP_OPTION_ON                                  ("on"),
    PP_OPTION_ONLY                                ("only"),
    // PP_OPTION_OFF                                 ("off"),

    VER_PLUS                                      ("+"),

    /* consts for argument key words
     */
    HELP_                                         ("--help"),
    DIR_                                          ("--dir"),
    CONFIG_FILE_                                  ("--config_file"),

    CSL_PRINT_IT_                                 ("--print_it"),
    CSL_PRINT_IT_FILENANME_                       ("--print_it_to"),
    CSL_PP_                                       ("--csl_pp"),
    CSL_PP_FILENAME_                              ("--csl_pp_filename"),
    CSL_CPP_GEN_                                  ("--cpp_gen"),
    CSL_CSIM_GEN_                                 ("--csim_gen"),
    CSL_VERILOG_TB_GEN_                           ("--verilog_tb_gen"),
    CSL_MAX_ERROR_                                ("--csl_max_error"),
    CSL_MAX_WARN_                                 ("--csl_max_warning"),
    CSL_I_                                        ("--I"),
    CSL_DEFINE_                                   ("--D"),
    CSL_VF_INCDIR_                                ("--vf_incdir+"),
    CSL_INCLUDE_VF_                               ("--include_vf"),
    CSL_INCLUDE_VERILOG_                          ("--include_verilog"),
    CSL_F_                                        ("--f"),

    VER_PP_                                       ("-verilog_pp"),
    VER_PP_FILENAME_                              ("-verilog_pp_filename"),
    VER_PRJ_                                      ("-prj"),
    VER_Y_                                        ("-y"),
    VER_V_                                        ("-v"),
    VER_DEFINE_                                   ("+define+"),
    VER_INCDIR_                                   ("+incdir+"),
    VER_LIBEXT_                                   ("+libext+"),
    VER_LIBNONAMEHIDE_                            ("+libnonamehide"),
    VER_LIBORDER_                                 ("+liborder"),
    VER_LIBRESCAN_                                ("+librescan"),
    VER_F_                                        ("-f")

#ifndef __RELEASE_VERSION
    ,
    INFO_                                         ("--info"),
    CSLOM_AST_                                    ("--cslom_ast"),
    EXEC_STAGE_                                   ("--exec_stage"),
    CDOM_AST_                                     ("-cdom_ast"),
    VEXEC_STAGE_                                  ("-exec_stage")
#endif
  {}


} // NSCLi
