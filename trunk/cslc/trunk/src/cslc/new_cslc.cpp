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

#include "new_cslc.h"
 

namespace NSCslc {

  // *********************************************************************
  // CSLcSignal class
  // *********************************************************************
  CSLcSignal::CSLcSignal() throw() {
  }

  CSLcSignal::~CSLcSignal() throw() {
  }

  // *********************************************************************
  // CSLcMain class
  // *********************************************************************
  RefCSLcMain CSLcMain::m_instance = RefCSLcMain();

  CSLcMain::CSLcMain(std::ostream *const oStream) {
    ASSERT(oStream != NULL, INTERNAL_ERROR_NULL_REFERENCE);

    m_argList = NSCLi::CLiArgumentList::build();

    m_cslcMessages = CSLcMessages::getCSLcMessagesInstance(oStream);
  }


  // called at the end of the main to remove tmp files

  void CSLcMain::cleanUp( void ) {
    RefString f = m_argList->getCslPpFile();
    if (!f.get()) {
      deleteTempFile(m_cslOutputFile);  
    }

    f = m_argList->getVerilogPpFile();
    if (!f.get()) {
      deleteTempFile(m_verilogOutputFile);  
    }
  }

  CSLcMain::~CSLcMain() {
    delete CCSLOmAdapter::getInstance();

  }

  RefCSLcMain CSLcMain::getCompilerInstance(std::ostream *const oStream) {
    if (!m_instance.get()) {
      m_instance = RefCSLcMain(new CSLcMain(oStream));
    }

    return m_instance;
  }

