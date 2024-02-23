//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
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


#include <iostream>
#include <fstream>
#include "cslc.h"
#include "../../boost/filesystem/operations.hpp"
#include "../../boost/filesystem/path.hpp"
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../cdom/CDOM_VerilogGenerator.h"
#include "../cdom/CDOM_SystemCGenerator.h"
#include "../cdom/CDOM_SchematicCodeGenerator.h"
#include "../cslom/CSLOM_CPP_Visitor.h"
#include "../autorouter/CSLOM_Checker.h"
#include "../autorouter/CSLOM_InstTree.h"
#include "../autorouter/CSLOM_InstTreeVisitor.h"
#include "../autorouter/Autorouter.h"
#include "../cdom/CDOM_Checker.h"
#include "../cslom_design_checker/CSLOM_Design_Checker.h"
#include "../support/CommonSupport.h"
#include "../cslom/CSLOM_DocGen.h"
#include "../cslom/CSLOM_CPP_Generator.h"
#include <time.h>
#include <stdlib.h>

using namespace std;
using namespace NSCInstTreeVisitor;
using namespace NSCInstTree;
using namespace NSChecker;
using namespace NSCSLOm;

extern TBool cslomHasErrors;
extern TBool cslParserHasErrors;
extern TBool verilogParserHasErrors;
extern TBool instTreeHasErrors;
extern TBool cdomHasErrors;
extern TBool checkerHasErrors;

extern RefString cslTopUnitName;

extern RefString cdomTopModuleName;

//#ifndef v2v // --- v2v ---
using namespace NSCslc;
//#endif // --- v2v ---


namespace fs = boost::filesystem;

Cslc::Cslc(int argc, char *argv[]){
  printLicence();

  //init random
  srand(time(0));

  cslArgs     = RefCslArgs(new CslArgs());
  verilogArgs = RefVerilogArgs(new VerilogArgs());

#ifndef __RELEASE
  cslArgs->setTheDebugMode();
#endif

  cmdParserExitCode = parseArguments(argc, argv, cslArgs, verilogArgs);

  NSWarnError::CslWE::Instance()->setMaxErrors(cslArgs->getCsl_maxerrors());
  NSWarnError::CslWE::Instance()->setMaxWarnings(cslArgs->getCsl_maxwarnings());

  cslomDesign = CSLOmDesign::build();
  cdomDesign  = CDOmDesign ::build();

  m_dir = cslArgs->getCsl_output_directory();
//   string csl_output_directory = cslArgs->getCsl_output_directory();
//   //create directory for generated code
//   try{
//     //root directory
//     fs::create_directory(csl_output_directory);

//     //verilog directory
//     fs::create_directory(csl_output_directory + "verilog_generated_code/");

//     //c++ directories
//     fs::create_directory(csl_output_directory + "cpp_gen/");
//     fs::create_directory(csl_output_directory + "cpp_gen/units_execute_includes/");
//     fs::create_directory(csl_output_directory + "cpp_gen/vectors_startGen_includes/");

//     //systemC
//     //......
//   }catch(fs::filesystem_error &err){
//     cerr << err.what() << endl;
//   }
}


Cslc::~Cslc(){

  delete CCSLOmAdapter::getInstance();
}


