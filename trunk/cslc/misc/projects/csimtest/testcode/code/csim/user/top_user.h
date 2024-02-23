#ifndef TOP_USER_H
#define TOP_USER_H

#include "../top.h"
#include "cnt_user.h"
#include "select_user.h"

using namespace NSCsimGen;

class top_user : public top {
  public:
    TInt i;
    void allocate();
    void initialize();
    void execute();
};

#endif
