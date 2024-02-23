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

#ifndef INC_GUARD_CSIM_CMD_LINE_EXPR_TREE_H
#define INC_GUARD_CSIM_CMD_LINE_EXPR_TREE_H

#include "CsimCmdLineTypeDefs.h"
#include "CsimCmdLineExpr.h"
#include "CsimCmdLineExprOper.h"
#include "CsimCmdLineExprNum.h"
#include "CsimCmdLineExprId.h"

namespace NSCsimLib {


class CsimCmdLineExprTree {
    
    RefTVec_RefCsimCmdLineExpr          m_exprVec;

    TVec_RefCsimCmdLineExpr_iterator    m_currentExpr;

    RefCsimCmdLineExpr                  m_root;
    
    WeakRefCsimCmdLineExprTree          m_weakRef;

    TBool                               m_malformedExpr;

    RefCsimCmdLineExpr buildExprTree(TBool wasLParen = FALSE);

    void checkExprTree(RefCsimCmdLineExpr);

    void checkExprVec();

    CsimCmdLineExprTree(RefTVec_RefCsimCmdLineExpr   exprs);

  protected:

    RefCsimCmdLineExprTree getThis() { return boost::static_pointer_cast<CsimCmdLineExprTree>(m_weakRef.lock()); }

  public:

    static RefCsimCmdLineExprTree build(RefTVec_RefCsimCmdLineExpr   exprs);

    RefCsimCmdLineExpr                 getRootExpr();


    TLongLong                          doEval();

    void                               print();

    TBool                              isMalformed();

    TBool                              isNumber();

    TBool                              isIdentifier();

    TBool                              isRelationalExpression();

    TBool                              isArithmeticExpression();

    TBool                              isAssignment();

};


}


#endif // INC_GUARD_CSIM_CMD_LINE_EXPR_TREE_H

//END OF FILE



