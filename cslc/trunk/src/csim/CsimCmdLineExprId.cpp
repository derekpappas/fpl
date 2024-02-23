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


#include "CsimCmdLineExprId.h"


namespace NSCsimLib {


CsimCmdLineExprId::CsimCmdLineExprId(RefTVec_RefString id, EExprIdType type, RefString delimiter, 
                                     RefString allowedFirst, RefString allowedRest) 
  : CsimCmdLineExpr(EXPR_TYPE_ID), m_fullPathNameVec(id), m_idType(type), m_delimiter(delimiter),
    m_allowedIdFirst(allowedFirst), m_allowedIdRest(allowedRest) {
  ASSERT(id.get(), "EXPR ID - null identifier received");
  ASSERT(EXPR_ID_TYPE_UNDEF < type && EXPR_ID_TYPE_MAX > type, "EXPR ID - invalid type");
  ASSERT(delimiter.get(), "EXPR ID - null delimiter received");
  ASSERT(allowedFirst.get(), "EXPR ID - null allowedFirst received");
  ASSERT(allowedRest.get(), "EXPR ID - null allowedRest received");
}


RefTVec_RefString       CsimCmdLineExprId::getFullPathName()    { return m_fullPathNameVec; }


EExprIdType     CsimCmdLineExprId::getIdType()          { return m_idType; }


RefString       CsimCmdLineExprId::getDelimiter()       { return m_delimiter; }

RefString       CsimCmdLineExprId::getAllowedFirst()    { return m_allowedIdFirst; }

RefString       CsimCmdLineExprId::getAllowedRest()     { return m_allowedIdRest; }


TBool           CsimCmdLineExprId::isSignal()           { return m_idType == EXPR_ID_TYPE_SIGNAL; }

TBool           CsimCmdLineExprId::isUnit()             { return m_idType == EXPR_ID_TYPE_UNIT; }

TBool           CsimCmdLineExprId::isClock()            { return m_idType == EXPR_ID_TYPE_CLOCK; }

TBool           CsimCmdLineExprId::isFF()               { return m_idType == EXPR_ID_TYPE_FF; }

TBool           CsimCmdLineExprId::isVW()               { return m_idType == EXPR_ID_TYPE_VW; }

TBool           CsimCmdLineExprId::isMem()              { return m_idType == EXPR_ID_TYPE_MEM; }

}



//END OF FILE



