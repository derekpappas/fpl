#ifndef A_USER_H
#define A_USER_H

#include "../a.h"


using namespace NSCsimGen;

class a_user : public a {
  public:
    TInt i;
    void allocate();
    void initialize();
    void execute();
};

#endif