  CslcTool::ECSLcError CSLcMain::runCompiler(TInt argc,
                                             TChar** argv,
                                             TInt cslcComponent) {

    try {

      /** set the type of the CSLC component to be run
       */
      m_cslcComponent = cslcComponent;

      /** set the seed for the pseudo-random std generator
       */
      std::srand(std::time(NULL));

      /** display the license agreement
       */
      m_cslcMessages->displayLicense();

      /** parse the given argument list
       */
      NSCLi::CLiTool::ECLiError argParse = m_argList->parseArgumentList(argc, argv);
      if (argParse == NSCLi::CLiTool::APARSE_HELP) {
        m_cslcMessages->display(NSCLi::CLiError::getHelp());

        return CslcTool::Instance()->ERR_NONE;
      }
      else if (argParse != NSCLi::CLiTool::APARSE_SUCCESS) {
        m_cslcMessages->display(NSCLi::CLiError::getError());
        return CslcTool::Instance()->ERR_ARG_PARSE;
      }
      else if (argParse == NSCLi::CLiTool::APARSE_SUCCESS) {
        m_cslcMessages->display(NSCLi::CLiError::getWarning());

        /** set the maximum number of errors/warnings 
         */
        TUInt cslMaxErrors = m_argList->getCslMaxErr();
        NSWarnError::CslWE::Instance()->setMaxErrors(cslMaxErrors);

        TUInt cslMaxWarnings = m_argList->getCslMaxWarn();
        NSWarnError::CslWE::Instance()->setMaxWarnings(cslMaxWarnings);

#     ifndef __RELEASE_VERSION
        m_displayInfo = m_argList->getDisplayInfo();
        m_displayCslomAst = m_argList->getDisplayCslomAst();
        m_displayCdomAst = m_argList->getDisplayCdomAst();
        m_execStage = m_argList->getExecStage();
        m_vExecStage = m_argList->getVExecStage();
#     endif

        /** run the CSL compiler
         */
        CslcTool::ECSLcError cslErr = runCslCompiler();
        if(cslErr != CslcTool::Instance()->ERR_NONE) {
          return cslErr;
        }

        /** run the Verilog compiler
         */
        CslcTool::ECSLcError verErr = runVerCompiler();
        if (verErr != CslcTool::Instance()->ERR_NONE) {
          return verErr;
        }

        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslReader(NSCSLOm::RefCSLOmDesign& cslomDesign, RefTVec_RefString& cslSourceFiles) {
    try {
      if (!cslSourceFiles->empty()) {
        /* CSL Preprocessor
         */
        CslcTool::ECSLcError ppErr = runCslPreprocessor(cslSourceFiles);
        //      CHECK_ERR(ppErr);
        if (ppErr != CslcTool::Instance()->ERR_NONE) {
          return ppErr;
        }

        if (m_cslPp != NSCLi::CLiTool::PP_ONLY) {
          DISPLAY_FILE(*m_cslOutputFile);

          //TODO: get rid of this garbage
          currentParsedFile.push(m_cslOutputFile->c_str());

          /** CSL Lexer
           */
          std::fstream inputFile;
          RefCslLexer cslLexer;
          CslcTool::ECSLcError lexerErr = runCslLexer(*m_cslOutputFile, inputFile, cslLexer);
          //CHECK_ERR(lexerErr);
          if (lexerErr != CslcTool::Instance()->ERR_NONE) {
            return lexerErr;
          }

          /** CSL Parser
           */
          RefCslParser cslParser;
          RefASTFactory cslASTFactory;
          antlr::RefAST cslAST;
          CslcTool::ECSLcError parserErr = runCslParser(cslLexer, cslParser, cslASTFactory, cslAST);
          //        CHECK_ERR(parserErr);
          if (parserErr != CslcTool::Instance()->ERR_NONE) {
            return parserErr;
          }

          /** CSL Tree Walker
           */
          CslcTool::ECSLcError twErr = runCslTreeWalker(cslASTFactory, cslAST, cslomDesign);
          //        CHECK_ERR(twErr);
          if (twErr != CslcTool::Instance()->ERR_NONE) {
            return twErr;
          }
        }
      }
      return CslcTool::Instance()->ERR_NONE;
    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

#ifndef __RELEASE_VERSION
  void CSLcMain::displayInfo(const std::string& str) {
    if (m_displayInfo) {
      m_cslcMessages->display(str);
    }
  }

  void CSLcMain::displayAST(const RefAST& ast,
                            const std::string& comp) {

    if (m_displayCslomAst
        || m_displayCdomAst) {

      if (!ast.get()) {
        return ;
      }

      displayInfo(CslcTool::Instance()->DISP_AST + comp + CslcTool::Instance()->DISP_BEGIN);

      std::string astStr = ast->toStringList();
      m_cslcMessages->display(astStr);

      displayInfo(CslcTool::Instance()->DISP_AST + comp + CslcTool::Instance()->DISP_END);
    }
  }
#else
  void displayInfo(const std::string& str) {
  }

  void displayAST(const RefAST& ast,
                            const std::string& comp) {

  }

#endif

  void CSLcMain::DISPLAY_FILE      (const std::string& _file                        ) { displayInfo(CslcTool::Instance()->DISP_FILE  + "\'" + _file + "\'" + CslcTool::Instance()->DISP_LINE); }
  void CSLcMain::DISPLAY_INFO_BEGIN(const TInt& _nr , const std::string& _msg) { displayInfo(CslcTool::Instance()->DISP_STAGE + intToString(_nr) + _msg + CslcTool::Instance()->DISP_BEGIN);}
  void CSLcMain::DISPLAY_INFO_END  (const TInt& _nr , const std::string& _msg) { displayInfo(CslcTool::Instance()->DISP_STAGE + intToString(_nr) + _msg + CslcTool::Instance()->DISP_END);}
  void CSLcMain::DISPLAY_AST       (antlr::RefAST&  _ast, const std::string& _msg) { displayAST(_ast, _msg);}
  void CSLcMain::DISPLAY_CGEN_BEGIN(const std::string& _msg                         ) { displayInfo(CslcTool::Instance()->DISP_HEAD  + _msg + CslcTool::Instance()->DISP_BEGIN);}
  void CSLcMain::DISPLAY_CGEN_END  (const std::string& _msg                         ) { displayInfo(CslcTool::Instance()->DISP_HEAD  + _msg + CslcTool::Instance()->DISP_END);}

  void CSLcMain::displayIT(const NSCInstTree::RefCInstTreeNode& cslITRoot) {
    RefString fileName = m_argList->getCslItFile();

    if (cslITRoot.get()) {
      if (fileName.get()) {
        //TODO: print to file
        RefCInstTreeTraversal cslITTraversal = RefCInstTreeTraversal(new NSCInstTreeVisitor::CInstTreeTraversal(fileName));
        cslITRoot->acceptVisitor(*cslITTraversal);
      }
      else if (m_argList->getCslPrintIt()) {
        RefCInstTreeTraversal cslITTraversal = RefCInstTreeTraversal(new NSCInstTreeVisitor::CInstTreeTraversal());
        cslITRoot->acceptVisitor(*cslITTraversal);
      }
    }
  }

  CslcTool::ECSLcError CSLcMain::createTempFile(RefString& fileName) {
    if (!fileName.get()) {
      RefString rsFile = NSCLi::CLiCommon::Instance()->generateRandomFileName();
      std::string file = *rsFile;
      if (file.empty()) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_TEMP_FILE_FAILURE);
        return CslcTool::Instance()->ERR_TEMP_FILE_FAILURE;
      }
      else {
        fileName = RefString(new std::string(file));
        return CslcTool::Instance()->ERR_NONE;
      }
    }
    else {
      return CslcTool::Instance()->ERR_NONE;
    }
  }

  CslcTool::ECSLcError CSLcMain::deleteTempFile(RefString& fileName) {
    if (fileName.get()) {
      NSCLi::CLiTool::ECLiFileStat result = NSCLi::CLiCommon::Instance()->deleteFile(*fileName); // FIX DEP memory leak problem!!!!
      if (result == NSCLi::CLiTool::FS_NOT_EXISTS) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_FILE_NOT_EXISTS, *fileName);
        return CslcTool::Instance()->ERR_FILE_NOT_EXISTS;
      }
      else if (result == NSCLi::CLiTool::FS_FAIL) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_BOOST_FILESYSYTEM, NSCLi::CLiCommon::Instance()->m_errorMessage.str());
        return CslcTool::Instance()->ERR_BOOST_FILESYSYTEM;
      }
      else if (result == NSCLi::CLiTool::FS_EXECUTE_WRITE_DENIED) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_EXECUTE_WRITE_PERMISSION_NEEDED, *fileName);
        return CslcTool::Instance()->ERR_EXECUTE_WRITE_PERMISSION_NEEDED;
      }
    }

    return CslcTool::Instance()->ERR_NONE;
  }

  CslcTool::ECSLcError CSLcMain::openInputStream(const RefString& fileName,
                                                 std::fstream*& input) {

    try {

      input = new std::fstream;
      NSCLi::CLiTool::ECLiFileStat result = NSCLi::CLiCommon::Instance()->openFile(*fileName, *input, std::ios::in | std::ios::binary);
      if (result == NSCLi::CLiTool::FS_READ_DENIED) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_READ_PERMISSION_NEEDED, *fileName);
        return CslcTool::Instance()->ERR_READ_PERMISSION_NEEDED;
      }
      else if (result == NSCLi::CLiTool::FS_FAIL) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_BOOST_FILESYSYTEM, NSCLi::CLiCommon::Instance()->m_errorMessage.str());
        return CslcTool::Instance()->ERR_BOOST_FILESYSYTEM;
      }
      else if (result == NSCLi::CLiTool::FS_COULD_NOT_OPEN) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE, *fileName);
        return CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE;
      }
      else {
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_BOOST_EXCEPTION(_e, *fileName)
      CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::openOutputStream(const RefString& fileName,
                                                  std::fstream* output) {

    try {

      NSCLi::CLiTool::ECLiFileStat result = NSCLi::CLiCommon::Instance()->openFile(*fileName, *output, std::ios::out);
      if (result == NSCLi::CLiTool::FS_WRITE_DENIED) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_WRITE_PERMISSION_NEEDED, *fileName);
        return CslcTool::Instance()->ERR_WRITE_PERMISSION_NEEDED;
      }
      else if (result == NSCLi::CLiTool::FS_FAIL) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_BOOST_FILESYSYTEM, NSCLi::CLiCommon::Instance()->m_errorMessage.str());
        return CslcTool::Instance()->ERR_BOOST_FILESYSYTEM;
      }
      else if (result == NSCLi::CLiTool::FS_EXECUTE_WRITE_DENIED) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_EXECUTE_WRITE_PERMISSION_NEEDED, *fileName);
        return CslcTool::Instance()->ERR_EXECUTE_WRITE_PERMISSION_NEEDED;
      }
      else if (result == NSCLi::CLiTool::FS_COULD_NOT_OPEN) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE, *fileName);
        return CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE;
      }
      else {
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_BOOST_EXCEPTION(_e, *fileName)
      CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::createDirectory(const RefString& rootPath) {

    try {

      ASSERT(rootPath.get(), INTERNAL_ERROR_NULL_REFERENCE);

      // DEP 2010-06-06     boost::filesystem::path fsPath(*rootPath, boost::filesystem::native);
      boost::filesystem::path fsPath(*rootPath);
      boost::filesystem::create_directory(fsPath);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_BOOST_EXCEPTION(_e, *rootPath)
      CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::createDirectory(const RefString& rootPath,
                                                 const std::string& dirName,
                                                 RefString& dirPath) {

    try {

      ASSERT(rootPath.get(), INTERNAL_ERROR_NULL_REFERENCE);
      ASSERT(!dirName.empty(), INTERNAL_ERROR_EMPTY_STRING);

      // DEP 2010-06-06 boost::filesystem::path fsRoot(*rootPath, boost::filesystem::native);
      boost::filesystem::path fsRoot(*rootPath);
      NSCLi::CLiTool::TAccessRights fileAccessRights;
      NSCLi::CLiTool::ECLiFileStat result = NSCLi::CLiCommon::Instance()->fileStat(fsRoot, fileAccessRights);
      if (result == NSCLi::CLiTool::FS_FAIL) {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_BOOST_FILESYSYTEM, NSCLi::CLiCommon::Instance()->m_errorMessage.str());
        return CslcTool::Instance()->ERR_BOOST_FILESYSYTEM;
      }
      else if (fileAccessRights & NSCLi::CLiTool::ACCESS_EXECUTE
               && fileAccessRights & NSCLi::CLiTool::ACCESS_WRITE) {

        std::string dir = ((*rootPath == NSCslc::CslcTool::Instance()->CHAR_START_DIR)
                           ? (dirName)
                           : (*rootPath + dirName));

        // DEP 2010-06-06        boost::filesystem::path fsPath(dir, boost::filesystem::native);
        boost::filesystem::path fsPath(dir);
        boost::filesystem::create_directory(fsPath);

        dirPath = RefString(new std::string(dir));

        return CslcTool::Instance()->ERR_NONE;
      }
      else {
        m_cslcMessages->displayError(CslcTool::Instance()->ERR_EXECUTE_WRITE_PERMISSION_NEEDED, *rootPath);
        return CslcTool::Instance()->ERR_EXECUTE_WRITE_PERMISSION_NEEDED;
      }
    
    }
    CATCH_BOOST_EXCEPTION(_e, *rootPath)
      CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runPdfGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                           const std::string& pdfPath) {

    try {

      //TODO:add PDF gen
      //     DISPLAY_CGEN_BEGIN(CG_PDF);

      //     RefCPDFGenerator pdfGen = RefCPDFGenerator(new NSCPDFGenerator::CPDFGenerator(pdfPath));
      //     cslomDesign->acceptVisitor(*pdfGen);

      //     DISPLAY_CGEN_END(CG_PDF);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCppGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                           const std::string& cppPath) {

    try {
      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_CPP);

      RefCCPPGenerator cppGen = RefCCPPGenerator(new NSCCPPGenerator::CCPPGenerator(cppPath));
      cslomDesign->acceptVisitor(*cppGen);

      DISPLAY_CGEN_END(CslcTool::Instance()->CG_CPP);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCSimGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                            const std::string& csimPath,
                                            const std::string& csimGenPath) {
    try {

      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_CSIM);

      RefCsimCppGenerator csimGen = RefCsimCppGenerator(new NSCsimCppGenerator::CsimCppGenerator(csimPath));
      RefString csimGenDir(new std::string(csimGenPath));
      csimGen->setGeneratePath(csimGenDir);
      cslomDesign->acceptVisitor(*csimGen);

      DISPLAY_CGEN_END(CslcTool::Instance()->CG_CSIM);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  /*CslcTool::ECSLcError CSLcMain::runXMLGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                           const std::string& xmlPath) {
    try {

      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_XML);

      RefCSLOmXmlGenerator xmlGen = RefCSLOmXmlGenerator(new NSCSLOmXmlGenerator::CSLOmXmlGenerator(xmlPath));
      cslomDesign->acceptVisitor(*xmlGen);

      DISPLAY_CGEN_END(CslcTool::Instance()->CG_XML);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }*/

  CslcTool::ECSLcError CSLcMain::runGuiXmlGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                                    const std::string& guiXmlGeneratorPath) {
    try {

      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_GUI_XML_GENERATOR);

      RefCSLOmGuiXmlGenerator guiXmlGenerator = RefCSLOmGuiXmlGenerator(new NSCSLOmGuiXmlGenerator::CSLOmGuiXmlGenerator(guiXmlGeneratorPath));
      cslomDesign->acceptVisitor(*guiXmlGenerator);

      DISPLAY_CGEN_END(CslcTool::Instance()->CG_GUI_XML_GENERATOR);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runGuiCslGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                                    const std::string& guiCslGeneratorPath) {
    try {

      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_GUI_CSL_GENERATOR);

      RefCSLOmGuiCslGenerator guiCslGenerator = RefCSLOmGuiCslGenerator(new NSCSLOmGuiCslGenerator::CSLOmGuiCslGenerator(guiCslGeneratorPath));
      cslomDesign->acceptVisitor(*guiCslGenerator);

      DISPLAY_CGEN_END(CslcTool::Instance()->CG_GUI_CSL_GENERATOR);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }


  CslcTool::ECSLcError CSLcMain::runVerilogDefineGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                                     const std::string& verilogDefinePath) {

    try {

      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_VERILOG_DEFINE);

      RefCVerilogDefineGenerator verDefGen = RefCVerilogDefineGenerator(new NSCVerilogDefineGenerator::CVerilogDefineGenerator(verilogDefinePath));

      verDefGen->enableObjTraversal();
      verDefGen->enableObjBeforeTraversal();
      verDefGen->enableObjAfterTraversal();
      verDefGen->enableObjInTraversal();
      cslomDesign->acceptVisitor(*verDefGen);

DISPLAY_CGEN_END(CslcTool::Instance()->CG_VERILOG_DEFINE);

      return CslcTool::Instance()->ERR_NONE;
    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }


//----MS added
  CslcTool::ECSLcError CSLcMain::runCslCdomVerilogStimExpMemory(const NSCdom::RefCDOmDesign& cdomDesign,
							        const std::string& verilogPath) {
    try {

	DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_VERILOG_MEM);

      RefCStimExpGenerator stimExpMemGen = RefCStimExpGenerator(new NSCdomStimExpGenerator::CStimExpGenerator(verilogPath));
      cdomDesign->acceptVisitor(*stimExpMemGen);
      run_tb_StimExpMemory(stimExpMemGen);

      // RefString cslVfInclude = m_argList->getVfIncdir();
      // verGen->setVfInclude(cslVfInclude);

      stimExpMemGen->enableObjTraversal();
      stimExpMemGen->enableObjBeforeTraversal();
      stimExpMemGen->enableObjAfterTraversal();
      stimExpMemGen->enableObjInTraversal();
      cdomDesign->acceptVisitor(*stimExpMemGen);

	DISPLAY_CGEN_END(CslcTool::Instance()->CG_VERILOG_MEM);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }
//------end

  CslcTool::ECSLcError CSLcMain::runVerilogGen(const NSCdom::RefCDOmDesign& cdomDesign,
                                               const std::string& verilogPath) {

    try {

	DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_VERILOG);

      RefCVerilogGenerator verGen = RefCVerilogGenerator(new NSCdomVerilogGenerator::CVerilogGenerator(verilogPath));

      RefString cslVfInclude = m_argList->getVfIncdir();
      verGen->setVfInclude(cslVfInclude);

      verGen->enableObjTraversal();
      verGen->enableObjBeforeTraversal();
      verGen->enableObjAfterTraversal();
      verGen->enableObjInTraversal();
      cdomDesign->acceptVisitor(*verGen);

	DISPLAY_CGEN_END(CslcTool::Instance()->CG_VERILOG);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runVHDLGen(const NSCdom::RefCDOmDesign& cdomDesign,
                                            const std::string& vhdlPath) {

    try {

	DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_VHDL);

      RefCVHDLGenerator vhdlGen(new NSCdomVHDLGenerator::CVHDLGenerator(vhdlPath));
      cdomDesign->acceptVisitor(*vhdlGen);

	DISPLAY_CGEN_END(CslcTool::Instance()->CG_VHDL);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }
  //----OB added another param
  CslcTool::ECSLcError CSLcMain::runSysCGen(const NSCdom::RefCDOmDesign& cdomDesign,
					    const std::string& sysCPath) {
    try {


      //TODO: add sysC gen
	DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_SYSC);
      //----OB added body---start
      RefCSystemCGenerator scGen = RefCSystemCGenerator(new NSCdomSystemCGenerator::CSystemCGenerator(sysCPath));

      scGen->enableObjTraversal();
      scGen->enableObjBeforeTraversal();
      scGen->enableObjAfterTraversal();
      scGen->enableObjInTraversal();
      cdomDesign->acceptVisitor(*scGen);
      //------end

	DISPLAY_CGEN_END(CslcTool::Instance()->CG_SYSC);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }


//----OB added
  CslcTool::ECSLcError CSLcMain::runSchemCGen(const NSCdom::RefCDOmDesign& cdomDesign,
					    const std::string& schemCPath) {
    try {

	DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_SchemC);

      //RefCSchematicCodeGenerator schemGen = RefCSchematicCodeGenerator(new  NSCdomSchematicCodeGenerator::CSchematicCodeGenerator(schemCPath));
      RefCSchematicCodeGenerator schemGen = RefCSchematicCodeGenerator(new NSCdomSchematicCodeGenerator::CSchematicCodeGenerator(schemCPath));


      schemGen->enableObjTraversal();
      schemGen->enableObjBeforeTraversal();
      schemGen->enableObjAfterTraversal();
      schemGen->enableObjInTraversal();
      cdomDesign->acceptVisitor(*schemGen);

	DISPLAY_CGEN_END(CslcTool::Instance()->CG_SchemC);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }
      //------end

  CslcTool::ECSLcError CSLcMain::runCdomChecker(const NSCdom::RefCDOmDesign& cdomDesign) {
    try {

      ASSERT(cdomDesign.get(), INTERNAL_ERROR_NULL_REFERENCE);

      RefCDOmChecker cdomCk = RefCDOmChecker(new NSCdomChecker::CDOmChecker());
      cdomCk->enableObjTraversal();
      cdomCk->enableObjBeforeTraversal();
      cdomCk->enableObjAfterTraversal();
      cdomCk->enableObjInTraversal();
      cdomDesign->acceptVisitor(*cdomCk);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCdomCodeGens(const NSCdom::RefCDOmDesign& cdomDesign,
                                                 const std::string& sysCPath,
						 const std::string& schemCPath,
                                                 const std::string& verilogPath,
                                                 const std::string& vhdlPath) {

    try {

      /** Verilog StimExpMemory Code Generator
       */
      CslcTool::ECSLcError stimExpMemErr = runCslCdomVerilogStimExpMemory(cdomDesign, verilogPath);
      //      CHECK_ERR(stimExpMemErr);
      if (stimExpMemErr != CslcTool::Instance()->ERR_NONE) { 
        return stimExpMemErr;
      }

      /** Verilog Code Generator
       */
      CslcTool::ECSLcError verErr = runVerilogGen(cdomDesign, verilogPath);
      //      CHECK_ERR(verErr);
      if (verErr != CslcTool::Instance()->ERR_NONE) { 
        return verErr;
      }
       
      /** VHDL Code Generator
       */
      CslcTool::ECSLcError vhdlErr = runVHDLGen(cdomDesign, vhdlPath);
      //      CHECK_ERR(vhdlErr);
      if (vhdlErr != CslcTool::Instance()->ERR_NONE) { 
        return vhdlErr;
      }
  
      /** System C Code Generator
       */
      CslcTool::ECSLcError sysCErr = runSysCGen(cdomDesign, sysCPath);
      //      CHECK_ERR(sysCErr);
      if (sysCErr != CslcTool::Instance()->ERR_NONE) {
        return sysCErr;
      }

// FIX Boost assert      /** Schematic Code Generator
// FIX Boost assert       */
// FIX Boost assert      CslcTool::ECSLcError schemCErr = CslcTool::Instance()->ERR_NONE;
// FIX Boost assert      // DEP there is a Boost pointer assert!!!
// FIX Boost assert	     schemCErr = runSchemCGen(cdomDesign, schemCPath);
// FIX Boost assert      //      CHECK_ERR(schemCErr);
// FIX Boost assert      if (schemCErr != CslcTool::Instance()->ERR_NONE) {
// FIX Boost assert        return schemCErr;
// FIX Boost assert      }

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }


  /*  CslcTool::ECSLcError CSLcMain::runCdomChecker(const NSCdom::RefCDOmDesign& cdomDesign) {
    try {

      ASSERT(cdomDesign.get(), INTERNAL_ERROR_NULL_REFERENCE);

      RefCDOmChecker cdomCk = RefCDOmChecker(new NSCdomChecker::CDOmChecker());
      cdomCk->enableObjTraversal();
      cdomCk->enableObjBeforeTraversal();
      cdomCk->enableObjAfterTraversal();
      cdomCk->enableObjInTraversal();
      cdomDesign->acceptVisitor(*cdomCk);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
    }*/


  CslcTool::ECSLcError CSLcMain::runCslPreprocessor(const RefTVec_RefString& cslSourceFiles) {
    try {

	     DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_PREPROCESSOR, NSCslc::CslcTool::Instance()->CSL_PP);

      /* Create temporary file name
       */
      m_cslOutputFile = m_argList->getCslPpFile();
      CslcTool::ECSLcError err = createTempFile(m_cslOutputFile);
      //    CHECK_ERR(err);
      if (err != CslcTool::Instance()->ERR_NONE) {
        return err;
      }

      /* Open the output stream for passing it to the preprocessor
       */
      std::fstream output;
      err = openOutputStream(m_cslOutputFile, &output);
      //    CHECK_ERR(err);
      if (err != CslcTool::Instance()->ERR_NONE) {
        return err;
      }

      /* Create list of input files for preprocessing
       */
      std::fstream* fileStream;
      NSPreproc::RefTVec_RefPpFile ppSourceFiles(new NSPreproc::TVec_RefPpFile());

      for (TVec_RefString_const_iter sourceFile = cslSourceFiles->begin();
           sourceFile != cslSourceFiles->end();
           ++sourceFile) {

        err = openInputStream(*sourceFile, fileStream);
        //      CHECK_ERR(err);
        if (err != CslcTool::Instance()->ERR_NONE) {
          return err;
        }

        NSPreproc::RefPpFile ppSrcFile = NSPreproc::PpFile::build(NSPreproc::PP_FLOW_CSL, *sourceFile, fileStream);
        ppSourceFiles->push_back(ppSrcFile);

      }

      /* Run the preprocessor
       */
      NSPreproc::RefCSLcPreprocessor pp(new NSPreproc::CSLcPreprocessor(&output, ppSourceFiles));
      pp->runPreprocessor();

      //TODO: finish and add new PP somewhere in the future
      //     std::fstream* sourceStream;
      //     NSCSLcPP::RefTVec_RefCSLcPpFile ppFiles(new NSCSLcPP::TVec_RefCSLcPpFile());

      //     for (NSCSLOm::TVec_RefString_const_iter sourceFile = cslSourceFiles->begin();
      //          sourceFile != cslSourceFiles->end();
      //          ++sourceFile) {

      //       err = openInputStream(*sourceFile, sourceStream);
      //       CHECK_ERR(err);
      //      if (err != CslcTool::Instance()->ERR_NONE) {
      //        return err;
      //      }

      //       NSCSLcPP::RefCSLcPpFile ppFile = NSCSLcPP::CSLcPpFile::build(sourceStream, *sourceFile);
      //       ppFiles->push_back(ppFile);
      //     }

      //     RefTVec_RefString includeDirectories = m_argList->getCslIncludeDirectories();
      //     RefTVec_RefString macroDefinitions = m_argList->getCslMacroDefinitions();
      //     NSCSLcPP::RefCSLcPp cslcPp(new NSCSLcPP::CSLcPp(NSCSLcPP::PPFL_CSL, &output, includeDirectories, macroDefinitions));
      //     cslcPp->runCSLcPp(ppFiles);

	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_PREPROCESSOR, NSCslc::CslcTool::Instance()->CSL_PP);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslLexer(const std::string& cslFile,
                                             std::fstream& inputFile,
                                             RefCslLexer& cslLexer) {

    try {
      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_LEXER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_LEXER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_LEXER, NSCslc::CslcTool::Instance()->CSL_L);

        NSCLi::CLiTool::ECLiFileStat result = NSCLi::CLiCommon::Instance()->openFile(cslFile, inputFile, std::ios::in);
        if (result == NSCLi::CLiTool::FS_READ_DENIED) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_READ_PERMISSION_NEEDED, cslFile);
          return CslcTool::Instance()->ERR_READ_PERMISSION_NEEDED;
        }
        else if (result == NSCLi::CLiTool::FS_COULD_NOT_OPEN) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE, cslFile);
          return CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE;
        }
        else {
          cslLexer = RefCslLexer(new CslLexer(inputFile));
          cslLexer->setFilename(cslFile);
          cslLexer->setTokenObjectFactory(&CslToken::factory);
      
    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_LEXER, NSCslc::CslcTool::Instance()->CSL_L);
      
          return CslcTool::Instance()->ERR_NONE;
        }
        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_LEXER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslParser(const RefCslLexer& cslLexer,
                                              RefCslParser& cslParser,
                                              RefASTFactory& cslASTFactory,
                                              antlr::RefAST& cslAST) {

    try {
      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_PARSER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_PARSER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_PARSER, NSCslc::CslcTool::Instance()->CSL_P);

        ASSERT(cslLexer.get(), INTERNAL_ERROR_NULL_REFERENCE);

        cslParser = RefCslParser(new CslParser(*cslLexer));
 
        std::string cslFile = cslLexer->getFilename();
        cslParser->setFilename(cslFile);


        //      const char * cslAstId = CslcTool::Instance()->CSL_AST_ID.c_str();
        const char * const cslAstId = "cslAST";

        cslASTFactory = RefASTFactory(new ASTFactory(cslAstId, CslAST::factory));
        cslParser->initializeASTFactory(*cslASTFactory);
        cslParser->setASTFactory(cslASTFactory.get());

        cslParser->select_components(m_cslcComponent);

        cslParser->source_text();

        cslAST = cslParser->getAST();

        if (cslParserHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {
 
    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_PARSER, NSCslc::CslcTool::Instance()->CSL_P);
          DISPLAY_AST(cslAST, "CSL");

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_PARSER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);

  }

  CslcTool::ECSLcError CSLcMain::runCslTreeWalker(const RefASTFactory& cslASTFactory,
                                                  const antlr::RefAST& cslAST,
                                                  NSCSLOm::RefCSLOmDesign& cslomDesign) {
    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_TREE_WALKER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_TREE_WALKER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_TREE_WALKER, NSCslc::CslcTool::Instance()->CSL_TW);

        ASSERT(cslASTFactory.get(), INTERNAL_ERROR_NULL_REFERENCE);

        RefCslTreeWalker cslTW = RefCslTreeWalker(new CslTreeWalker());
        cslTW->initializeASTFactory(*cslASTFactory);
        cslTW->setASTFactory(cslASTFactory.get());

        RefTVec_RefString vCurrentScope = RefTVec_RefString(new TVec_RefString());
        cslTW->source_text(RefCslAST(cslAST), cslomDesign, vCurrentScope);

        if (cslomHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_TREE_WALKER, NSCslc::CslcTool::Instance()->CSL_TW);

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_TREE_WALKER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);

  }

  CslcTool::ECSLcError CSLcMain::runCslInstanceTree(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                                    NSCInstTree::RefCInstTreeNode& cslITRoot) {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_INST_TREE) {
        //   IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_INST_TREE)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_INST_TREE, NSCslc::CslcTool::Instance()->CSL_IT);

        ASSERT(cslomDesign.get(), INTERNAL_ERROR_NULL_REFERENCE);

        NSCInstTree::RefCInstTreeCreator cslIT = NSCInstTree::RefCInstTreeCreator(new NSCInstTree::CInstTreeCreator());
        cslomDesign->acceptVisitor(*cslIT);
        cslITRoot = cslIT->getRoot();

        if (instTreeHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {
          displayIT(cslITRoot);

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_INST_TREE, NSCslc::CslcTool::Instance()->CSL_IT);

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_INST_TREE){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);

  }

  CslcTool::ECSLcError CSLcMain::runCslAutomapper() {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_AUTOMAPPER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_AUTOMAPPER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_AUTOMAPPER, NSCslc::CslcTool::Instance()->CSL_AM);

        //TODO: add automapper

  	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_AUTOMAPPER, NSCslc::CslcTool::Instance()->CSL_AM);

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_AUTOMAPPER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslAutorouter() {
    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_AUTOROUTER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_AUTOROUTER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_AUTOROUTER, NSCslc::CslcTool::Instance()->CSL_AR);

        NSAutorouter::CAutorouter::startAutoRouter();

        if (m_arHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_AUTOROUTER, NSCslc::CslcTool::Instance()->CSL_AR);

          return CslcTool::Instance()->ERR_NONE;
        }

        //      IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_AUTOROUTER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslomChecker(const NSCSLOm::RefCSLOmDesign& cslomDesign) {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CSLOM_CHECKER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CHECKER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CHECKER, NSCslc::CslcTool::Instance()->CSL_CS_CK);

        ASSERT(cslomDesign.get(), INTERNAL_ERROR_MSG << "NULL refernce");

        RefCSLOmDesignChecker cslomCk = RefCSLOmDesignChecker(new NSCSLOmDesignChecker::CSLOmDesignChecker());
        cslomCk->enableObjTraversal();
        cslomCk->enableObjBeforeTraversal();
        cslomCk->enableObjAfterTraversal();
        cslomCk->enableObjInTraversal();
        cslomDesign->acceptVisitor(*cslomCk);

        if (checkerHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CHECKER, NSCslc::CslcTool::Instance()->CSL_CS_CK);
  
          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CSLOM_CHECKER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);

  }

  CslcTool::ECSLcError CSLcMain::runCslConnectionChecker(const NSCInstTree::RefCInstTreeNode& cslITRoot) {
    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CONNECTION_CHECKER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CONNECTION_CHECKER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CONNECTION_CHECKER, NSCslc::CslcTool::Instance()->CSL_CC);

        RefCInstTreeTraversal cslITTraversal = RefCInstTreeTraversal(new NSCInstTreeVisitor::ConnectionChecker());
        if (cslITRoot.get()) {
          cslITRoot->acceptVisitor(*cslITTraversal);
        }

        if (ccHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_CONNECTION_CHECKER, NSCslc::CslcTool::Instance()->CSL_CC);

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CONNECTION_CHECKER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::createCslDirectories() {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS)

        RefString rootPath = m_argList->getOutputDirectory();
        TBool mustCreate = m_argList->getMustCreateOutputDirectory();
        if (!rootPath.get()) {
          rootPath = RefString(new std::string(CslcTool::Instance()->CURRENT_DIR));
        }
        else if (mustCreate) {
          CslcTool::ECSLcError dirErr = createDirectory(rootPath);
          //        CHECK_ERR(dirErr);
          if (dirErr != CslcTool::Instance()->ERR_NONE) {
            return dirErr;
          }
        }

        std::string dirName;
        if (cslTopUnitName.get()) {
          dirName = CslcTool::Instance()->CHAR_START_DIR + *cslTopUnitName + CslcTool::Instance()->END_GEN_DIR;
        }
        else {
          dirName = CslcTool::Instance()->DEFAULT_GEN_DIR;
        }

        RefString cslDir;
        CslcTool::ECSLcError dirErr = createDirectory(rootPath, dirName, cslDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }

        RefString genDocs;
        dirErr = createDirectory(cslDir, CslcTool::Instance()->GEN_DOCS_DIR, genDocs);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genDocs, CslcTool::Instance()->GEN_PDF_DIR, m_cslPdfDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        RefString genCode;
        dirErr = createDirectory(cslDir, CslcTool::Instance()->GEN_CODE_DIR, genCode);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_CPP_DIR, m_cslCppDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode,CslcTool::Instance()->GEN_CSIM_DIR, m_cslCSimDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(m_cslCSimDir, CslcTool::Instance()->GEN_CSIM_SUBDIR, m_cslCSimGenDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        //dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_XML_DIR, m_cslXMLDir);
        //      CHECK_ERR(dirErr);
        //if (dirErr != CslcTool::Instance()->ERR_NONE) {
        //  return dirErr;
        //}


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_GUI_XML_GENERATOR_DIR, m_cslGuiXmlGeneratorDir);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_GUI_CSL_GENERATOR_DIR, m_cslGuiCslGeneratorDir);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_SYSC_DIR, m_cslSysCDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }

        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_SchemC_DIR, m_cslSchemCDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_VER_DIR, m_cslVerilogDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_VHDL_DIR, m_cslVhdlDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }

	dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_CSL_DIR, m_cslCslDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslomCodeGens(const NSCSLOm::RefCSLOmDesign& cslomDesign) {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS, CslcTool::Instance()->CSL_CS_CG);

        ASSERT(m_cslPdfDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslCppDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslCSimDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslCSimGenDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        //ASSERT(m_cslXMLDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslGuiXmlGeneratorDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslGuiCslGeneratorDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslVerilogDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
	ASSERT(m_cslCslDir.get(), INTERNAL_ERROR_NULL_REFERENCE);

        /** PDF code generator
         */

        RefString rsPdfPath = NSCLi::CLiCommon::Instance()->completePath(m_cslPdfDir);
        std::string pdfPath = *rsPdfPath;

        CslcTool::ECSLcError pdfErr = runPdfGen(cslomDesign, pdfPath);
        //      CHECK_ERR(pdfErr);
        if (pdfErr != CslcTool::Instance()->ERR_NONE) {
          return pdfErr;
        }

        /** CPP code generator
         */
        if (m_argList->getCppGen()) {
          RefString rsCppPath = NSCLi::CLiCommon::Instance()->completePath(m_cslCppDir);
          std::string cppPath = *rsCppPath;

          CslcTool::ECSLcError cppErr = runCppGen(cslomDesign, cppPath);
          //        CHECK_ERR(cppErr);
          if (cppErr != CslcTool::Instance()->ERR_NONE) {
            return cppErr;
          }
        }

        /** CSIM code generator
         */
        if (m_argList->getCsimGen()) {
          RefString rsCsimPath = NSCLi::CLiCommon::Instance()->completePath(m_cslCSimDir);
          std::string csimPath = *rsCsimPath;

          RefString rsCsimGenPath = NSCLi::CLiCommon::Instance()->completePath(m_cslCSimGenDir);
          std::string csimGenPath = *rsCsimGenPath; 

          CslcTool::ECSLcError csimErr = runCSimGen(cslomDesign, csimPath, csimGenPath);
          //        CHECK_ERR(csimErr);
          if (csimErr != CslcTool::Instance()->ERR_NONE) {
            return csimErr;
          }
        }

        /** XML code generator
         */
        //RefString rsXmlPath = NSCLi::CLiCommon::Instance()->completePath(m_cslXMLDir);
        //std::string xmlPath = *rsXmlPath;
        //CslcTool::ECSLcError xmlErr = runXMLGen(cslomDesign, xmlPath);
        //      CHECK_ERR(xmlErr);
        //if (xmlErr != CslcTool::Instance()->ERR_NONE) {
        //  return xmlErr;
        //}

        /** GUI XML generator
         */
        RefString rsGuiXmlGeneratorPath = NSCLi::CLiCommon::Instance()->completePath(m_cslGuiXmlGeneratorDir);
        std::string guiXmlGeneratorPath = *rsGuiXmlGeneratorPath;
        CslcTool::ECSLcError guiXmlGeneratorErr = runGuiXmlGenerator(cslomDesign, guiXmlGeneratorPath);
        if (guiXmlGeneratorErr != CslcTool::Instance()->ERR_NONE) {
          return guiXmlGeneratorErr;
        }

        /** GUI CSL generator
         */
        RefString rsGuiCslGeneratorPath = NSCLi::CLiCommon::Instance()->completePath(m_cslGuiCslGeneratorDir);
        std::string guiCslGeneratorPath = *rsGuiCslGeneratorPath;
        CslcTool::ECSLcError guiCslGeneratorErr = runGuiCslGenerator(cslomDesign, guiCslGeneratorPath);
        if (guiCslGeneratorErr != CslcTool::Instance()->ERR_NONE) {
          return guiCslGeneratorErr;
        }


        /** verilog Define code generator
         */
        RefString rsVerilogDefinePath = NSCLi::CLiCommon::Instance()->completePath(m_cslVerilogDir);
        std::string verilogDefinePath = *rsVerilogDefinePath;
        CslcTool::ECSLcError verDefErr = runVerilogDefineGen(cslomDesign, verilogDefinePath);
        //      CHECK_ERR(verDefErr);
        if (verDefErr != CslcTool::Instance()->ERR_NONE) {
          return verDefErr;
        }


	/** CSL CSLOM_VerilogTbCodeGenerator
         */
	RefString rsVerilogPath = NSCLi::CLiCommon::Instance()->completePath(m_cslVerilogDir);
        std::string verilogPath = *rsVerilogPath;
        CslcTool::ECSLcError vtcgErr = runCslCSLOM_VerilogTbCodeGenerator(cslomDesign,verilogPath);
        //        CHECK_ERR(vtcgErr);
        if (vtcgErr != CslcTool::Instance()->ERR_NONE) {
          return vtcgErr;
        }

	/** CSL CSLOM_CslCodeGenerator
         */
	RefString rsCslPath = NSCLi::CLiCommon::Instance()->completePath(m_cslCslDir);
        std::string cslPath = *rsCslPath;
        CslcTool::ECSLcError cslGenErr = runCslCSLOM_CslCodeGenerator(cslomDesign,cslPath);
        //        CHECK_ERR(vtcgErr);
        if (cslGenErr != CslcTool::Instance()->ERR_NONE) {
          return cslGenErr;
        }


	//	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS, CslcTool::Instance()->CSL_CS_CG);

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }
  CslcTool::ECSLcError CSLcMain::runCslCSLOM_VerilogTbCodeGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign ,
								    const std::string& verilogPath) {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS) {

      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_VERILOGTB);

      RefCVerilogTbGenerator cslCSLOM_VerilogTbCodeGenerator = RefCVerilogTbGenerator(new NSCSLOmVerilogTbGenerator::CSLOmVerilogTbGenerator(verilogPath));
      cslomDesign->acceptVisitor(*cslCSLOM_VerilogTbCodeGenerator);

     
      run_tb_testbench(cslCSLOM_VerilogTbCodeGenerator);

      DISPLAY_CGEN_END(CslcTool::Instance()->CG_VERILOGTB);

	  //      return CslcTool::Instance()->ERR_NONE;

