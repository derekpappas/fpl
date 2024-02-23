//----------------------------------------------------------------------
// Copyright (c) 2006 Fastpathlogic
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
 *   Part of the Csl parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

#ifndef CSLLEXERUTILS_HPP
#define CSLLEXERUTILS_HPP

#include <string>
#include <vector>
#include "antlr/config.hpp"
#include "Def.hpp"

ANTLR_USING_NAMESPACE(std);

struct TCslLexerState
    {
    TInt m_line;
    TInt m_col;
    string m_filename;
    };

class CslLexerException: public exception
    {
    public:
        CslLexerException(const TCslLexerState& state,
            const TChar *message) throw()
                : m_state(state), m_message(message) { }
        virtual ~CslLexerException() throw () { }
        const TChar* what() const throw() { return m_message.c_str(); }
        const TCslLexerState& state() const { return m_state; }
    private:
        TCslLexerState m_state;
        string m_message;
    };
#endif

// End of File
