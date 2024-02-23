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


#include "CsimMemoryBase.h"


namespace NSCsimLib {



CsimMemoryBase::CsimMemoryBase(RefString name, TUInt width, TUInt depth, RefCsimClock clock, RefCsimUnit parent)  
  : m_name(name), m_width(width), m_depth(depth), m_clock(clock), m_parent(parent), m_radix(T_BIN) {

  //create the ports

  TUInt onOffWidth = 1;

  m_rdEnPort = CsimPortTBool::build(RefString(new std::string("rdEn")), onOffWidth, parent, PORT_DIR_INPUT);

  m_rdEnPort->allocateValue();

  m_rdEnPort->setValue(FALSE);

  m_wrEnPort = CsimPortTBool::build(RefString(new std::string("wrEn")), onOffWidth, parent, PORT_DIR_INPUT);

  m_wrEnPort->allocateValue();

  m_wrEnPort->setValue(FALSE);

  m_resetPort = CsimPortTBool::build(RefString(new std::string("reset")), onOffWidth, parent, PORT_DIR_INPUT);

  m_resetPort->allocateValue();

  m_resetPort->setValue(FALSE);

//  resetMemory(); 
}



CsimMemoryBase::~CsimMemoryBase() {}




RefCsimUnit     CsimMemoryBase::getParent() const { return boost::static_pointer_cast<CsimUnit>(m_parent.lock()); }




const RefString      CsimMemoryBase::getName() const { return m_name; }



TUInt      CsimMemoryBase::getWidth() const { return m_width; }



TUInt      CsimMemoryBase::getDepth() const { return m_depth; }




RefCsimClock         CsimMemoryBase::getClock() const { return m_clock; }





RefCsimPortTBool     CsimMemoryBase::getRdEnPort() const { return m_rdEnPort; }




RefCsimPortTBool     CsimMemoryBase::getWrEnPort() const { return m_wrEnPort; }




RefCsimPortTBool     CsimMemoryBase::getResetPort() const { return m_resetPort; }




TRadix        CsimMemoryBase::getRadix() const {
  return m_radix;
}




void        CsimMemoryBase::setRadix(TRadix radix) {
  m_radix = radix;
}



}

//END OF FILE
