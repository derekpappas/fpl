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

#ifndef VERILOGTOKEN_HPP
#define VERILOGTOKEN_HPP

#include <string>
#include "antlr/config.hpp"
#include "antlr/CommonToken.hpp"
#include "VerilogNumber.hpp"
#include "VerilogLexerUtils.hpp"

ANTLR_BEGIN_NAMESPACE(antlr)

class VerilogToken;

class VerilogToken: public CommonToken
    {
public:
    VerilogToken() : CommonToken(), m_fileNameId(IFileNameCollection::NO_FILE),
        m_fileNameCollection(NULL) { }
    VerilogToken(int t, const ANTLR_USE_NAMESPACE(std)string& txt)
        : CommonToken(t, txt), m_fileNameId(IFileNameCollection::NO_FILE),
            m_fileNameCollection(NULL) { }
    VerilogToken(const ANTLR_USE_NAMESPACE(std)string& s)
        : CommonToken(s), m_fileNameId(IFileNameCollection::NO_FILE),
            m_fileNameCollection(NULL) { }

public:
    TFileNameId getFileNameId() const
        { return m_fileNameId; }
    IFileNameCollection* getFileNameCollection() const
        { return m_fileNameCollection; }
    void setFileNameId(TFileNameId id, IFileNameCollection *col = NULL)
        {
        m_fileNameId = id;
        m_fileNameCollection = col;
        }
    ANTLR_USE_NAMESPACE(std)string fileName() const;
    const RefVerilogNumber getNumber() const { return m_number; }
    void setNumber(const RefVerilogNumber number) { m_number = number; }

public:
    ANTLR_USE_NAMESPACE(std)string toString() const;
    static RefToken factory();

protected:
    TFileNameId m_fileNameId;
    IFileNameCollection *m_fileNameCollection;
    RefVerilogNumber m_number;

private:
    VerilogToken(const VerilogToken&);
    const VerilogToken& operator=(const VerilogToken&);
};

ANTLR_END_NAMESPACE

#endif

// End of File