int Cslc::cslToVerilog(){
  vector<string> cslSourceFile       = cslArgs->getCslSourceFile();
  bool           csl_info            = cslArgs->isCsl_info();
  bool           cslom_ast           = cslArgs->isCslom_ast();
  int            csl_pp              = cslArgs->getCsl_pp();
  int            csl_execution_stage = cslArgs->getCsl_execution_stage();


  RefAST ast;

  if(cslSourceFile.empty()) return 1;

  NSCSLOm::RefTVec_RefString vCurrentScope = NSCSLOm::RefTVec_RefString(new NSCSLOm::TVec_RefString);

  try{
    for(vector<string>::iterator it = cslSourceFile.begin(); it!=cslSourceFile.end(); ++it) {
      if(csl_info){
        DCOUT("file name: "<<*(it)<<endl);
      }

      /* TODO: add this to the new cslc - OS needs this queue for parser !!!*/
      currentParsedFile.push(it->c_str());
    
      /**preprocessor*/
      if(csl_pp != 1){// csl_pp not OFF
        if(csl_info){
          DCOUT("\t ->Preprocessing_begin"<<endl);
        }
    
        //here should run the preprocessor
        //when implemented
    
        if(csl_info){
          DCOUT("\t ->Preprocessing_end"<<endl<<endl);
        }
      }
      //stop here
      if(csl_pp == 2 || csl_execution_stage == 0){//csl_pp = ONLY or csl_execution_stage = preprocessor 
        currentParsedFile.pop();
        continue;
      }
    
    
      
      /**lexer*/
      if(csl_info){
        DCOUT("\t ->lexer_begin"<<endl);
      }
    
      ifstream input(it->c_str());
      if (!input){
        currentParsedFile.pop();
        DCERR("Unable to open file for reading: " << *(it) << endl);
        return CSLPARSER_INPUT_FILE_OPEN_FAILURE;
      }
      CslLexer lexer(input);
      lexer.setFilename(*(it));
      lexer.setTokenObjectFactory(&CslToken::factory);
    
      if(csl_info){
        DCOUT("\t ->lexer_end"<<endl<<endl);
      }
      
    
    
    
      /**parser*/
      if(csl_info){
        DCOUT("\t ->parser_begin"<<endl);
      }
      
      auto_ptr<CslParser> parser(new CslParser(lexer));
      parser->setFilename(*(it));
      ASTFactory ast_factory("CslAST", CslAST::factory);
      parser->initializeASTFactory(ast_factory);
      parser->setASTFactory(&ast_factory);
      
      parser->source_text();
      ast = parser->getAST();
    
      currentParsedFile.pop();
      
      if(cslParserHasErrors){
        return 0;
      }

      if(csl_info){
        DCOUT("\t ->parser_end"<<endl<<endl);
      }
    
      
     /**ast*/
      if(cslom_ast){
        if(csl_info){
          DCOUT("\t ->Cslom_ast_begin"<<endl);
        }
    
        if(ast.get()){
          DCOUT(ast->toStringList() << endl);
        }
    
        if(csl_info){
          DCOUT("\t ->Cslom_ast_end"<<endl<<endl);
        }
      }
      //stop here
      if(csl_execution_stage == 1){
        continue;
      }
    
      
    
      
      /**walker*/
      if(csl_info){
        DCOUT("\t ->walker_begin"<<endl);
      }
    
      CslTreeWalker walker;
      walker.initializeASTFactory(ast_factory);
      walker.setASTFactory(&ast_factory);
      walker.source_text(RefCslAST(ast), cslomDesign, vCurrentScope);
    
      if(csl_info){
        DCOUT("\t ->walker_end"<<endl<<endl);
      }
      
      if(cslomHasErrors){
        return 0;
      }

      
    }//for each file
    if(ast.get()){
      //destroy(ast);
    }
    //stop here
    if(csl_pp == 2 || csl_execution_stage <= 2){//csl_pp = ONLY ot csl_execution_stage = preprocessor | lexer+parser | walker
      return 1;
    }
    
   /**instance tree*/
   if(csl_info){
     DCOUT("\t ->instance_tree_begin"<<endl);
   }
   
   CInstTreeCreator* instTreeCreator = new CInstTreeCreator();
   cslomDesign->acceptVisitor(*instTreeCreator);
   RefCInstTreeNode instTreeRoot = instTreeCreator->getRoot();
   delete instTreeCreator;
   
   if(instTreeHasErrors){
     return 0;
   }

   if(csl_info){
     DCOUT("\t ->instance_tree_end"<<endl<<endl);

     DCOUT("\t ->Print_inst_tree_begin"<<endl<<endl);

     CInstTreeTraversal* instTreeTraversal = new CInstTreeTraversal();
     if (instTreeRoot.get()) {
       instTreeRoot->acceptVisitor(*instTreeTraversal);
     }
     delete instTreeTraversal;

     DCOUT("\t ->Print_inst_tree_end"<<endl<<endl);
   }

   createDirectories(CT_CSL_TO_VER);
    
    /**autorouter*/
    if(csl_info){
      DCOUT("\t ->autorouter_begin"<<endl);
    }
    
    NSAutorouter::CAutorouter::startAutoRouter();
    
    if(csl_info){
      DCOUT("\t ->autorouter_end"<<endl<<endl);
    }
    //stop here
    if(csl_execution_stage == 3){ //csl_execution_stage = autorouter
      return 1;
    }
    
    
    
    
    /**automapper*/
    //not yet
    if(csl_info){
      DCOUT("\t ->automapper_begin"<<endl);
    }
    
    
    if(csl_info){
      DCOUT("\t ->automapper_end"<<endl<<endl);
    }
    //stop here
    if(csl_execution_stage == 4){ //csl_execution_stage = autorouter
      return 1;
    }

    /**cslom_checker*/
    if(csl_info){
      DCOUT("\t ->cslom_checker_begin"<<endl);
    }

    auto_ptr<NSCSLOmDesignChecker::CSLOmDesignChecker> cslomCheckerVisitor(new NSCSLOmDesignChecker::CSLOmDesignChecker());
    cslomCheckerVisitor->enableObjTraversal();
    cslomCheckerVisitor->enableObjBeforeTraversal();
    cslomCheckerVisitor->enableObjAfterTraversal();
    cslomCheckerVisitor->enableObjInTraversal();
    cslomDesign->acceptVisitor(*cslomCheckerVisitor);
    
    if(csl_info){
      DCOUT("\t ->cslom_checker_end"<<endl<<endl);
    }
    
    if(checkerHasErrors){
      return 0;
    }
    
   /**code gen*/
   cslomCodeGen();
    
   /**adapter*/
   if(csl_info){
      DCOUT("->adapter_begin"<<endl);
   }
   
   auto_ptr<NSAdapter::CAdapterToCDOM> adapterVisitor(new NSAdapter::CAdapterToCDOM(cdomDesign));
   adapterVisitor->enableObjTraversal();
   adapterVisitor->enableObjBeforeTraversal();
   adapterVisitor->enableObjAfterTraversal();
   adapterVisitor->enableObjInTraversal();
   cslomDesign->acceptVisitor(*adapterVisitor);
   cdomDesign = (adapterVisitor)->getProduct();
    
   if(csl_info){
     DCOUT("->adapter_end"<<endl<<endl);
   }   
   //stop here
   if(csl_execution_stage == 5){ //csl_execution_stage = autorouter
     return 1;
   }

   if(cdomHasErrors){
     return 0;
   }

   cslomDesign = RefCSLOmDesign();

    /**CDOM checker */
    if(csl_info){
      DCOUT("->cdom_checker_begin"<<endl);
    }
    auto_ptr<NSCdomChecker::CDOmChecker> checkerVisitor(new NSCdomChecker::CDOmChecker());
    checkerVisitor->enableObjTraversal();
    checkerVisitor->enableObjBeforeTraversal();
    checkerVisitor->enableObjAfterTraversal();
    cdomDesign->acceptVisitor(*checkerVisitor);
    if(csl_info){
      DCOUT("->Cdom_checker_end"<<endl<<endl);
    }

  }catch(RecognitionException &e) {
    DCERR("ANTLR exception: " << e.toString() << endl);
    return CSLPARSER_PARSING_EXCEPTION;
  }catch(ANTLRException& e){
     DCERR("ANTLR exception: " << e.toString() << endl);
     return CSLPARSER_PARSING_EXCEPTION;
  }catch(CslLexerException& ve){
    const TCslLexerState &st = ve.state();
    DCERR("Lexer<" << st.m_filename << ","
          << st.m_line << ","
          << st.m_col <<  ">: " << ve.what() << endl);

    return CSLPARSER_LEXER_EXCEPTION;
  }catch(BaseException& be){
    DCERR("Base Exception: " << be.what() << endl);
    return CSLPARSER_BASE_EXCEPTION;
  }catch(NSBase::Exception& e){
    DCERR("Exception: " << endl);
    DCERR(e.what() << "At line:" << e.getLineNumber() << endl);
    return CSLPARSER_SYSTEM_EXCEPTION;
  }catch(exception& e){
    DCERR("exception: " << e.what() << endl);
    return CSLPARSER_SYSTEM_EXCEPTION;
  }

  return 1;
}

