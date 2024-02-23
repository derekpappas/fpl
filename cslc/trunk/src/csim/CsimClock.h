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

#ifndef INC_GUARD_CSIM_CLOCK_H
#define INC_GUARD_CSIM_CLOCK_H

#include "CsimInclude.h"
//#include "CsimSimulator.h"

namespace NSCsimLib {

//************************************************************************************************************************************************************************
// class CsimClock
//************************************************************************************************************************************************************************

/**
 * m_period determines the posedge and negedge of the clock
 * example: if m_period is 5 then you will have
 *            posedge: 100001000010000....
 *            negedge: 001000010000100....
*/

class CsimClock{
  private:

    WeakRefCsimClock m_weakRef;

    TUInt m_period;
    TUInt m_offset;
    TUInt m_currentPos;
    TUInt m_cycleNr;

    RefString  m_name;

    RefTVec_RefCsimFlipFlopBase m_FlipFlopVec;

    WeakRefCsimUnit             m_parent;

    RefTVec_WeakRefCsimUnit     m_connectedUnits;

    RefTVec_RefString           m_connectedUnitsClkName; 


    CsimClock(TUInt period, RefString name, RefCsimUnit parent) ;

  protected:

    RefCsimClock    getThis() const { return boost::static_pointer_cast<CsimClock>(m_weakRef.lock());}

  public:    

    /* clock increases with one unit */
    void   next     ();

    TInt getCycleNo();

    /* returns TRUE if clock is on posEdge, FALSE otherwise */
    TBool  posEdge  () const ;

    /* returns TRUE if clock is on negEdge, FALSE otherwise */ 
    TBool  negEdge  () const ;

    /* set offset(not position) relative to position 0
     * returns old offset, if argument is 0 then it just returns current offset (like a get function)
    */
    void   setOffset(TUInt offset) ;

    TUInt  getOffset() const ;

    void registerFF(RefCsimFlipFlopBase ff) ;

    RefTVec_RefCsimFlipFlopBase getFFVec() const ;

    /* returns period */
    TUInt  getPeriod() const ;
  
    /* returns clock name */
    const RefString getName() const ;


    RefCsimUnit          getParent();


    RefTVec_RefCsimUnit  getConnectedUnits();


    RefTVec_RefString    getConnectedUnitsClockNames();


    void                 connectToClock(RefCsimUnit unit, RefCsimClock& clock, RefString clockName);


    /* build function */
    static RefCsimClock build(TUInt period, RefString name, RefCsimUnit parent) ;
};

}

#endif //INC_GUARD_CSIM_CLOCK_H

//END OF FILE
