//---------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpath Logic, Inc.
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic, Inc.;
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

/**
 * Author: OvidiuB
 */

#ifndef _ERROR_API_H
#define _ERROR_API_H

#include <vector>
#include <string>
#include <iostream>
#include <sstream>
#include "../preproc/VPreprocessor.h"
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "TypeDefs.h"
#include "../csl_xml_warn_error/warn_err.h"

/////////////////////////////////////////////////////////////////////////

typedef std::pair<unsigned int, std::string> TmpLineMap;

class VPLineMap {
   std::map<unsigned int, TmpLineMap> lines;
 public:
   void insert(unsigned int, unsigned int, std::string);
   TmpLineMap get(unsigned int);
   void clear();
};

extern VPLineMap lineMap;

extern std::stack<const NSVerilogPreprocessor::CLineMapProcessor*> tempLineMap;

extern std::stack<std::string>  currentParsedFile;

inline std::string getCurrentParsedFile(){
  std::string ret("unknown");
  //  std::cout << std::string("**getCurrentParsedFile**") << currentParsedFile.top() << std::endl;
  if (!currentParsedFile.empty()){
    ret = currentParsedFile.top();
  } 
  return ret;
}

////////////////////////////////////////////////////////////////////////

/*
 * the vector of arguments for the error
 */
extern std::vector<std::string> args;


extern NSWarnError::RefCslWE errors;

/*
 *converts an int to a string
 */
std::string intToString(int val);

/*
 *adds an error;
 *err is the code of the error(an enum->see csl_xml_warn_error/CSLC_Errors.h)
 *args is the vector of arguments for the error
 *line is the line number the error has occured
 *isFatal flags the error as fatal, that is, the compiler will stop if such an error has occured
 */
void addErr(NSWarningErr::all_errors err, std::vector<std::string>& args, TLineNumberType line = 0, RefString file = RefString(), TBool isFatal = FALSE, TBool isDesErr = FALSE) ;


#endif /*_ERROR_API_H*/
