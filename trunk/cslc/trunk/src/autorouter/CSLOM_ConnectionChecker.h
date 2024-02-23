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

#ifndef INC_GUARD_CONN_CHECKER_H
#define INC_GUARD_CONN_CHECKER_H

#include <iostream>
#include <fstream>
#include "CSLOM_InstTree.h"
#include "CSLOM_InstTreeVisitor.h"
#include "../support/CommonSupport.h"


namespace NSCInstTreeVisitor {

class ConnectionChecker : public CInstTreeTraversal {
    
  public:
    
    ConnectionChecker() {}
    ~ConnectionChecker() {}

    void checkNotTopPorts(const NSCInstTree::RefCInstTreeNode                              & node);
    void checkTopPorts   (const NSCInstTree::RefCInstTreeNode                              & node);
    void checkSignals    (const NSCInstTree::RefCInstTreeNode                              & node);

    void beforeTraversal(const NSCInstTree::RefCInstTreeNode                              & node                  );
    void inTraversal    (const NSCInstTree::RefCInstTreeNode                              & node                  );
    void afterTraversal (const NSCInstTree::RefCInstTreeNode                              & node                  );
};

}

#endif