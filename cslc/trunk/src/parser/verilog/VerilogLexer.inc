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

void VerilogLexer::initialize()
    {
    m_udpTable = FALSE;
    }

RefToken VerilogLexer::makeToken(int t)
    {
    RefToken tok = CharScanner::makeToken(t);

    VerilogToken *vtok = static_cast<VerilogToken*>(tok.get());
    vtok->setFileNameId(m_fileNames.getFileNameId(getFilename()), &m_fileNames);

    return tok;
    }

RefToken VerilogLexer::makeNumberToken(int t, const RefVerilogNumber number)
    {
    RefToken tok = makeToken(t);
    
    VerilogToken *vtok = static_cast<VerilogToken*>(tok.get());
    vtok->setNumber(number);

    return tok;
    }

TChar VerilogLexer::octStrToChar(const string& str) const
    {
    TInt ch = octStrToInt(str);

    if (ch > 0xFF)
        throw VerilogLexerException(
                  lexerState(),
                  "Octal value in string esacpe sequence is higher than \\377"
              );

    return (TChar) ch;
    }

TVerLexerState VerilogLexer::lexerState() const
    {
    TVerLexerState state;
    
    state.m_line = getLine();
    state.m_col = getColumn();
    state.m_filename = getFilename();
    
    return state;
    }

void VerilogLexer::handleLineDirective(const string& filename,
        const string& lineText)
    {
    setFilename(filename);

    TInt l;
    TBool overflow;

    l = strToInt(lineText, overflow);
    
    if (overflow)
        throw VerilogLexerException(lexerState(), "Line number out of range");
    
    setLine(l);
    }

TInt VerilogLexer::convertStrToInt(const string& str)
    {
    TInt i;
    TBool overflow;

    i = strToInt(str, overflow);
    
    if (overflow)
        throw VerilogLexerException(lexerState(), "Integer constant out of range");
    
    return i;
    }

TReal VerilogLexer::convertStrToReal(const string& str)
    {
    TReal r;
    TBool overflow;
    TBool underflow;

    r = strToReal(str, overflow, underflow);
    
    if (overflow)
        throw VerilogLexerException(lexerState(), "Real constant out of range (overflow)");

    if (underflow)
        throw VerilogLexerException(lexerState(), "Real constant out of range (underflow)");
    
    return r;
    }

// End of File
