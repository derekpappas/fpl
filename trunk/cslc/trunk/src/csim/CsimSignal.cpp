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


#include "CsimSignal.h"


namespace std {

stringstream& operator<<(stringstream& os, const NSCsimLib::CsimSignalBase& clk) {
  os << *clk;
  return os ;
}

}


namespace NSCsimLib {

//template <typename T>
//  typedef CsimSignal<T>    CsimSignalT;


template<typename T>
CsimSignal<T>::_Value::_Value() : m_value(RefT(static_cast<T*>(NULL))), m_allocFlag(FALSE), m_signals(new TVec_WeakRefCsimSignalBase), m_valid(FALSE) {}



template<typename T>
T    CsimSignal<T>::_Value::getValue() const { ASSERT(m_allocFlag, "CSIM - Signal - value not allocated"); return *m_value; }



template<typename T>
TBool         CsimSignal<T>::_Value::isAllocated() const { return m_allocFlag; }



template<typename T>
void          CsimSignal<T>::_Value::allocate() { 

  m_value = RefT(new T);
  m_allocFlag = TRUE;
}



template<typename T>
TBool          CsimSignal<T>::_Value::isValid() {
  return m_valid;
}


template<typename T>
void           CsimSignal<T>::_Value::setValid(TBool valid) {
  m_valid = valid;
}



template<typename T>
void CsimSignal<T>::_Value::setValue(T& value) {

  ASSERT(m_allocFlag, "CSIM - Signal - trying to give value to non allocated pointer");

  //allocate();

  *m_value = value;

}



template<typename T>
void CsimSignal<T>::_Value::registerSignal(WeakRefCsimSignalBase sig) {
  ASSERT((sig.lock()).get(), "CSIM - Signal - null ref received ");
  ASSERT(m_signals.get(), "CSIM - Signal - this should not be");

  m_signals->push_back(sig);

  return;
}




template<typename T>
  RefTVec_WeakRefCsimSignalBase  CsimSignal<T>::_Value::getSharedSignals() {
  ASSERT(m_signals.get(), "CSIM - Signal - this should not be");

  return m_signals;
}


//template <typename T> struct CsimSignal<T>::_Value;
//template CsimSignal<TBool>;
//template CsimSignal<TChar>;
//template CsimSignal<TShort>;
//template CsimSignal<TInt>;
//template CsimSignal<TLongLong>;

//template CsimSignal

//template<typename T>
//  boost::shared_ptr<>   CsimSignal<T>::getValueObj() { return m_value; }



template<typename T>
CsimSignal<T>::CsimSignal(RefString name, TUInt width, RefCsimUnit parent) : CsimSignalBase(name, width, parent), m_value(new ValueT) { }



template<typename T>
void CsimSignal<T>::connect(RefCsimSignalT signal) { 
  ASSERT(signal.get(), "CSIM - Signal - null reference received");

  RefTVec_WeakRefCsimSignalBase otherVal = signal->m_value->getSharedSignals();

  for (TVec_WeakRefCsimSignalBase_iterator it = otherVal->begin(); it != otherVal->end(); ++it) {
    (boost::static_pointer_cast<CsimSignalT>((*it).lock()))->m_value = m_value;
    WeakRefCsimSignalBase temp = *it;
    m_value->registerSignal(temp);
  }

  //      m_value = signal->getValueObj();
}




template<typename T>
TBool CsimSignal<T>::hasAllocatedValue() { return m_value->isAllocated(); }



template<typename T>
TBool          CsimSignal<T>::isValid() {
  return m_value->isValid();
}


template<typename T>
void           CsimSignal<T>::setValid(TBool valid) {
  m_value->setValid(valid);
}



template<typename T>
void CsimSignal<T>::allocateValue() { m_value->allocate(); }



template<typename T>
void CsimSignal<T>::setValue(T value) {
  ASSERT(m_value->isAllocated(), "CSIM - Signal - trying to set value of non allocated ref");

  if(!valueHasMaxWidth<T>(value, getWidth())) { 
    DCERR("CSIM - Signal - setting the value of the signal/port with a value that has width > width of signal/port. Possible loss of data.(this should be warning)");
  }

  m_value->setValue(value);
  if (canTestModified() && !wasModified()) { setModified(); }
}



template<typename T>
void CsimSignal<T>::copyValue(CsimSignal<T>::RefCsimSignalT signal) {
  ASSERT(signal.get(), "CSIM - Signal - received null ref");
  ASSERT(m_value->isAllocated(), "CSIM - Signal - trying to set value of non allocated ref");
  ASSERT(signal->m_value->isAllocated(), "CSIM - Signal - trying to copy value from non allocated ref");

  T newVal = signal->m_value->getValue();

  m_value->setValue(newVal);
  if (canTestModified() && !wasModified()) { setModified(); }
}



template<typename T>
T  CsimSignal<T>::getValue() const { 
  ASSERT(m_value->isAllocated(), "CSIM - Signal - trying to get the value from non-allocated ref");

  TULongLong returnVal = m_value->getValue();

  if (getWidth() < ( sizeof(T) * 8 )) {

    TULongLong mask = static_cast<TULongLong>(floor(pow(static_cast<TLDouble>(2), static_cast<TLDouble>(getWidth())))) - 1;//we need to return the value on width bits
    returnVal &= mask;
  }
        
  return static_cast<T>(returnVal); 
}





template<typename T>
/*CsimSignal<T>::RefCsimSignalT*/ boost::shared_ptr< CsimSignal<T> >   CsimSignal<T>::build(RefString name, TUInt width, RefCsimUnit parent) {
  ASSERT(name.get()  , "CSIM - Signal - null reference received"  );
  ASSERT(name->size(), "CSIM - Signal - string of size 0 received");
  ASSERT(width       , "CSIM - Signal - width 0 received"         );
  ASSERT(parent.get(), "CSIM - Signal - received null ref"        );

  CsimSignalT* signal;

  try {

    signal = new CsimSignal(name, width, parent);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "CSIM - Signal - new operator failed");
  }

