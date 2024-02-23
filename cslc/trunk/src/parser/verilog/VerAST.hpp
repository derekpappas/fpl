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

#ifndef VERAST_HPP
#define VERAST_HPP

#include <antlr/CommonAST.hpp>
#include "VerilogToken.hpp"
#include "../../support/Base.hpp"
#include "VerilogNumber.hpp"

namespace antlr {

class VerAST;

typedef ANTLR_USE_NAMESPACE(antlr)ASTRefCount<VerAST> RefVerAST;
}

void myDestroy(antlr::RefAST&);

ANTLR_BEGIN_NAMESPACE(antlr);
class VerAST : public ANTLR_USE_NAMESPACE(antlr)CommonAST
{
  public:
    VerAST(const VerAST& other) 
      : CommonAST(other) , m_number(other.m_number) , m_line(other.m_line) , m_col(other.m_col) { }

    VerAST() : CommonAST(), m_line(0), m_col(0) { }
    virtual ~VerAST() { RefAST temp; myDestroy(temp=getNextSibling()); myDestroy(temp=getFirstChild()); }

    virtual int getLine() const
    {
      if ( m_line != 0 )
        return m_line;
      if(getFirstChild())
        return (RefVerAST(getFirstChild())->getLine());
      return 0;
    }
    virtual void setLine(int l)
    {
      m_line = l;
    }
    virtual int getColumn() const
    {
      if (m_col != 0)
        return m_col;
      if(getFirstChild())
        return (RefVerAST(getFirstChild())->getColumn());
      return 0;
    }
    virtual void setColumn(int c)
    {
      m_col = c;
    }

    const RefVerilogNumber getNumber() const { return m_number; }
    void setNumber(const RefVerilogNumber number) { m_number = number; }

    virtual void initialize(int t, const ANTLR_USE_NAMESPACE(std)string& txt)
    {
      CommonAST::initialize(t,txt);
      m_line = 0;
      m_col = 0;
    }
    virtual void initialize(ANTLR_USE_NAMESPACE(antlr)RefToken t)
    {
      CommonAST::initialize(t);
      m_line = t->getLine();
      m_col = t->getColumn();
      VerilogToken* vt = static_cast<VerilogToken*>(t.get());
      m_number = vt->getNumber();
    }
    virtual void initialize(RefVerAST ast)
    {
      CommonAST::initialize(ANTLR_USE_NAMESPACE(antlr)RefAST(ast));
      m_line = ast->getLine();
      m_col = ast->getColumn();
      m_number = ast->getNumber();
    }

    void addChild(RefVerAST c)
    {
      BaseAST::addChild(ANTLR_USE_NAMESPACE(antlr)RefAST(c));
    }
    void setNextSibling(RefVerAST c)
    {
      BaseAST::setNextSibling(ANTLR_USE_NAMESPACE(antlr)RefAST(c));
    }

    virtual ANTLR_USE_NAMESPACE(antlr)RefAST clone( void )
    {
      return ANTLR_USE_NAMESPACE(antlr)RefAST(new VerAST(*this));
    }
    static ANTLR_USE_NAMESPACE(antlr)RefAST factory( void )
    {
      return ANTLR_USE_NAMESPACE(antlr)RefAST(RefVerAST(new VerAST()));
    }

  protected:
    RefVerilogNumber m_number;

  private:
    int m_line;
    int m_col;
};

ANTLR_END_NAMESPACE

#endif

// End of File