int Cslc::verToVer(){
  vector<string> verilogSourceFiles  = verilogArgs->getVerilogSourceFiles();
  vector<string> verilogIncludeDir   = verilogArgs->getIncludeDirectories();
  vector<string> verilogDefines      = verilogArgs->getDefines(); 
  bool           csl_info            = cslArgs->isCsl_info();
  bool           cdom_ast            = cslArgs->isCdom_ast();
  int            verilog_pp          = cslArgs->getVerilog_pp();
  int            csl_execution_stage = cslArgs->getCsl_execution_stage();
  string         tempFileName        = cslArgs->getVerilog_pp_filename();

  if(verilogSourceFiles.empty()) return 1;

  if(!tempFileName.size()){
    tempFileName = generateRandomFileName(16);
  }

  RefAST ast;
  
  const NSVerilogPreprocessor::CLineMapProcessor *lineMap = 0;
  try{
    for(vector<string>::iterator it = verilogSourceFiles.begin(); it!=verilogSourceFiles.end(); ++it){
      if(csl_info){
        DCOUT("file name: "<<*(it)<<endl);
      }
    
      currentParsedFile.push(*(it));      
    
      /**preprocessor*/
      if(verilog_pp != 1){ //ON or ONLY
        if(csl_info){
          DCOUT("\t->Preprocessing_begin"<<endl);
        }
        
        NSVerilogPreprocessor::CPreprocessor *preproc = new NSVerilogPreprocessor::CPreprocessor(it->c_str(), tempFileName.c_str(), verilogIncludeDir);
        if(verilogDefines.size()) {
          for(int i = 0; i < verilogDefines.size(); ++i) {
            NSVerilogPreprocessor::CTextMacro::definedMacroList.push_back(new NSVerilogPreprocessor::CTextMacro(verilogDefines[i], vector<string>(), string()));
          }
        }
        lineMap = preproc->getLineMapping();
        ::tempLineMap.push(lineMap);
        preproc->start();
        std::vector< std::pair<unsigned long, unsigned int> > *stateVect = preproc->getStateVect();
        delete stateVect;
        delete preproc;
    
        if(csl_info){
          DCOUT("\t->Preprocesssing_end"<<endl<<endl);
        }
      }
      //stop here
      if(verilog_pp == 2 || csl_execution_stage == 0){//verilog_pp = ONLY or csl_execution_stage = preprocessor 
        currentParsedFile.pop();
        continue;
      }
      

      ifstream input(tempFileName.c_str());
      if (!input){
        cerr << "\t->Unable to open file for reading: " <<  endl;
        if( lineMap ) delete lineMap;
        return VPARSER_INPUT_FILE_OPEN_FAILURE;
      }
    
    
    
    
      /**lexer*/
      if(csl_info){
        DCOUT("\t->lexer_begin"<<endl);
      }
    
      VerilogLexer lexer(input);
      lexer.initialize();
      lexer.setFilename(tempFileName);
      lexer.setTokenObjectFactory(&VerilogToken::factory);
    
      if(csl_info){
        DCOUT("\t->lexer_end"<<endl<<endl);
      }
      
    
    
      /**parser*/
      if(csl_info){
        DCOUT("\t->parser_begin"<<endl);
      }
    
      auto_ptr<VerilogParser> parser(new VerilogParser(lexer));
      parser->setFilename(tempFileName);
      ASTFactory ast_factory("VerAST", VerAST::factory);
      parser->initializeASTFactory(ast_factory);
      parser->setASTFactory(&ast_factory);
      
      parser->source_text();
      ast = parser->getAST();
    
      if(csl_info){
        DCOUT("\t->parser_end"<<endl<<endl);
      }
      if(verilogParserHasErrors){
        currentParsedFile.pop();
        return 0;
      }
    
      currentParsedFile.pop ();
    
      /**ast*/
      if(cdom_ast){
        if(csl_info){
          DCOUT("\t->ast_begin"<<endl);
        }
    
        if(ast.get()){
          DCOUT(ast->toStringList()<<endl);
        }
    
        if(csl_info){
          DCOUT("\t->ast_end"<<endl<<endl);
        }    
      }  
        
    
      /**delete temp file*/
      if(!verilog_pp || csl_execution_stage){
        removeFile(tempFileName);
      }
      //stop here
      if(csl_execution_stage == 1){
        continue;
      }
      
      /**walker*/
      if(csl_info){
        //        DCOUT("*** Walking begin"<<endl);
        DCOUT("->walker_begin" << endl);
      }
    
      VerilogTreeWalker walker;
      walker.initializeASTFactory(ast_factory);
      walker.setASTFactory(&ast_factory);        
      walker.source_text(RefVerAST(ast), cdomDesign);
    
      if(csl_info){
        DCOUT("->walker_end"<<endl<<endl);
      }
    
      if(cslomHasErrors){
        //return 0;
      }
    
    }//end for
    
    if(ast.get()){
      //destroy(ast);
    }
    
    //stpop here
    if(verilog_pp == 2 || csl_execution_stage <= 2){//verilog_pp = ONLY ot csl_execution_stage = preprocessor | lexer+parser | walker
      return 1;
    }
 
    /**cdom checker*/
    if(csl_info){
      DCOUT("->cdom_checker_begin"<<endl);
    }
    auto_ptr<NSCdomChecker::CDOmChecker> checkerVisitor(new NSCdomChecker::CDOmChecker());
    checkerVisitor->enableObjTraversal();
    checkerVisitor->enableObjBeforeTraversal();
    checkerVisitor->enableObjAfterTraversal();
    cdomDesign->acceptVisitor(*checkerVisitor);
    
    if(csl_info){
      DCOUT("->cdom_checker_end"<<endl<<endl);
    }

//     DCERR("!!!!!!! " << *cdomTopModuleName);

    createDirectories(CT_VER_TO_VER);


  }catch(RecognitionException &e) {
    cerr << "ANTLR exception: " << e.toString() << endl;
    if( lineMap ) delete lineMap;
    return VPARSER_PARSING_EXCEPTION;
  }catch(ANTLRException& e){
    cerr << "ANTLR exception: " << e.toString() << endl;
    if( lineMap ) delete lineMap;
    return VPARSER_PARSING_EXCEPTION;
  }catch(VerilogLexerException& ve){
    const TVerLexerState &st = ve.state();
    cerr << "Lexer<" << st.m_filename << ","
         << st.m_line << ","
         << st.m_col <<  ">: " << ve.what() << endl;
    if( lineMap ) delete lineMap;
    return VPARSER_LEXER_EXCEPTION;
  }catch(BaseException& be){
    cerr << "Base Exception: " << be.what() << endl;
    if( lineMap ) delete lineMap;
    return VPARSER_BASE_EXCEPTION;
  }catch(NSBase::Exception& e){
    cerr << "Exception: " << endl;
    cerr << e.what() << "At line:" << e.getLineNumber() << endl;
    if( lineMap ) delete lineMap;
    return VPARSER_SYSTEM_EXCEPTION;
  }catch(exception& e){
    cerr << "exception: " << e.what() << endl;
    if( lineMap ) delete lineMap;
    return VPARSER_SYSTEM_EXCEPTION;
  }


  return 1;
}

