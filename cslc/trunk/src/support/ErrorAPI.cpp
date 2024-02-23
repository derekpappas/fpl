//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 FastPath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of FastPath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of FastPath Logic.
//
// RESTRICTED RIGHTS LEGEND:
// Use, duplication or disclosure by the Government is subject to
// restrictions as set forth in subdivision (c)(1)(ii) of the Rights in
// Technical Data and Computer Software clause at DFARS 252.227-7013,
// and/or in similar or succesor clauses in the FAR, DOD or NASA FAR Supplement.
// Unpublished rights reserved under the Copyright Laws of the United States
//----------------------------------------------------------------------

/**
 * Author: OvidiuB 
 */

#include <vector>
#include <string>
#include <iostream>
#include <sstream>
#include "TypeDefs.h"
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../csl_xml_warn_error/warn_err.h"
#include "../preproc/VPreprocessor.h"
//#include "Tracer.h"

//#include "ErrorAPI.h"
//#include "../cslc/verilogParser.h"

bool __traceOnFlagOption = false;


typedef std::pair<unsigned int, std::string> TmpLineMap;

class VPLineMap {
   std::map<unsigned int, TmpLineMap> lines;
 public:
   void insert(unsigned int, unsigned int, std::string);
   TmpLineMap get(unsigned int);
   void clear();
};

VPLineMap lineMap;

std::stack<const NSVerilogPreprocessor::CLineMapProcessor*> tempLineMap;

std::string getCurrentParsedFile();



void VPLineMap::insert(unsigned int tempLine, unsigned int origLine, std::string origFile){
  std::cout << "********inserting : line " << tempLine << " corresponds to line " << origLine << " from file " << origFile << "********\n";
  lines[tempLine] = make_pair(origLine, origFile);
}

void VPLineMap::clear() {
  lines.clear();
}

TmpLineMap VPLineMap::get(unsigned int tempLine){
  //test to see if lined mapped
  return lines[tempLine];
}
  
//current parsed file
std::stack<std::string>  currentParsedFile;

std::string getCurrentParsedFile(){
  std::string ret("to be implemented");
  //  std::cout << std::string("**getCurrentParsedFile**") << currentParsedFile.top() << std::endl;
  if (!currentParsedFile.empty()){
    ret = currentParsedFile.top();
  } 
  return ret;
}

std::vector<std::string> args;

NSWarnError::RefCslWE errors = NSWarnError::CslWE::Instance();

std::string intToString(int val) {
  std::stringstream ss;
  ss << val;
  return ss.str();
  }



void addErr(NSWarningErr::all_errors err, std::vector<std::string>& args, TLineNumberType line = 0, RefString file = RefString(), TBool isFatal = FALSE, TBool isDesErr = FALSE) {
  /*std::vector<NSWarnError::RefString> allArgs;
  if(line) {
    //////ADDED NEXT LINE
    allArgs.insert(allArgs.begin(),NSWarnError::RefString(new std::string("bla")));
    ////////////

    allArgs.push_back(NSWarnError::RefString(new std::string(intToString(line))));//MODIFIED THIS LINE(push_back changed to insert(begin(),...))
  }
  for(int i = 0; i < args.size(); ++i) {
    NSWarnError::RefString arg(new std::string(args[i]));
    allArgs.push_back(arg);
  }
  errors->addWarnError(err, allArgs);
  if(isFatal) {
    errors->foundFatal();
  }
  args.clear();   */

/*  DO NOT ERASE THIS COMMENT. PLEASE !!!!!!*/
 std::vector<NSWarnError::RefString> allArgs;
// if (line && getCurrentParsedFile().substr(0, 3) == "tmp" && getCurrentParsedFile().substr(getCurrentParsedFile().find_last_of(".")) == ".temp" ){
//   NSWarnError::RefString arg(new std::string(lineMap.get(line).second.c_str()));
//   allArgs.push_back(arg);
//   line = lineMap.get(line).first;
//   allArgs.push_back(NSWarnError::RefString(new std::string(intToString(line))));
// }
// else if (line){
//   std::vector<NSVerilogPreprocessor::TIncludeMap> filePath;
//   if (!tempLineMap.empty()){
//     line = tempLineMap.top()->traceLine(line, filePath);
//   }
//   NSWarnError::RefString arg(new std::string(getCurrentParsedFile().c_str()));
//   allArgs.push_back(arg);
//   allArgs.push_back(NSWarnError::RefString(new std::string(intToString(line))));
// }
// for(int i = 0; i < args.size(); ++i) {
//   NSWarnError::RefString arg(new std::string(args[i]));
//   allArgs.push_back(arg);
// }
 RefString arg;
 if (!isDesErr) {
   if (file.get()) {
     arg = RefString(new std::string(*file));
   }
   else {
     arg = RefString(new std::string(getCurrentParsedFile()));
   }
   allArgs.push_back(arg);
   allArgs.push_back(RefString(new std::string(intToString(line))));
 }
 for(unsigned int i = 0; i < args.size(); ++i) {
   arg = RefString(new std::string(args[i]));
   allArgs.push_back(arg);
 }
 
 errors->addWarnError(err, allArgs);
 if(isFatal) {
   errors->foundFatal(err);
 } 
 args.clear();
}
