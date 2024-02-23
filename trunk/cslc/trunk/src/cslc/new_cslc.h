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

#ifndef INC_GUARD_cslc_h_
#define INC_GUARD_cslc_h_

#include "cslc_Support.h"

namespace NSCslc {

  // *********************************************************************
  // CSLcSignal class
  // *********************************************************************
  class CSLcSignal {
  public:
    CSLcSignal() throw();
    ~CSLcSignal() throw();
  };

  // *********************************************************************
  // CSLcMain class
  // *********************************************************************
  class CSLcMain {
  private:
    static RefCSLcMain                          m_instance;

    NSCLi::RefCLiArgumentList                   m_argList;
    TInt                                        m_cslcComponent;

#   ifndef __RELEASE_VERSION
    TBool                                       m_displayInfo;
    TBool                                       m_displayCslomAst;
    TBool                                       m_displayCdomAst;
    NSCLi::CLiTool::ECSLcExecStage              m_execStage;
    NSCLi::CLiTool::ECSLcVExecStage             m_vExecStage;
#   endif

    NSCLi::CLiTool::ECSLcPpOption               m_cslPp;
    NSCLi::CLiTool::ECSLcPpOption               m_verPp;

    RefString                                   m_cslPdfDir;
    RefString                                   m_cslCppDir;
    RefString                                   m_cslCSimDir;
    RefString                                   m_cslCSimGenDir;
    RefString                                   m_cslXMLDir;
    RefString                                   m_cslGuiXmlGeneratorDir;
    RefString                                   m_cslGuiCslGeneratorDir;
    RefString                                   m_cslSysCDir;
    RefString                                   m_cslSchemCDir;
    RefString                                   m_cslVerilogDir;
    RefString                                   m_cslVhdlDir;
    RefString                                   m_verSysCDir;
    RefString                                   m_verSchemCDir;
    RefString                                   m_verVerilogDir;
    RefString                                   m_verVhdlDir;
    RefString                                   m_cslCslDir;
    RefCSLcMessages                             m_cslcMessages;

    RefString                                   m_cslOutputFile;
    RefString                                   m_verilogOutputFile;

  public:
    ~CSLcMain();

    void cleanUp( void );
    static RefCSLcMain getCompilerInstance(std::ostream *const oStream);

    CslcTool::ECSLcError runCompiler(TInt argc,
                                     TChar** argv,
                                     TInt cslcComponent);

    CslcTool::ECSLcError runCslReader(NSCSLOm::RefCSLOmDesign& cslomDesign, RefTVec_RefString& cslSourceFiles);

  private:
    CSLcMain(std::ostream *const oStream);

#   ifndef __RELEASE_VERSION
    void displayInfo(const std::string& str);
    void displayAST(const RefAST& ast,
                    const std::string& comp);
#   endif

    void DISPLAY_FILE      (const std::string& _file                        );
    void DISPLAY_INFO_BEGIN(const TInt& _nr , const std::string& _msg);
    void DISPLAY_INFO_END  (const TInt& _nr , const std::string& _msg);
    void DISPLAY_AST       (antlr::RefAST&  _ast, const std::string& _msg);
    void DISPLAY_CGEN_BEGIN(const std::string& _msg                         );
    void DISPLAY_CGEN_END  (const std::string& _msg                         );

    void displayIT(const NSCInstTree::RefCInstTreeNode& cslITRoot);

    CslcTool::ECSLcError createTempFile(RefString& fileName);
    CslcTool::ECSLcError deleteTempFile(RefString& fileName);
    CslcTool::ECSLcError openInputStream(const RefString& fileName,
                                         std::fstream*& input);
    CslcTool::ECSLcError openOutputStream(const RefString& fileName,
                                          std::fstream* output);
    CslcTool::ECSLcError createDirectory(const RefString& rootPath);
    CslcTool::ECSLcError createDirectory(const RefString& rootPath,
                                         const std::string& dirName,
                                         RefString& dirPath);
    CslcTool::ECSLcError createCslDirectories();
    CslcTool::ECSLcError createVerDirectories();

