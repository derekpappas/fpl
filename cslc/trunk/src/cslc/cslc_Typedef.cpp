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

#include "cslc_Typedef.h"
 
namespace NSCslc {


 CslcTool* CslcTool::pinstance = 0;// initialize pointer
  CslcTool* CslcTool::Instance() 
  {
    if (pinstance == 0)  // is it the first call?
    {  
      pinstance = new CslcTool; // create sole instance
    }
    return pinstance; // address of sole instance
  }

  CslcTool::CslcTool() :

#ifndef __RELEASE_VERSION
     IS_RELEASE (false),
#else
     IS_RELEASE (true),
#endif

  // *********************************************************************
  // CslcTool
  // *********************************************************************
  // *********************************************************************
  // consts
  // *********************************************************************
#ifndef __RELEASE_VERSION

    DISP_FILE                             ("File: "),
    DISP_STAGE                            ("---Stage "),
    DISP_BEGIN                            ("_begin"),
    DISP_END                              ("_end\n"),
    DISP_LINE                             ("\n------------------------------"),
    DISP_AST                              ("------AST_"),
    DISP_HEAD                             ("\t*** "),

    CSL_PP                                (" CSL_preprocessor"),
    CSL_L                                 (" CSL_lexer"),
    CSL_P                                 (" CSL_parser"),
    CSL_TW                                (" CSL_tree_walker"),
    CSL_IT                                (" CSL_instance_tree"),
    CSL_AM                                (" CSL_automapper"),
    CSL_AR                                (" CSL_autorouter"),
    CSL_CS_CK                             (" CSLOM_checker"),
    CSL_CC                                (" CSLOM_connection_checker"),
    CSL_CS_CG                             (" CSLOM_code_gen"),
    CSL_A                                 (" CSL_adapter"),
     // CSL_VTB                               (" CSLOM_verilogTbCodeGenerator"),
    CSL_CD_CK                             (" CDOM_checker"),
    CSL_CD_CG                             (" CDOM_code_generators"),

    VER_PP                                (" Verilog_preprocessor"),
    VER_L                                 (" Verilog_lexer"),
    VER_P                                 (" Verilog_parser"),
    VER_TW                                (" Verilog_tree_walker"),
    VER_CD_CK                             (" CDOM_checker"),
    VER_CD_CG                             (" CDOM_code_gen"),

    CG_PDF                                ("pdfcodegen"),
    CG_CPP                                ("cppcodegen"),
    CG_CSIM                               ("csimcodegen"),
    //CG_XML                                ("xmlcodegen"),
    CG_GUI_XML_GENERATOR                  ("xmlcodegen"),
    CG_GUI_CSL_GENERATOR                  ("cslcodegen"),
    CG_VERILOG_DEFINE                     ("verilogdefinecodegen"),
    CG_VERILOG                            ("verilogcodegen"),
    CG_VERILOGTB                          ("verilogtbcodegen"),
    CG_VERILOG_MEM                        ("verilogstimexpmem"),
    CG_VHDL                               ("vhdlcodegen"),
    CG_SYSC                               ("syscodegen"),
    CG_CSLGEN                             ("cslcodegen"),
    CG_SchemC                             ("schemcodegen"),
    
#endif

  CSL_AST_ID                            ("cslAST"),
  VER_AST_ID                            ("verilogAST"),

  CURRENT_DIR                           ("."),
  CHAR_START_DIR                        (NSCLi::CLiTool::Instance()->DIR_DELIMITER),
  END_GEN_DIR                           ("_cslc_generated"),
  END_VGEN_DIR                          ("cslc_generated"),
  DEFAULT_GEN_DIR                       (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "cslc_generated"),
  GEN_CODE_DIR                          (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "code"),
  GEN_DOCS_DIR                          (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "docs"),
  GEN_PDF_DIR                           (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "pdf"),
  GEN_CPP_DIR                           (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "cpp"),
  GEN_CSIM_DIR                          (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "csim"),
  GEN_CSIM_SUBDIR                       (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "generated"),
  //GEN_XML_DIR                           (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "xml"),
  GEN_GUI_XML_GENERATOR_DIR             (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "xml"),
  GEN_GUI_CSL_GENERATOR_DIR             (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "csl"),
  GEN_SYSC_DIR                          (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "systemC"),
  GEN_SchemC_DIR                        (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "schematicCode"),
  GEN_VER_DIR                           (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "verilog"),
  GEN_VHDL_DIR                          (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "vhdl"),
  GEN_CSL_DIR                           (NSCLi::CLiTool::Instance()->DIR_DELIMITER + "verilog")

  { }



} // NSCLi
