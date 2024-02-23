//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007 Fastpath Logic
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


#include "CsimCmdLine.h"


namespace NSCsimLib {



CsimCmdLine::CsimCmdLine() : m_cmdPrompt(new std::string("shell>"))/*, m_inputSource(&std::cin), m_output(&std::cout)*/ {}



void CsimCmdLine::setCmdPrompt(RefString& prompt) {  
  ASSERT(prompt.get(), "null prompt received");
  ASSERT(!prompt->empty(), "empty prompt received");

  m_cmdPrompt = RefString(new std::string(*prompt));
}


//void CsimCmdLine::setInputSrc(TIStreamP& inputSrc) { m_inputSource = inputSrc; }


//void CsimCmdLine::setOutput(TOStreamP& output) { m_output = output; }


RefString CsimCmdLine::getNextCmd() {

  RefString cmd = RefString(new std::string(readline(m_cmdPrompt->c_str())));

  add_history(cmd->c_str());

  return cmd;
}

void CsimCmdLine::print(RefString& out) {

  std::cout << *out << std::endl;
}


}

//END OF FILE
