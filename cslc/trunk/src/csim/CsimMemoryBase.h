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
//#include "CsimPort.h"
//#include "CsimClock.h"


#ifndef INC_GUARD_CSIM_MEMORY_BASE_H
#define INC_GUARD_CSIM_MEMORY_BASE_H

namespace NSCsimLib {


//************************************************************************************************************************************************************************
//CMemoryBase class
//************************************************************************************************************************************************************************


class CsimMemoryBase {

  public:

    typedef boost::shared_ptr<CsimMemoryBase>    RefCsimMemoryBase;
    typedef boost::weak_ptr<CsimMemoryBase>      WeakRefCsimMemoryBase;



  protected:

    RefString                   m_name;
    TUInt                       m_width;
    TUInt                       m_depth;
    RefCsimClock                m_clock;
    RefCsimPortTBool            m_rdEnPort;
    RefCsimPortTBool            m_wrEnPort;
    RefCsimPortTBool            m_resetPort; 


    WeakRefCsimUnit             m_parent;

    TRadix                      m_radix;//for printing

    WeakRefCsimMemoryBase       m_weakRef;

    RefCsimMemoryBase     getThis() const { return boost::static_pointer_cast<CsimMemoryBase>(m_weakRef.lock()); }


    CsimMemoryBase(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) ;


  public:


    virtual ~CsimMemoryBase();


    RefCsimUnit             getParent() const ;

    

    const RefString         getName() const ;
    


    TUInt                   getWidth() const ;
    
    TUInt                   getDepth() const ;

    RefCsimClock            getClock() const ;

    RefCsimPortTBool        getRdEnPort() const ;

    RefCsimPortTBool        getWrEnPort() const ;

    RefCsimPortTBool        getResetPort() const ;

    TRadix                  getRadix() const;


    void                    setRadix(TRadix radix);


    virtual RefTVec_TLongLong operator*() const =0;
};


}


#endif // INC_GUARD_CSIM_MEMORY_BASE_H


//END OF FILE
