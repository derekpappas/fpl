#ifndef B_USER_H
#define B_USER_H

#include "a_user.h"
#include "../b.h"


using namespace NSCsimGen;

class b_user : public b {
  public:
    TInt i;

    void allocate();
    void initialize();
    void execute();
};

#endif