  RefCsimSignalT  refSignal = RefCsimSignalT(signal);
  signal->m_weakRef = WeakRefCsimSignalT(refSignal);
  signal->m_value->registerSignal(signal->m_weakRef);

  signal->allocateValue();

  return refSignal;
}


template<typename T>
TLongLong CsimSignal<T>::operator*() const {
  return static_cast<TLongLong>(m_value->getValue());
}




template CsimSignal<TBool>::_Value::_Value() ;
template CsimSignal<TChar>::_Value::_Value() ;
template CsimSignal<TShort>::_Value::_Value() ;
template CsimSignal<TInt>::_Value::_Value() ;
template CsimSignal<TLongLong>::_Value::_Value() ;


template TBool    CsimSignal<TBool>::_Value::getValue() const ;
template TChar    CsimSignal<TChar>::_Value::getValue() const ;
template TShort    CsimSignal<TShort>::_Value::getValue() const ;
template TInt    CsimSignal<TInt>::_Value::getValue() const ;
template TLongLong    CsimSignal<TLongLong>::_Value::getValue() const ;


template TBool       CsimSignal<TBool>::_Value::isAllocated() const ;
template TBool       CsimSignal<TChar>::_Value::isAllocated() const ;
template TBool       CsimSignal<TShort>::_Value::isAllocated() const ;
template TBool       CsimSignal<TInt>::_Value::isAllocated() const ;
template TBool       CsimSignal<TLongLong>::_Value::isAllocated() const ;


template void        CsimSignal<TBool>::_Value::allocate() ;
template void        CsimSignal<TChar>::_Value::allocate() ;
template void        CsimSignal<TShort>::_Value::allocate() ;
template void        CsimSignal<TInt>::_Value::allocate() ;
template void        CsimSignal<TLongLong>::_Value::allocate() ;


template void CsimSignal<TBool>::_Value::setValue(TBool& value) ;
template void CsimSignal<TChar>::_Value::setValue(TChar& value) ;
template void CsimSignal<TShort>::_Value::setValue(TShort& value) ;
template void CsimSignal<TInt>::_Value::setValue(TInt& value) ;
template void CsimSignal<TLongLong>::_Value::setValue(TLongLong& value) ;


template TBool CsimSignal<TBool>::_Value::isValid() ;
template TBool CsimSignal<TChar>::_Value::isValid() ;
template TBool CsimSignal<TShort>::_Value::isValid() ;
template TBool CsimSignal<TInt>::_Value::isValid() ;
template TBool CsimSignal<TLongLong>::_Value::isValid() ;


template void CsimSignal<TBool>::_Value::setValid(TBool) ;
template void CsimSignal<TChar>::_Value::setValid(TBool) ;
template void CsimSignal<TShort>::_Value::setValid(TBool) ;
template void CsimSignal<TInt>::_Value::setValid(TBool) ;
template void CsimSignal<TLongLong>::_Value::setValid(TBool) ;


template void CsimSignal<TBool>::_Value::registerSignal(WeakRefCsimSignalBase sig) ;
template void CsimSignal<TChar>::_Value::registerSignal(WeakRefCsimSignalBase sig) ;
template void CsimSignal<TShort>::_Value::registerSignal(WeakRefCsimSignalBase sig) ;
template void CsimSignal<TInt>::_Value::registerSignal(WeakRefCsimSignalBase sig) ;
template void CsimSignal<TLongLong>::_Value::registerSignal(WeakRefCsimSignalBase sig) ;


