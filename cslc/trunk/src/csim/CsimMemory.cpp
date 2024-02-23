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


#include "CsimMemory.h"


namespace std {


stringstream& operator<<(stringstream& os, const NSCsimLib::CsimMemoryBase& mem) {

  NSCsimLib::RefTVec_TLongLong values = *mem;

  for (TUInt i = 0; i < mem.getDepth(); ++i) {
    os << NSCsimLib::convertValueTo<TLongLong>(values->at(i), mem.getRadix()) << std::endl;
  }

  return os;
}

}


namespace NSCsimLib {



template <typename T>
CsimMemory<T>::CsimMemory(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent): 
  CsimMemoryBase(name, width, depth, clock, parent) {

    //create the ports

  TUInt addrWidth = static_cast<TUInt>(ceil(log2(static_cast<TDouble>(m_depth))));
  
  m_rdAddrPort = CsimPortT::build(RefString(new std::string("rdAddr")), addrWidth, parent, PORT_DIR_INPUT);

  m_rdAddrPort->allocateValue();

  m_rdDataPort = CsimPortT::build(RefString(new std::string("rdData")), m_width, parent, PORT_DIR_OUTPUT);

  m_rdDataPort->allocateValue();

  m_wrAddrPort = CsimPortT::build(RefString(new std::string("wrAddr")), addrWidth, parent, PORT_DIR_INPUT);

  m_wrAddrPort->allocateValue();

  m_wrDataPort = CsimPortT::build(RefString(new std::string("wrData")), m_width, parent, PORT_DIR_INPUT);

  m_wrDataPort->allocateValue();

  m_memoryVec = RefTVec_T( new TVec_T);

  resetMemory();   
  
}


template <typename T>
void  CsimMemory<T>::resetMemory() {

  if (m_memoryVec.get()) { //clear memory if needed

    if (!m_memoryVec->empty()) { m_memoryVec->clear(); }
  }

  m_memoryVec->resize(m_depth);
}


template <typename T>
boost::shared_ptr< CsimPort<T> >         CsimMemory<T>::getRdAddrPort() const { return m_rdAddrPort; }



template <typename T>
boost::shared_ptr< CsimPort<T> >         CsimMemory<T>::getWrAddrPort() const { return m_wrAddrPort; }



template <typename T>
boost::shared_ptr< CsimPort<T> >         CsimMemory<T>::getRdDataPort() const { return m_rdDataPort; }



template <typename T>
boost::shared_ptr< CsimPort<T> >         CsimMemory<T>::getWrDataPort() const { return m_wrDataPort; }



template <typename T>
T     CsimMemory<T>::getValueAtPosition(TUInt  position) const { 
  ASSERT(m_memoryVec->size() > position, "CSIM - Memory - trying to access position outside of bounds"); 
  return m_memoryVec->at(position); 
}



template <typename T>
void      CsimMemory<T>::setValueAtPosition(TUInt  position, T value) { 
  ASSERT(m_memoryVec->size() >= position, "CSIM - Memory - trying to access position outside of bounds");

  TVec_T_iterator iter = m_memoryVec->begin();;

  for (TUInt j = 0; j < position; ++iter, ++j) {}

  *iter = value;
}



template <typename T>
void      CsimMemory<T>::dumpMemory(std::ofstream &out) {

  if (out.is_open()) { //if stream is open

    for (int i = 0; i < m_depth && out.good(); ++i) {//write the memory to file while stream is good 

      out << m_memoryVec->at(i) << std::endl;
    }
  }
}



template <typename T>
void      CsimMemory<T>::execute() {

  TBool resetVal = m_resetPort->getValue();

  if (m_resetPort->getValue()) {//check resetPort and reset memory if reset is TRUE

    resetMemory();
  }

  if (m_clock->posEdge()) {//if clock is on posEdge

    if (m_wrEnPort->getValue()) {//if wrEnPort is TRUE

      T position = m_wrAddrPort->getValue();

      ASSERT(m_memoryVec->size() > position, "CSIM - Memory - trying to access position outside of bounds");

      TVec_T_iterator iter = m_memoryVec->begin();;

      for (TUInt j = 0; j < position; ++iter, ++j) {}

      *iter = m_wrDataPort->getValue();//write m_wrDataPort into memory at position from m_wrAddrPort
    }

    if (m_rdEnPort->getValue()) {//if rdEnPort is TRUE

      T position = m_rdAddrPort->getValue();

      ASSERT(m_memoryVec->size() > position, "CSIM - Memory - trying to access position outside of bounds");

      m_rdDataPort->setValue(m_memoryVec->at(position));//write from position m_rdAddrPort from memory into m_rdDataPort
    }
  }
}



template <typename T>
boost::shared_ptr< CsimMemory<T> >    CsimMemory<T>::build(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) {
  ASSERT(name.get()            , "CSIM - Memory - received null ref"            );
  ASSERT(!name->empty()        , "CSIM - Memory - empty name received"          );
  ASSERT(0 < width && 0 < depth, "CSIM - Memory - received 0 for width or depth");
  ASSERT(clock.get()           , "CSIM - Memory - received null ref"            );
  ASSERT(parent.get()          , "CSIM - Memory - received null ref"            );

  CsimMemoryT* mem;

  try {
    mem = new CsimMemoryT(name, width, depth, clock, parent);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "CSIM - Memory - new operator failed");
  }

