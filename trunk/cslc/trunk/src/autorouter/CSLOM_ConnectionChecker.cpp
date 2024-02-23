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

/**
 * Author: Zamfir Bogdan <bogdanz@fplsrl.com>
 */

#include "CSLOM_ConnectionChecker.h"

TBool ccHasErrors = FALSE;

namespace NSCInstTreeVisitor {

  using namespace NSCSLOm;
  using namespace std;

  void ConnectionChecker::checkNotTopPorts(const NSCInstTree::RefCInstTreeNode                              & node) {
    RefTVec_RefCSLOmPortDecl ports = node->getUnitDecl()->getPortListFull();
    RefTMap_RefCSLOmExprLink_RefCSLOmExpr connectionMap = node->getUnitInst()->getConnectionMap();
    TVec_RefCSLOmPortDecl::iterator port = ports->begin();
    for (; port < ports->end(); port++) {
      TUInt found = 0;
      if (connectionMap->find((*port)->getF2ALink()) != connectionMap->end()) {
        found++;
      }
      if ((*port)->getParent()->getParent()->isInterface()) {
        RefCSLOmBase parent = (*port)->getParent();
        while(parent->getParent()->isInterface()) {
          RefCSLOmExprLink f2aLink = CSLOmConnectable::cast(parent)->getF2ALink();
          if (connectionMap->find(f2aLink) != connectionMap->end()) {
            found++;
          }
          parent = parent->getParent();
        }
      }
      TUInt foundInUnit = 0;
      RefTVec_RefCSLOmBase stmts = node->getUnitDecl()->getAssignListFull();
      TVec_RefCSLOmBase::iterator stmt = stmts->begin();
      for (; stmt < stmts->end(); stmt++) {
        RefTVec_RefCSLOmExpr exprs = CSLOmStmtAssign::cast(*stmt)->getLHS()->getExprs();
        for (TVec_RefCSLOmExpr::iterator expr = exprs->begin(); expr < exprs->end(); expr++) { // FIX - Factor create function
          if ((*expr)->isExprLink() && (*expr)->doEval().get() == (*port).get()) {
            foundInUnit++;
          }
          else if ((*expr)->isExprLink() && (*expr)->doEval()->isInterface()) {
            if ((*port)->getParent()->getParent()->isInterface()) {
              RefCSLOmBase parent = (*port)->getParent();
              while(parent->getParent()->isInterface() && !found) {
                if ((*expr)->doEval().get() == parent.get()) {
                  foundInUnit++;
                }
                parent = parent->getParent();
              }
            }
          }
        }
        exprs = CSLOmStmtAssign::cast(*stmt)->getRHS()->getExprs();
        for (TVec_RefCSLOmExpr::iterator expr = exprs->begin(); expr < exprs->end(); expr++) { // FIX - Factor create function
          if ((*expr)->isExprLink() && (*expr)->doEval().get() == (*port).get()) {
            foundInUnit++;
          }
          else if ((*expr)->isExprLink() && (*expr)->doEval()->isInterface()) {
            if ((*port)->getParent()->getParent()->isInterface()) {
              RefCSLOmBase parent = (*port)->getParent();
              while(parent->getParent()->isInterface() && !found) {
                if ((*expr)->doEval().get() == parent.get()) {
                  foundInUnit++;
                }
                parent = parent->getParent();
              }
            }
          }
        }
      }
      if (!found && !foundInUnit) { // FIX - create error function
        args.push_back(*convertLink((*port)->getF2ALink()));
        args.push_back(*CSLOmIdentifier::cast(node->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSA_PORT_DANDLING_WIRE_FOUND, args, node->getUnitInst()->getLineNumber(), node->getUnitInst()->getFileName());
        ccHasErrors = TRUE;
      }
      else if (!(*port)->isArGenerated() && found > 1) { // FIX - create error function
        args.push_back(*convertLink((*port)->getF2ALink()));
        args.push_back(*CSLOmIdentifier::cast(node->getUnitInst()->getChild(ID))->getName());
        addErr(NSWarningErr::DEE_CSA_PORT_MULTIPLE_CONNECTION_FOUND, args, node->getUnitInst()->getLineNumber(), node->getUnitInst()->getFileName());
        ccHasErrors = TRUE;
      }
      //     else if (!(*port)->isArGenerated() && foundInUnit > 1) {
      //       args.push_back(*convertLink((*port)->getF2ALink()));
      //       args.push_back(*CSLOmIdentifier::cast(node->getUnitDecl()->getChild(ID))->getName());
      //       addErr(NSWarningErr::DEE_CSA_PORT_MULTIPLE_CONNECTION_FOUND, args, node->getUnitInst()->getLineNumber(), node->getUnitInst()->getFileName());
      //       ccHasErrors = TRUE;
      //     }
    }
  }

  void ConnectionChecker::checkTopPorts   (const NSCInstTree::RefCInstTreeNode                              & node) {
    RefTVec_RefCSLOmUnitInstance insts = node->getUnitDecl()->getUnitInstances();
    RefTVec_RefCSLOmPortDecl ports = node->getUnitDecl()->getPortListFull();
    if(ports.get()) {
      TVec_RefCSLOmPortDecl::iterator port = ports->begin();
      for (; port < ports->end(); port++) {
        TUInt found = 0;
        TVec_RefCSLOmUnitInstance::iterator inst = insts->begin();
        for (; inst < insts->end(); inst++) {
          RefTMap_RefCSLOmExprLink_RefCSLOmExpr connectionMap = (*inst)->getConnectionMap();
          TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator connection = connectionMap->begin();
          for (; connection != connectionMap->end(); connection++) {
            if (connection->second->isExprLink()) {  
              if (connection->second->doEval().get() == (*port).get()) {
                found++;
              }
              else if (connection->second->doEval()->isInterface()) {
                if ((*port)->getParent()->getParent()->isInterface()) {
                  RefCSLOmBase parent = (*port)->getParent();
                  while(!parent->getParent()->isUnitDecl() && !found) {
                    if (connection->second->doEval().get() == parent.get()) {
                      found++;
                    }
                    parent = parent->getParent();
                  }
                }
              }
            }
            else {
              RefTVec_RefCSLOmExpr exprs = connection->second->getExprs();
              TVec_RefCSLOmExpr::iterator expr = exprs->begin();
              for (; expr < exprs->end(); expr++) {
                if ((*expr)->doEval().get() == (*port).get()) {
                  found++;
                }
              }
            }
          }
        }
        RefTVec_RefCSLOmBase stmts = node->getUnitDecl()->getAssignListFull();
        TVec_RefCSLOmBase::iterator stmt = stmts->begin();
        for (; stmt < stmts->end(); stmt++) {
          RefTVec_RefCSLOmExpr exprs = CSLOmStmtAssign::cast(*stmt)->getLHS()->getExprs();
          for (TVec_RefCSLOmExpr::iterator expr = exprs->begin(); expr < exprs->end(); expr++) {
            if ((*expr)->isExprLink() && (*expr)->doEval().get() == (*port).get()) {
              found++;
            }
            else if ((*expr)->doEval()->isInterface()) {
              if ((*port)->getParent()->getParent()->isInterface()) { // FIX - factor and create function
                RefCSLOmBase parent = (*port)->getParent();
                while(!parent->getParent()->isUnitDecl() && !found) {
                  if ((*expr)->doEval().get() == parent.get()) {
                    found++;
                  }
                  parent = parent->getParent();
                }
              }
            }
          }
          exprs = CSLOmStmtAssign::cast(*stmt)->getRHS()->getExprs();
          for (TVec_RefCSLOmExpr::iterator expr = exprs->begin(); expr < exprs->end(); expr++) {
            if ((*expr)->isExprLink() && (*expr)->doEval().get() == (*port).get()) {
              found++;
            }
            else if ((*expr)->doEval()->isInterface()) {
              if ((*port)->getParent()->getParent()->isInterface()) { // FIX - factor and create function
                RefCSLOmBase parent = (*port)->getParent();
                while(!parent->getParent()->isUnitDecl() && !found) {
                  if ((*expr)->doEval().get() == parent.get()) {
                    found++;
                  }
                  parent = parent->getParent();
                }
              }
            }
          }
        }
  
        if (!found) {
          args.push_back(*convertLink((*port)->getF2ALink()));
          args.push_back(*CSLOmIdentifier::cast(node->getUnitDecl()->getChild(ID))->getName());
          addErr(NSWarningErr::DEE_CSA_PORT_DANDLING_WIRE_FOUND, args, node->getUnitDecl()->getLineNumber(), node->getUnitDecl()->getFileName());
          ccHasErrors = TRUE;
        }
      }
    }
  }

  void ConnectionChecker::checkSignals    (const NSCInstTree::RefCInstTreeNode                              & node) {
    RefTVec_RefCSLOmUnitInstance insts = node->getUnitDecl()->getUnitInstances();
    RefTVec_RefCSLOmSignal signals = node->getUnitDecl()->getAllSignals();
    if(signals.get()) {
      TVec_RefCSLOmSignal::iterator signal = signals->begin();
      for (; signal < signals->end(); signal++) {
        TUInt found = 0;
        TVec_RefCSLOmUnitInstance::iterator inst = insts->begin();
        for (; inst < insts->end(); inst++) {
          RefTMap_RefCSLOmExprLink_RefCSLOmExpr connectionMap = (*inst)->getConnectionMap();
          TMap_RefCSLOmExprLink_RefCSLOmExpr::iterator connection = connectionMap->begin();
          for (; connection != connectionMap->end(); connection++) {
            if (connection->second->isExprLink()) {  
              if (connection->second->doEval().get() == (*signal).get()) {
                found++;
              }
              else if (connection->second->doEval()->isSignalGroup()) { // FIX - Factor create function XXX
                if ((*signal)->getParent()->isSignalGroup()) {
                  RefCSLOmBase parent = (*signal)->getParent();
                  while(!parent->isUnitDecl() && !found) {
                    if (connection->second->doEval().get() == parent.get()) {
                      found++;
                    }
                    parent = parent->getParent();
                  }
                }
              }
            }
            else {
              RefTVec_RefCSLOmExpr exprs = connection->second->getExprs();
              TVec_RefCSLOmExpr::iterator expr = exprs->begin();
              for (; expr < exprs->end(); expr++) {
                if ((*expr)->doEval().get() == (*signal).get()) {
                  found++;
                }
              }
            }
          }
        }
        RefTVec_RefCSLOmBase stmts = node->getUnitDecl()->getAssignListFull();
        TVec_RefCSLOmBase::iterator stmt = stmts->begin();
        for (; stmt < stmts->end(); stmt++) {
          RefTVec_RefCSLOmExpr exprs = CSLOmStmtAssign::cast(*stmt)->getLHS()->getExprs();
          for (TVec_RefCSLOmExpr::iterator expr = exprs->begin(); expr < exprs->end(); expr++) {
            if ((*expr)->isExprLink() && (*expr)->doEval().get() == (*signal).get()) {
              found++;
            }
            else if ((*expr)->doEval()->isSignalGroup()) { // FIX - Factor create function XXX
              if ((*signal)->getParent()->isSignalGroup()) {
                RefCSLOmBase parent = (*signal)->getParent();
                while(!parent->isUnitDecl() && !found) {
                  if ((*expr)->doEval().get() == parent.get()) {
                    found++;
                  }
                  parent = parent->getParent();
                }
              }
            }
          }
          exprs = CSLOmStmtAssign::cast(*stmt)->getRHS()->getExprs();
          for (TVec_RefCSLOmExpr::iterator expr = exprs->begin(); expr < exprs->end(); expr++) {
            if ((*expr)->isExprLink() && (*expr)->doEval().get() == (*signal).get()) {
              found++;
            }
            else if ((*expr)->doEval()->isSignalGroup()) { // FIX - Factor create function XXX
              if ((*signal)->getParent()->isSignalGroup()) {
                RefCSLOmBase parent = (*signal)->getParent();
                while(!parent->isUnitDecl() && !found) {
                  if ((*expr)->doEval().get() == parent.get()) {
                    found++;
                  }
                  parent = parent->getParent();
                }
              }
            }
          }
        }
  
        if (!found) {
          args.push_back(*convertLink((*signal)->getF2ALink()));
          args.push_back(*CSLOmIdentifier::cast(node->getUnitDecl()->getChild(ID))->getName());
          addErr(NSWarningErr::DEE_CSA_PORT_DANDLING_WIRE_FOUND, args, node->getUnitDecl()->getLineNumber(), node->getUnitDecl()->getFileName());
          ccHasErrors = TRUE;
        }
      }
    }
  }


  void ConnectionChecker::beforeTraversal(const NSCInstTree::RefCInstTreeNode & node ) {
    if (node->getUnitInst().get()) {
      checkNotTopPorts(node);
    }
    else {
      checkTopPorts(node);
    }
    checkSignals(node);
  }

  void ConnectionChecker::inTraversal(const NSCInstTree::RefCInstTreeNode & node) {
  }

  void ConnectionChecker::afterTraversal(const NSCInstTree::RefCInstTreeNode & node ) {
  }

}
