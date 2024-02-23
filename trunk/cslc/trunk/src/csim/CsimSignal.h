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


#include "CsimInclude.h"


#ifndef INC_GUARD_CSIM_SIGNAL_H
#define INC_GUARD_CSIM_SIGNAL_H


//#include "CsimSupport.h"
//#include "CsimUnit.h"

namespace NSCsimLib {

template <class T>
class CsimSignal : public CsimSignalBase {

  public:
    //typedefs 
    typedef boost::shared_ptr<T>                RefT;
    typedef CsimSignal<T>                       CsimSignalT;
    typedef boost::shared_ptr<CsimSignalT>      RefCsimSignalT;
    typedef boost::weak_ptr<CsimSignalT>        WeakRefCsimSignalT;



    /******value object **********************************************************/
    /*****************************************************************************/


    typedef struct _Value {

      private:
        //actual value
        RefT                                    m_value;
        //flag for allocation of value
        TBool                                   m_allocFlag;
        //signals that share value
        RefTVec_WeakRefCsimSignalBase           m_signals;

        TBool                                   m_valid;
      public:


        //        _Value(T& value) : m_value(new T(value))/*, m_allocFlag(TRUE)*/, m_signals(new TVec_WeakRefCsimSignalBase) {}



        _Value() ;



        T    getValue() const ;



        //returns the m_allocFlag 
        TBool         isAllocated() const ;



        //allocates a new m_value
        void          allocate() ;

        TBool         isValid();

        void          setValid(TBool);

        //sets the value of m_value
        void setValue(T& value) ;

        //register signal in value
        void registerSignal(WeakRefCsimSignalBase sig) ;

        RefTVec_WeakRefCsimSignalBase  getSharedSignals() ;

    } ValueT;

    /**********************************************************************************************/
    /**********************************************************************************************/


    typedef boost::shared_ptr<ValueT>           RefValueT;

  protected:

    
    
    RefValueT                                   m_value;

    

    //returns the value object (internal)
    //    RefValueT   getValueObj() ;


    CsimSignal(RefString name, TUInt width, RefCsimUnit parent) ;

    RefCsimSignalT    getThis() const { return boost::static_pointer_cast<CsimSignalT>(m_weakRef.lock());}

  public:

    //connect two signals - sets the current signal val to the val of the signal received as arg
    void connect(RefCsimSignalT signal) ;


    //check if value is allocated
    TBool hasAllocatedValue() ;

    TBool isValid();

    void  setValid(TBool);
    

    //allocate a new value 
    //WARNING - does not set a new value - use setValue()
    void allocateValue() ;


    //set value of the signal
    void setValue(T value) ;


    //copy the value of another signal (just copies value, does not point to the same value - for that use connect)
    void copyValue(RefCsimSignalT signal) ;


    T getValue() const ;


    static RefCsimSignalT   build(RefString name, TUInt width, RefCsimUnit parent) ; 

    TLongLong operator*() const;
};

}


namespace std {

stringstream& operator<<(stringstream& os, const NSCsimLib::CsimSignalBase& clk);

}

#endif // INC_GUARD_CSIM_SIGNAL_H

//END OF FILE
