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


#ifndef INC_GUARD_CSIM_FLIPFLOP_H
#define INC_GUARD_CSIM_FLIPFLOP_H

#include "CsimInclude.h"

namespace NSCsimLib {


//**************************************************************************************************************************************************************************
//CsimFlipFlop class
//**************************************************************************************************************************************************************************
/**
 *           ---------
 *           |   |   |
 *           |   |   |
 *       --->| D | Q |--->
 *           |   |   |          
 *           |   |   |
 *           ------^--
 *           clk___|
 *                 
 * Because D is a pointer user cand change its value in a very simple way.
 * D is a pointer to a combinational signal.
 * A clock is attached to every FlipFlops.
 * If Clock is true then the prop() function propagates the D value to Q.
 * 
*/
//T must have copy constructor and default constructor
template <typename T>
class CsimFlipFlop : public CsimFlipFlopBase {

  public:
    //typedefs
    typedef boost::shared_ptr<T>                                           RefT;
    typedef CsimFlipFlop<T>                                                CsimFlipFlopT;
    typedef boost::shared_ptr<CsimFlipFlopT>                               RefCsimFlipFlopT;
    typedef boost::weak_ptr<CsimFlipFlopT>                                 WeakRefCsimFlipFlopT;
    typedef CsimPort<T>                                                    CsimPortT;
    typedef boost::shared_ptr<CsimPortT>                                   RefCsimPortT;
//    typedef boost::shared_ptr<CsimFlipFlop>                                  RefCsimFlipFlop;
//    typedef boost::weak_ptr<CsimFlipFlop>                                    WeakRefCsimFlipFlop;

  private:

    RefT                        m_temp;
    TBool                       m_reset;

    //constructor
    CsimFlipFlop(RefCsimClock clock, RefString name) ;

  protected:

    RefCsimFlipFlopT    getThis() const { return boost::static_pointer_cast<CsimFlipFlopT>(m_weakRef.lock());}

  public:
    //public members
    RefCsimPortT                 m_d;
    RefCsimPortT                 m_q;
    RefCsimPortTBool             m_en;

    //propagate value from d to q
    void                propagateValue () ;


    void                postPropagateValue();


    void init();
    void connect();
    void execute();
    void initialize();
    void defaultInitialize();
    void lockOutputValue(T value);
    void unlockOutputValue();



    //build
    static RefCsimFlipFlopT  build(RefCsimClock clock, RefString name, TUInt width, RefCsimPortTBool en = RefCsimPortTBool()) ;

    std::pair<TLongLong, TLongLong>  operator*() const;

};

}

namespace std {

stringstream& operator<<(stringstream& os, const NSCsimLib::CsimFlipFlopBase& ff);

}

#endif // INC_GUARD_CSIM_FLIPFLOP_H

//END OF FILE
