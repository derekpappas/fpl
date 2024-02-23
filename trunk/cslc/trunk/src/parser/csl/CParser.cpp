// //----------------------------------------------------------------------
// // Copyright (c) 2006 Fastpathlogic
// // All Rights Reserved.
// // This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpathlogic;
// // the contents of this file may not be disclosed to third parties,
// // copied or duplicated in any form, in whole or in part, without the prior
// // written permission of Fastpathlogic.
// //
// // RESTRICTED RIGHTS LEGEND:
// // Use, duplication or disclosure by the Government is subject to
// // restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// // Technical Data and Computer Software clause at DFARS 252.227-7013,
// // and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// // Unpublished rights reserved under the Copyright Laws of the United States
// //----------------------------------------------------------------------

// /*
//  *   Part of the Csl parser
//  *   Author: David Mishelashvili <dm@internet.ge>
//  *   2005
//  */

// #include <iostream>
// #include <iomanip>
// #include <fstream>
// #include <cstdlib>
// #include <cstdio>
// #include <memory>
// #include <queue>
// #include "Base.hpp"
// #include "CslToken.hpp"
// #include "CslLexer.hpp"
// #include "CslParser.hpp"
// #include "CslTreeWalker.hpp"
// #include "CslAST.hpp"
// #include "CParserErrorCodes.hpp"
// #include "../../cdom/CDOM.h"
// #include "../../cdom/VeriNum.h"
// #include "../../cdom/CDOM_Visitor.h"
// #include "../../cslom/CSLOM.h"
// #include "../../cslom/CSLOM_Visitor.h"
// #include "../../cslom2cdom_adapter/Adapter.h"

// ANTLR_USING_NAMESPACE(std);
// ANTLR_USING_NAMESPACE(antlr);

// const char *version = "v1.0(dev)";

// int parse_file(const char *filename, int ast_flag, int info_flag,  int stage, int preproc_flag);
// int process_batch_file(const char *batch_file, int ast_flag, int info_flag, int stage, int preproc_flag);
// void strip_quotes(char *str);
// int arguments(int argc,char *argv[]);
// void destroy(RefAST &ast);

// void print_version()
// {
//   cout << "Csl parser " << version << endl;
// }

// void print_usage(const char *progname)
// {
//   cout << "Usage: " << progname << " "
//     << "[-f filename] [-b batch_file] [-s stage] [-aivph?]" << endl
//     << "   stage=0             preprocessor" << endl
//     << "   stage=1             lexer+parser" << endl
//     << "   stage=2             walker(treeparser)/CDOM" << endl
//     << "Options:" << endl
//     << "   -a                  print AST (requires a filename)" << endl
//     << "   -i                  info messages (requires a filename)" << endl
//     << "   -v                  print version " << endl
//     << "   -p                  do not run prepocessor " << endl
//     << "   -h or -?            help" << endl;
// }

// int main(int argc, char *argv[]) {
//   int i;
//   i=arguments(argc,argv);
//   return i;
// }
// int arguments(int argc,char *argv[])
// {
  
//   char *filename = NULL;
//   char *batch_file = NULL;
//   int ast_flag = 0;
//   int info_flag = 0;
//   int stage = 20;
//   int preproc_flag = 0;
//   int noIncrement = 0;

//   int i=1;
//   unsigned j=1;
//   if(argc==1) //no cmd line args except argv[0]
//   {
//     print_usage(argv[0]);
//     return 0;
//   }
//   int nr=8;
//   int cmdarg[nr];
//   for(i=0 ;i<nr; i++)
//     cmdarg[i]=0;
//   i=1;
//   while(i<argc){
//     if(argv[i][0]!='-'){
//       print_usage(argv[0]);
//       return CSLPARSER_NO_INPUT_FILES;
//     }    
//     unsigned aux =strlen(argv[i]);
//     j=1;
//     while(j < aux){
//       char c = argv[i][j];
//       switch (c) {
//       case 'b':
//         if(j!=1){ 
//           cout << "-b option cannot be preceded by any other option within the same cmd line arg" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//         }