CMD_EXIT_CODE Cslc::getCmdParserExitCode(){
  return cmdParserExitCode;
}


void Cslc::cslomCodeGen(){

  int    csl_execution_stage  = cslArgs->getCsl_execution_stage();
  bool   csl_info             = cslArgs->isCsl_info();
  bool   csl_single           = cslArgs->isCsl_single();
  bool   csl_cpp_gen          = cslArgs->isCsl_generateCppCode();
  bool   csl_csim_gen         = cslArgs->isCsl_generateCSimCode();
  string name                 = cslArgs->getCsl_output_name();
//   string csl_output_directory = cslArgs->getCsl_output_directory();
 
  if(csl_single){
    vector<string> csl_src = cslArgs->getCslSourceFile();
    name = csl_src.at(0);
    int find = name.rfind(".",name.size());
    if(find!=string::npos){
      name.erase(find,name.size());
    }
  }
  
  if(csl_execution_stage!=6) return ;

  if(csl_info){
    DCOUT("cslom_code_gen"<<endl);
  }
    
  /**docGen*/
//  if(csl_info){
//    DCOUT("\t*** DocGen begin"<<endl);
//  }

//  auto_ptr<NSDocGen::CDocGen> docGen(new NSDocGen::CDocGen(name));
//  docGen->enableObjTraversal();
//  docGen->enableObjBeforeTraversal();
//  docGen->enableObjAfterTraversal();
//  docGen->enableObjInTraversal();
//  cslomDesign->acceptVisitor(*docGen);

//  if(csl_info){
//    DCOUT("\t*** DocGen end"<<endl<<endl);
//  }



  if(csl_cpp_gen){    
    /**CSLOM_CPP_Generator*/
    if(csl_info){
      DCOUT("\t*** cppcodegen_begin"<<endl);
    }
       
    if(csl_info){
      DCOUT("\t*** cppcodegen_end"<<endl<<endl);
    }
  }

  if(csl_csim_gen){    
    if(csl_info){
      DCOUT("\t*** csimcodegen_begin"<<endl);
    }
       
    auto_ptr<NSCCPPGenerator::CCPPGenerator> cppCodeGen(new NSCCPPGenerator::CCPPGenerator(m_dir + "generated_code/generated_cpp/"));
    cppCodeGen->enableObjTraversal();
    cppCodeGen->enableObjBeforeTraversal();
    cppCodeGen->enableObjAfterTraversal();
    cppCodeGen->enableObjInTraversal();
    cslomDesign->acceptVisitor(*cppCodeGen);
      
    if(csl_info){
      DCOUT("\t*** csimcodegen_end"<<endl<<endl);
    }
  }

}

