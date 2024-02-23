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
 *   Author: David Mishelashvili 
 *   2005
 */

#ifndef CSLTOKEN_HPP
#define CSLTOKEN_HPP

#include <string>
#include "antlr/config.hpp"
#include "antlr/CommonToken.hpp"
#include "CslNumber.hpp"
#include "CslLexerUtils.hpp"

ANTLR_BEGIN_NAMESPACE(antlr)

class CslToken;

class CslToken: public CommonToken {
  public:
    CslToken() : CommonToken() { }
    CslToken(int t, const ANTLR_USE_NAMESPACE(std)string& txt)
      : CommonToken(t, txt) { }
    CslToken(const ANTLR_USE_NAMESPACE(std)string& s)
      : CommonToken(s) { }

  public:
    const RefCslNumber getNumber() const { return m_number; }
    void setNumber(const RefCslNumber number) { m_number = number; }

  public:
    ANTLR_USE_NAMESPACE(std)string toString() const;
    static RefToken factory();

  protected:
    RefCslNumber m_number;

  private:
    CslToken(const CslToken&);
    const CslToken& operator=(const CslToken&);
};

ANTLR_END_NAMESPACE

#endif

// End of File
