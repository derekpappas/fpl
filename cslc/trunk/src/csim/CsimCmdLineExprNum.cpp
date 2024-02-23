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


#include "CsimCmdLineExprNum.h"


namespace NSCsimLib {


CsimCmdLineExprNum::CsimCmdLineExprNum(TLongLong num) : CsimCmdLineExpr(EXPR_TYPE_NUM), m_number(num) {}

RefCsimCmdLineExprNum CsimCmdLineExprNum::build(TLongLong num) {
  
  CsimCmdLineExprNum* number;

  try {
    number = new CsimCmdLineExprNum(num);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "EXPR NUM - new operator failed");
  }

  RefCsimCmdLineExprNum refNumber = RefCsimCmdLineExprNum(number);
  number->m_weakRef = WeakRefCsimCmdLineExprNum(refNumber);

  return refNumber;
}

TLongLong CsimCmdLineExprNum::doEval() { return m_number; }


}


//END OF FILE 

