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
 *   Part of the Verilog parser
 *   Author: David Mishelashvili <dm@internet.ge>
 *   2005
 */

#ifndef VERILOGLEXERUTILS_HPP
#define VERILOGLEXERUTILS_HPP

#include <string>
#include <vector>
#include "antlr/config.hpp"
#include "Def.hpp"

ANTLR_USING_NAMESPACE(std);

struct TVerLexerState
    {
    TInt m_line;
    TInt m_col;
    string m_filename;
    };

class VerilogLexerException: public exception
    {
    public:
        VerilogLexerException(const TVerLexerState& state,
            const TChar *message) throw()
                : m_state(state), m_message(message) { }
        virtual ~VerilogLexerException() throw () { }
        const TChar* what() const throw() { return m_message.c_str(); }
        const TVerLexerState& state() const { return m_state; }
    private:
        TVerLexerState m_state;
        string m_message;
    };



typedef TInt TFileNameId;

class IFileNameCollection
    {
    public:
        enum TNoFile { NO_FILE = -1 };

    public:
        virtual TFileNameId getFileNameId(const string& fileName) = 0;
        virtual string fileNameById(TFileNameId id) const = 0;
        virtual TInt count() const = 0;
    };

class FileNameCollection: public IFileNameCollection
    {
    public:
        typedef vector<string> FileNameVector;
    public:
        virtual ~FileNameCollection() { };

    public: // from base class
        TFileNameId getFileNameId(const string& fileName);
        string fileNameById(TFileNameId id) const;
        TInt count() const;

    private:
        FileNameVector m_fileNames;
    };

// for debug purpose
const TChar* tokenName(TInt t);

#endif

// End of File