//         if(cmdarg[0]==0){
//           if(argv[i+1] == NULL){
//             cout << "No batch file name specified" <<endl;
//             print_usage(argv[0]);
//             return CSLPARSER_NO_INPUT_FILES;
//           }
//           else if(argv[i+1][0] == '-') {
//             cout << "No batch file name specified" <<endl;
//             print_usage(argv[0]);
//             return CSLPARSER_NO_INPUT_FILES;
//           }
//           else {
//             batch_file=argv[i+1];
//             cmdarg[0]=1;
//           }
//         }
//         else{
//           cout << "Only one batch file is required" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//         }
//         if(aux>2){
//           cout << "-b option cannot be followed by any other option within the same cmd line arg" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//         }
 
//         i++;//skip the bash file name
//         break;

//       case 'f': 
//         if(j!=1){ 
//           cout << "-f option cannot be preceded by any other option within the same cmd line arg" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//         }

//         if(cmdarg[1]==0){
//           if(argv[i+1] == NULL){
//             cout << "No file name specified" <<endl;
//             print_usage(argv[0]);
//             return CSLPARSER_NO_INPUT_FILES;
//           }
//           else if(argv[i+1][0] == '-') {
//             cout << "No file name specified" <<endl;
//             print_usage(argv[0]);
//             return CSLPARSER_NO_INPUT_FILES;
//           }
//           else {
//             filename=argv[i+1];
//             cmdarg[1]=1;
//           }
//         }
//         else{
//           cout << "Only one file is required" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//           }
//         if(aux>2){
//           cout << "-f option cannot be followed by any other option within the same cmd line arg" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//         }
//         i++;//skip the file name
//         break;

//       case 's':
//         if(j!=1){ 
//           cout << "-s option cannot be preceded by any other option within the same cmd line arg" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//         }
//         if(cmdarg[2]==0){
//           if(argv[i+1] == NULL)          //./cslparser -f sample.csl -s
//             noIncrement = 1;
//           else if(argv[i+1][0] == '-')   //./cslparser -f sample.csl -s -ai
//             noIncrement = 1;
//           else {                           //./cslparser -f sample.csl -s 1 -ai
//             stage = atoi(argv[i+1]);
//             cmdarg[2]=1;
//           }
//         }
//         else{
//           cout << "Stage option can only be stated once" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//           }
//         if(aux>2){
//           cout << "-s option cannot be followed by another option within the same cmd line arg" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//         }
//         if(!noIncrement)
//           i++;//skip stage indicator
//         break;

//       case 'a':
//         if(cmdarg[3]==0){
//           ast_flag = 1;
//           cmdarg[3]=1;
//         }
//         else{
//           cout << "Print AST option can only be stated once" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//           }
//         break;

//       case 'i': 
//         if(cmdarg[4]==0){
//           info_flag = 1;
//           cmdarg[4]=1;
//         }
//         else{
//           cout << "Print info option can only be stated once" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//           }

//         break;

//       case 'v':
//        if(cmdarg[5]==0 && cmdarg[6]==0) {
//          cmdarg[5] = 1;
//        }
//        else {
//         cout <<  "Print version option can only be stated once and NOT in a combination with h or ? options" << endl;
//         print_usage(argv[0]);
//         return CSLPARSER_NO_INPUT_FILES;
//        }
//       break;

//       case 'h':
//        if(cmdarg[6]==0 && cmdarg[5]==0){
//          cmdarg[6]=1;
//          print_usage(argv[0]);
//          return CSLPARSER_BAD_ARGS;
//        }
//        else{
//           cout << "Help(h or ?) option can only be stated once and NOT in a combination with v option" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//        }
//        break;
//       case '?':
//        if(cmdarg[6]==0 && cmdarg[5]==0){
//          cmdarg[6]=1;
//          print_usage(argv[0]);
//          return CSLPARSER_BAD_ARGS;
//       }
//        else{
//           cout << "Help(h or ?) option can only be stated once and not in a combination with v option" << endl;
//           print_usage(argv[0]);
//           return CSLPARSER_NO_INPUT_FILES;
//        }
//        break;
//       case 'p': 
//        if(cmdarg[7]==0) {
//          cmdarg[7]=1;
//          preproc_flag = 1;
//        }
//        else {
//          cout << "Preprocessor option can only be stated once " << endl;
//          print_usage(argv[0]);
//          return CSLPARSER_NO_INPUT_FILES;
//        }
//        break;

