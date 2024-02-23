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


#ifndef INC_GUARD_CSIM_SIMULATOR_H
#define INC_GUARD_CSIM_SIMULATOR_H

#include "CsimInclude.h"
//#include "CsimMemory.h"
//#include "CsimFlipFlop.h"

namespace NSCsimLib {

//defined by user, should return top unit
//RefCsimUnit  getRoot() ;

RefCsimUnit getRootUnit(); //returns top unit - user defined

class CsimSimulator {
    
    RefTVec_RefCsimUnit         m_unitVec;

    RefTVec_RefCsimClock        m_clockVec;

    RefTVec_RefCsimVectorWriter m_vwVec;

    RefCsimUnit                 m_topUnit;

    static RefCsimSimulator     m_simulatorRef;

    CsimSimulator();/* : m_unitVec(new TVec_RefCsimUnit), m_clockVec(new TVec_RefCsimClock) {}*/

  public:

    void sortExecs(RefString fileName);

    static RefCsimSimulator getInstance() ;/*{

      if (!CsimSimulator::m_simulatorRef.get()) {
  
        try {
          CsimSimulator::m_simulatorRef = RefCsimSimulator(new CsimSimulator);
        }
        catch(std::exception& ex) {
          ASSERT(FAIL, "Csim - Simulator - new operator failed");
        }
      }

      CsimSimulator::m_simulatorRef->m_topUnit = NSCsimLib::getRootUnit();

      return CsimSimulator::m_simulatorRef;
      }*/

    void registerUnit(RefCsimUnit unit) ;/*{
      ASSERT(unit.get(), "Csim - Simulator - received null reference");
      ASSERT(m_unitVec.get(), "Csim - Simulator - this should not happen");

      m_unitVec->push_back(unit);
      }*/

    void registerClock(RefCsimClock clock) ;/*{
      ASSERT(clock.get(), "CSIM - Simulator - reveived null ref");

      m_clockVec->push_back(clock);
      }*/

    void registerVW(RefCsimVectorWriter vw) ;/*{
      ASSERT(vw.get(), "CSIM - Simulator - null ref received");

      m_vwVec->push_back(vw);
      }*/


    RefTVec_RefCsimUnit  getUnits();


    RefTVec_RefCsimClock  getClocks();


    RefCsimUnit getUnitByName(RefString);


    RefCsimClock getClockByName(RefString);
    


    void cycle() ;/*{
      ASSERT(m_unitVec.get(), "CSIM - Simulator - THIS should NEVER happen");
      ASSERT(m_clockVec.get(), "CSIM - Simulator - THIS should NEVER happen");

      //call execute() for all units(top unit should be the last unit in the vector) in the simulator
      for (TVec_RefCsimUnit_iterator i = m_unitVec->begin(); m_unitVec->end() != i; ++i) { (*i)->execute(); }

      //call writeVector() for all vector writers in the simulator
      for (TVec_RefCsimVectorWriter_iterator i = m_vwVec->begin(); m_vwVec->end() != i; ++i) { if ((*i)->canWrite()) { (*i)->writeVector(); }  }

      //call propagate() for all flipFlops associated to all the clocks in simulator that are on posEdge
      for (TVec_RefCsimClock_iterator i = m_clockVec->begin(); m_clockVec->end() != i; ++i) { 
    
        if ((*i)->posEdge()) {

          RefTVec_RefCsimFlipFlopBase ffVec = (*i)->getFFVec();

          for (TVec_RefCsimFlipFlopBase_iterator j = ffVec->begin(); ffVec->end() != j; ++j) { (*j)->propagateValue(); }
        }
      }

      //update clocks
      for (TVec_RefCsimClock_iterator i = m_clockVec->begin(); m_clockVec->end() != i; ++i) { (*i)->next(); }
      }*/


    RefCsimUnit getRootUnit();

};

//RefCsimSimulator NSCsimLib::CsimSimulator::m_simulatorRef = RefCsimSimulator();

}

#endif // INC_GUARD_CSIM_SIMULATOR_H

//END OF FILE
