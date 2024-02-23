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


#include "CsimClock.h"


namespace NSCsimLib {


//**********************************************************************************************************************************************************************
// class CsimClock
//**********************************************************************************************************************************************************************

CsimClock::CsimClock(TUInt period, RefString name, RefCsimUnit parent) : m_period(period), m_offset(0), m_currentPos(0), m_cycleNr(0), m_name(name), 
                                                                         m_FlipFlopVec(new TVec_RefCsimFlipFlopBase), m_parent(parent), 
                                                                         m_connectedUnits(new TVec_WeakRefCsimUnit), m_connectedUnitsClkName(new TVec_RefString) {}



void CsimClock::next() { ++m_currentPos %= m_period; ++m_cycleNr; }


TInt CsimClock::getCycleNo() { return m_cycleNr; }

TBool CsimClock::posEdge() const { return m_offset == m_currentPos; }



/* set posEdge offset(not position), posEdge position must be different than negEdge position 
 * returns old offset
 */
void CsimClock::setOffset(TUInt offset) { m_offset = offset % m_period; /*offset must be < m_period*/ }



TUInt CsimClock::getOffset() const { return m_offset; }



TBool CsimClock::negEdge() const { return ( ( ( static_cast<TUInt>( floor( static_cast<TFloat>(m_period) / 2 ) ) + m_offset) % m_period ) == m_currentPos ); }


void  CsimClock::registerFF(RefCsimFlipFlopBase ff) { 
  ASSERT(ff.get(), "CSIM - Clock - received null ref");

  m_FlipFlopVec->push_back(ff);
}


RefTVec_RefCsimFlipFlopBase CsimClock::getFFVec() const { return m_FlipFlopVec; }



TUInt CsimClock::getPeriod() const { return m_period; }


/* returns clock name */
const RefString CsimClock::getName() const { return m_name; }


RefCsimUnit          CsimClock::getParent() {
  RefCsimUnit temp = m_parent.lock();
  ASSERT(temp.get(), "this should not be");
  return temp;
}


RefTVec_RefCsimUnit  CsimClock::getConnectedUnits() {
  ASSERT(m_connectedUnits.get(), "this should not be");
  RefTVec_RefCsimUnit retVec = RefTVec_RefCsimUnit(new TVec_RefCsimUnit);
  for (TVec_WeakRefCsimUnit::iterator it = m_connectedUnits->begin(); it != m_connectedUnits->end(); ++it) {
    RefCsimUnit temp = it->lock();
    ASSERT(temp.get(), "this should not be");
    retVec->push_back(temp);
  }
  return retVec;
}


RefTVec_RefString    CsimClock::getConnectedUnitsClockNames() {
  ASSERT(m_connectedUnitsClkName.get(), "this should not be");
  
  return m_connectedUnitsClkName;
}


void                 CsimClock::connectToClock(RefCsimUnit unit, RefCsimClock& clock, RefString clockName) {
  ASSERT(m_connectedUnits.get(), "this should not be");
  ASSERT(m_connectedUnitsClkName.get(), "this should not be");

  //**** register ****
  //register unit in clock
  m_connectedUnits->push_back(WeakRefCsimUnit(unit));
  //register the clock name in that unit
  m_connectedUnitsClkName->push_back(clockName);
  //register clock in unit
  unit->addClock(getThis());


  //do the connection
  clock = getThis();
}


//build 
RefCsimClock CsimClock::build(TUInt period, RefString name, RefCsimUnit parent) {
  ASSERT(period > 0  , "CSIM - CLOCK - period 0 received"  );
  ASSERT(name.get()  , "CSIM - CLOCK - null name received" );
  ASSERT(name->size(), "CSIM - CLOCK - empty name received");
  ASSERT(parent.get(), "CSIM - CLOCK - null parent received");

  CsimClock* clock;
  
  try {

    clock = new CsimClock(period, name, parent);
  }
  catch (std::exception& e) {

    ASSERT(FAIL, "CSIM - CLOCK - new operator failed");
  }

  RefCsimClock refClock = RefCsimClock(clock);
  clock->m_weakRef = WeakRefCsimClock(refClock);
  //register unit in clock
  clock->m_connectedUnits->push_back(WeakRefCsimUnit(parent));
  //register the clock name in that unit
  clock->m_connectedUnitsClkName->push_back(name);
  //register clock in unit
  parent->addClock(refClock);
  (CsimSimulator::getInstance())->registerClock(refClock);

  return refClock;
}


}


//END OF FILE