void Cslc::cdomCodeGen(){
  int    csl_execution_stage  = cslArgs->getCsl_execution_stage();
  bool   csl_info             = cslArgs->isCsl_info();
  bool   csl_single           = cslArgs->isCsl_single();
  string name                 = cslArgs->getCsl_output_name();
//   string csl_output_directory = cslArgs->getCsl_output_directory();

  if(csl_single){
    vector<string> csl_src = cslArgs->getCslSourceFile();
    name = csl_src.at(0);
    int find = name.rfind(".",name.size());
    if(find!=string::npos){
      name.erase(find,name.size());
    }
  }
  
  if(csl_execution_stage!=6) return ;

  if(csl_info){
    DCOUT("CDOM code gen"<<endl);
  }
        
  /**CVerilogGenerator*/
  if(csl_info){
    DCOUT("\t*** verilogcodegen_begin"<<endl);
  }

  //  DCERR("!!!!!!!!!!!" << m_verilogDir + name);

  auto_ptr<NSCdomVerilogGenerator::CVerilogGenerator> cdomVerilogCodeGen(new NSCdomVerilogGenerator::CVerilogGenerator(m_verilogDir + name));
  cdomVerilogCodeGen->enableObjTraversal();
  cdomVerilogCodeGen->enableObjBeforeTraversal();
  cdomVerilogCodeGen->enableObjAfterTraversal();
  cdomVerilogCodeGen->enableObjInTraversal();
  cdomDesign->acceptVisitor(*cdomVerilogCodeGen);
    
  if(csl_info){
    DCOUT("\t*** verilogcodegen_end"<<endl<<endl);
  }
  
  
  
  if(csl_info){
    DCOUT("\t*** syscodegen_begin"<<endl);
  }

  //  
  //  string sysc_name = "SysC_generated_code.cpp";
  //  if(csl_single){
  //    sysc_name = name + ".cpp";
  //  }
  //
  //  auto_ptr<NSCdomSystemCGenerator::CSystemCGenerator> cdomSysCCodeGen(new NSCdomSystemCGenerator::CSystemCGenerator(sysc_name.c_str()));
  //  cdomSysCCodeGen->enableObjTraversal();
  //  cdomSysCCodeGen->enableObjBeforeTraversal();
  //  cdomSysCCodeGen->enableObjAfterTraversal();
  //  cdomSysCCodeGen->enableObjInTraversal();
  //  cdomDesign->acceptVisitor(*cdomSysCCodeGen);
  //    

  if(csl_info){
    DCOUT("\t*** syscodegen_end"<<endl<<endl);
  }
}

