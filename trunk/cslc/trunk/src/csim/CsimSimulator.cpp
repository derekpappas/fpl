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


#include "CsimSimulator.h"
#include <fstream>

namespace NSCsimLib {

CsimSimulator::CsimSimulator() : m_unitVec(new TVec_RefCsimUnit), m_clockVec(new TVec_RefCsimClock), m_vwVec(new TVec_RefCsimVectorWriter), m_topUnit() {}

RefCsimSimulator CsimSimulator::getInstance() {

  if (!CsimSimulator::m_simulatorRef.get()) {
  
    try {
      CsimSimulator::m_simulatorRef = RefCsimSimulator(new CsimSimulator);
    }
    catch(std::exception& ex) {
      ASSERT(FAIL, "Csim - Simulator - new operator failed");
    }

    CsimSimulator::m_simulatorRef->m_topUnit = NSCsimLib::getRootUnit();
    CsimSimulator::m_simulatorRef->m_topUnit->defaultInitialize();
    CsimSimulator::m_simulatorRef->m_unitVec->push_back(*(CsimSimulator::m_simulatorRef->m_unitVec->begin()));
    CsimSimulator::m_simulatorRef->m_unitVec->erase(CsimSimulator::m_simulatorRef->m_unitVec->begin());
  }

  return CsimSimulator::m_simulatorRef;
}

void CsimSimulator::registerUnit(RefCsimUnit unit) {
  ASSERT(unit.get(), "Csim - Simulator - received null reference");
  ASSERT(m_unitVec.get(), "Csim - Simulator - this should not happen");

  m_unitVec->push_back(unit);
}


void CsimSimulator::registerClock(RefCsimClock clock) {
  ASSERT(clock.get(), "CSIM - Simulator - reveived null ref");

  m_clockVec->push_back(clock);
}



void CsimSimulator::registerVW(RefCsimVectorWriter vw) {
  ASSERT(vw.get(), "CSIM - Simulator - null ref received");

  m_vwVec->push_back(vw);
}



RefTVec_RefCsimUnit   CsimSimulator::getUnits() {
  ASSERT(m_unitVec.get(), "this should not be");

  return m_unitVec;
}


RefTVec_RefCsimClock  CsimSimulator::getClocks() {
  ASSERT(m_clockVec.get(), "this should not be");

  return m_clockVec;
}


RefCsimUnit           CsimSimulator::getUnitByName(RefString unitName) {
  ASSERT(m_unitVec.get(), "this should not be");

  for (TVec_RefCsimUnit::iterator it = m_unitVec->begin(); it != m_unitVec->end(); ++it) {
    RefString temp = (*it)->getUnitName();
    ASSERT(temp.get(), "this should not be");
    if (!temp->compare(*unitName)) { return *it; }
  }

  return RefCsimUnit();
}


RefCsimClock          CsimSimulator::getClockByName(RefString clockName) {
   ASSERT(m_clockVec.get(), "this should not be");

  for (TVec_RefCsimClock::iterator it = m_clockVec->begin(); it != m_clockVec->end(); ++it) {
    RefString temp = (*it)->getName();
    ASSERT(temp.get(), "this should not be");
    if (!temp->compare(*clockName)) { return *it; }
  }

  return RefCsimClock();
}

RefTVec_RefString breakHID(RefString hid) {
  RefTVec_RefString vId = RefTVec_RefString(new TVec_RefString());
  RefString temp;
  TUInt lastPos = 0;
  if (hid->find(".", 0) == std::string::npos) {
    vId->push_back(hid);
    return vId;
  }
  else {
    lastPos = hid->find(".", 0);
    temp = RefString(new std::string(hid->substr(0, hid->find(".", 0))));
    vId->push_back(temp);
  }
  while (hid->find(".", lastPos+1) != std::string::npos) {
    temp = RefString(new std::string(hid->substr(lastPos+1, hid->find(".", lastPos+1) - lastPos - 1 )));
    lastPos = hid->find(".", lastPos+1);
    vId->push_back(temp);
  }
  vId->push_back(RefString(new std::string(hid->substr(lastPos+1, hid->size() - lastPos - 1 ))));
//   for (int i = 0 ; i < vId->size(); i++) {
//     std::cerr<<*(vId->at(i))<<std::endl;
//   }
  return vId;
}

void CsimSimulator::sortExecs(RefString fileName) {
  std::ifstream in(fileName->c_str());

  TInt line = 0;

  typedef boost::shared_ptr<char> RefChar;
  RefChar s = RefChar(new char[256]);
  RefTVec_RefCsimUnit units = RefTVec_RefCsimUnit(new TVec_RefCsimUnit);

  while (!in.eof()) {
    if (in.fail() || in.bad()) {
      std::cerr<<"Failed to read from file! Aborting execute sorting!"<<std::endl;
      in.close();
      return;
    }
    in.getline(s.get(), 256);
    line++;
    RefString unitHid = RefString(new std::string(s.get()));
    while (unitHid->empty()) {
      if (in.eof()) {
        break;
      }
      in.getline(s.get(), 256);
      line++;
      unitHid = RefString(new std::string(s.get()));
    }
    if (unitHid->empty() && in.eof()) {
      break;
    }
    RefTVec_RefString vId = breakHID(unitHid);
    RefCsimUnit inst = CsimSimulator::getRootUnit();
    if (inst->getUnitName()->compare(*(vId->at(0)))) {
      std::cerr<<"At line "<<line<<": Failed to identify instance - HID is not correct! Aborting execute sorting!"<<std::endl;
      in.close();
      return;
    }
    for (TVec_RefString::iterator it = vId->begin()+1; it < vId->end(); it++) {
      inst = inst->getChildByName(*it);
      if (!inst.get()) {
        std::cerr<<"At line "<<line<<": Failed to identify instance - HID is not correct! Aborting execute sorting!"<<std::endl;
        in.close();
        return;
      }
    }
    TBool found = FALSE;
    for (TVec_RefCsimUnit::iterator it1 = units->begin(); it1 < units->end(); ++it1) {
      if (inst.get() == (*it1).get()) {
        found = TRUE;
      }
    }
    if (found) {
      std::cerr<<"At line "<<line<<": Found duplicate hid! Removing duplicate!"<<std::endl;
    }
    else {
      units->push_back(inst);
    }
  }

  for (TVec_RefCsimUnit::iterator it = m_unitVec->begin(); it < m_unitVec->end(); ++it) {
    TBool found = FALSE;
    for (TVec_RefCsimUnit::iterator it1 = units->begin(); it1 < units->end(); ++it1) {
      if ((*it).get() == (*it1).get()) {
        found = TRUE;
      }
    }
    if (!found) {
      units->push_back(*it);
    }
  }
  m_unitVec = units;

  in.close();
}

void CsimSimulator::cycle() {
  ASSERT(m_unitVec.get(), "CSIM - Simulator - THIS should NEVER happen");
  ASSERT(m_clockVec.get(), "CSIM - Simulator - THIS should NEVER happen");

  //call execute() for all units(top unit should be the last unit in the vector) in the simulator
  for (TVec_RefCsimUnit_iterator i = m_unitVec->begin(); m_unitVec->end() != i; ++i) { (*i)->execute(); }


  //call propagate() for all flipFlops associated to all the clocks in simulator that are on posEdge
  for (TVec_RefCsimClock_iterator i = m_clockVec->begin(); m_clockVec->end() != i; ++i) { 
    
    if ((*i)->posEdge()) {

      RefTVec_RefCsimFlipFlopBase ffVec = (*i)->getFFVec();

      for (TVec_RefCsimFlipFlopBase_iterator j = ffVec->begin(); ffVec->end() != j; ++j) { (*j)->propagateValue(); }
    }
  }


  //call propagate() for all flipFlops associated to all the clocks in simulator that are on posEdge
  for (TVec_RefCsimClock_iterator i = m_clockVec->begin(); m_clockVec->end() != i; ++i) { 
    
    if ((*i)->posEdge()) {

      RefTVec_RefCsimFlipFlopBase ffVec = (*i)->getFFVec();

      for (TVec_RefCsimFlipFlopBase_iterator j = ffVec->begin(); ffVec->end() != j; ++j) { (*j)->postPropagateValue(); }
    }
  }

  //call writeVector() for all vector writers in the simulator
  for (TVec_RefCsimVectorWriter_iterator i = m_vwVec->begin(); m_vwVec->end() != i; ++i) { if ((*i)->canWrite()) { (*i)->writeVector(); }  }

  //update clocks
  for (TVec_RefCsimClock_iterator i = m_clockVec->begin(); m_clockVec->end() != i; ++i) { (*i)->next(); }
}

RefCsimSimulator NSCsimLib::CsimSimulator::m_simulatorRef = RefCsimSimulator();

RefCsimUnit CsimSimulator::getRootUnit(){ return m_topUnit; }

}




//END OF FILE
