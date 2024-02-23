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

#ifndef INC_GUARD_CSIM_CMD_LINE_EXPR_NUM_H
#define INC_GUARD_CSIM_CMD_LINE_EXPR_NUM_H

#include "CsimCmdLineTypeDefs.h"
#include "CsimCmdLineExpr.h"

namespace NSCsimLib {

class CsimCmdLineExprNum : public CsimCmdLineExpr {

    TLongLong m_number;

    CsimCmdLineExprNum(TLongLong num);

  protected:

    RefCsimCmdLineExprNum  getThis() { return boost::static_pointer_cast<CsimCmdLineExprNum>(m_weakRef.lock()); }

  public:
    
    static RefCsimCmdLineExprNum build(TLongLong num);

    TLongLong doEval();

};

}


#endif // INC_GUARD_CSIM_CMD_LINE_EXPR_NUM_H

//END OF FILE

