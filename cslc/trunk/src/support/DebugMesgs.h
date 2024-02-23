//----------------------------------------------------------------------
// Copyright (c) 2007, 2008 Fastpathlogic
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

/**
 * Author: Bogdan Zamfir <bogdanz@fplsrl.com>
 */

#ifndef INC_GUARD_DEBUG_MSG_h
#define INC_GUARD_DEBUG_MSG_h
//#define __RELEASE_VERSION
#include <iostream>
#ifndef __RELEASE_VERSION //DCOUT
#define DCOUT(msg) \
  std::cout<<"DEBUG:" << msg;
#else
#define DCOUT(msg) 
#endif // DCOUT

#ifndef __RELEASE_VERSION //DCERR
#define DCERR(msg) \
   std::cerr<<"DEBUG:" << msg << std::endl;
#else
#define DCERR(msg) 
#endif //DCERR

#endif //INC_GUARD_DEBUG_MSG_h
