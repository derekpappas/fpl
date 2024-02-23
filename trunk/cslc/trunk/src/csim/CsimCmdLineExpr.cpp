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


#include "CsimCmdLineExpr.h"


namespace NSCsimLib {


CsimCmdLineExpr::CsimCmdLineExpr(EExprType type) : m_type(type), m_children(new TVec_RefCsimCmdLineExpr), m_parent(), m_locked(FALSE) {
  ASSERT(EXPR_TYPE_UNDEF < type && EXPR_TYPE_MAX > type, "EXPR - undefied type");
}


CsimCmdLineExpr::~CsimCmdLineExpr() {}


EExprType CsimCmdLineExpr::getType() { return m_type; }


RefTVec_RefCsimCmdLineExpr CsimCmdLineExpr::getChildren() { 
  ASSERT(m_children.get(), "EXPR - this should not happen");
  return m_children; 
}


void CsimCmdLineExpr::addChild(RefCsimCmdLineExpr child) {
  ASSERT(child.get(), "EXPR - null child received");
  ASSERT(m_children.get(), "EXPR - this should not happen");
  m_children->push_back(child);
  child->setParent(getThis());
}


void CsimCmdLineExpr::addChildAtPos(RefCsimCmdLineExpr child, TUInt pos) {
  ASSERT(child.get(), "EXPR - null child received");
  ASSERT(m_children.get(), "EXPR - this should not happen");
  ASSERT(pos < m_children->size(), "EXPR - position out of bounds");
  TVec_RefCsimCmdLineExpr_iterator it = m_children->begin();
  for (TUInt i = 0; i < m_children->size() - 1; ++i, ++it) {}
  *it = child;
  child->setParent(getThis());
}


void CsimCmdLineExpr::setParent(RefCsimCmdLineExpr parent) { 
  ASSERT(parent.get(), "EXPR - null parent received");

  m_parent = WeakRefCsimCmdLineExpr(parent);
}


RefCsimCmdLineExpr CsimCmdLineExpr::getParent() { return m_parent.lock(); }


TBool              CsimCmdLineExpr::isNum() { return m_type == EXPR_TYPE_NUM; }

TBool              CsimCmdLineExpr::isId() { return m_type == EXPR_TYPE_ID; }

TBool              CsimCmdLineExpr::isOp() { return m_type == EXPR_TYPE_OPER; }

void               CsimCmdLineExpr::lock() { m_locked = TRUE; }

TBool              CsimCmdLineExpr::isLocked() { return m_locked; }

TBool              CsimCmdLineExpr::hasMaxNoOfChildren() { return TRUE; }
}


//END OF FILE 

