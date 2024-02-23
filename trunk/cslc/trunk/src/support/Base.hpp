//----------------------------------------------------------------------
// Copyright (c) 2006, 2007, 2008 Fastpathlogic
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

/*
 *   Part of the Verilog parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

#ifndef INC_GUARD_VERILOG_BASE_HPP
#define INC_GUARD_VERILOG_BASE_HPP

#include <string>
#include <exception>
#include "TypeDefs.h"

class BaseException: public std::exception {
    public:
        BaseException(const TChar *message) throw()
                : m_message(message) { }
        virtual ~BaseException() throw () { }
        const TChar* what() const throw() { return m_message.c_str(); }
    private:
        std::string m_message;
    };

std::string intToStr(TInt val);
TInt charToInt(TChar ch);
TInt octStrToInt(const std::string& str);
TInt strToInt(const std::string& str, TBool& overflow);
TReal strToReal(const std::string& str, TBool& overflow, TBool& underflow);
std::string realToStr(TReal real);
std::string escapeStr(const std::string& str);
TBool equal(const std::string& str1, const std::string& str2);
TBool startsWith(const std::string& str1, const std::string& str2, TBool ignoreCase);

#endif

// End of File
