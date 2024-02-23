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


#ifndef _CSLC_H
#define _CSLC_H

#include <iostream>
#include <iomanip>
#include <fstream>
#include <cstdlib>
#include <cstdio>
#include <memory>
#include <queue>
#include <string>
#include <map>
#include "../cdom/Base.h"
//#include "../parser/verilog/Base.hpp"
#include "../parser/verilog/VerilogToken.hpp"
#include "../parser/verilog/VerilogLexer.hpp"
#include "../parser/verilog/VerilogParser.hpp"
#include "../parser/verilog/VerilogTreeWalker.hpp"
#include "../parser/verilog/VerAST.hpp"
#include "../parser/verilog/VParserErrorCodes.hpp"
#include "../preproc/VPreprocessor.h"
#include "../cdom/CDOM.h"

#ifndef v2v // --- v2v ---

//#include "../parser/csl/Base.hpp"
#include "../parser/csl/CslToken.hpp"
#include "../parser/csl/CslLexer.hpp"
#include "../parser/csl/CslParser.hpp"
#include "../parser/csl/CslTreeWalker.hpp"
#include "../parser/csl/CslAST.hpp"
#include "../parser/csl/CParserErrorCodes.hpp"
#include "../cdom/CDOM.h"

#endif // --- v2v ---

#include "../cdom/VeriNum.h"
#include "../cdom/CDOM_Visitor.h"

#ifndef v2v // --- v2v ---

#include "../cslom/CSLOM.h"
#include "../cslom/CSLOM_Visitor.h"
#include "../cslom2cdom_adapter/Adapter.h"

#endif  // --- v2v ---

#include "../support/RefCount.h"
#include "../support/CommonSupport.h"
//#include "../support/cli/CslArgumentSupport.h"

using namespace NSCSLOm;
using namespace NSCdom;
namespace NSCslc {

typedef enum _ECT {
  CT_CSL_TO_VER,
  CT_VER_TO_VER
} ECT;

class Cslc{
  private:
  //  RefCslArgs     cslArgs;
  //  RefVerilogArgs verilogArgs;
    string         m_dir;
    string         m_verilogDir;
    string         m_cppDir;

    RefCSLOmDesign cslomDesign;
    RefCDOmDesign  cdomDesign;
    
   // CMD_EXIT_CODE cmdParserExitCode;

    void printLicence();

    //for the preprocessor
    string generateRandomFileName(int length);

    //not my functions
    void destroy(RefAST& ast);
    void removeFile(string file_name);

  public:
    Cslc(int argc,char *argv[]);
    ~Cslc();

    int cslToVerilog();
    int verToVer();

   // CMD_EXIT_CODE getCmdParserExitCode();

    void cslomCodeGen();
    void cdomCodeGen();

    void createDirectories(ECT compType);
};


} 

#endif
