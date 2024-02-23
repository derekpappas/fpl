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


#include "CsimTypeDefs.h"
#include <readline/readline.h>
#include <readline/history.h>



#ifndef INC_GUARD_CSIM_CMD_LINE
#define INC_GUARD_CSIM_CMD_LINE


namespace NSCsimLib {

  
class CsimCmdLine {

    //  typedef std::istream*  TIStreamP;   

    //  typedef std::ostream*  TOStreamP;

  typedef char*     TCharP;



  RefString   m_cmdPrompt;

    //  TIStreamP   m_inputSource;

    //  TOStreamP   m_output;

    //  RefString   m_lastCommand;

public:

  CsimCmdLine() ;

  void setCmdPrompt(RefString& prompt);


    //  void setInputSrc(TIStreamP& inputSrc); 


    //  void setOutput(TOStreamP& output);


  RefString getNextCmd();


  void print(RefString& out);
  

};

}


#endif // INC_GUARD_CSIM_CMD_LINE


//END OF FILE
