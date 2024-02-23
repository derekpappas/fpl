//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 Fastpathlogic
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
 * Author: 
 */

#ifndef INC_GUARD_TypeDefs_h
#define INC_GUARD_TypeDefs_h

//using namespace boost;

#include <boost/shared_ptr.hpp>
#include <string>
#include <vector>
#include <stack>
//********************************************************************************
// CDOM defines
//********************************************************************************
#define FALSE false
#define TRUE true

//********************************************************************************
// CDOM typedefs
// legend
// T = TYPE
// U = UNSIGNED
//********************************************************************************
typedef char               TChar;
typedef short              TShort;
typedef int                TInt;
typedef unsigned int       TUInt;
typedef long               TLong;
typedef unsigned long      TULong;
typedef long long          TLongLong;
typedef unsigned long long TULongLong;
typedef float              TFloat;
typedef double             TDouble;
typedef double             TReal;
typedef long double        TLDouble;
typedef bool               TBool;
typedef TInt               TLineNumberType;

typedef boost::shared_ptr<std::string>               RefString;

typedef std::vector<TInt>                      TVec_TInt;           //vector of TInt
typedef std::vector<TUInt>                     TVec_TUInt;           //vector of TInt
typedef std::vector<TBool>                     TVec_TBool;           //vector of TBool
typedef std::vector<TLong>                     TVec_TLong;           //vector of TInt
typedef std::stack<TInt>                       TStack_TInt;          //stack of TInt

typedef TVec_TInt::const_iterator                      TVec_TInt_const_iter;
typedef TVec_TUInt::const_iterator                     TVec_TUInt_const_iter;
typedef TVec_TLong::const_iterator                     TVec_TLong_const_iter;
typedef TVec_TBool::const_iterator                     TVec_TBool_const_iter;

typedef std::string                                     TString;
// typedef boost::shared_ptr<>                      RefTVec_TInt;
// typedef boost::shared_ptr<TVec_TInt>                      RefTVec_TInt;
// typedef boost::shared_ptr<TVec_TUInt>                     RefTVec_TUInt;
// typedef boost::shared_ptr<TVec_TBool>                     RefTVec_TBool;
// typedef boost::shared_ptr<TVec_TLong>                     RefTVec_TLong;
// typedef boost::shared_ptr<TStack_TInt>                    RefTStack_TInt;


#endif /*INC_GUARD_CDOM_TypeDefs_h*/
