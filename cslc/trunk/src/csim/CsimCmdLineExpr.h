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

#ifndef INC_GUARD_CSIM_CMD_LINE_EXPR_H
#define INC_GUARD_CSIM_CMD_LINE_EXPR_H

#include "CsimCmdLineTypeDefs.h"

namespace NSCsimLib {

class CsimCmdLineExpr {
  
    EExprType                    m_type;

    RefTVec_RefCsimCmdLineExpr   m_children;

    WeakRefCsimCmdLineExpr       m_parent;

    //usefull for expression tree evaluation - when an expression sub-tree
    //should act as one expression, e.i.  '(a+b)' in 'c + (a+b) + d'

    TBool                        m_locked;

  protected:

    WeakRefCsimCmdLineExpr       m_weakRef;

    CsimCmdLineExpr(EExprType type);

    RefCsimCmdLineExpr getThis() { return boost::static_pointer_cast<CsimCmdLineExpr>(m_weakRef.lock()); }

  public:

    virtual ~CsimCmdLineExpr();

    virtual TLongLong doEval() = 0;

    EExprType                   getType();

    RefTVec_RefCsimCmdLineExpr  getChildren();

    void                        addChild(RefCsimCmdLineExpr child);

    void                        addChildAtPos(RefCsimCmdLineExpr child, TUInt pos);

    void                        setParent(RefCsimCmdLineExpr parent);

    RefCsimCmdLineExpr          getParent();

    TBool                       isNum();

    TBool                       isId();

    TBool                       isOp();

    void                        lock();

    TBool                       isLocked();

    virtual TBool               hasMaxNoOfChildren();
};

}


#endif // INC_GUARD_CSIM_CMD_LINE_EXPR_H

//END OF FILE
