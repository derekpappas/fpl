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

#include "CsimSignalBase.h"

namespace NSCsimLib {


CsimSignalBase::CsimSignalBase(RefString name, TUInt width, RefCsimUnit parent) : m_name(name), m_width(width), m_parent(parent), m_wasModified(FALSE), 
                                                                                  m_testModified(FALSE), m_weakRef(){}


CsimSignalBase::~CsimSignalBase() {}


const RefString          CsimSignalBase::getName() const { return m_name; }


TUInt                    CsimSignalBase::getWidth() const { return m_width; }


RefCsimUnit              CsimSignalBase::getParent() const { return boost::static_pointer_cast<CsimUnit>(m_parent.lock()); }


TBool                    CsimSignalBase::wasModified() {
  return m_wasModified;
}



void                     CsimSignalBase::setModified() {
  m_wasModified = TRUE;
}



void                     CsimSignalBase::resetModified() {
  m_wasModified = FALSE;
}



void                     CsimSignalBase::startTestingModified() {
  if (!m_testModified) { m_testModified = TRUE; }
}



void                     CsimSignalBase::stopTestingModified() {
  if (m_testModified) { m_testModified = FALSE; }
}


TBool                    CsimSignalBase::canTestModified() {
  return m_testModified;
}

}

//END OF FILE
