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


#include "CsimCmdLineExprIdSignal.h"

namespace NSCsimLib {

CsimCmdLineExprIdSignal::CsimCmdLineExprIdSignal(RefTVec_RefString id, RefCsimSignalBase signal) : 
  CsimCmdLineExprId(id, EXPR_ID_TYPE_SIGNAL), m_signal(signal) {
  ASSERT(id.get(), "EXPR ID SIGNAL - null identifier received");
  ASSERT(!id->empty(), "EXPR ID SIGNAL - empty identifier received");
  ASSERT(signal.get(), "EXPR ID SIGNAL - undefined signal received");
}



RefCsimCmdLineExprIdSignal CsimCmdLineExprIdSignal::build(RefTVec_RefString id, RefCsimSignalBase signal) {
  ASSERT(id.get(), "EXPR ID SIGNAL - null identifier received");
  ASSERT(!id->empty(), "EXPR ID SIGNAL - empty identifier received");
  ASSERT(signal.get(), "EXPR ID SIGNAL - undefined signal received");
  
  CsimCmdLineExprIdSignal* idSignal;

  try {
    idSignal = new CsimCmdLineExprIdSignal(id, signal);
  }
  catch (std::exception& ex) {
    ASSERT(FAIL, "new operator failed");
  }

  RefCsimCmdLineExprIdSignal refIdSignal = RefCsimCmdLineExprIdSignal(idSignal);
  idSignal->m_weakRef = WeakRefCsimCmdLineExprIdSignal(refIdSignal);

  return refIdSignal;
}



TLongLong             CsimCmdLineExprIdSignal::doEval() {
  ASSERT(m_signal.get(), "this shouldn't happen");

  return *(*m_signal);
}


RefCsimSignalBase       CsimCmdLineExprIdSignal::getObj() {
  ASSERT(m_signal.get(), "this shouldn't happen");
  
  return m_signal;
}

};

//END OF FILE 


