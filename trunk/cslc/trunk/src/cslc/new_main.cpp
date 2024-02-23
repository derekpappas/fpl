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

#include <signal.h>
#include "cslc_Platform.h"
#include "new_cslc.h"

// FIX THE ANT BUILD FILE TO INCLUDE THIS -I <path>
#include "../support/cli/cslcCLI_Typedef.h"
#include "../support/cli/cslcCLI_Support.h"

#ifndef __RLM_OFF
#include "license.h"
#endif

void signal_handler(int signal) {
  throw NSCslc::CSLcSignal();
}

void killSingletons() {
  //  NSCLi::CLiTool::Instance()->PrepareToDie();
  NSCLi::CLiTool::DestroyInstance();
  NSCLi::CLiCommon::DestroyInstance();
  NSCslc::CslcTool::DestroyInstance();
}

int main(int argc, char** argv) {


  // Kill the singletons on exit
  std::atexit(&killSingletons);

  //TODO: get 'component to run' status
  TInt cslcComponent = NSCslc::CslcTool::COMP_ALL;

# ifndef __RLM_OFF

  TChar rlmErrorMessage[RLM_ERRSTRING_MAX];
  RLM_HANDLE rlmHandle = NULL;
  RLM_LICENSE rlmLicense = NULL;
  const char* rlmProduct = "cslc";
  const char* rlmProductVersion = "1.0";
  int rlmStat;

  rlmHandle = ::rlm_init(".", argv[0], (char*)NULL);
  rlmStat = ::rlm_stat(rlmHandle);
  if (rlmStat) {
    ::rlm_errstring((RLM_LICENSE)NULL, rlmHandle, rlmErrorMessage);
    DCERR("Error initializing license: " << rlmErrorMessage);
  }
  else {
    rlmLicense = ::rlm_checkout(rlmHandle, rlmProduct, rlmProductVersion, 1);
    rlmStat = ::rlm_license_stat(rlmLicense);
    if (rlmStat == RLM_EL_INQUEUE) {
      DCERR("Queued to license for \'" << rlmProduct << "\'.");
    }
    else if (rlmStat) {
      ::rlm_errstring(rlmLicense, rlmHandle, rlmErrorMessage);
      DCERR("Error checking out license for \'" << rlmProduct << "\': " << rlmErrorMessage);
    }
  }

  if (rlmLicense) {
    ::rlm_checkin(rlmLicense);
  }
  ::rlm_close(rlmHandle);

  if (rlmStat) {
    return NSCslc::CslcTool::E_FATAL_ERROR;
  }

# else

  DCERR("You are running CSLC without RLM; you'd better be offline...");

# endif

  ::signal(SIGINT, signal_handler);

  NSCslc::RefCSLcMain compiler = NSCslc::CSLcMain::getCompilerInstance(&std::cout);

  int retVal = compiler->runCompiler(argc, argv, cslcComponent);

  compiler->cleanUp();

  return retVal;
}
