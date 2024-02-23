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

#include "cslc.h"
#include <iostream>
#include <string>

int main(int argc, char** argv) {
  NSCslc::Cslc cslc(argc, argv);
  CMD_EXIT_CODE exit_code=cslc.getCmdParserExitCode();

#ifdef MAC_MALLOC_DEBUG
printf("Done!");
  while (1) {
    // do nothing
  }
#endif

  if(exit_code == CMD_PARSE_FAILED){  
    return 1;
  }else if(exit_code == CMD_HELP){
    return 0;
  }

  //exit_code == CMD_PARSE_OK

  try{

    if(!cslc.cslToVerilog()){
      return 1;
    }

    if(!cslc.verToVer()){
       return 1;
    }

    cslc.cdomCodeGen();
  }catch(std::string error){
    std::cout<<error<<endl;
    return 1;
  }

  return (0);
}
