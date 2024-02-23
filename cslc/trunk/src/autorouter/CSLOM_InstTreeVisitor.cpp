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

#include "CSLOM_InstTreeVisitor.h"

using namespace std;

namespace NSCInstTreeVisitor {

CInstTreeVisitor::CInstTreeVisitor() {}

CInstTreeTraversal::CInstTreeTraversal(RefString fileName) :
  m_fileName(fileName) { 

  if (fileName.get()) {
    m_out = new std::ofstream(fileName->c_str());
  }
  else {
    m_out = &cout;
  }
  initMaskValue();
}

CInstTreeTraversal::~CInstTreeTraversal() { 
  if (m_fileName.get()) {
    delete m_out;
  }
}

void CInstTreeTraversal::initMaskValue() {
  m_mask = 0 - 1;
}

TBool CInstTreeTraversal::testMask(ETraversalType Ttype) {
  return (m_mask >> Ttype) & 1;
}

void CInstTreeTraversal::enableNodeTraversal() {
  m_mask |= 1 << NODE_TRAVERSAL;
}
void CInstTreeTraversal::enableNodeBeforeTraversal() {
  m_mask |= 1 << NODE_TRAVERSAL_BEFORE;
}
void CInstTreeTraversal::enableNodeInTraversal() {
  m_mask |= 1 << NODE_TRAVERSAL_IN;
}
void CInstTreeTraversal::enableNodeAfterTraversal() {
  m_mask |= 1 << NODE_TRAVERSAL_AFTER;
}

void CInstTreeTraversal::disableNodeTraversal() {
  m_mask &= ~(1 << NODE_TRAVERSAL);
}
void CInstTreeTraversal::disableNodeBeforeTraversal() {
  m_mask &= ~(1 << NODE_TRAVERSAL_BEFORE);
}
void CInstTreeTraversal::disableNodeInTraversal() {
  m_mask &= ~(1 << NODE_TRAVERSAL_IN);
}
void CInstTreeTraversal::disableNodeAfterTraversal() {
  m_mask &= ~(1 << NODE_TRAVERSAL_AFTER);
}

TBool CInstTreeTraversal::isNodeTraversalEnabled() {
  return (m_mask >> NODE_TRAVERSAL) & 1;
}
TBool CInstTreeTraversal::isNodeBeforeTraversalEnabled() {
  return (m_mask >> NODE_TRAVERSAL_BEFORE) & 1;
}
TBool CInstTreeTraversal::isNodeInTraversalEnabled() {
  return (m_mask >> NODE_TRAVERSAL_IN) & 1;
}
TBool CInstTreeTraversal::isNodeAfterTraversalEnabled() {
  return (m_mask >> NODE_TRAVERSAL_AFTER) & 1;
}

void CInstTreeTraversal::visit(const NSCInstTree::RefCInstTreeNode & node) {
  TBool isNodeVisitEnabled        = isNodeTraversalEnabled();
  TBool isBeforeTraversalEnabled  = isNodeBeforeTraversalEnabled();
  TBool isInTraversalEnabled      = isNodeInTraversalEnabled();
  TBool isAfterTraversalEnabled   = isNodeAfterTraversalEnabled();

  if( isNodeVisitEnabled ) {
    if(isBeforeTraversalEnabled) {
      beforeTraversal(node);
    }
    NSCInstTree::RefTMap_RefString_RefCInstTreeNode childrenVec = node->getChildren();
    if(childrenVec.get()) {
      for(NSCInstTree::TMap_RefString_RefCInstTreeNode::iterator iter = childrenVec->begin(); iter != childrenVec->end(); ++iter) {
        iter->second->acceptVisitor(*this);
        if(isInTraversalEnabled) {
          inTraversal(node);
        }
      }
    }


    if(isAfterTraversalEnabled)
      afterTraversal(node);
  }

}

void CInstTreeTraversal::beforeTraversal(const NSCInstTree::RefCInstTreeNode                                        & node                   ) {
  for (int i = 0; i < node->getLevel(); i++) {
    (*m_out)<<"|";  
  }
  (*m_out)<< *((node->getUnitDecl())->getID()->getName()) <<" "<<*(node->getName())<< std::endl;
}

void CInstTreeTraversal::inTraversal(const NSCInstTree::RefCInstTreeNode                                            & node                   ) {
}

void CInstTreeTraversal::afterTraversal(const NSCInstTree::RefCInstTreeNode                                        & node                    ) {
}

}
