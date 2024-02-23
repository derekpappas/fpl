#ifndef FF_USER_H
#define FF_USER_H

#include "../generated/ff.h"

namespace NSCsimGen {

class ff_user : public ff {
public:
  RefCsimFlipFlopTChar ff_temp;
    
  void allocate();
  void initialize();
  void execute();
};
}

#endif
