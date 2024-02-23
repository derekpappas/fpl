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

#ifndef INC_GUARD_CSIM_CMD_LINE_EXPR_ID_H
#define INC_GUARD_CSIM_CMD_LINE_EXPR_ID_H

#include "CsimCmdLineTypeDefs.h"
#include "CsimCmdLineExpr.h"

namespace NSCsimLib {


class CsimCmdLineExprId : public CsimCmdLineExpr {

    //    RefString     m_identifier;

    RefTVec_RefString   m_fullPathNameVec;

    EExprIdType   m_idType;

    RefString     m_delimiter;

    RefString     m_allowedIdFirst;

    RefString     m_allowedIdRest;

  protected:
    
    RefCsimCmdLineExprId getThis() { return boost::static_pointer_cast<CsimCmdLineExprId>(m_weakRef.lock()); }

    CsimCmdLineExprId (RefTVec_RefString identifier, EExprIdType type, RefString delimiter = RefString(new std::string(".")), 
                       RefString allowedFirst = RefString(new std::string("_abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ")), 
                       RefString allowedRest = RefString(new std::string("_abcdefghijklmnopqrstuvxyzABCDEFGHIJKLMNOPQRSTUVXYZ0123456789")));

  public:


    RefTVec_RefString     getFullPathName();

    EExprIdType   getIdType();

    RefString     getDelimiter();

    RefString     getAllowedFirst();

    RefString     getAllowedRest();


    TBool         isSignal();

    TBool         isUnit();

    TBool         isClock();

    TBool         isFF();

    TBool         isVW();

    TBool         isMem();

};


}


#endif // INC_GUARD_CSIM_CMD_LINE_EXPR_ID_H

//END OF FILE



