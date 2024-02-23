//---------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpath Logic, Inc.
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of Fastpath Logic, Inc.;
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

/*
 * Author: Zamfir Bogdan <bogdanz@fastpathlogic.ro>
 * 2007
 */

#ifndef INC_GUARD_ASSERT_WITH_MSG_h
#define INC_GUARD_ASSERT_WITH_MSG_h

#include <iostream>
#ifndef __RELEASE_VERSION
#include <cassert>
#define ASSERT(smth, msg) \
  if( !(smth) ) {\
    std::cerr << msg << std::endl;\
    assert(smth);\
  }
#else
const int FATAL_ERROR = 1;
#define ASSERT(smth, msg) \
  if(!(smth)) { \
    std::cerr << "A fatal error in the product occured please contact support about this" << std::endl;\
    throw FATAL_ERROR;\
 }
#endif

#endif
