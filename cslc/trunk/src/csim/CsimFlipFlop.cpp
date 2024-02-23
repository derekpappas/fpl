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

#include "CsimFlipFlop.h"
#include <map>


namespace std {

stringstream& operator<<(stringstream& os, const NSCsimLib::CsimFlipFlopBase& ff) {
  pair< long long, long long> values = *ff;
  os << values.first << " " << values.second;
  return os;
}

}



namespace NSCsimLib {

template <typename T>
CsimFlipFlop<T>::CsimFlipFlop(RefCsimClock clock, RefString name) : CsimFlipFlopBase(clock, name), m_temp(new T), m_reset(FALSE) {}


template <typename T>
void   CsimFlipFlop<T>::propagateValue () { //Q = D
  if (getClock()->posEdge()) { 
    if(!m_en.get() || (m_en.get() && m_en->getValue() == 1 )) {
      if(!m_reset){
        *m_temp = m_d->getValue();
      }
    }
    //    DCERR(">>>>> temp = " << int(*m_temp));
//    m_q->copyValue(m_d); 
//    if (m_d->isValid()) {
//      m_q->setValid(TRUE);
//    }
  } 
}


template <typename T>
void   CsimFlipFlop<T>::postPropagateValue() {
  if(!m_en.get() || (m_en.get() && m_en->getValue() == 1 )) {
    m_q->setValue(*m_temp);
  //DCERR(">>>>> m_q = " << int(m_q->getValue()));
  }
}


template <typename T>
void CsimFlipFlop<T>::init() {}


template <typename T>
void CsimFlipFlop<T>::connect() {}


template <typename T>
void CsimFlipFlop<T>::execute() {}


template <typename T>
void CsimFlipFlop<T>::initialize() {}


template <typename T>
void CsimFlipFlop<T>::defaultInitialize() {}

template <typename T>
void CsimFlipFlop<T>::lockOutputValue(T value){
  *m_temp = value;
  m_reset = TRUE;
}

template <typename T>
void CsimFlipFlop<T>::unlockOutputValue(){
  m_reset = FALSE;
}




template <typename T>
  boost::shared_ptr< CsimFlipFlop<T> >  CsimFlipFlop<T>::build(RefCsimClock clock, RefString name, TUInt width, RefCsimPortTBool en) { 
  ASSERT(clock.get() &&  name.get() , "CSIM - FlipFlop - null reference received"       );
  ASSERT(!name->empty()             , "CSIM - FlipFlop - empty string received received");
      
  
  CsimFlipFlopT* flipFlop;

  try {
    flipFlop = new CsimFlipFlop(clock, name);
  }
  catch (std::exception& e) {
    ASSERT(FAIL, "CSIM - FlipFlop - new operator failed");
  }
  
  RefCsimFlipFlopT refFlipFlop = RefCsimFlipFlopT(flipFlop);
  flipFlop->m_weakRef = WeakRefCsimFlipFlopT(refFlipFlop);

  //register the flip flop in the clock
  clock->registerFF(refFlipFlop);
  
  flipFlop->m_d = CsimPort<T>::build(RefString(new std::string("d")), width, flipFlop->getThis(), PORT_DIR_INPUT);
  flipFlop->m_q = CsimPort<T>::build(RefString(new std::string("q")), width, flipFlop->getThis(), PORT_DIR_OUTPUT);

  flipFlop->m_en = en;
  return refFlipFlop;
}


template <typename T>
std::pair< TLongLong, TLongLong>  CsimFlipFlop<T>::operator*() const {
  return std::make_pair(static_cast<TLongLong>(m_d->getValue()), static_cast<TLongLong>(m_q->getValue()));
}



template CsimFlipFlop<TBool>::CsimFlipFlop(RefCsimClock clock, RefString name);
template CsimFlipFlop<TChar>::CsimFlipFlop(RefCsimClock clock, RefString name);
template CsimFlipFlop<TShort>::CsimFlipFlop(RefCsimClock clock, RefString name);
template CsimFlipFlop<TInt>::CsimFlipFlop(RefCsimClock clock, RefString name);
template CsimFlipFlop<TLongLong>::CsimFlipFlop(RefCsimClock clock, RefString name);

template void   CsimFlipFlop<TBool>::propagateValue ();
template void   CsimFlipFlop<TChar>::propagateValue ();
template void   CsimFlipFlop<TShort>::propagateValue ();
template void   CsimFlipFlop<TInt>::propagateValue ();
template void   CsimFlipFlop<TLongLong>::propagateValue ();


template void   CsimFlipFlop<TBool>::postPropagateValue() ;
template void   CsimFlipFlop<TChar>::postPropagateValue() ;
template void   CsimFlipFlop<TShort>::postPropagateValue() ;
template void   CsimFlipFlop<TInt>::postPropagateValue() ;
template void   CsimFlipFlop<TLongLong>::postPropagateValue() ;


template void   CsimFlipFlop<TBool>::lockOutputValue    (TBool     value) ;
template void   CsimFlipFlop<TChar>::lockOutputValue    (TChar     value) ;
template void   CsimFlipFlop<TShort>::lockOutputValue   (TShort    value) ;
template void   CsimFlipFlop<TInt>::lockOutputValue     (TInt      value) ;
template void   CsimFlipFlop<TLongLong>::lockOutputValue(TLongLong value) ;


template void   CsimFlipFlop<TBool>::unlockOutputValue    () ;
template void   CsimFlipFlop<TChar>::unlockOutputValue    () ;
template void   CsimFlipFlop<TShort>::unlockOutputValue   () ;
template void   CsimFlipFlop<TInt>::unlockOutputValue     () ;
template void   CsimFlipFlop<TLongLong>::unlockOutputValue() ;


template boost::shared_ptr< CsimFlipFlop<TBool> >  CsimFlipFlop<TBool>::build(RefCsimClock clock, RefString name, TUInt width, RefCsimPortTBool en);
template boost::shared_ptr< CsimFlipFlop<TChar> >  CsimFlipFlop<TChar>::build(RefCsimClock clock, RefString name, TUInt width, RefCsimPortTBool en);
template boost::shared_ptr< CsimFlipFlop<TShort> >  CsimFlipFlop<TShort>::build(RefCsimClock clock, RefString name, TUInt width, RefCsimPortTBool en);
template boost::shared_ptr< CsimFlipFlop<TInt> >  CsimFlipFlop<TInt>::build(RefCsimClock clock, RefString name, TUInt width, RefCsimPortTBool en);
template boost::shared_ptr< CsimFlipFlop<TLongLong> >  CsimFlipFlop<TLongLong>::build(RefCsimClock clock, RefString name, TUInt width, RefCsimPortTBool en);


}

//END OF FILE
