#ifndef SELECT_H
#define SELECT_H

#include "/home/oanab/cslc/trunk/src/csim/CsimSignal.h"
#include "/home/oanab/cslc/trunk/src/csim/CsimPort.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class select : public CsimUnit {
public:
  RefCsimPortTBool out0;
  RefCsimPortTBool out1;
  RefCsimPortTBool out2;
  RefCsimPortTBool out3;
  RefCsimPortTChar in;
  RefCsimPortTBool reset_;
  RefCsimClock clk;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  select() : CsimUnit(RefString(new std::string("select"))) {}
};
}

#endif
