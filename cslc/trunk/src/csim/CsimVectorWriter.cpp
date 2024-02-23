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


#include "CsimVectorWriter.h"


namespace NSCsimLib {


//constructor
CsimVectorWriter::CsimVectorWriter( TUInt id, TUInt version, RefString filename, /*RefString vectorName, RefString  vectorInstanceName, 
                                                                                   RefString unitName, RefString moduleInstanceName, TUInt width,*/ 
                                    ECsimVectorType type, /*RefCsimClock clock, */
                                    TRadix radix, TUInt maxEvents/*, TOFStream* out*/) 
  : m_clock(), m_id(id), m_version(version), m_filename(filename)/*, m_vectorName(vectorName), m_unitName(unitName)*/, m_radix(radix), 
    m_type(type), m_width(0), m_count(ZERO), m_maxEvents(maxEvents), m_out(new CsimVectorWriter::TOFStream)  { m_out->open(filename->c_str()); }


CsimVectorWriter::~CsimVectorWriter() { m_out->close(); }

    

void                CsimVectorWriter::setWidth(TUInt width) {
  ASSERT(width > 0, "CSIM - VectorWriter - illegal width received");

  m_width = width;
}


void                CsimVectorWriter::setClock(RefCsimClock clock) {
  ASSERT(clock.get(), "CSIM - VectorWriter - null clock received");

  m_clock = clock;
}


void                CsimVectorWriter::writeComments() {}//to do


//void                CsimVectorWriter::setOutputStream( std::ofstream& out) { m_out = &out; }

TRadix              CsimVectorWriter::getRadix() const { return m_radix; }

TUInt               CsimVectorWriter::getMaxEvents() const { return m_maxEvents; }
                       
TUInt               CsimVectorWriter::getId() const { return m_id; }
                       
TUInt               CsimVectorWriter::getVersion() const { return m_version; }
                       
TUInt               CsimVectorWriter::getWidth() const {   ASSERT(m_width, "CSIM - VectorWriter - width not set"); return m_width; }

const RefString     CsimVectorWriter::getFilename() const { return m_filename; }

//const RefString     CsimVectorWriter::getVectorName() const { return m_vectorName; }

//const RefString     CsimVectorWriter::getUnitName() const { return m_unitName; }

ECsimVectorType     CsimVectorWriter::getType() const { return m_type; }

RefCsimClock        CsimVectorWriter::getClock() const { return m_clock; }

CsimVectorWriter::TOFStream*          CsimVectorWriter::getOutputStream() const { return m_out.get(); }

}

//END OF FILE
