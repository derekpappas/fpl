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


#include "CsimCmdLineExprIdUnit.h"

namespace NSCsimLib {

CsimCmdLineExprIdUnit::CsimCmdLineExprIdUnit(RefTVec_RefString id, RefCsimUnit unit) : CsimCmdLineExprId(id, EXPR_ID_TYPE_UNIT), 
                                                               m_unit(unit) {
  ASSERT(id.get(), "EXPR ID UNIT - null identifier received");
  ASSERT(!id->empty(), "EXPR ID UNIT - empty identifier received");
  ASSERT(unit.get(), "EXPR ID UNIT - null unit received");
}


RefCsimCmdLineExprIdUnit CsimCmdLineExprIdUnit::build(RefTVec_RefString id, RefCsimUnit unit) {
  ASSERT(id.get(), "EXPR ID UNIT - null identifier received");
  ASSERT(!id->empty(), "EXPR ID UNIT - empty identifier received");
  ASSERT(unit.get(), "EXPR ID UNIT - null unit received");

  CsimCmdLineExprIdUnit* u;

  try {
    u = new CsimCmdLineExprIdUnit(id, unit);
  }
  catch(std::exception& e){
    ASSERT(FAIL, "EXPR ID UNIT - new operator failed");
  }

  RefCsimCmdLineExprIdUnit refU = RefCsimCmdLineExprIdUnit(u);
  u->m_weakRef = WeakRefCsimCmdLineExprIdUnit(refU);

  return refU;
}


RefCsimUnit              CsimCmdLineExprIdUnit::getUnit() { return m_unit; }

TLongLong                     CsimCmdLineExprIdUnit::doEval() { return 0; }

}

//END OF FILE 


