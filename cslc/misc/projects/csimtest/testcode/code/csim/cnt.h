#ifndef CNT_H
#define CNT_H

#include "/home/oanab/cslc/trunk/src/csim/CsimSignal.h"
#include "/home/oanab/cslc/trunk/src/csim/CsimPort.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class cnt : public CsimUnit {
public:
  RefCsimPortTChar out;
  RefCsimPortTBool reset_;
  RefCsimClock clk;
  RefCsimPortTBool en;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  cnt() : CsimUnit(RefString(new std::string("cnt"))) {}
};
}

#endif
