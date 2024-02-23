//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007 Fastpathlogic
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

//#define DEBUG_REFCOUNT

#ifndef INC_GUARD_RefCount_h
#define INC_GUARD_RefCount_h

//#define DEBUG_REFCOUNT

#include <cassert>
#include <exception>

#ifdef DEBUG_REFCOUNT
#include <iostream>
#endif

namespace NSRefCount {
// ********************************************************************************
// Ref class
// ********************************************************************************
class Ref {
  public:
    virtual ~Ref() {};
    virtual Ref* increment() =0;
    virtual bool decrement() =0;
    virtual void* get() const =0;
    virtual unsigned int count() const =0;
};

// ********************************************************************************
// WeakRef class
// ********************************************************************************
template<class T> class RefCount;

template<class T1, class T2> RefCount<T1> ref_down_cast(const RefCount<T2>& ref) {
  if(false)
    T2* $tmp = (T1*)0; // ensures proper "inheritance simulation"
  return ref.m_ref ? RefCount<T1>(*(ref.m_ref->increment())) : RefCount<T1>(0);
}

// Objects of this class do not prevent refcount pointers beeing collected
// when their reference counter drops to 0 and consequently the objects
// of this class may point to invalid pointers. Due to performace reasons,
// no tracking to detect invalid pointers is being performed.
// Use this class with extreme care and ONLY if you know what you're doing.
template<class T> class WeakRef {
  public:
    Ref* m_ref;

    explicit WeakRef(Ref* ref = 0) : m_ref(ref) {}

    template<class T2> WeakRef(const WeakRef<T2>& other) : m_ref(other.m_ref) {
      if(false)
        T* $tmp = (T2*)0; // ensures proper "inheritance simulation"
    }

    ~WeakRef() {}

    RefCount<T> lock() const {
#ifdef DEBUG_REFCOUNT
      std::cout << "[WeakRef::lock()]";
      if(m_ref) {
        std::cout << " Wrapped pointer: " << m_ref->get();
      }
      else {
        std::cout << " Wrapped pointer: NULL";
      }
      std::cout << std::endl;
#endif
      return m_ref ? RefCount<T>(*(m_ref->increment())) : RefCount<T>(0);
    }
};

// ********************************************************************************
// RefCount class
// ********************************************************************************
// Template paramter: T
// The contract for type T: must provide a public clone function with the following signature:
//   T* clone() const; // const is optional
template<class T> class RefCount {
  private:
    class RefImpl : public Ref {
      private:
        T* const m_ptr;
        unsigned int m_count;

      public:
        RefImpl(T* ptr) : m_ptr(ptr), m_count(1) {}
        ~RefImpl() { delete m_ptr; }

        Ref* increment() { ++m_count; return this; }
        bool decrement() { return --m_count == 0; }
        void* get() const { return m_ptr; }
        unsigned int count() const { return m_count; }
    };

  public:
    Ref* m_ref;

  public:
    explicit RefCount(Ref& ref) : m_ref(&ref) {}

    WeakRef<T> getWeakRef() {
#ifdef DEBUG_REFCOUNT
      std::cout << "[RefCount::getWeakRef()]";
      if(m_ref) {
        std::cout << " Wrapped pointer: " << m_ref->get();
      }
      else {
        std::cout << " Wrapped pointer: NULL";
      }
      std::cout << std::endl;
#endif
      return WeakRef<T>(m_ref);
    }

    explicit RefCount(T* ptr = 0) : m_ref(ptr ? new RefImpl(ptr) : 0) {
#ifdef DEBUG_REFCOUNT
      std::cout << "[RefCount] constructor.";
      if(m_ref) {
        std::cout << " Wrapped pointer: " << m_ref->get();
      }
      else {
        std::cout << " Wrapped pointer: NULL";
      }
      std::cout << std::endl;
#endif
    }

    RefCount(const RefCount& other) : m_ref(other.m_ref ? other.m_ref->increment() : 0) {
#ifdef DEBUG_REFCOUNT
      std::cout << "[RefCount] copy constructor.";
      if(m_ref) {
        std::cout << " Shared wrapped pointer: " << m_ref->get() << ". Total reference count: " << m_ref->count();
      }
      else {
        std::cout << " Wrapped pointer: NULL";
      }
      std::cout << std::endl;
#endif
    }

    template<class T2> RefCount(const RefCount<T2>& other) : m_ref(other.m_ref ? other.m_ref->increment() : 0) {
      if(false)
        T* $tmp = (T2*)0; // ensures proper "inheritance simulation"
#ifdef DEBUG_REFCOUNT
      std::cout << "[RefCount] specialized copy constructor.";
      if(m_ref) {
        std::cout << " Shared wrapped pointer: " << m_ref->get() << ". Total reference count: " << m_ref->count();
      }
      else {
        std::cout << " Wrapped pointer: NULL";
      }
      std::cout << std::endl;
#endif
    }

    ~RefCount()  {
      if(m_ref && m_ref->decrement()) {
#ifdef DEBUG_REFCOUNT
        std::cout << "[RefCount] destructor. Destructing wrapped pointer: " << m_ref->get() << std::endl;
#endif
        delete m_ref;
      }
#ifdef DEBUG_REFCOUNT
      else {
        std::cout << "[RefCount] destructor.";
        if(m_ref) {
          std::cout << " Shared wrapped pointer: " << m_ref->get() << ". Remaining reference count: " << m_ref->count();
        }
        else {
          std::cout << " Wrapped pointer: NULL";
        }
        std::cout << std::endl;
      }
#endif
    }

    RefCount cloneRef() { return RefCount(m_ref ? (static_cast<T*>(m_ref->get()))->clone() : 0); }

    RefCount& operator=(const RefCount& other) {
      if(m_ref == other.m_ref) {
        return *this;
      }
      Ref* tmp = other.m_ref ? other.m_ref->increment() : 0;
      if(m_ref && m_ref->decrement()) {
#ifdef DEBUG_REFCOUNT
        std::cout << "[RefCount] operator=. Destructing wrapped pointer: " << m_ref->get() << std::endl;
#endif
        delete m_ref;
      }
#ifdef DEBUG_REFCOUNT
      else {
        std::cout << "[RefCount] operator=.";
        if(m_ref) {
          std::cout << " Previous shared wrapped pointer: " << m_ref->get() << ". Remaining reference count: " << m_ref->count();
        }
        else {
          std::cout << " Previous wrapped pointer: NULL";
        }
        std::cout << std::endl;
      }
#endif
      m_ref = tmp;
#ifdef DEBUG_REFCOUNT
      std::cout << "[RefCount] operator=.";
      if(m_ref) {
        std::cout << " Shared wrapped pointer: " << m_ref->get() << ". Total reference count: " << m_ref->count();
      }
      else {
        std::cout << " Wrapped pointer: NULL";
      }
      std::cout << std::endl;
#endif
      return *this;
    }

    template<class T2> RefCount& operator=(const RefCount<T2>& other) {
      if(false)
        T* $tmp = (T2*)0; // ensures proper "inheritance simulation"
      if(m_ref == other.m_ref) {
        return *this;
      }
      Ref* tmp = other.m_ref ? other.m_ref->increment() : 0;
      if(m_ref && m_ref->decrement()) {
#ifdef DEBUG_REFCOUNT
        std::cout << "[RefCount] specialized operator=. Destructing wrapped pointer: " << m_ref->get() << std::endl;
#endif
        delete m_ref;
      }
#ifdef DEBUG_REFCOUNT
      else {
        std::cout << "[RefCount] specialized operator=.";
        if(m_ref) {
          std::cout << " Previous shared wrapped pointer: " << m_ref->get() << ". Remaining reference count: " << m_ref->count();
        }
        else {
          std::cout << " Previous wrapped pointer: NULL";
        }
        std::cout << std::endl;
      }
#endif
      m_ref = tmp;
#ifdef DEBUG_REFCOUNT
      std::cout << "[RefCount] specialized operator=.";
      if(m_ref) {
        std::cout << " Shared wrapped pointer: " << m_ref->get() << ". Total reference count: " << m_ref->count();
      }
      else {
        std::cout << " Wrapped pointer: NULL";
      }
      std::cout << std::endl;
#endif
      return *this;
    }

    //operator const T*() const { return m_ref ? static_cast<T*>(m_ref->get()) : 0; }

    //operator T*() { return m_ref ? static_cast<T*>(m_ref->get()) : 0; }

    bool operator==(const RefCount& other) const { return m_ref == other.m_ref; }

    template<class T2> bool operator==(const RefCount<T2>& other) const {
      static_cast <T*> ((T2*)0); // ensures proper "inheritance simulation"
      return m_ref == other.m_ref;
    }

    bool operator!=(const RefCount& other) const { return m_ref != other.m_ref; }

    template<class T2> bool operator!=(const RefCount<T2>& other) const {
      static_cast <T*> ((T2*)0); // ensures proper "inheritance simulation"
      return m_ref != other.m_ref;
    }

    T& operator*() {
      assert(m_ref);
      return *(static_cast<T*>(m_ref->get()));
    }

    const T& operator*() const {
      assert(m_ref);
      return *(static_cast<T*>(m_ref->get()));
    }

    T* operator->() {
      assert(m_ref);
      return static_cast<T*>(m_ref->get());
    }

    const T* operator->() const {
      assert(m_ref);
      return static_cast<T*>(m_ref->get());
    }

    T* get();
    const T* get() const;
};

template<class T>
  T* RefCount<T>::get() { return m_ref ? static_cast<T*>(m_ref->get()) : 0; }

template<class T>
  const T* RefCount<T>::get() const { return m_ref ? static_cast<T*>(m_ref->get()) : 0; }

} // end namespace NSRefCount

#endif /*INC_GUARD_RefCount_h*/