template RefTVec_WeakRefCsimSignalBase  CsimSignal<TBool>::_Value::getSharedSignals() ;
template RefTVec_WeakRefCsimSignalBase  CsimSignal<TChar>::_Value::getSharedSignals() ;
template RefTVec_WeakRefCsimSignalBase  CsimSignal<TShort>::_Value::getSharedSignals() ;
template RefTVec_WeakRefCsimSignalBase  CsimSignal<TInt>::_Value::getSharedSignals() ;
template RefTVec_WeakRefCsimSignalBase  CsimSignal<TLongLong>::_Value::getSharedSignals() ;


//template CsimSignal<TBool>::RefValueT   CsimSignal<TBool>::getValueObj() ;
//template CsimSignal<TChar>::RefValueT   CsimSignal<TChar>::getValueObj() ;
//template CsimSignal<TShort>::RefValueT   CsimSignal<TShort>::getValueObj() ;
//template CsimSignal<TInt>::RefValueT   CsimSignal<TInt>::getValueObj() ;
//template CsimSignal<TLongLong>::RefValueT   CsimSignal<TLongLong>::getValueObj() ;


template CsimSignal<TBool>::CsimSignal(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TChar>::CsimSignal(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TShort>::CsimSignal(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TInt>::CsimSignal(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TLongLong>::CsimSignal(RefString name, TUInt width, RefCsimUnit parent) ;


template void CsimSignal<TBool>::connect(RefCsimSignalT signal) ;
template void CsimSignal<TChar>::connect(RefCsimSignalT signal) ;
template void CsimSignal<TShort>::connect(RefCsimSignalT signal) ;
template void CsimSignal<TInt>::connect(RefCsimSignalT signal) ;
template void CsimSignal<TLongLong>::connect(RefCsimSignalT signal) ;


template TBool CsimSignal<TBool>::hasAllocatedValue() ;
template TBool CsimSignal<TChar>::hasAllocatedValue() ;
template TBool CsimSignal<TShort>::hasAllocatedValue() ;
template TBool CsimSignal<TInt>::hasAllocatedValue() ;
template TBool CsimSignal<TLongLong>::hasAllocatedValue() ;


template TBool CsimSignal<TBool>::isValid() ;
template TBool CsimSignal<TChar>::isValid() ;
template TBool CsimSignal<TShort>::isValid() ;
template TBool CsimSignal<TInt>::isValid() ;
template TBool CsimSignal<TLongLong>::isValid() ;


template void CsimSignal<TBool>::setValid(TBool) ;
template void CsimSignal<TChar>::setValid(TBool) ;
template void CsimSignal<TShort>::setValid(TBool) ;
template void CsimSignal<TInt>::setValid(TBool) ;
template void CsimSignal<TLongLong>::setValid(TBool) ;


template void CsimSignal<TBool>::allocateValue() ;
template void CsimSignal<TChar>::allocateValue() ;
template void CsimSignal<TShort>::allocateValue() ;
template void CsimSignal<TInt>::allocateValue() ;
template void CsimSignal<TLongLong>::allocateValue() ;


template void CsimSignal<TBool>::setValue(TBool value) ;
template void CsimSignal<TChar>::setValue(TChar value) ;
template void CsimSignal<TShort>::setValue(TShort value) ;
template void CsimSignal<TInt>::setValue(TInt value) ;
template void CsimSignal<TLongLong>::setValue(TLongLong value) ;


template void CsimSignal<TBool>::copyValue(CsimSignal<TBool>::RefCsimSignalT signal) ;
template void CsimSignal<TChar>::copyValue(CsimSignal<TChar>::RefCsimSignalT signal) ;
template void CsimSignal<TShort>::copyValue(CsimSignal<TShort>::RefCsimSignalT signal) ;
template void CsimSignal<TInt>::copyValue(CsimSignal<TInt>::RefCsimSignalT signal) ;
template void CsimSignal<TLongLong>::copyValue(CsimSignal<TLongLong>::RefCsimSignalT signal) ;


template TBool  CsimSignal<TBool>::getValue() const ;
template TChar  CsimSignal<TChar>::getValue() const ;
template TShort  CsimSignal<TShort>::getValue() const ;
template TInt  CsimSignal<TInt>::getValue() const ;
template TLongLong  CsimSignal<TLongLong>::getValue() const ;



template CsimSignal<TBool>::RefCsimSignalT   CsimSignal<TBool>::build(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TChar>::RefCsimSignalT   CsimSignal<TChar>::build(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TShort>::RefCsimSignalT   CsimSignal<TShort>::build(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TInt>::RefCsimSignalT   CsimSignal<TInt>::build(RefString name, TUInt width, RefCsimUnit parent) ;
template CsimSignal<TLongLong>::RefCsimSignalT   CsimSignal<TLongLong>::build(RefString name, TUInt width, RefCsimUnit parent) ;


template TLongLong CsimSignal<TBool>::operator*() const;
template TLongLong CsimSignal<TChar>::operator*() const;
template TLongLong CsimSignal<TShort>::operator*() const;
template TLongLong CsimSignal<TInt>::operator*() const;
template TLongLong CsimSignal<TLongLong>::operator*() const;

}

//END OF FILE