  RefCsimMemoryT  refMem = RefCsimMemoryT(mem);
  mem->m_weakRef = WeakRefCsimMemoryT(refMem);

  return refMem;
}



template <typename T>
RefTVec_TLongLong CsimMemory<T>::operator*() const {
  RefTVec_TLongLong retVec(new TVec_TLongLong);

  for (TUInt i = 0; i < getDepth(); ++i) {
    retVec->push_back(static_cast<TLongLong>(getValueAtPosition(i)));
  }

  return retVec;
}




template void  CsimMemory<TBool>::resetMemory() ;
template void  CsimMemory<TChar>::resetMemory() ;
template void  CsimMemory<TShort>::resetMemory() ;
template void  CsimMemory<TInt>::resetMemory() ;
template void  CsimMemory<TLongLong>::resetMemory() ;


template CsimMemory<TBool>::CsimMemory(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) ;
template CsimMemory<TChar>::CsimMemory(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) ;
template CsimMemory<TShort>::CsimMemory(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) ;
template CsimMemory<TInt>::CsimMemory(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) ;
template CsimMemory<TLongLong>::CsimMemory(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) ;


template CsimMemory<TBool>::RefCsimPortT         CsimMemory<TBool>::getRdAddrPort() const ;
template CsimMemory<TChar>::RefCsimPortT         CsimMemory<TChar>::getRdAddrPort() const ;
template CsimMemory<TShort>::RefCsimPortT         CsimMemory<TShort>::getRdAddrPort() const ;
template CsimMemory<TInt>::RefCsimPortT         CsimMemory<TInt>::getRdAddrPort() const ;
template CsimMemory<TLongLong>::RefCsimPortT         CsimMemory<TLongLong>::getRdAddrPort() const ;


template CsimMemory<TBool>::RefCsimPortT         CsimMemory<TBool>::getWrAddrPort() const ;
template CsimMemory<TChar>::RefCsimPortT         CsimMemory<TChar>::getWrAddrPort() const ;
template CsimMemory<TShort>::RefCsimPortT         CsimMemory<TShort>::getWrAddrPort() const ;
template CsimMemory<TInt>::RefCsimPortT         CsimMemory<TInt>::getWrAddrPort() const ;
template CsimMemory<TLongLong>::RefCsimPortT         CsimMemory<TLongLong>::getWrAddrPort() const ;


template CsimMemory<TBool>::RefCsimPortT         CsimMemory<TBool>::getRdDataPort() const ;
template CsimMemory<TChar>::RefCsimPortT         CsimMemory<TChar>::getRdDataPort() const ;
template CsimMemory<TShort>::RefCsimPortT         CsimMemory<TShort>::getRdDataPort() const ;
template CsimMemory<TInt>::RefCsimPortT         CsimMemory<TInt>::getRdDataPort() const ;
template CsimMemory<TLongLong>::RefCsimPortT         CsimMemory<TLongLong>::getRdDataPort() const ;


template CsimMemory<TBool>::RefCsimPortT         CsimMemory<TBool>::getWrDataPort() const ;
template CsimMemory<TChar>::RefCsimPortT         CsimMemory<TChar>::getWrDataPort() const ;
template CsimMemory<TShort>::RefCsimPortT         CsimMemory<TShort>::getWrDataPort() const ;
template CsimMemory<TInt>::RefCsimPortT         CsimMemory<TInt>::getWrDataPort() const ;
template CsimMemory<TLongLong>::RefCsimPortT         CsimMemory<TLongLong>::getWrDataPort() const ;



}

//END OF FILE
