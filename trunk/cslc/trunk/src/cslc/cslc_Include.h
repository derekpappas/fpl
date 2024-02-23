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

#ifndef INC_GUARD_cslc_Include_h_
#define INC_GUARD_cslc_Include_h_

#include <iostream>
#include <fstream>

#include <vector>
#include <queue>
#include <map>

//TODO: these should be included somewhere else before the cslc main
#include <antlr/CharStreamException.hpp>
#include <antlr/CharStreamIOException.hpp>
#include <antlr/IOException.hpp>
#include <antlr/NoViableAltException.hpp>
#include <antlr/NoViableAltForCharException.hpp>
#include <antlr/TokenStreamException.hpp>
#include <antlr/TokenStreamIOException.hpp>
#include <antlr/TokenStreamRecognitionException.hpp>
#include <antlr/TokenStreamRetryException.hpp>

#include "../support/CommonSupport.h"

#include "../support/Base.hpp"
#include "../parser/verilog/VerilogToken.hpp"
#include "../parser/verilog/VerilogLexer.hpp"
#include "../parser/verilog/VerilogParser.hpp"
#include "../parser/verilog/VerilogTreeWalker.hpp"
#include "../parser/verilog/VerAST.hpp"
#include "../parser/verilog/VParserErrorCodes.hpp"

#include "../preproc/Preproc.h"
#include "../preproc/CSLcPP.h"

#ifndef v2v

#include "../support/Base.hpp"
#include "../parser/csl/CslToken.hpp"
#include "../parser/csl/CslLexer.hpp"
#include "../parser/csl/CslParser.hpp"
#include "../parser/csl/CslTreeWalker.hpp"
#include "../parser/csl/CslAST.hpp"
#include "../parser/csl/CParserErrorCodes.hpp"

#include "../csl_xml_warn_error/WESAXHandlers.h"

#include "../cslom/CSLOM.h"
#include "../cslom_generators/CSLOM_GUI_XML_generator.h"
#include "../cslom_generators/CSLOM_GUI_CSL_generator.h"
#include "../cslom_generators/CSLOM_VerilogDefineGenerator.h"
#include "../cslom_generators/CSLOM_PDF_Generator.h"
#include "../cslom_generators/CSLOM_CPP_Generator.h"
#include "../cslom_generators/CSIM_CPP_Generator.h"
//---------MS added----start
#include "../cslom_generators/CSLOM_VerilogTbCodeGenerator.h"
#include "../cslom_generators/CSLOM_VerilogTbInterface.h"
#include "../cslom_generators/CSLOM_VerilogTbTestbench.h"
#include "../cslom_generators/CSLOM_CslCodeGenerator.h"
#include "../cslom_generators/CSLOM_CslTmplDriver.h"
//--------end--------------
#include "../autorouter/CSLOM_InstTreeVisitor.h"
#include "../autorouter/CSLOM_ConnectionChecker.h"

#include "../cslom_design_checker/CSLOM_Design_Checker.h"

#include "../cslom2cdom_adapter/Adapter.h"

#endif //v2v

#include "../support/cli/cslcCLI.h"

#include "../cdom/CDOM.h"
#include "../cdom/CDOM_Checker.h"
#include "../cdom/CDOM_VerilogGenerator.h"
//----------MS added----------------------
#include "../cdom/CDOM_StimExpGenerator.h"
#include "../cdom/CDOM_VerilogStimExpMemory.h" 
//---------------------------------------- 
#include "../cdom/CDOM_VHDLGenerator.h"
//-------OB added----start
#include "../cdom/CDOM_SystemCGenerator.h"
#include "../cdom/CDOM_SchematicCodeGenerator.h"
//-------end


#endif //INC_GUARD_cslc_Include_h_
