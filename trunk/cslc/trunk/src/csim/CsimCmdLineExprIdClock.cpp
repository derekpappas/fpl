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


#include "CsimCmdLineExprIdClock.h"

namespace NSCsimLib {

CsimCmdLineExprIdClock::CsimCmdLineExprIdClock(RefTVec_RefString id, RefCsimClock clock) : CsimCmdLineExprId(id, EXPR_ID_TYPE_CLOCK), 
                                                               m_clock(clock) {
  ASSERT(id.get(), "EXPR ID CLOCK - null identifier received");
  ASSERT(!id->empty(), "EXPR ID CLOCK - empty identifier received");
  ASSERT(clock.get(), "EXPR ID CLOCK - null clock received");
}


RefCsimCmdLineExprIdClock CsimCmdLineExprIdClock::build(RefTVec_RefString id, RefCsimClock clock) {
  ASSERT(id.get(), "EXPR ID CLOCK - null identifier received");
  ASSERT(!id->empty(), "EXPR ID CLOCK - empty identifier received");
  ASSERT(clock.get(), "EXPR ID CLOCK - null clock received");

  CsimCmdLineExprIdClock* clk;

  try {
    clk = new CsimCmdLineExprIdClock(id, clock);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "EXPR ID CLOCK - new operator failed");
  }

  RefCsimCmdLineExprIdClock refClk = RefCsimCmdLineExprIdClock(clk);
  clk->m_weakRef = WeakRefCsimCmdLineExprIdClock(refClk);

  return refClk;
}


RefCsimClock             CsimCmdLineExprIdClock::getObj() { return m_clock; }

TLongLong                CsimCmdLineExprIdClock::doEval() { return 0; }

};

//END OF FILE 


