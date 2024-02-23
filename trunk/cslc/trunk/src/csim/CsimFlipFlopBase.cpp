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


#include "CsimFlipFlopBase.h"

namespace NSCsimLib {

CsimFlipFlopBase::CsimFlipFlopBase(RefCsimClock clock, RefString name) : CsimUnit(name), m_clock(clock) {}


CsimFlipFlopBase::~CsimFlipFlopBase() {}


//const RefString     CsimFlipFlopBase::getName        () const { return m_name; }//return name

    
RefCsimClock        CsimFlipFlopBase::getClock       () { return m_clock; }


}


//END OF FILE
