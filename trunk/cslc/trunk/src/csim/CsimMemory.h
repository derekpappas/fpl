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
//#include "CsimPort.h"
//#include "CsimClock.h"


#ifndef INC_GUARD_CSIM_MEMORY_H
#define INC_GUARD_CSIM_MEMORY_H

namespace NSCsimLib {


//************************************************************************************************************************************************************************
//CMemoryBase class
//************************************************************************************************************************************************************************


template<class T>       
class CsimMemory : public CsimMemoryBase {
    
  public:
    //typedefs
    typedef CsimMemory<T>                               CsimMemoryT;
    typedef boost::shared_ptr<CsimMemoryT>              RefCsimMemoryT;
    typedef boost::weak_ptr<CsimMemoryT>                WeakRefCsimMemoryT;

    typedef CsimPort<T>                                 CsimPortT;
    typedef boost::shared_ptr<CsimPortT>                RefCsimPortT;
    typedef CsimPort<TBool>                             CsimPortTBool;
    typedef boost::shared_ptr<CsimPortTBool>            RefCsimPortTBool;

    typedef std::vector<T>                              TVec_T;
    typedef typename TVec_T::const_iterator             TVec_T_const_iterator;
    typedef typename TVec_T::iterator                   TVec_T_iterator;
    typedef boost::shared_ptr<TVec_T>                   RefTVec_T;

      
  private:
    RefCsimPortT                m_rdAddrPort;
    RefCsimPortT                m_wrAddrPort;
    RefCsimPortT                m_rdDataPort;
    RefCsimPortT                m_wrDataPort;

    RefTVec_T                   m_memoryVec;

      
    //internal for reseting memory
    void  resetMemory() ;
      


  protected:

    RefCsimMemoryT     getThis() const { return boost::static_pointer_cast<CsimMemoryT>(m_weakRef.lock()); }

 
    CsimMemory(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent);

  public:


    RefCsimPortT            getRdAddrPort() const ;

    RefCsimPortT            getWrAddrPort() const ;

    RefCsimPortT            getRdDataPort() const ;

    RefCsimPortT            getWrDataPort() const ;

    T                       getValueAtPosition(TUInt  position) const ;


    void                    setValueAtPosition(TUInt  position, T value) ;



    void                    dumpMemory(std::ofstream &out) ;




    void                    execute() ;




    static RefCsimMemoryT    build(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent) ;


    RefTVec_TLongLong operator*() const;

};


}


namespace std {

stringstream& operator<<(stringstream& os, const NSCsimLib::CsimMemoryBase& mem);

}

#endif // INC_GUARD_CSIM_MEMORY_H


//END OF FILE
