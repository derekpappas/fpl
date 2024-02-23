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


#include "CsimCmdLineExprIdMemory.h"

namespace NSCsimLib {

CsimCmdLineExprIdMemory::CsimCmdLineExprIdMemory(RefTVec_RefString id, RefCsimMemoryBase memory) : 
  CsimCmdLineExprId(id, EXPR_ID_TYPE_MEM), m_memory(memory) {
  ASSERT(id.get(), "EXPR ID SIGNAL - null identifier received");
  ASSERT(!id->empty(), "EXPR ID SIGNAL - empty identifier received");
  ASSERT(memory.get(), "EXPR ID SIGNAL - undefined signal received");
}



CsimCmdLineExprIdMemory::RefCsimCmdLineExprIdMemory CsimCmdLineExprIdMemory::build(RefTVec_RefString id, RefCsimMemoryBase memory) {
  ASSERT(id.get(), "EXPR ID SIGNAL - null identifier received");
  ASSERT(!id->empty(), "EXPR ID SIGNAL - empty identifier received");
  ASSERT(memory.get(), "EXPR ID SIGNAL - undefined signal received");
  
  CsimCmdLineExprIdMemory* idMemory;

  try {
    idMemory = new CsimCmdLineExprIdMemory(id, memory);
  }
  catch (std::exception& ex) {
    ASSERT(FAIL, "new operator failed");
  }

  RefCsimCmdLineExprIdMemory refIdMemory = RefCsimCmdLineExprIdMemory(idMemory);
  idMemory->m_weakRef = CsimCmdLineExprIdMemory::WeakRefCsimCmdLineExprIdMemory(refIdMemory);

  return refIdMemory;
}



TLongLong             CsimCmdLineExprIdMemory::doEval() {
  ASSERT(m_memory.get(), "this shouldn't happen");

  return 0;
}


RefCsimMemoryBase     CsimCmdLineExprIdMemory::getObj() {
  ASSERT(m_memory.get(), "this shouldn't happen");

  return m_memory;
}

};

//END OF FILE 


