#ifndef CNT_USER_H
#define CNT_USER_H

#include "../generated/cnt.h"

namespace NSCsimGen{

class cnt_user : public cnt {
  public:
    RefCsimFlipFlopTChar ff_out;
    TInt val;

    void allocate();
    void initialize();
    void execute();
    void init();
};

}
#endif
