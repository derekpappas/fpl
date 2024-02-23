#ifndef TOP_USER_H
#define TOP_USER_H

#include "../generated/top.h"
#include "ff_user.h"

namespace NSCsimGen {

class top_user : public top {
public:
    int i;

  void allocate();
  void initialize();
  void execute();
};
}

#endif