//       default: 
//         print_usage(argv[0]);
//         return CSLPARSER_BAD_ARGS;

//       }
//       j++;
//     }
//     i++;
//   }
    
//   if(cmdarg[5]) {
//     print_version();
//     return CSLPARSER_BAD_ARGS;
//   }
//   if(cmdarg[0] && cmdarg[1])
//   {
//     cout << "Illegal combination! File or batch file?" << endl;
//     print_usage(argv[0]);
//     return CSLPARSER_NO_INPUT_FILES;
//   }
//   if(!cmdarg[0] && !cmdarg[1] && !cmdarg[5])
//   {
//     cout << "File or batch file required" << endl;
//     print_usage(argv[0]);
//     return CSLPARSER_NO_INPUT_FILES;
//   }

//   if (filename != NULL) { // read a single file
//     int returned=parse_file(filename, ast_flag, info_flag,  stage, preproc_flag);
//     //remove((string(filename)+string(".temp")).c_str());
//     return returned;
//   }

//   if (batch_file != NULL) { // read a batch file which contains n files
//     return process_batch_file(batch_file, ast_flag, info_flag,  stage, preproc_flag);
//   }
  

//   print_usage(argv[0]);
//   return CSLPARSER_NO_INPUT_FILES;
// }
// // remove the leading quotes from a string


// void strip_quotes(char *str) {
//   if (*str == '"')
//   {
//     while (*str)
//       *str = *(++str);
//     if (*(----str) == '"')
//       *str = '\0';
//   }
// }

// // read a list of files 

// int process_batch_file(const char *batch_file, int ast_flag,
//     int info_flag, int stage, int preproc_flag)
// {
//   const char *DELIM = " \t";
//   const int MAX_LINE = 512;
//   char buf[MAX_LINE];

//   if (info_flag)
//     cout << "*** Processing batch file: " << batch_file << endl;

//   ifstream bf(batch_file);

//   if (!bf)
//   {
//     cerr << "Unable to open file for reading: " << batch_file << endl;
//     return CSLPARSER_BATCH_FILE_OPEN_FAILURE;
//   }


//   while (!bf.eof())
//   {
//     bf.getline(buf, MAX_LINE);

//     int r;	
//     char *tok1 = strtok(buf, DELIM);
//     char *tok2;
//     if (tok1)
//     {
//       if (strcmp(tok1, "add_file") == 0)
//       {
//         tok2 = strtok(NULL, DELIM);
//         if (strcmp(tok2, "-verilog") == 0)
//         {
//           char *tok3 = strtok(NULL, DELIM);
//           if(tok3)
//           {
//             strip_quotes(tok3);
//             r = parse_file(tok3, ast_flag, info_flag, stage, preproc_flag);
//             if (r < 0)
//               return r;
//           }
//         }
//       }
//       else
//       {
//         tok2 = strtok(NULL, DELIM);
//         if (!tok2) // there is only a file name
//         {
//           r = parse_file(tok1, ast_flag, info_flag, stage, preproc_flag);
//           if (r < 0)
//             return r;
//         }
//       }
//     }

//     //cout << buf << endl;
//   }

//   if (info_flag)
//     cout << "*** Batch file procesing is over" << endl;

//   return 0;
// }

// int parse_file(const char *filename, int ast_flag,
//     int info_flag, int stage, int preproc_flag)
// {
//   RefAST ast;
//   NSCSLOm::RefCSLOmDesign design = NSCSLOm::CSLOmDesign::build();
//   RefTVec_RefString vCurrentScope = RefTVec_RefString(new TVec_RefString);
//   try
//   {
//     string name = string(filename);
    
//     ifstream input(name.c_str());
//     if (!input)
//     {
//       cerr << "Unable to open file for reading: " << name << endl;
//       return CSLPARSER_INPUT_FILE_OPEN_FAILURE;
//     }

//     if (info_flag)
//     {
//       cout << "*** Parsing file: " << name << endl;
//     }

//     if( stage <= 0 ) {
//       return 0;
//     }

//     CslLexer lexer(input);
//     lexer.setFilename(name);
//     lexer.setTokenObjectFactory(&CslToken::factory);

