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

#ifndef INC_GUARD_CSIM_FLIPFLOP_BASE_H
#define INC_GUARD_CSIM_FLIPFLOP_BASE_H

//#include "CsimClock.h"

namespace NSCsimLib {

//**************************************************************************************************************************************************************************
//CsimFlipFlopBase class
//**************************************************************************************************************************************************************************

class CsimFlipFlopBase : public CsimUnit {

    //typedefs
    typedef boost::shared_ptr<CsimFlipFlopBase>                            RefCsimFlipFlopBase;
    typedef boost::weak_ptr<CsimFlipFlopBase>                              WeakRefCsimFlipFlopBase;       

  private:

    RefCsimClock         m_clock;

    //    RefString            m_name;

  protected:

    //weak ref
    //WeakRefCsimFlipFlopBase     m_weakRef;

    //constructor
    CsimFlipFlopBase(RefCsimClock clock, RefString name) ;


    RefCsimFlipFlopBase    getThis() const { return boost::static_pointer_cast<CsimFlipFlopBase>(m_weakRef.lock());}

  public:

    virtual ~CsimFlipFlopBase() ;

    //get name
    //    const RefString     getName        () const { return m_name; }//return name

    //get clock
    RefCsimClock        getClock       () ;

    //init
    virtual void        init          () =0;

    virtual void        propagateValue() =0;

    virtual void        postPropagateValue() =0;

    virtual std::pair<TLongLong, TLongLong>  operator*() const =0;
    
};

}

#endif // INC_GUARD_CSIM_FLIPFLOP_BASE_H

//END OF FILE 

