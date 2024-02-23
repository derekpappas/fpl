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

// Author BogdanZ

#ifndef INC_GUARD_CSLOm_STMTs_h
#define INC_GUARD_CSLOm_STMTs_h

#include "Base.h"
#include "../support/CommonSupport.h"
#include "VeriNum.h"
#include "CSLOM_Declarations.h"
#include "CSLOM_Base.h"
#include "CSLOM_Scoping.h"

namespace NSCSLOmVisitor {
class CVisitor;
}

namespace NSCSLOm {

// ********************************************************************************
// CSLOmStmt class
// ********************************************************************************
/**
 * Base class for all stmt objects
 */
class CSLOmStmt: public CSLOmBase {
  public:

    /**
     * stmt type:
     * - assign stmt
     */
    enum ECSLOmStmtType {
      STMT_UNDEFINED,
      STMT_ASSIGN,
      STMT_MAX
    };

  private:
    RefCSLOmStmt getThis() const { return boost::static_pointer_cast<CSLOmStmt>(m_weakRef.lock()); }

  protected:
    ECSLOmStmtType m_stmtType;
    CSLOmStmt(TLineNumberType, RefString, ECSLOmStmtType);
    
  public:

    /**
     * API function to cast a base object to the a stmt object
     */
    static RefCSLOmStmt cast(RefCSLOmBase);

    /**
     * API function to get the type of the stmt
     */
    ECSLOmStmtType getStmtType() const;
};

// ********************************************************************************
// CSLOmStmtAssign class
// ********************************************************************************
/**
 * class that holds a stmt assign 
 * m_children[0] = LHS
 * m_children[1] = RHS
 * 
 * the children are expressions
 */
class CSLOmStmtAssign: public CSLOmStmt {
  private:
    RefCSLOmStmtAssign getThis() const { return boost::static_pointer_cast<CSLOmStmtAssign>(m_weakRef.lock()); }
  protected:
    CSLOmStmtAssign(TLineNumberType, RefString);
  public:

    /**
     * API functions to cast a base object the a stmt assign object
     */
    static RefCSLOmStmtAssign cast(RefCSLOmBase);

    /**
     * build method for the stmt assign class
     * @param lineNumber - type TLineNumberType - linenumber where the stmt accured in the code
     * @param parent - type RefCSLOmBase - parent object(usualy a unit)the object that the assign stmt accured in
     * @param lhs - type RefCSLOmExpr - left hand side of the stmt
     * @param rhs - type RefCSLOmExpr - right hand side of the stmt
     */
    static RefCSLOmStmtAssign build(TLineNumberType, RefString, RefCSLOmBase, RefCSLOmExpr, RefCSLOmExpr);
    
    /**
     * API function to return the children of the object
     */
    RefCSLOmExpr getLHS() const;
    RefCSLOmExpr getRHS() const;

    void acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const;
};

}

#endif
