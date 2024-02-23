#ifndef SELECT_USER_H
#define SELECT_USER_H

#include "../generated/select.h"
namespace NSCsimGen {

class select_user : public select {
  public:
    RefCsimFlipFlopTBool ff_out0;
    RefCsimFlipFlopTBool ff_out1;
    RefCsimFlipFlopTBool ff_out2;
    RefCsimFlipFlopTBool ff_out3;

    void allocate();
    void initialize();
    void execute();
    void init();
};

}

#endif
