//----------------------------------------------------------------------
// Copyright (c) 2005, 2006, 2007, 2008 FastPath Logic
// All Rights Reserved.
// This is UNPUBLISHED PROPRIETARY SOURCE CODE of FastPath Logic;
// the contents of this file may not be disclosed to third parties,
// copied or duplicated in any form, in whole or in part, without the prior
// written permission of FastPath Logic.
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

#ifndef INC_GUARD_CSLOM_InstanceTree_Visitor_h
#define INC_GUARD_CSLOM_InstanceTree_Visitor_h

#include <iostream>
#include <fstream>
#include "CSLOM_InstTree.h"
#include "../support/CommonSupport.h"

namespace NSCInstTreeVisitor {

class CInstTreeVisitor {
  protected:
    CInstTreeVisitor();
  public:
    virtual ~CInstTreeVisitor() {}
    virtual void visit(const NSCInstTree::RefCInstTreeNode                              & node               ) = 0;
};

class CInstTreeTraversal : public CInstTreeVisitor {

  private:
    std::ostream *m_out;
    RefString m_fileName;
    TUInt m_mask;
    enum ETraversalType {
      NODE_TRAVERSAL,
      NODE_TRAVERSAL_BEFORE,
      NODE_TRAVERSAL_IN,
      NODE_TRAVERSAL_AFTER,
    };
    //initialize the mask with a default value
    void initMaskValue();

  public: 
    //enable traversal methods
    void enableNodeTraversal();
    void enableNodeBeforeTraversal();
    void enableNodeInTraversal();
    void enableNodeAfterTraversal();

    //disable traversal methods
    void disableNodeTraversal();
    void disableNodeBeforeTraversal();
    void disableNodeInTraversal();
    void disableNodeAfterTraversal();

    bool testMask(ETraversalType);

    //test if traversal is enabled
    TBool isNodeTraversalEnabled();
    TBool isNodeBeforeTraversalEnabled();
    TBool isNodeInTraversalEnabled();
    TBool isNodeAfterTraversalEnabled();

    CInstTreeTraversal(RefString fileName = RefString());
    ~CInstTreeTraversal();
    void visit(const NSCInstTree::RefCInstTreeNode                & node              );

    virtual void beforeTraversal(const NSCInstTree::RefCInstTreeNode                              & node                  );
    virtual void inTraversal    (const NSCInstTree::RefCInstTreeNode                              & node                  );
    virtual void afterTraversal (const NSCInstTree::RefCInstTreeNode                              & node                  );
};

}
#endif //INC_GUARD_CSLOM_InstanceTree_Visitor_h
