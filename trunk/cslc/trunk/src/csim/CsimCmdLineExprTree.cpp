//---------------------------------------------------------------------
// Copyright (C) 2005, 2006, 2007 Fastpath Logic
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


#include "CsimCmdLineExprTree.h"

namespace NSCsimLib {


CsimCmdLineExprTree::CsimCmdLineExprTree(RefTVec_RefCsimCmdLineExpr exprs) : m_exprVec(exprs), m_currentExpr(m_exprVec->begin()), m_root(), m_malformedExpr(FALSE)  { 
  ASSERT(exprs.get(), "EXPR TREE - null vector of expressions received");
  checkExprVec();
  m_root = buildExprTree(); 
  checkExprTree(m_root); 
}



RefCsimCmdLineExprTree CsimCmdLineExprTree::build(RefTVec_RefCsimCmdLineExpr   exprs) {
  ASSERT(exprs.get(), "EXPR TREE - null vector of expressions received");

  CsimCmdLineExprTree* tree;

  try {
    tree = new CsimCmdLineExprTree(exprs);
  }
  catch(std::exception& e) {
    ASSERT(FAIL, "EXPR TREE - new operator failed");
  }

  RefCsimCmdLineExprTree refTree = RefCsimCmdLineExprTree(tree);
  tree->m_weakRef = WeakRefCsimCmdLineExprTree(refTree);

  return refTree;
}



RefCsimCmdLineExpr CsimCmdLineExprTree::getRootExpr() { return m_root; }



TLongLong               CsimCmdLineExprTree::doEval() {
  ASSERT(m_root.get(), "EXPR TREE - null root");
  return m_root->doEval();
}



void CsimCmdLineExprTree::print() {
  RefCsimCmdLineExpr temp = m_root;

  TInt i = 0;

  TBool stop = FALSE;

  RefTVec_RefCsimCmdLineExpr level( new TVec_RefCsimCmdLineExpr);

  level->push_back(temp);

  while (!stop) {

    DCERR("LEVEL =" << i );

    RefTVec_RefCsimCmdLineExpr  children( new TVec_RefCsimCmdLineExpr);

    for (TVec_RefCsimCmdLineExpr_iterator it = level->begin(); it != level->end(); ++it) {
      RefStringstream output(new std::stringstream);
      RefCsimCmdLineExpr parent = (*it)->getParent();
      if (parent.get()) {
        (*output) << "(PARENT ->" << "ADDR:" << parent.get() << ", ";
        if (parent->isOp()) {
          (*output) << "OP:" << (boost::static_pointer_cast<CsimCmdLineExprOper>(parent))->getOperType() << ") ";
        }
        else if (parent->isNum()) {
          (*output) << "NUM:" << (boost::static_pointer_cast<CsimCmdLineExprNum>(parent))->doEval() << ") ";
        }
        else if (parent->isId()) {
          (*output) << "ID:" << (boost::static_pointer_cast<CsimCmdLineExprId>(parent))->doEval() << ") ";
        }
      }
      (*output) << "ADDR:" << (*it).get() << ", ";
      if ((*it)->isOp()) {
        (*output) << "OP:" << (boost::static_pointer_cast<CsimCmdLineExprOper>(*it))->getOperType() << "     ";
      }
      else if ((*it)->isNum()) {
        (*output) << "NUM:" << (boost::static_pointer_cast<CsimCmdLineExprNum>(*it))->doEval() << "     ";
      }
      else if ((*it)->isId()) {
        (*output) << "ID:" << (boost::static_pointer_cast<CsimCmdLineExprId>(*it))->doEval() << ") ";
      }

      DCERR( output->str() );

      RefTVec_RefCsimCmdLineExpr tmpVec = (*it)->getChildren();

      for (TVec_RefCsimCmdLineExpr_iterator iter = tmpVec->begin(); iter != tmpVec->end(); ++iter) {
        children->push_back(*iter);
      }
    }

    ++i;
    if (children->empty()) { stop = TRUE; }
    else { 
      level->clear();
      for ( TVec_RefCsimCmdLineExpr_iterator iter = children->begin(); children->end() != iter; ++iter) { level->push_back(*iter); }
    }
  }
}



RefCsimCmdLineExpr CsimCmdLineExprTree::buildExprTree(TBool wasLParen) {

  RefCsimCmdLineExpr tempRoot;

  if (m_malformedExpr) { return tempRoot; }


  while (m_currentExpr != m_exprVec->end() && !m_malformedExpr) {

    if (!tempRoot.get()) { tempRoot = *m_currentExpr; }
    else {
      if ((*m_currentExpr)->isNum() || (*m_currentExpr)->isId()) {//m_currentExpr is num or id
        RefCsimCmdLineExpr temp = tempRoot;
        while (temp->isOp()) {
          RefTVec_RefCsimCmdLineExpr children = temp->getChildren();
          if (temp->hasMaxNoOfChildren()) {
            RefCsimCmdLineExpr lastChild = children->at(children->size() - 1);
            if (lastChild->isOp()) {
              temp = lastChild;
            }
            else {
              m_malformedExpr = TRUE; return tempRoot;
            }
          }
          else { break; }
        }
        
        temp->addChild(*m_currentExpr);
      }

      else {//m_currentExpr is op

        if ((*m_currentExpr)->isOp() &&
            (boost::static_pointer_cast<CsimCmdLineExprOper>(*m_currentExpr))->getOperType() == EXPR_OPER_TYPE_RPAREN) {
          if (!wasLParen) {
            m_malformedExpr = TRUE; 
          }
          return tempRoot;
        }
        
        RefCsimCmdLineExpr temp = tempRoot;
        
        TBool addAsChild = FALSE;
        TBool replaceLastChild = FALSE;

        while (temp->isOp()) {
          RefCsimCmdLineExprOper currentOper = boost::static_pointer_cast<CsimCmdLineExprOper>(*m_currentExpr);
          RefCsimCmdLineExprOper tempOper    = boost::static_pointer_cast<CsimCmdLineExprOper>(temp);

          if (currentOper->getOperType() >= tempOper->getOperType()) {

            if (temp->hasMaxNoOfChildren()) {
              RefTVec_RefCsimCmdLineExpr children = temp->getChildren();
              RefCsimCmdLineExpr lastChild = children->at(children->size() - 1);

              if (lastChild->isOp()) { temp = lastChild; }
              else { replaceLastChild = TRUE; break; }
            }
            else { addAsChild = TRUE; break; }
          }
          else { break; }
        }

        RefCsimCmdLineExpr currentExpr;

        RefCsimCmdLineExprOper currentOper = boost::static_pointer_cast<CsimCmdLineExprOper>(*m_currentExpr);

        if (currentOper->getOperType() == EXPR_OPER_TYPE_LPAREN) {

          if (replaceLastChild || !addAsChild) { m_malformedExpr = TRUE; return tempRoot; }

          RefCsimCmdLineExprOper paren = CsimCmdLineExprOper::build(EXPR_OPER_TYPE_PAREN);
          ++m_currentExpr;
          RefCsimCmdLineExpr subExpr = buildExprTree(TRUE);
          if (!subExpr.get()) { m_malformedExpr = TRUE; return tempRoot; }
          paren->addChild(subExpr);
          currentExpr = paren;
          if (!m_malformedExpr) {
            if (m_currentExpr == m_exprVec->end()) { m_malformedExpr = TRUE; return tempRoot; }
          }
//          else {
//           
//            
//            RefCsimCmdLineExprOper rparen = boost::static_pointer_cast<CsimCmdLineExprOper>(*m_currentExpr);
//            if () {}
//          }
          
        }
        else { currentExpr = *m_currentExpr;}

        if (addAsChild) {
          
          if (replaceLastChild) {
            
            RefTVec_RefCsimCmdLineExpr children = temp->getChildren();
            TVec_RefCsimCmdLineExpr::iterator it = temp->getChildren()->begin();
            for (TUInt i = 0; i < children->size(); ++i, ++it) ;
            currentExpr->addChild(*it);
            children->erase(it);
            temp->addChild(currentExpr);
          }
          else {
            
            temp->addChild(currentExpr);
          }
        }
        else {  
          
          RefCsimCmdLineExpr parent = temp->getParent();
          if (parent.get()) {
            RefTVec_RefCsimCmdLineExpr children = parent->getChildren();
            TVec_RefCsimCmdLineExpr::iterator it = parent->getChildren()->begin();
            for (TUInt i = 0; i < children->size(); ++i, ++it) ;
            currentExpr->addChild(temp);
            children->erase(it);
            parent->addChild(currentExpr);
          }
          else { currentExpr->addChild(temp); tempRoot = currentExpr; }
        }
      }
    }
    ++m_currentExpr;
  }

  return tempRoot;

}



void CsimCmdLineExprTree::checkExprVec() {

  if (m_malformedExpr) { return; }

  if (m_exprVec->empty()) { return; }

  TVec_RefCsimCmdLineExpr_iterator nextExpr = m_currentExpr + 1;
  
  while (nextExpr != m_exprVec->end()) {
    if ((*m_currentExpr)->isId() || (*m_currentExpr)->isNum()) {
      if ((*nextExpr)->isId() || (*nextExpr)->isNum()) { m_malformedExpr = TRUE; return; }
    }
    else {
      if ((*nextExpr)->isOp()) {
        RefCsimCmdLineExprOper currentOp = boost::static_pointer_cast<CsimCmdLineExprOper>(*m_currentExpr);
        RefCsimCmdLineExprOper nextOp = boost::static_pointer_cast<CsimCmdLineExprOper>(*nextExpr);
        if (currentOp->getOperType() != EXPR_OPER_TYPE_LPAREN && currentOp->getOperType() != EXPR_OPER_TYPE_RPAREN && 
             nextOp->getOperType() != EXPR_OPER_TYPE_LPAREN && nextOp->getOperType() != EXPR_OPER_TYPE_RPAREN) {
        
              if (nextOp->getOperType() > currentOp->getOperType()) { m_malformedExpr = TRUE; return; }
        }
        else if ((currentOp->getOperType() == EXPR_OPER_TYPE_LPAREN || currentOp->getOperType() == EXPR_OPER_TYPE_RPAREN) && 
                 (nextOp->getOperType() != EXPR_OPER_TYPE_LPAREN && nextOp->getOperType() != EXPR_OPER_TYPE_RPAREN)) {

          if (currentOp->getOperType() == EXPR_OPER_TYPE_LPAREN) {
            if (nextOp->getOperType() != EXPR_OPER_TYPE_PLUS && 
                nextOp->getOperType() != EXPR_OPER_TYPE_MINUS) {

              m_malformedExpr = TRUE; return;
            }
          }
        }
        else if ((currentOp->getOperType() != EXPR_OPER_TYPE_LPAREN && currentOp->getOperType() != EXPR_OPER_TYPE_RPAREN) && 
                 (nextOp->getOperType() == EXPR_OPER_TYPE_LPAREN || nextOp->getOperType() == EXPR_OPER_TYPE_RPAREN)) {

          if (nextOp->getOperType() == EXPR_OPER_TYPE_RPAREN) {
            m_malformedExpr = TRUE; return;
          }
        }
        else if (currentOp->getOperType() != nextOp->getOperType()) { m_malformedExpr = TRUE; return; }
      }
    }
    ++m_currentExpr;
    ++nextExpr;
  }

  m_currentExpr = m_exprVec->begin();
}



void CsimCmdLineExprTree::checkExprTree(RefCsimCmdLineExpr root) {
  //  ASSERT(root.get(), "EXPR TREE - this should not be");

  //the checks

  //  DCERR("the checks.");

  if (m_malformedExpr) { return; }

  if (!root.get()) { m_malformedExpr = TRUE; return; }

  if (root->isNum() || root->isId()) {
    if (root->getChildren()->size()) { m_malformedExpr = TRUE; }
  }
  else {
    RefCsimCmdLineExprOper rootOper = boost::static_pointer_cast<CsimCmdLineExprOper>(root);
    EExprOperArity arity = rootOper->getOperArity();
    ASSERT(arity < EXPR_OPER_ARITY_MAX && arity > EXPR_OPER_ARITY_UNDEF, "this shold not happen");
    if (arity == EXPR_OPER_ARITY_UNARY) { 
      if (root->getChildren()->size() != 1) { m_malformedExpr = TRUE; return; } 
      else { checkExprTree(root->getChildren()->at(0)); }
    }
    else if (arity == EXPR_OPER_ARITY_BINARY) { 
      if (root->getChildren()->size() != 2) { m_malformedExpr = TRUE; return; } 
      else { 
        checkExprTree(root->getChildren()->at(0)); 
        checkExprTree(root->getChildren()->at(1)); 
      }
    }
    else if (arity == EXPR_OPER_ARITY_TERNARY) { 
      if (root->getChildren()->size() != 3) { m_malformedExpr = TRUE; return; } 
      else {
        checkExprTree(root->getChildren()->at(0));
        checkExprTree(root->getChildren()->at(1)); 
        checkExprTree(root->getChildren()->at(2)); 
      }
    }
    else if (arity == EXPR_OPER_ARITY_UNARY_AND_BINARY) {
      if (root->getChildren()->size() != 1 && root->getChildren()->size() != 2) {
        m_malformedExpr = TRUE; return; 
      }
      else {
        checkExprTree(root->getChildren()->at(0));
        if (root->getChildren()->size() == 2) {
          checkExprTree(root->getChildren()->at(1)); 
        }
      }
    }
  }
  
  return;
}


TBool                              CsimCmdLineExprTree::isMalformed() { return m_malformedExpr; }




TBool                              CsimCmdLineExprTree::isNumber() {

  TBool retVal = FALSE;

  if (!m_malformedExpr) {
    ASSERT(m_root.get(), "root is empty");
    if (m_root->isNum()) { retVal = TRUE; }
  }

  return retVal;
}


TBool                              CsimCmdLineExprTree::isIdentifier() {

  TBool retVal = FALSE;

  if (!m_malformedExpr) {
    ASSERT(m_root.get(), "root is empty");
    if (m_root->isId()) { retVal = TRUE; }
  }

  return retVal;
}



TBool                              CsimCmdLineExprTree::isRelationalExpression() {
  
  TBool retVal = FALSE;

  if (!m_malformedExpr) {
    ASSERT(m_root.get(), "root is empty");
    RefCsimCmdLineExprOper root = boost::static_pointer_cast<CsimCmdLineExprOper>(m_root);
    EExprOperType type = root->getOperType();

    switch (type) {
      case EXPR_OPER_TYPE_COMPARE_EQT:
      case EXPR_OPER_TYPE_COMPARE_NEQT:
      case EXPR_OPER_TYPE_COMPARE_LT:
      case EXPR_OPER_TYPE_COMPARE_LTE:
      case EXPR_OPER_TYPE_COMPARE_GT:
      case EXPR_OPER_TYPE_COMPARE_GTE:
        retVal = TRUE;
      default: ;
    }
  }

  return retVal;
}



TBool                              CsimCmdLineExprTree::isArithmeticExpression() {

  TBool retVal = FALSE;

  if (!m_malformedExpr) {
    ASSERT(m_root.get(), "root is empty");
    RefCsimCmdLineExprOper root = boost::static_pointer_cast<CsimCmdLineExprOper>(m_root);
    EExprOperType type = root->getOperType();

    switch (type) {
      case EXPR_OPER_TYPE_PLUS:
      case EXPR_OPER_TYPE_MINUS:
      case EXPR_OPER_TYPE_MULTIPLY:
      case EXPR_OPER_TYPE_DIVIDE:
      case EXPR_OPER_TYPE_MODULUS:
        retVal = TRUE;
      default: ;
    }
  }

  return retVal;
}



TBool                              CsimCmdLineExprTree::isAssignment() {

  TBool retVal = FALSE;

  if (!m_malformedExpr) {
    ASSERT(m_root.get(), "root is empty");
    RefCsimCmdLineExprOper root = boost::static_pointer_cast<CsimCmdLineExprOper>(m_root);
    EExprOperType type = root->getOperType();

    if (type == EXPR_OPER_TYPE_ASSIGN) {
      retVal = TRUE;
    }
  }

  return retVal;
}

}

//END OF FILE 


