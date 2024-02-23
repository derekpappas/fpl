//----------------------------------------------------------------------
// Copyright (c) 2005-2008 Fastpathlogic
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
//Author: Tb

#ifndef INC_GUARD_cslc_Platform_h_
#define INC_GUARD_cslc_Platform_h_

# if !defined(CSLC_WINDOWS) && !defined(CSLC_POSIX)
#   if defined(_WIN32) || defined(__WIN32__) || defined(WIN32) || defined(__CYGWIN__)
#     define CSLC_WINDOWS
#   else
#     define CSLC_POSIX
#   endif
# endif

#endif //INC_GUARD_cslc_Platform_h_
