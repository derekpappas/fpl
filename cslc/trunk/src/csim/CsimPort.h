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


#ifndef INC_GUARD_CSIM_PORT_H
#define INC_GUARD_CSIM_PORT_H


namespace NSCsimLib {

template <class T>
class CsimPort : public CsimSignal<T> {

    //typedefs 
    typedef boost::shared_ptr<T>                RefT;
    typedef CsimPort<T>                         CsimPortT;
    typedef boost::shared_ptr<CsimPortT>        RefCsimPortT;
    typedef boost::weak_ptr<CsimPortT>          WeakRefCsimPortT;

    
    ECsimPortDir            m_dir;

    CsimPort(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) ;

  protected:

    RefCsimPortT    getThis() const { return boost::static_pointer_cast<CsimPortT>((this->m_weakRef).lock());}

  public:

    ECsimPortDir getDirection() const ;


    static RefCsimPortT   build(RefString name, TUInt width, RefCsimUnit parent, ECsimPortDir dir) ;
};

}

#endif // INC_GUARD_CSIM_PORT_H


//END OF FILE
