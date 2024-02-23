//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007, 2008 Fastpath Logic
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

#include "CSLOM.h"
#include "CSLOM_Visitor.h"
#include "../csl_xml_warn_error/CSLC_Errors.h"
#include "../csl_xml_warn_error/we_logic.h"
#include <algorithm>
#include <iterator>
#include <sstream>
#include <cstdlib>
#include <cmath>
#include "../support/CommonSupport.h"

/**
 * Bit that tells the cslc if errors appeared in the CSLOM
 */
extern TBool cslomHasErrors;


namespace NSCSLOm {

// ********************************************************************************
// CSLOmStmt class
// ********************************************************************************
CSLOmStmt::CSLOmStmt(TLineNumberType lineNumber, RefString fileName, CSLOmStmt::ECSLOmStmtType type) :
  CSLOmBase(TYPE_STMT, lineNumber, fileName),
  m_stmtType(type) { }

RefCSLOmStmt CSLOmStmt::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmStmt();
  }
  else {
    ASSERT(object->isStmt() , "type check on cast failure");
    return boost::static_pointer_cast<CSLOmStmt>(object);
  }
}

CSLOmStmt::ECSLOmStmtType CSLOmStmt::getStmtType() const {
  return m_stmtType;
} 

// ********************************************************************************
// CSLOmStmtAssign class
// ********************************************************************************
CSLOmStmtAssign::CSLOmStmtAssign(TLineNumberType lineNumber, RefString fileName) :
  CSLOmStmt(lineNumber, fileName, CSLOmStmt::STMT_ASSIGN) { }

RefCSLOmStmtAssign CSLOmStmtAssign::cast(RefCSLOmBase object) {
  if (!object.get()) {
    return RefCSLOmStmtAssign();
  }
  else {
    ASSERT(object->isStmt() , "type check on cast failure");
    ASSERT(CSLOmStmt::cast(object)->getStmtType() == CSLOmStmt::STMT_ASSIGN, "type check on cast failure");
    return boost::static_pointer_cast<CSLOmStmtAssign>(object);
  }
}

RefCSLOmStmtAssign CSLOmStmtAssign::build(TLineNumberType lineNumber, RefString fileName, RefCSLOmBase parent, RefCSLOmExpr leftHS, RefCSLOmExpr rightHS) {
  ASSERT(parent.get(), "null parent");
  ASSERT(leftHS.get(), "null LHS");
  ASSERT(rightHS.get(), "null LHS");

//   RefCSLOmBase lhs = leftHS->doEval();
//   RefCSLOmBase rhs = rightHS->doEval(TRUE);

  //if(!leftHS->isExprLink()) {
  //  addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_LHS, args, lineNumber);
  //  cslomHasErrors = TRUE;
  //  return RefCSLOmStmtAssign();
  //}
  
  
//   if(leftHS->isExprLink()) {
//     if(!lhs.get()) {
//       addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_LHS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmStmtAssign();
//     }
//     else if (!lhs->isConnectable()) {
//       addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_LHS, args, lineNumber, fileName);
//       cslomHasErrors = TRUE;
//       return RefCSLOmStmtAssign();
//     }
//     if(rhs.get()) {
//       if (lhs->isPort() && rhs->isPort()) {
//         //todo: fix error message
//         RefCSLOmBase temp = lhs;
//         while (!temp->isUnitDecl()) {
//           temp = temp->getParent();
//         }
//         RefCSLOmBase temp1 = rhs;
//         while (!temp1->isUnitDecl()) {
//           temp1 = temp1->getParent();
//         }
//         if (temp.get() == temp1.get()) {
//           addErr(NSWarningErr::CSE_CSC_EXPR_CANNOT_EVAL_RHS, args, lineNumber, fileName);
//           cslomHasErrors = TRUE;
//           return RefCSLOmStmtAssign();
//         }
//       }
//     }
//   }

  CSLOmStmtAssign* stmtAssign;
  try {
    stmtAssign = new CSLOmStmtAssign(lineNumber, fileName);
  }
  catch (std::exception& e) {
    ASSERT(FAIL,"new operator failed");
  }


  RefCSLOmStmtAssign refStmtAssign(stmtAssign);
  stmtAssign->m_weakRef = boost::weak_ptr<CSLOmBase>( refStmtAssign);
  stmtAssign->setParent(parent);
  
  leftHS->setParent(refStmtAssign);
  rightHS->setParent(refStmtAssign);

  return refStmtAssign;
}

RefCSLOmExpr CSLOmStmtAssign::getLHS() const {
  return CSLOmExpr::cast(getChild(STMT_ASSIGN_LHS));
}

RefCSLOmExpr CSLOmStmtAssign::getRHS() const {
  return CSLOmExpr::cast(getChild(STMT_ASSIGN_RHS));
}

void CSLOmStmtAssign::acceptVisitor(NSCSLOmVisitor::CVisitor& visitor) const {
  visitor.visit(getThis());
}

}