if(csl_info){
    DCOUT("\t*** schematiccodegen_begin"<<endl);
  }


  if(csl_info){
    DCOUT("\t*** schematiccodegen_end"<<endl<<endl);
  }
}

void Cslc::destroy(RefAST& ast) {
  if(!ast.get())
    return;
  // std::cerr << "before destroy" << endl;
  std::queue<RefAST> destroyQueue;
  destroyQueue.push(ast);
  ast = 0;
  RefAST temp1, temp2;
  while(!destroyQueue.empty()) {
    temp1 = destroyQueue.front();
    destroyQueue.pop();
    temp2 = temp1->getFirstChild();
    temp1->setFirstChild(RefAST(0));
    if(temp2.get())
      destroyQueue.push(temp2);
    temp2 = temp1->getNextSibling();
    temp1->setNextSibling(RefAST(0));
    if(temp2.get())
      destroyQueue.push(temp2);
    temp1 = 0;
    temp2 = 0;
  }
}


void Cslc::removeFile(string file_name) {
  fs::path full_path( fs::initial_path() );
  full_path = fs::system_complete(fs::path(file_name, fs::native));
  if(fs::exists(full_path) )
    if(!full_path.empty())
      fs::remove(full_path);
}



void Cslc::printLicence(){
  cout<<""<<endl;
  cout<<""<<endl;
  cout<<"Please read and accept the license below to continue."<<endl;
  cout<<""<<endl;
  cout<<"IMPORTANT - READ CAREFULLY BEFORE DOWNLOADING, ACCESSING OR USING THE"<<endl;
  cout<<"Chip Specification Language Compiler(cslc) (COLLECTIVELY, \"SOFTWARE\") OF Fastpath Logic, INC."<<endl;
  cout<<"YOUR USE OF THE SOFTWARE IS EXPRESSLY CONDITIONED UPON AND SUBJECT TO"<<endl;
  cout<<"YOUR AGREEMENT TO THESE TERMS AND CONDITIONS. IF YOU DO NOT AGREE TO"<<endl;
  cout<<"THESE TERMS AND CONDITIONS, DO NOT DOWNLOAD, ACCESS OR USE THE SOFTWARE"<<endl;
  cout<<"(REFER TO LICENCE.TXT DOCUMENT)"<<endl;
}

