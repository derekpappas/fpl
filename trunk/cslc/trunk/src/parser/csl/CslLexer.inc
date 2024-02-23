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

RefToken CslLexer::makeToken(int t) {
  RefToken tok = CharScanner::makeToken(t);
  return tok;
}

RefToken CslLexer::makeNumberToken(int t, const RefCslNumber number) {
  RefToken tok = makeToken(t);

  CslToken *vtok = static_cast<CslToken*>(tok.get());
  vtok->setNumber(number);

  return tok;
}

TChar CslLexer::octStrToChar(const string& str) const {
  TInt ch = octStrToInt(str);

  if (ch > 0xFF) 
    throw CslLexerException( lexerState(), "Octal value in string escape sequence is higher than \\377");

  return (TChar) ch;
}

TCslLexerState CslLexer::lexerState() const {
  TCslLexerState state;

  state.m_line = getLine();
  state.m_col = getColumn();
  state.m_filename = getFilename();

  return state;
}

TInt CslLexer::convertStrToInt(const string& str) {
  TInt i;
  TBool overflow;

  i = strToInt(str, overflow);

  if (overflow)
    throw CslLexerException(lexerState(), "Integer constant out of range");

  return i;
}

TDouble CslLexer::convertStrToReal(const string& str) {
  TDouble r;
  TBool overflow;
  TBool underflow;

  r = strToReal(str, overflow, underflow);

  if (overflow)
    throw CslLexerException(lexerState(), "Real constant out of range (overflow)");

  if (underflow)
    throw CslLexerException(lexerState(), "Real constant out of range (underflow)");

  return r;
}

// End of File