    CslcTool::ECSLcError runPdfGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                   const std::string& pdfPath);
    CslcTool::ECSLcError runCppGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                   const std::string& cppPath);
    CslcTool::ECSLcError runCSimGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                    const std::string& csimPath,
                                    const std::string& csimGenPath);
    //CslcTool::ECSLcError runXMLGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
    //                               const std::string& xmlPath);
    CslcTool::ECSLcError runGuiXmlGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                            const std::string& guiXmlGeneratorPath);
    CslcTool::ECSLcError runGuiCslGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                            const std::string& guiCslGeneratorPath);
    CslcTool::ECSLcError runVerilogDefineGen(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                             const std::string& verilogDefinePath);
    //-----OB added another param---start
    CslcTool::ECSLcError runSysCGen(const NSCdom::RefCDOmDesign& cdomDesign,
				    const std::string& sysCPath);
   CslcTool::ECSLcError runVecCtrl(const NSCdom::RefCDOmDesign& cdomDesign); //,
	//			    const std::string& sysCPath);
    CslcTool::ECSLcError runSchemCGen(const NSCdom::RefCDOmDesign& cdomDesign,
				    const std::string& schemCPath);
    //-------end
    CslcTool::ECSLcError runVerilogGen(const NSCdom::RefCDOmDesign& cdomDesign,
                                       const std::string& verilogPath);
    CslcTool::ECSLcError runVHDLGen(const NSCdom::RefCDOmDesign& cdomDesign,
                                    const std::string& vhdlPath);
    CslcTool::ECSLcError runCdomChecker(const NSCdom::RefCDOmDesign& cdomDesign);
    CslcTool::ECSLcError runCdomCodeGens(const NSCdom::RefCDOmDesign& cdomDesign,
                                         const std::string& sysCPath,
					 const std::string& schemCPath,
                                         const std::string& verilogPath,
                                         const std::string& vhdlPath);
    //------------------------MS added-----------------------------------------------------
    CslcTool::ECSLcError runCslCdomVerilogStimExpMemory(const NSCdom::RefCDOmDesign& cdomDesign, 
							 const std::string& verilogPath);
    //------------------------------------------------------------------------------------
    CslcTool::ECSLcError runCslPreprocessor(const RefTVec_RefString& cslSourceFiles);
    CslcTool::ECSLcError runCslLexer(const std::string& cslFile,
                                     std::fstream& inputFile,
                                     RefCslLexer& cslLexer);
    CslcTool::ECSLcError runCslParser(const RefCslLexer& cslLexer,
                                      RefCslParser& cslParser,
                                      RefASTFactory& cslASTFactory,
                                      antlr::RefAST& cslAST);
    CslcTool::ECSLcError runCslTreeWalker(const RefASTFactory& cslASTFactory,
                                          const antlr::RefAST& cslAST,
                                          NSCSLOm::RefCSLOmDesign& cslomDesign);
    CslcTool::ECSLcError runCslInstanceTree(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                            NSCInstTree::RefCInstTreeNode& cslITRoot);
    CslcTool::ECSLcError runCslAutomapper();
    CslcTool::ECSLcError runCslAutorouter();
   //-------------------------MS added----------------------------------------------------------
    CslcTool::ECSLcError runCslCSLOM_VerilogTbCodeGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign, 
							    const std::string& verilogPath);
    CslcTool::ECSLcError runCslCSLOM_CslCodeGenerator(const NSCSLOm::RefCSLOmDesign& cslomDesign, 
							    const std::string& cslPath);
   //----------------------------------------------------------------------------------------------
    CslcTool::ECSLcError runCslomChecker(const NSCSLOm::RefCSLOmDesign& cslomDesign);
    CslcTool::ECSLcError runCslConnectionChecker(const NSCInstTree::RefCInstTreeNode& cslITRoot);
    CslcTool::ECSLcError runCslomCodeGens(const NSCSLOm::RefCSLOmDesign& cslomDesign);
    CslcTool::ECSLcError runCslAdapter(const NSCSLOm::RefCSLOmDesign& cslomDesign,
                                       NSCdom::RefCDOmDesign& cdomDesign);
    
    CslcTool::ECSLcError runCslCdomChecker(const NSCdom::RefCDOmDesign& cdomDesign);
    CslcTool::ECSLcError runCslCdomCodeGens(const NSCdom::RefCDOmDesign& cdomDesign);
    CslcTool::ECSLcError runCslCompiler();

    CslcTool::ECSLcError runVerPreprocessor(const RefTVec_RefString& verilogSourceFiles);
    CslcTool::ECSLcError runVerLexer(const std::string& verFile,
                                     std::fstream& inputFile,
                                     RefVerilogLexer& verLexer);
    CslcTool::ECSLcError runVerParser(const RefVerilogLexer& verLexer,
                                      RefVerilogParser& verParser,
                                      RefASTFactory& verASTFactory,
                                      antlr::RefAST& verAST);
    CslcTool::ECSLcError runVerTreeWalker(const RefASTFactory& verASTFactory,
                                          const antlr::RefAST& verAST,
                                          NSCdom::RefCDOmDesign& cdomDesign);
    CslcTool::ECSLcError runVerCdomChecker(const NSCdom::RefCDOmDesign& cdomDesign);
    CslcTool::ECSLcError runVerCdomCodeGens(const NSCdom::RefCDOmDesign& cdomDesign);
    CslcTool::ECSLcError runVerCompiler();

    template<class T>
    TBool downCastException(std::exception& _e);
    template<class T>
    TBool downCastException(antlr::ANTLRException& _e);

    void catchStdException(std::exception& _e);
    void catchAntlrException(antlr::ANTLRException& _e);
  };

  // *********************************************************************
  // CSLcMessages class
  // *********************************************************************
  class CSLcMessages {
    friend class CSLcMain;

  private:
    static RefCSLcMessages                      m_instance;
    std::ostream*                               m_oStream;

  private:
    CSLcMessages(std::ostream *const oStream);

    static RefCSLcMessages getCSLcMessagesInstance(std::ostream *const oStream);

    void displayLicense();

    void display(const std::string& str);

    void displayError(CslcTool::ECSLcError err);
    void displayError(CslcTool::ECSLcError err,
                      const std::string& token);

    void displayException(CslcTool::ECSLcExceptionCode eCode);
  };

} //NSCslc

#endif //INC_GUARD_cslc_h_