//     auto_ptr<CslParser> parser(new CslParser(lexer));
//     parser->setFilename(name);
//     ASTFactory ast_factory("CslAST", CslAST::factory);
//     parser->initializeASTFactory(ast_factory);
//     parser->setASTFactory(&ast_factory);

//     parser->source_text();
//     ast = parser->getAST();
//     if(ast)
//     {
// #if !SILENT
//       if (ast_flag)
//       {
//         cout << "*** Printing AST" << endl;
//         cout << ast->toStringList() << endl;
//         cout << endl;
//       }
// #endif

//       if( stage <= 1 ) {
//         return 0;
//       }
//       if (stage>=2)
//       {
//         if (info_flag)
//           cout << "*** Walking" << endl;
//         CslTreeWalker walker;
//         walker.initializeASTFactory(ast_factory);
//         walker.setASTFactory(&ast_factory);

//         walker.source_text(RefCslAST(ast), design, vCurrentScope);

//         if( stage >= 3 ) {//TODO fix flow control problem
//           //NSCdom::RefCDOmDesign cdomDesign = NSCdom::CDOmDesign::build();
//           //auto_ptr<NSCSLOmVisitor::CVisitor> adapterVisitor(new NSAdapter::CAdapterToCDOM(cdomDesign));
//           //design->acceptVisitor(*adapterVisitor);
//           //string outputFileName(name+string(".v"));
//           //auto_ptr<NSCdomVisitor::CVisitor> cdomCodeGen(new NSCdomVisitor::CVerilogGenVisitor(outputFileName.c_str()));
//           //cdomDesign->acceptVisitor(*cdomCodeGen);
//         }

//         if (info_flag)
//           cout << "*** Done walking" << endl;
//       }
//       else
//         if (info_flag)
//           cout << "*** Parsing done (TW/CSLOm is disabled)" << endl;
//     }
//     else
//     {
//       cerr << "No AST constructed" << endl;
//     }
    
    
//   }
//   catch(RecognitionException &e) {
//     cerr << "ANTLR exception: " << e.toString() << endl;
//     return CSLPARSER_PARSING_EXCEPTION;
//   }
//   catch(ANTLRException& e)
//   {
//     cerr << "ANTLR exception: " << e.toString() << endl;
//     return CSLPARSER_PARSING_EXCEPTION;
//   }
//   catch(CslLexerException& ve)
//   {
//     const TCslLexerState &st = ve.state();
//     cerr << "Lexer<" << st.m_filename << ","
//       << st.m_line << ","
//       << st.m_col <<  ">: " << ve.what() << endl;
//     return CSLPARSER_LEXER_EXCEPTION;
//   }
//   catch(BaseException& be)
//   {
//     cerr << "Base Exception: " << be.what() << endl;
//     return CSLPARSER_BASE_EXCEPTION;
//   }
//   catch(NSBase::Exception& e)
//   {
//     cerr << "Exception: " << endl;
//     cerr << e.what() << "At line:" << e.getLineNumber() << endl;
//     return CSLPARSER_SYSTEM_EXCEPTION;
//   }
//   catch(exception& e)
//   {
//     cerr << "exception: " << e.what() << endl;
//     return CSLPARSER_SYSTEM_EXCEPTION;
//   }
 
//   if(ast.get()) {
//     destroy(ast);
//   }
//   return 0;
// }

// void destroy(RefAST &ast) {
//   if(!ast.get())
//     return;
//   std::cerr << "before destroy" << endl;
//   std::queue<RefAST> destroyQueue;
//   destroyQueue.push(ast);
//   ast = 0;
//   RefAST temp1, temp2;
//   while(!destroyQueue.empty()) {
//     temp1 = destroyQueue.front();
//     destroyQueue.pop();
//     temp2 = temp1->getFirstChild();
//     temp1->setFirstChild(RefAST(0));
//     if(temp2.get())
//       destroyQueue.push(temp2);
//     temp2 = temp1->getNextSibling();
//     temp1->setNextSibling(RefAST(0));
//     if(temp2.get())
//       destroyQueue.push(temp2);
//     temp1 = 0;
//     temp2 = 0;
//   }

//   std::cerr << "after destroy" << endl;
// }
// // End of File