void Cslc::createDirectories(ECT compType) {
  try{
    if (m_dir.empty()) {
      m_dir = string("./");
      if (compType == CT_CSL_TO_VER) {
        if (cslTopUnitName.get()) {
          m_dir.append(*cslTopUnitName + "_");
        }
      }
      else {
        if (cdomTopModuleName.get()) {
          m_dir.append(*cdomTopModuleName);
        }
      }
      m_dir.append("cslc_generated/");
    }

    //root directory
    fs::create_directory(m_dir);

    //generated code root directory
    string genCodeDir = m_dir + "generated_code/";
    fs::create_directory(genCodeDir);

    //verilog directory
    m_verilogDir = genCodeDir + "generated_verilog/";
    fs::create_directory(m_verilogDir);

    //c++ directories
    m_cppDir = genCodeDir + "generated_cpp/";
    fs::create_directory(m_cppDir);
    fs::create_directory(m_cppDir + "units_execute_includes/");
    fs::create_directory(m_cppDir + "vectors_startGen_includes/");

    //systemC
    //......
  }catch(fs::filesystem_error &err){
    cerr << err.what() << endl;
  }
}

string Cslc::generateRandomFileName(int length){
  /**
   * literals: '_', 'a', 'b', ..., 'z', 'A', 'B', ..., 'Z', '0', ...,'9'
   *
   *            0    1    2        26    27  28        52    53      62          
  */
  string result;


  for(int i=0; i<length; ++i){
    int temp = (rand() % 63);
    if(temp == 0){
      result += '_';
    }else if(temp < 27){
      result += 'a' + temp - 1;
    }else if(temp < 53){
      result += 'A' + temp - 27;
    }else{
      result += '0' + temp - 53;
    }
  }

  return result;
}
