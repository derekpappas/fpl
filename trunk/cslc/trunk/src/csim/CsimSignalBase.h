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


#include "CsimInclude.h"

#ifndef INC_GUARD_CSIM_SIGNAL_BASE_H
#define INC_GUARD_CSIM_SIGNAL_BASE_H


namespace NSCsimLib {

class CsimSignalBase {

    RefString                                   m_name;
    TUInt                                       m_width;
    WeakRefCsimUnit                             m_parent;
    TBool                                       m_testModified;
    TBool                                       m_wasModified;

    RefCsimSignalBase    getThis() const { return boost::static_pointer_cast<CsimSignalBase>(m_weakRef.lock());}

  protected:

    WeakRefCsimSignalBase                       m_weakRef;

    CsimSignalBase(RefString name, TUInt width, RefCsimUnit parent) ;

  public:

    virtual ~CsimSignalBase();

    const RefString          getName() const ;

    TUInt                    getWidth() const ;

    RefCsimUnit              getParent() const ;

    TBool                    wasModified();

    void                     setModified();

    void                     resetModified();

    void                     startTestingModified();

    void                     stopTestingModified();

    TBool                    canTestModified();


    virtual TLongLong operator*() const = 0;

};


}

#endif // INC_GUARD_CSIM_SIGNAL_BASE_H

//END OF FILE
