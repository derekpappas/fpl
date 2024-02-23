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


#include "CsimUnit.h"


namespace NSCsimLib {


CsimUnit::CsimUnit(RefString unitName) : m_unitName(unitName),
                                         m_signalBaseVec(new TVec_RefCsimSignalBase), 
                                         m_vectorWriterVec(new TVec_WeakRefCsimVectorWriter),
                                         m_clocksVec(new TVec_RefCsimClock),
                                         m_children(new TVec_RefCsimUnit){}

CsimUnit::~CsimUnit() {}

//new - need to add checks
void                                 CsimUnit::setInstanceName(RefString instanceName){ m_instanceName = instanceName;  }

void                                 CsimUnit::setParent(RefCsimUnit parent){ 
  m_parent = parent;  
  //double registration
  parent->addUnit(getThis());
}
//end of new

const RefString                      CsimUnit::getUnitName() const { return m_unitName; }


const RefString                      CsimUnit::getInstanceName() const { return m_instanceName; }


RefCsimUnit                          CsimUnit::getParent() const { return boost::static_pointer_cast<CsimUnit>(m_parent.lock()); }



//returns the child with that name, or null ref if child not found
RefCsimUnit                          CsimUnit::getChildByName(RefString childName) const {
  ASSERT(childName.get()    , "CSIM - Unit - null string received" );
  ASSERT(!childName->empty(), "CSIM - Unit - empty string received");
  ASSERT(m_children.get(), "CSIM - Unit - this shouldn't happen");

  for (TVec_RefCsimUnit_const_iterator it = m_children->begin(); m_children->end() != it; ++it) {

    const RefString temp = (*it)->getInstanceName();
    ASSERT(temp.get(), "CSIM - Unit - this shouldn't happen");
    if (!temp->compare(*childName)) { return *it; }
  }

  return RefCsimUnit();
}


//returns the signal with that name, or null ref if signal not found
RefCsimSignalBase                    CsimUnit::getSignalByName(RefString signalName) const {
  ASSERT(signalName.get()    , "CSIM - Unit - null string received" );
  ASSERT(!signalName->empty(), "CSIM - Unit - empty string received");
  ASSERT(m_signalBaseVec.get(), "CSIM - Unit - this shouldn't happen");


  for (TVec_RefCsimSignalBase_const_iterator it = m_signalBaseVec->begin(); 
       m_signalBaseVec->end() != it; 
       ++it) {

    const RefString temp = (*it)->getName();
    ASSERT(temp.get(), "CSIM - Unit - this shouldn't happen");
    if (!temp->compare(*signalName)) { return *it; }
  }

  return RefCsimSignalBase();
}


//returns the vector writer with that name, or null ref if vector writer not found
////RefCsimVectorWriter                  CsimUnit::getVectorWriterByName(RefString vectorWriterName) const {
////  ASSERT(vectorWriterName.get()    , "CSIM - Unit - null string received" );
////  ASSERT(!vectorWriterName->empty(), "CSIM - Unit - empty string received");
////
////  RefCsimVectorWriter vectorWriter;
////
////  ASSERT(m_vectorWriterVec.get(), "CSIM - Unit - this shouldn't happen");
////  for (TVec_WeakRefCsimVectorWriter_const_iterator it = m_vectorWriterVec->begin();
////       m_vectorWriterVec->end() != it;
////       ++it) {
////
////    vectorWriter = boost::static_pointer_cast<CsimVectorWriter>((*it).lock());
////    const RefString temp = vectorWriter->getVectorName();
////    ASSERT(temp.get(), "CSIM - Unit - this shouldn't happen");
////    if (!temp->compare(*vectorWriterName)) { return vectorWriter; }
////  }
////
////  return vectorWriter;
////}



//add unit instance to unit
void                                 CsimUnit::addUnit(RefCsimUnit unit) {
  ASSERT(unit.get(), "CSIM - Unit - null unit received");

  ASSERT(m_children.get(), "CSIM - Unit - this shouldn't happen");
  m_children->push_back(unit);
}


void                                 CsimUnit::addConnectable(RefCsimSignalBase signal) {
  ASSERT(signal.get(), "CSIM - Unit - received null ref");

  ASSERT(m_signalBaseVec.get(), "CSIM - Unit - this shouldn't happen");
  m_signalBaseVec->push_back(signal);
}


void                                 CsimUnit::addVectorWriter(RefCsimVectorWriter vectorWriter) {
  ASSERT(vectorWriter.get(), "CSIM - Unit - received null ref");

  ASSERT(m_vectorWriterVec.get(), "CSIM - Unit - this shouldn't happen");
  m_vectorWriterVec->push_back(vectorWriter);
}


void                                 CsimUnit::addClock(RefCsimClock clock) {
  ASSERT(m_clocksVec.get(), "this should not be");
  ASSERT(clock.get(), "received null ref");

  m_clocksVec->push_back(clock);
}


RefTVec_RefCsimUnit                  CsimUnit::getChildren() {
  ASSERT(m_children.get(), "CSIM - Unit - this shouldn't happen");
  
  return m_children;
}


RefTVec_RefCsimSignalBase            CsimUnit::getSignals() {
  ASSERT(m_signalBaseVec.get(), "CSIM - Unit - this shouldn't happen");

  return m_signalBaseVec;
}


RefTVec_WeakRefCsimVectorWriter      CsimUnit::getVWs() {
  ASSERT(m_vectorWriterVec.get(), "CSIM - Unit - this shouldn't happen");

  return m_vectorWriterVec;
}


RefTVec_RefCsimClock                 CsimUnit::getClocks() {
  ASSERT(m_clocksVec.get(), "this should not be");
  
  return m_clocksVec;
}


RefCsimUnit build(CsimUnit* unit){
  RefCsimUnit temp = RefCsimUnit(unit);
  unit->setWeakRef(temp);
  CsimSimulator::getInstance()->registerUnit(temp);
  return temp;
}

//ADDED NOW
RefCsimVectorWriter buildVW(CsimVectorWriter* vw, RefCsimUnit unit){
  RefCsimVectorWriter temp = RefCsimVectorWriter(vw);
  vw->setWeakRef(temp);
  vw->defaultInitialize(unit);
  vw->defaultConnect(unit);
  (CsimSimulator::getInstance())->registerVW(temp);
  return temp;
}

}




//END OF FILE
