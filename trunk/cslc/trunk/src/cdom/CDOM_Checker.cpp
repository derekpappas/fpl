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
//-----------------------------------------------------------------------


#include <iostream>
#include "CDOM_Checker.h"
#include "../csl_xml_warn_error/we_logic.h"
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../support/ErrorAPI.h"


//extern std::vector<std::string> args;

/*
 *errors is the only instance of the CslWE singleton class
 */
//extern NSWarnError::RefCslWE errors;

/*
 *converts an int to a string
 */
//std::string intToString(int val);

/*
 *adds an error;
 *err is the code of the error(an enum->see csl_xml_warn_error/CSLC_Errors.h)
 *args is the vector of arguments for the error
 *line is the line number the error has occured
 *isFatal flags the error as fatal, that is, the compiler will stop if such an error has occured
 */
//void addErr(NSWarningErr::all_errors err, std::vector<std::string>& args, TLineNumberType line = 0, bool isFatal = false);

using namespace std;

RefString cdomTopModuleName = RefString(new std::string(""));

namespace NSCdomChecker {

/*
 *CDOmChecker class
 *
 */

CDOmChecker::CDOmChecker(){}
CDOmChecker::~CDOmChecker(){}

void CDOmChecker::beforeTraversal(const NSCdom::RefCDOmDesign                          & design                      ) {
  my_design = design;
}

void CDOmChecker::beforeTraversal(const NSCdom::RefCDOmModuleDecl                      & moduleDecl                  ) {
  //this creates the string that will be used by main to generate path names
  if(moduleDecl->isTopModule()){
    (*(cdomTopModuleName)).append(*(moduleDecl->getModuleName())+"_");
  }
}

void CDOmChecker::beforeTraversal(const NSCdom::RefCDOmModuleOrUdpInstantiation        & moduleInstantiation         ) {
  RefCDOmExprLink moduleExprLink = moduleInstantiation->getModuleExprLink();
  RefString name = moduleExprLink->getName();
  RefCDOmScope scope = my_design->getAttachedScope();

  if ( !scope->containsID(name) ){
    bool alreadyAdded = false;
    for (int i = 0; i < undef.size(); ++i){
      if ( undef[i] == name && !alreadyAdded ){
        alreadyAdded = true;
      } else if( alreadyAdded ){
        i = undef.size() - 1;
      }
    }
    if ( !alreadyAdded ){
      undef.push_back(name);
    }
  }
}

void CDOmChecker::afterTraversal(const NSCdom::RefCDOmDesign                          & design                      ) {
  for ( int i = 0; i < undef.size(); ++i) {
    args.push_back(*(undef[i]));
    addErr(NSWarningErr::VEE_VEP_MOD_UNDEFINED_MOD_CSCVE, args);
    //cerr << "Warning: Undefined module: " << *undef[i];
  }
  //    cerr << endl;
}

std::vector<RefString>& CDOmChecker::getUndefModuleVect() {
  return undef;
}

}
