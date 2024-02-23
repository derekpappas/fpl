#ifndef CNT_USER_H
#define CNT_USER_H

#include "../cnt.h"
#include "/storage/users/andreib/svn/trunk/src/csim/CsimFlipFlop.h"

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