//
//  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_VERILOG_TB, CslcTool::Instance()->CSL_VTB);
//
//        ASSERT(cslomDesign.get(), INTERNAL_ERROR_NULL_REFERENCE);
//
//        cdomDesign = NSCdom::CDOmDesign::build();
//		RefCVerilogTbGenerator cslCSLOM_VerilogTbCodeGenerator = RefCVerilogTbGenerator(new NSCSLOmVerilogTbGenerator::CVerilogTbGenerator());
//		 cslomDesign->acceptVisitor(*cslCSLOM_VerilogTbCodeGenerator);
//		 cdomDesign = cslCSLOM_VerilogTbCodeGenerator->getProduct();


        if (cdomHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS, CslcTool::Instance()->CSL_CS_CG);

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
    }

  CslcTool::ECSLcError CSLcMain::runCslCSLOM_CslCodeGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign ,
								    const std::string& cslPath) {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS) {

      DISPLAY_CGEN_BEGIN(CslcTool::Instance()->CG_CSLGEN);

      RefCCslCodeGenerator cslCSLOM_CslCodeGenerator = RefCCslCodeGenerator(new NSCSLOmCslCodeGenerator::CSLOmCslCodeGenerator(cslPath));
      cslomDesign->acceptVisitor(*cslCSLOM_CslCodeGenerator);

      //run_csl_generator(cslCSLOM_CslCodeGenerator);

      DISPLAY_CGEN_END(CslcTool::Instance()->CG_CSLGEN);


        if (cdomHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS, CslcTool::Instance()->CSL_CS_CG);

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CSLOM_CODE_GENS){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
    }

  CslcTool::ECSLcError CSLcMain::runCslAdapter(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                               NSCdom::RefCDOmDesign& cdomDesign) {

    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_ADAPTER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_ADAPTER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_ADAPTER, CslcTool::Instance()->CSL_A);

        ASSERT(cslomDesign.get(), INTERNAL_ERROR_NULL_REFERENCE);

        cdomDesign = NSCdom::CDOmDesign::build();
        RefCAdapterToCDOM cslAdapter = RefCAdapterToCDOM(new NSAdapter::CAdapterToCDOM(cdomDesign));
        cslomDesign->acceptVisitor(*cslAdapter);
        cdomDesign = cslAdapter->getProduct();


        if (cdomHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_CSL);
          return CslcTool::Instance()->ERR_CSL;
        }
        else {

    	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_ADAPTER, CslcTool::Instance()->CSL_A);

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_ADAPTER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

   
  CslcTool::ECSLcError CSLcMain::runCslCdomChecker(const NSCdom::RefCDOmDesign& cdomDesign) {
    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CDOM_CHECKER) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CDOM_CHECKER)
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CDOM_CHECKER, CslcTool::Instance()->CSL_CD_CK);

        runCdomChecker(cdomDesign);

  	DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_CDOM_CHECKER, CslcTool::Instance()->CSL_CD_CK);

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CDOM_CHECKER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslCdomCodeGens(const NSCdom::RefCDOmDesign& cdomDesign) {
    try {

      if (CslcTool::Instance()->isRelease() || m_execStage >= NSCLi::CLiTool::EXEC_STAGE_CDOM_CODE_GENS) {
        //    IF_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CDOM_CODE_GENS)
        DISPLAY_INFO_BEGIN(NSCLi::CLiTool::EXEC_STAGE_CDOM_CODE_GENS, CslcTool::Instance()->CSL_CD_CG);

        ASSERT(m_cslSysCDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslSchemCDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslVerilogDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_cslVhdlDir.get(), INTERNAL_ERROR_NULL_REFERENCE);

        RefString rsSysCPath = NSCLi::CLiCommon::Instance()->completePath(m_cslSysCDir);
        std::string sysCPath = *rsSysCPath;

        RefString rsSchemCPath = NSCLi::CLiCommon::Instance()->completePath(m_cslSchemCDir);
        std::string schemCPath = *rsSchemCPath;

        RefString rsVerilogPath = NSCLi::CLiCommon::Instance()->completePath(m_cslVerilogDir);
        std::string verilogPath = *rsVerilogPath;

        RefString rsVhdlPath = NSCLi::CLiCommon::Instance()->completePath(m_cslVhdlDir);
        std::string vhdlPath = *rsVhdlPath;

        CslcTool::ECSLcError cgErr = runCdomCodeGens(cdomDesign, sysCPath, schemCPath, verilogPath, vhdlPath);
        //      CHECK_ERR(cgErr);
        if (cgErr != CslcTool::Instance()->ERR_NONE) {
          return cgErr;
        }

        DISPLAY_INFO_END(NSCLi::CLiTool::EXEC_STAGE_CDOM_CODE_GENS, CslcTool::Instance()->CSL_CD_CG);

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_execStage < NSCLi::CLiTool::EXEC_STAGE_CDOM_CODE_GENS){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runCslCompiler() {
    try {

      /** get the CSL source files
       */
      RefTVec_RefString cslSourceFiles = m_argList->getCslSourceFiles();
      if (!cslSourceFiles->empty()) {
        m_cslPp = m_argList->getCslPp();

        NSCSLOm::RefCSLOmDesign cslomDesign = NSCSLOm::CSLOmDesign::build();
        NSCdom::RefCDOmDesign cdomDesign;

        /* CSL Preprocessor
         */
        CslcTool::ECSLcError ppErr = runCslPreprocessor(cslSourceFiles);
        //      CHECK_ERR(ppErr);
        if (ppErr != CslcTool::Instance()->ERR_NONE) {
          return ppErr;
        }

        if (m_cslPp != NSCLi::CLiTool::PP_ONLY) {
          DISPLAY_FILE(*m_cslOutputFile);

          //TODO: get rid of this garbage
          currentParsedFile.push(m_cslOutputFile->c_str());

          /** CSL Lexer
           */
          std::fstream inputFile;
          RefCslLexer cslLexer;
          CslcTool::ECSLcError lexerErr = runCslLexer(*m_cslOutputFile, inputFile, cslLexer);
          //CHECK_ERR(lexerErr);
          if (lexerErr != CslcTool::Instance()->ERR_NONE) {
            return lexerErr;
          }

          /** CSL Parser
           */
          RefCslParser cslParser;
          RefASTFactory cslASTFactory;
          antlr::RefAST cslAST;
          CslcTool::ECSLcError parserErr = runCslParser(cslLexer, cslParser, cslASTFactory, cslAST);
          //        CHECK_ERR(parserErr);
          if (parserErr != CslcTool::Instance()->ERR_NONE) {
            return parserErr;
          }

          /** CSL Tree Walker
           */
          CslcTool::ECSLcError twErr = runCslTreeWalker(cslASTFactory, cslAST, cslomDesign);
          //        CHECK_ERR(twErr);
          if (twErr != CslcTool::Instance()->ERR_NONE) {
            return twErr;
          }

          //TODO: get rid of this garbage
          currentParsedFile.pop();

          /** CSL Instance Tree
           */
          NSCInstTree::RefCInstTreeNode cslITRoot;
          CslcTool::ECSLcError itErr = runCslInstanceTree(cslomDesign, cslITRoot);
          // CHECK_ERR(itErr);
          if (itErr != CslcTool::Instance()->ERR_NONE) {
            return itErr;
          }

          /** CSL Autorouter
           */
          CslcTool::ECSLcError arErr = runCslAutorouter();
          //        CHECK_ERR(arErr);
          if (arErr != CslcTool::Instance()->ERR_NONE) {
            return arErr;
          }

          /** CSL Automapper
           */
          CslcTool::ECSLcError amErr = runCslAutomapper();
          //        CHECK_ERR(amErr);
          if (amErr != CslcTool::Instance()->ERR_NONE) {
            return amErr;
          }

          /** CSLOM Checker
           */
          CslcTool::ECSLcError ccErr = runCslomChecker(cslomDesign);
          //        CHECK_ERR(ccErr);
          if (ccErr != CslcTool::Instance()->ERR_NONE) {
            return ccErr;
          }

          /** CSLOM Connection Checker
           */
          CslcTool::ECSLcError cccErr = runCslConnectionChecker(cslITRoot);
          //        CHECK_ERR(cccErr);
          if (cccErr != CslcTool::Instance()->ERR_NONE) {
            return cccErr;
          }
          /** create dirs
           */
          CslcTool::ECSLcError dirErr = createCslDirectories();
          //      CHECK_ERR(dirErr);
          if (dirErr != CslcTool::Instance()->ERR_NONE) {
            return dirErr;
          }

          /** CSLOM Code Generators
           */
          CslcTool::ECSLcError csErr = runCslomCodeGens(cslomDesign);
          //        CHECK_ERR(csErr);
          if (csErr != CslcTool::Instance()->ERR_NONE) {
            return csErr;
          }

          /** CSL Adapter
           */
          CslcTool::ECSLcError adapterErr = runCslAdapter(cslomDesign, cdomDesign);
          //        CHECK_ERR(adapterErr);
          if (adapterErr != CslcTool::Instance()->ERR_NONE) {
            return adapterErr;
          }

	 
          /** CDOM Checker
           */
          CslcTool::ECSLcError cdErr = runCslCdomChecker(cdomDesign);
          //        CHECK_ERR(cdErr);
          if (cdErr != CslcTool::Instance()->ERR_NONE) {
            return cdErr;
          }

          /** CDOM Code Generators
           */
          CslcTool::ECSLcError cgErr = runCslCdomCodeGens(cdomDesign);
          //        CHECK_ERR(cgErr);
          if (cgErr != CslcTool::Instance()->ERR_NONE) {
            return cgErr;
          }
        }
      }
      return CslcTool::Instance()->ERR_NONE;
    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runVerPreprocessor(const RefTVec_RefString& verilogSourceFiles) {
    try {

	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::VEXEC_STAGE_PREPROCESSOR, CslcTool::Instance()->VER_PP);

      /* Create temporary file name
       */
      m_verilogOutputFile = m_argList->getVerilogPpFile();
      CslcTool::ECSLcError err = createTempFile(m_verilogOutputFile);
      //    CHECK_ERR(err);
      if (err != CslcTool::Instance()->ERR_NONE) {
        return err;
      }

      /* Open the output stream for passing it to the preprocessor
       */
      std::fstream output;
      err = openOutputStream(m_verilogOutputFile, &output);
      //    CHECK_ERR(err);
      if (err != CslcTool::Instance()->ERR_NONE) {
        return err;
      }

      /* Create list of input files for preprocessing
       */
      std::fstream* fileStream;
      NSPreproc::RefTVec_RefPpFile ppSourceFiles(new NSPreproc::TVec_RefPpFile());
      for (TVec_RefString_const_iter sourceFile = verilogSourceFiles->begin();
           sourceFile != verilogSourceFiles->end();
           ++sourceFile) {

        err = openInputStream(*sourceFile, fileStream);
        //      CHECK_ERR(err);
        if (err != CslcTool::Instance()->ERR_NONE) {
          return err;
        }

        NSPreproc::RefPpFile ppSrcFile = NSPreproc::PpFile::build(NSPreproc::PP_FLOW_VER, *sourceFile, fileStream);
        ppSourceFiles->push_back(ppSrcFile);
      }

      /* Run the preprocessor
       */
      NSPreproc::RefCSLcPreprocessor pp(new NSPreproc::CSLcPreprocessor(&output, ppSourceFiles));
      pp->runPreprocessor();

	DISPLAY_INFO_END(NSCLi::CLiTool::VEXEC_STAGE_PREPROCESSOR, CslcTool::Instance()->VER_PP);

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runVerLexer(const std::string& verFile,
                                             std::fstream& inputFile,
                                             RefVerilogLexer& verLexer) {

    try {

      //    IF_VBEGIN(NSCLi::CLiTool::VEXEC_STAGE_LEXER)
      if (m_vExecStage >= NSCLi::CLiTool::VEXEC_STAGE_LEXER) {
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::VEXEC_STAGE_LEXER, CslcTool::Instance()->VER_L);

        NSCLi::CLiTool::ECLiFileStat result = NSCLi::CLiCommon::Instance()->openFile(verFile, inputFile, std::ios::in);
        if (result == NSCLi::CLiTool::FS_READ_DENIED) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_READ_PERMISSION_NEEDED, verFile);
          return CslcTool::Instance()->ERR_READ_PERMISSION_NEEDED;
        }
        else if (result == NSCLi::CLiTool::FS_COULD_NOT_OPEN) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE, verFile);
          return CslcTool::Instance()->ERR_COULD_NOT_OPEN_FILE;
        }
        else {
          verLexer = RefVerilogLexer(new VerilogLexer(inputFile));
          verLexer->initialize();
          verLexer->setFilename(verFile);
          verLexer->setTokenObjectFactory(&VerilogToken::factory);

    	DISPLAY_INFO_END(NSCLi::CLiTool::VEXEC_STAGE_LEXER, CslcTool::Instance()->VER_L);

          return CslcTool::Instance()->ERR_NONE;
        }

        //   IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_vExecStage < NSCLi::CLiTool::VEXEC_STAGE_LEXER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runVerParser(const RefVerilogLexer& verLexer,
                                              RefVerilogParser& verParser,
                                              RefASTFactory& verASTFactory,
                                              antlr::RefAST& verAST) {

    try {

      //    IF_VBEGIN(NSCLi::CLiTool::VEXEC_STAGE_PARSER)
      if (m_vExecStage >= NSCLi::CLiTool::VEXEC_STAGE_PARSER) {
  	DISPLAY_INFO_BEGIN(NSCLi::CLiTool::VEXEC_STAGE_PARSER, CslcTool::Instance()->VER_P);

        ASSERT(verLexer.get(), INTERNAL_ERROR_NULL_REFERENCE);

        verParser = RefVerilogParser(new VerilogParser(*verLexer));

        std::string verFile = verLexer->getFilename();
        verParser->setFilename(verFile);

        const char * const verAstId    = "verilogAST";
        //      const char * verAstId = CslcTool::Instance()->VER_AST_ID.c_str();

        verASTFactory = RefASTFactory(new ASTFactory(verAstId, VerAST::factory));
        verParser->initializeASTFactory(*verASTFactory);
        verParser->setASTFactory(verASTFactory.get());

        verParser->source_text();

        verAST = verParser->getAST();

        if (verilogParserHasErrors) {
          m_cslcMessages->displayError(CslcTool::Instance()->ERR_VER);
          return CslcTool::Instance()->ERR_VER;
        }
        else {

          DISPLAY_INFO_END(NSCLi::CLiTool::VEXEC_STAGE_PARSER, CslcTool::Instance()->VER_P);
          DISPLAY_AST(verAST, "Verilog");

          return CslcTool::Instance()->ERR_NONE;
        }

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_vExecStage < NSCLi::CLiTool::VEXEC_STAGE_PARSER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runVerTreeWalker(const RefASTFactory& verASTFactory,
                                                  const antlr::RefAST& verAST,
                                                  NSCdom::RefCDOmDesign& cdomDesign) {

    try {

      //    IF_VBEGIN(NSCLi::CLiTool::VEXEC_STAGE_TREE_WALKER)
      if (m_vExecStage >= NSCLi::CLiTool::VEXEC_STAGE_TREE_WALKER) {
         DISPLAY_INFO_BEGIN(NSCLi::CLiTool::VEXEC_STAGE_TREE_WALKER, CslcTool::Instance()->VER_TW);

        ASSERT(verASTFactory.get(), INTERNAL_ERROR_NULL_REFERENCE);

        RefVerilogTreeWalker verTW = RefVerilogTreeWalker(new VerilogTreeWalker());
        verTW->initializeASTFactory(*verASTFactory);
        verTW->setASTFactory(verASTFactory.get());

        verTW->source_text(RefVerAST(verAST), cdomDesign);

         DISPLAY_INFO_END(NSCLi::CLiTool::VEXEC_STAGE_TREE_WALKER, CslcTool::Instance()->VER_TW);

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_vExecStage < NSCLi::CLiTool::VEXEC_STAGE_TREE_WALKER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runVerCdomChecker(const NSCdom::RefCDOmDesign& cdomDesign) {
    try {

      //    IF_VBEGIN(NSCLi::CLiTool::VEXEC_STAGE_CDOM_CHECKER)
      if (m_vExecStage >= NSCLi::CLiTool::VEXEC_STAGE_CDOM_CHECKER) {
         DISPLAY_INFO_BEGIN(NSCLi::CLiTool::VEXEC_STAGE_CDOM_CHECKER, CslcTool::Instance()->VER_CD_CK);

        runCdomChecker(cdomDesign);

         DISPLAY_INFO_END(NSCLi::CLiTool::VEXEC_STAGE_CDOM_CHECKER, CslcTool::Instance()->VER_CD_CK);

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_vExecStage < NSCLi::CLiTool::VEXEC_STAGE_CDOM_CHECKER){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::createVerDirectories() {
        try {

      //    IF_VBEGIN(NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS)
      if (m_vExecStage >= NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS) {

        RefString rootPath = m_argList->getOutputDirectory();
        TBool mustCreate = m_argList->getMustCreateOutputDirectory();
        if (!rootPath.get()) {
          rootPath = RefString(new std::string(CslcTool::Instance()->CURRENT_DIR));
        }
        else if (mustCreate) {
          CslcTool::ECSLcError dirErr= createDirectory(rootPath);
          //      CHECK_ERR(dirErr);
          if (dirErr != CslcTool::Instance()->ERR_NONE) {
            return dirErr;
          }

        }

        std::string dirName;
        if (cdomTopModuleName.get()) {
          dirName = CslcTool::Instance()->CHAR_START_DIR + *cdomTopModuleName + CslcTool::Instance()->END_VGEN_DIR;
        }
        else {
          dirName = CslcTool::Instance()->DEFAULT_GEN_DIR;
        }

        RefString verDir;
        CslcTool::ECSLcError dirErr = createDirectory(rootPath, dirName, verDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        RefString genCode;
        dirErr = createDirectory(verDir, CslcTool::Instance()->GEN_CODE_DIR, genCode);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_SYSC_DIR, m_verSysCDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_SchemC_DIR, m_verSchemCDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_VER_DIR, m_verVerilogDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }


        dirErr = createDirectory(genCode, CslcTool::Instance()->GEN_VHDL_DIR, m_verVhdlDir);
        //      CHECK_ERR(dirErr);
        if (dirErr != CslcTool::Instance()->ERR_NONE) {
          return dirErr;
        }

      
        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_vExecStage < NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }
  
  CslcTool::ECSLcError CSLcMain::runVerCdomCodeGens(const NSCdom::RefCDOmDesign& cdomDesign) {
    try {

      //    IF_VBEGIN(NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS)
      if (m_vExecStage >= NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS) {
         DISPLAY_INFO_BEGIN(NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS, CslcTool::Instance()->VER_CD_CG);

        ASSERT(m_verSysCDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_verSchemCDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_verVerilogDir.get(), INTERNAL_ERROR_NULL_REFERENCE);
        ASSERT(m_verVhdlDir.get(), INTERNAL_ERROR_NULL_REFERENCE);

        RefString rsSysCPath = NSCLi::CLiCommon::Instance()->completePath(m_verSysCDir);
        std::string sysCPath = *rsSysCPath;

        RefString rsSchemCPath = NSCLi::CLiCommon::Instance()->completePath(m_verSchemCDir);
        std::string schemCPath = *rsSchemCPath;

        RefString rsVerilogPath = NSCLi::CLiCommon::Instance()->completePath(m_verVerilogDir);
        std::string verilogPath = *rsVerilogPath;

        RefString rsVhdlPath = NSCLi::CLiCommon::Instance()->completePath(m_verVhdlDir);
        std::string vhdlPath = *rsVhdlPath;


        CslcTool::ECSLcError cgErr = runCdomCodeGens(cdomDesign, sysCPath, schemCPath, verilogPath, vhdlPath);
        // CHECK_ERR(cgErr);
        if (cgErr != CslcTool::Instance()->ERR_NONE) {
          return cgErr;
        }

         DISPLAY_INFO_END(NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS, CslcTool::Instance()->VER_CD_CG);

        return CslcTool::Instance()->ERR_NONE;

        //    IF_END
      }
      else if (CslcTool::Instance()->notRelease() && m_vExecStage < NSCLi::CLiTool::VEXEC_STAGE_CDOM_CODE_GENS){
        return CslcTool::Instance()->ERR_NONE;
      }

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  CslcTool::ECSLcError CSLcMain::runVerCompiler() {
    try {

      /** get the Verilog source files
       */
      RefTVec_RefString verSourceFiles = m_argList->getVerilogSourceFiles();
      if (!verSourceFiles->empty()) {
        m_verPp = m_argList->getVerilogPp();

        NSCdom::RefCDOmDesign cdomDesign = NSCdom::CDOmDesign::build();

        /** Verilog Preprocessor
         */
        CslcTool::ECSLcError ppErr = runVerPreprocessor(verSourceFiles);
        //      CHECK_ERR(ppErr);
        if (ppErr != CslcTool::Instance()->ERR_NONE) {
          return ppErr;
        }

        if (m_verPp != NSCLi::CLiTool::PP_ONLY) {
           DISPLAY_FILE(*m_verilogOutputFile);

          //TODO: get rid of this garbage
          currentParsedFile.push(m_verilogOutputFile->c_str());

          /** Verilog Lexer
           */
          std::fstream inputFile;
          RefVerilogLexer verLexer;
          CslcTool::ECSLcError lexerErr = runVerLexer(*m_verilogOutputFile, inputFile, verLexer);
          // CHECK_ERR(lexerErr);
          if (lexerErr != CslcTool::Instance()->ERR_NONE) {
            return lexerErr;
          }

          /** Verilog Parser
           */
          RefVerilogParser verParser;
          RefASTFactory verASTFactory;
          antlr::RefAST verAST;
          CslcTool::ECSLcError parserErr = runVerParser(verLexer, verParser, verASTFactory, verAST);
          // CHECK_ERR(parserErr);
          if (parserErr != CslcTool::Instance()->ERR_NONE) {
            return parserErr;
          }

          /** Verilog Tree Walker
           */
          CslcTool::ECSLcError twErr = runVerTreeWalker(verASTFactory, verAST, cdomDesign);
          //        CHECK_ERR(twErr);
          if (twErr != CslcTool::Instance()->ERR_NONE) {
            return twErr;
          }

          //TODO: get rid of this garbage
          currentParsedFile.pop();

          /** CDOM Checker
           */
          CslcTool::ECSLcError cdomErr = runVerCdomChecker(cdomDesign);
          // CHECK_ERR(cdomErr);
          if (cdomErr != CslcTool::Instance()->ERR_NONE) {
            return cdomErr;
          }

          /** create dirs
           */
          CslcTool::ECSLcError dirErr = createVerDirectories();
          //      CHECK_ERR(dirErr);
          if (dirErr != CslcTool::Instance()->ERR_NONE) {
            return dirErr;
          }

          /** CDOM Code Generators
           */
          CslcTool::ECSLcError cgErr = runVerCdomCodeGens(cdomDesign);
          // CHECK_ERR(cgErr);
          if (cgErr != CslcTool::Instance()->ERR_NONE) {
            return cgErr;
          }
        }
      }

      return CslcTool::Instance()->ERR_NONE;

    }
    CATCH_ALL_EXCEPTIONS(_e, CslcTool::Instance()->ERR_NONE);
  }

  template<class T>
  TBool CSLcMain::downCastException(std::exception& _e) {

    T* __e = dynamic_cast<T*>(&_e);
    if (__e) {
      return TRUE;
    }
    else {
      return FALSE;
    }
  }

  template<class T>
  TBool CSLcMain::downCastException(antlr::ANTLRException& _e) {

    T* __e = dynamic_cast<T*>(&_e);
    if (__e) {
      return TRUE;
    }
    else {
      return FALSE;
    }
  }

  void CSLcMain::catchStdException(std::exception& _e) {
    /**the std::exception hierarchy
     *     - std::bad_exception
     *     - std::bad_alloc
     *     - std::bad_cast
     *     - std::bad_typeid
     *     - std::ios_base::failure
     *     - std::logic_error
     *            - std::domain_error
     *            - std::invalid_argument
     *            - std::length_error
     *            - std::out_of_range
     *     - std::runtime_error
     *            - std::overflow_error
     *            - std::range_error
     *            - std::underflow_error
     */
    CAST_STD_EXCEPTION(std::bad_exception    , _e, CslcTool::Instance()->E_STD_BAD_EXCEPTION);
    CAST_STD_EXCEPTION(std::bad_alloc        , _e, CslcTool::Instance()->E_STD_BAD_ALLOC);
    CAST_STD_EXCEPTION(std::bad_cast         , _e, CslcTool::Instance()->E_STD_BAD_CAST);
    CAST_STD_EXCEPTION(std::bad_typeid       , _e, CslcTool::Instance()->E_STD_BAD_TYPEID);
    CAST_STD_EXCEPTION(std::ios_base::failure, _e, CslcTool::Instance()->E_STD_IOS_BASE_FAILURE);

    CAST_STD_EXCEPTION(std::domain_error    , _e, CslcTool::Instance()->E_STD_DOMAIN_ERROR);
    CAST_STD_EXCEPTION(std::invalid_argument, _e, CslcTool::Instance()->E_STD_INVALID_ARGUMENT);
    CAST_STD_EXCEPTION(std::length_error    , _e, CslcTool::Instance()->E_STD_LENGTH_ERROR);
    CAST_STD_EXCEPTION(std::out_of_range    , _e, CslcTool::Instance()->E_STD_OUT_OF_RANGE);
    CAST_STD_EXCEPTION(std::logic_error     , _e, CslcTool::Instance()->E_STD_LOGIC_ERROR);

    CAST_STD_EXCEPTION(std::overflow_error , _e, CslcTool::Instance()->E_STD_OVERFLOW_ERROR);
    CAST_STD_EXCEPTION(std::range_error    , _e, CslcTool::Instance()->E_STD_RANGE_ERROR);
    CAST_STD_EXCEPTION(std::underflow_error, _e, CslcTool::Instance()->E_STD_UNDERFLOW_ERROR);
    CAST_STD_EXCEPTION(std::runtime_error  , _e, CslcTool::Instance()->E_STD_RUNTIME_ERROR);

    //TODO: add new handler for boost v1.4
    //   /**boost::filesystem::filesystem_error is derived from std::exception
    //    */
    //   CAST_STD_EXCEPTION(boost::filesystem::filesystem_error, _e, CslcTool::Instance()->E_BOOST_FS_ERROR);

    /**NSBase::Exception is derived from std::exception
     *         - NSBase::IllegalArgumentException
     *         - NSBase::IllegalStateException
     *         - NSBase::UnsupportedOperationException
     *         - NSBase::NoSuchElementException
     *         - NSBase::ConcurrentModificationException
     *         - NSBase::NotImplementedException
     */
    CAST_STD_EXCEPTION(NSBase::IllegalArgumentException       ,_e, CslcTool::Instance()->E_BASE_ILLEGAL_ARGUMENT);
    CAST_STD_EXCEPTION(NSBase::IllegalStateException          ,_e, CslcTool::Instance()->E_BASE_ILLEGAL_STATE);
    CAST_STD_EXCEPTION(NSBase::UnsupportedOperationException  ,_e, CslcTool::Instance()->E_BASE_UNSUPPORTED_OPERATION);
    CAST_STD_EXCEPTION(NSBase::NoSuchElementException         ,_e, CslcTool::Instance()->E_BASE_NO_SUCH_ELEMENT);
    CAST_STD_EXCEPTION(NSBase::ConcurrentModificationException,_e, CslcTool::Instance()->E_BASE_CONCURRENT_MODIFICATION);
    CAST_STD_EXCEPTION(NSBase::NotImplementedException        ,_e, CslcTool::Instance()->E_BASE_NOT_IMPLEMENTED);
    CAST_STD_EXCEPTION(NSBase::Exception                      ,_e, CslcTool::Instance()->E_BASE);

    /** NSCSLOm::VeriNumException is derived from std::exception
     */
    CAST_STD_EXCEPTION(NSCSLOm::VeriNumException, _e, CslcTool::Instance()->E_VERINUM);

    /** NSCdom::VeriNumException is derived from std::exception
     */
    CAST_STD_EXCEPTION(NSCdom::VeriNumException, _e, CslcTool::Instance()->E_VERINUM);

    /** BaseException is derived from std::exception
     */
    CAST_STD_EXCEPTION(BaseException, _e, CslcTool::Instance()->E_GEN_BASE);

    /** CslLexerException is derived from std::exception
     */
    CAST_STD_EXCEPTION(CslLexerException, _e, CslcTool::Instance()->E_GEN_CSL_LEXER);

    /** VerilogLexerException is derived from std::exception
     */
    CAST_STD_EXCEPTION(VerilogLexerException, _e, CslcTool::Instance()->E_GEN_VER_LEXER);

    {//safety nameless namespace
      /** XERCES_CPP_NAMESPACE::Exception is derived from std::exception
       */
      // XERCES_CPP_NAMESPACE might not be defined
      // XERCES_CPP_NAMESPACE_USE = using namespace XERCES_CPP_NAMESPACE;
      XERCES_CPP_NAMESPACE_USE
        CAST_STD_EXCEPTION(NoValueException     , _e, CslcTool::Instance()->E_XER_NO_VALUE);
      CAST_STD_EXCEPTION(IllegalValueException, _e, CslcTool::Instance()->E_XER_ILLEGAL_VALUE);
      CAST_STD_EXCEPTION(Exception            , _e, CslcTool::Instance()->E_XER);
    }

    DCERR(_e.what());
    throw CslcTool::Instance()->E_STD;
  }

  void CSLcMain::catchAntlrException(antlr::ANTLRException& _e) {
    /**the antlr::ANTLRException hierarchy
     *            - antlr::CharStreamException
     *                     - antlr::CharStreamIOException
     *            - antlr::IOException
     *            - antlr::RecognitionException
     *                     - antlr::MismatchedCharException
     *                     - antlr::MismatchedTokenException
     *                     - antlr::NoViableAltException
     *                     - antlr::NoViableAltForCharException
     *                     - antlr::SemanticException
     *            - antlr::TokenStreamException
     *                     - antlr::TokenStreamIOException
     *                     - antlr::TokenStreamRecognitionException
     *                     - antlr::TokenStreamRetryException
     */
    CAST_ANTLR_EXCEPTION(antlr::CharStreamIOException, _e, CslcTool::Instance()->E_ANTLR_CHAR_STREAM_IO);
    CAST_ANTLR_EXCEPTION(antlr::CharStreamException  , _e, CslcTool::Instance()->E_ANTLR_CHAR_STREAM);

    CAST_ANTLR_EXCEPTION(antlr::IOException, _e, CslcTool::Instance()->E_ANTLR_IO);

    CAST_ANTLR_EXCEPTION(antlr::MismatchedCharException    , _e, CslcTool::Instance()->E_ANTLR_MISMATCHED_CHAR);
    CAST_ANTLR_EXCEPTION(antlr::MismatchedTokenException   , _e, CslcTool::Instance()->E_ANTLR_MISMATCHED_TOKEN);
    CAST_ANTLR_EXCEPTION(antlr::NoViableAltException       , _e, CslcTool::Instance()->E_ANTLR_NO_VIABLE_ALT);
    CAST_ANTLR_EXCEPTION(antlr::NoViableAltForCharException, _e, CslcTool::Instance()->E_ANTLR_NO_VIABLE_ALT_FOR_CHAR);
    CAST_ANTLR_EXCEPTION(antlr::SemanticException          , _e, CslcTool::Instance()->E_ANTLR_SEMANTIC);
    CAST_ANTLR_EXCEPTION(antlr::RecognitionException       , _e, CslcTool::Instance()->E_ANTLR_RECOGNITION);

    CAST_ANTLR_EXCEPTION(antlr::TokenStreamIOException         , _e, CslcTool::Instance()->E_ANTLR_TOKEN_STREAM_IO);
    CAST_ANTLR_EXCEPTION(antlr::TokenStreamRecognitionException, _e, CslcTool::Instance()->E_ANTLR_TOKEN_STREAM_RECOGNITION);
    CAST_ANTLR_EXCEPTION(antlr::TokenStreamRetryException      , _e, CslcTool::Instance()->E_ANTLR_TOKEN_STREAM_RETRY);
    CAST_ANTLR_EXCEPTION(antlr::TokenStreamException           , _e, CslcTool::Instance()->E_ANTLR_TOKEN_STREAM);

    DCERR(_e.toString());
    throw CslcTool::Instance()->E_ANTLR;
  }

  // *********************************************************************
  // CSLcMessages class
  // *********************************************************************
  RefCSLcMessages CSLcMessages::m_instance = RefCSLcMessages();

  CSLcMessages::CSLcMessages(std::ostream *const oStream)
    : m_oStream(oStream) {}

  RefCSLcMessages CSLcMessages::getCSLcMessagesInstance(std::ostream *const oStream) {
    if (!m_instance.get()) {
      m_instance = RefCSLcMessages(new CSLcMessages(oStream));
    }

    return m_instance;
  }

  void CSLcMessages::displayLicense() {
    (*m_oStream) << std::endl
                 << "Fastpath Logic™ License Agreement" << std::endl
                 << std::endl
                 << "Please read and accept the license below to continue." << std::endl
                 << std::endl
                 << "IMPORTANT - read carefully before DOWNLOADING, ACCESSING or USING the"   << std::endl
                 << "Chip Specification Language Compiler(cslc) (collectivelly, \"SOFTWARE\"" << std::endl
                 << "of Fastpath Logic, INC."                                                 << std::endl
                 << "Your use of the SOFTWARE is expressly conditioned upon and subject to"   << std::endl
                 << "your agreement to these terms and conditions. If you do not agree to"    << std::endl
                 << "these terms and conditions, do not DOWNLOAD, ACCESS or USE the SOFTWARE" << std::endl
                 << "(refer to license.txt documents for more information)."                  << std::endl
                 << std::endl;
  }

  void CSLcMessages::display(const std::string& str) {
    if (!str.empty()) {
      (*m_oStream) << str << std::endl;
    }
  }

  void CSLcMessages::displayError(CslcTool::ECSLcError err) {
    switch(err) {
    case CslcTool::ERR_CSL:               (*m_oStream) << "CSL code has error(s)."                                      << std::endl; break;
    case CslcTool::ERR_VER:               (*m_oStream) << "Verilog code has error(s)."                                  << std::endl; break;
    case CslcTool::ERR_TEMP_FILE_FAILURE: (*m_oStream) << "Could not generate temporary file needed for preprocessing." << std::endl; break;

    default:
      ASSERT(FAIL, INTERNAL_ERROR_MSG << "unknown error");
      break;
    }
  }

  void CSLcMessages::displayError(CslcTool::ECSLcError err,
                                  const std::string& token) {

    switch(err) {
    case CslcTool::ERR_COULD_NOT_OPEN_FILE            : (*m_oStream) << "Could not open file \'" << token << "\'."                                    << std::endl; break;
    case CslcTool::ERR_FILE_NOT_EXISTS                : (*m_oStream) << "File \'"                << token << "\' does not exist."                     << std::endl; break;
    case CslcTool::ERR_EXECUTE_WRITE_PERMISSION_NEEDED: (*m_oStream) << "\'"                     << token << "\' execute or write permission denied." << std::endl; break;
    case CslcTool::ERR_WRITE_PERMISSION_NEEDED        : (*m_oStream) << "\'"                     << token << "\' write permission denied."            << std::endl; break;
    case CslcTool::ERR_READ_PERMISSION_NEEDED         : (*m_oStream) << "\'"                     << token << "\' read permission denied."             << std::endl; break;
    case CslcTool::ERR_BOOST_FILESYSYTEM              : (*m_oStream)                             << token                                             << std::endl; break;

    default:
      ASSERT(FAIL, INTERNAL_ERROR_MSG << "unknown error");
      break;
    }
  }

  void CSLcMessages::displayException(CslcTool::ECSLcExceptionCode eCode) {
    switch(eCode) {
    case CslcTool::E_FATAL_ERROR                   : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_BAD_EXCEPTION             : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_BAD_ALLOC                 : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_BAD_CAST                  : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_BAD_TYPEID                : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_IOS_BASE_FAILURE          : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_DOMAIN_ERROR              : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_INVALID_ARGUMENT          : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_LENGTH_ERROR              : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_OUT_OF_RANGE              : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_LOGIC_ERROR               : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_OVERFLOW_ERROR            : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_RANGE_ERROR               : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_UNDERFLOW_ERROR           : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD_RUNTIME_ERROR             : (*m_oStream) << std::endl; break;
    case CslcTool::E_STD                           : (*m_oStream) << std::endl; break;
    case CslcTool::E_BASE_ILLEGAL_ARGUMENT         : (*m_oStream) << std::endl; break;
    case CslcTool::E_BASE_ILLEGAL_STATE            : (*m_oStream) << std::endl; break;
    case CslcTool::E_BASE_UNSUPPORTED_OPERATION    : (*m_oStream) << std::endl; break;
    case CslcTool::E_BASE_NO_SUCH_ELEMENT          : (*m_oStream) << std::endl; break;
    case CslcTool::E_BASE_CONCURRENT_MODIFICATION  : (*m_oStream) << std::endl; break;
    case CslcTool::E_BASE_NOT_IMPLEMENTED          : (*m_oStream) << std::endl; break;
    case CslcTool::E_BASE                          : (*m_oStream) << std::endl; break;
    case CslcTool::E_VERINUM                       : (*m_oStream) << std::endl; break;
    case CslcTool::E_GEN_BASE                      : (*m_oStream) << std::endl; break;
    case CslcTool::E_GEN_CSL_LEXER                 : (*m_oStream) << std::endl; break;
    case CslcTool::E_GEN_VER_LEXER                 : (*m_oStream) << std::endl; break;
    case CslcTool::E_XER_NO_VALUE                  : (*m_oStream) << std::endl; break;
    case CslcTool::E_XER_ILLEGAL_VALUE             : (*m_oStream) << std::endl; break;
    case CslcTool::E_XER                           : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_CHAR_STREAM_IO          : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_CHAR_STREAM             : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_IO                      : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_MISMATCHED_CHAR         : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_MISMATCHED_TOKEN        : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_NO_VIABLE_ALT           : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_NO_VIABLE_ALT_FOR_CHAR  : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_SEMANTIC                : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_RECOGNITION             : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_TOKEN_STREAM_IO         : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_TOKEN_STREAM_RECOGNITION: (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_TOKEN_STREAM_RETRY      : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR_TOKEN_STREAM            : (*m_oStream) << std::endl; break;
    case CslcTool::E_ANTLR                         : (*m_oStream) << std::endl; break;
    case CslcTool::E_SIGINT                        : (*m_oStream) << "SIGINT received"       << std::endl; break;
    case CslcTool::E_UNKNOWN                       : (*m_oStream) << "got unknown exception" << std::endl; break;
    }

    //TODO: dump the memory
  }

} //NSCslc
