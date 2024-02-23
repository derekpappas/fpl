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


#ifndef INC_GUARD_CSIM_VECTOR_WRITER_H
#define INC_GUARD_CSIM_VECTOR_WRITER_H

#include "CsimInclude.h"
//#include "CsimClock.h"

namespace NSCsimLib {

//*******************************************************************************************************************************************************************
// CsimVectorWriter class
//*******************************************************************************************************************************************************************

class CsimVectorWriter{

    //typedefs
    typedef std::ofstream               TOFStream;


    WeakRefCsimVectorWriter  m_weakRef;

    RefCsimClock             m_clock;

    TInt                m_id;
    TInt                m_version;
    RefString           m_filename;
    //    RefString           m_vectorName;
    //RefString           m_vectorInstanceName;
    //    RefString           m_unitName;
    //RefString           m_moduleInstanceName;
                  
    TRadix                  m_radix;
    ECsimVectorType         m_type;
    TUInt                   m_width;


    TUInt                   m_count;

    TUInt                   m_maxEvents;

    boost::shared_ptr<TOFStream>              m_out;


  protected:

    CsimVectorWriter( TUInt id, TUInt version, RefString filename, /*RefString vectorName, RefString unitName, TUInt width,*/ ECsimVectorType type, 
                      /*RefCsimClock clock,*/ TRadix radix, TUInt maxEvents);


    RefCsimVectorWriter         getThis() const { return boost::static_pointer_cast<CsimVectorWriter>(m_weakRef.lock()); }


  public:

    //ADDED NOW
    void setWeakRef(RefCsimVectorWriter unit) { m_weakRef = WeakRefCsimVectorWriter(unit); }


    virtual ~CsimVectorWriter();

    //ADDED NOW
    virtual void defaultInitialize(RefCsimUnit unit) = 0;
    virtual void    defaultConnect(RefCsimUnit unit) = 0;

    void                setWidth(TUInt) ;

    void                setClock(RefCsimClock);


    TRadix              getRadix() const;
    
    TUInt               getMaxEvents() const;

    TUInt               getId() const;

    TUInt               getVersion() const;

    TUInt               getWidth() const;

    const RefString     getFilename() const;

    //    const RefString     getVectorName() const;

    //    const RefString     getUnitName() const;

    ECsimVectorType     getType() const;

    RefCsimClock        getClock() const;

    TOFStream*          getOutputStream() const;

    void                writeComments();

    virtual TBool       canWrite() { return TRUE; }

    virtual void        writeVector() = 0;

    //    virtual void setStartGen() = 0;

    //    bool getStartGen();
};


}

#endif // INC_GUARD_CSIM_VECTOR_WRITER_H

//END OF FILE
