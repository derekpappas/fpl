#ifndef TOP_H
#define TOP_H

#include "/home/oanab/cslc/trunk/src/csim/CsimSignal.h"
#include "/home/oanab/cslc/trunk/src/csim/CsimPort.h"
#include "cnt.h"
#include "select.h"
#include "vec_stim.h"
#include "vec_expect.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class top : public CsimUnit {
public:
  RefCsimPortTBool even;
  RefCsimPortTBool odd;
  RefCsimPortTBool valid;
  RefCsimPortTBool reset_;
  RefCsimPortTBool en;
  RefCsimClock clk;
  RefCsimSignalTBool out0;
  RefCsimSignalTBool out1;
  RefCsimSignalTBool out2;
  RefCsimSignalTBool out3;
  RefCsimSignalTBool weven;
  RefCsimSignalTBool wodd;
  RefCsimSignalTBool wvalid;
  RefCsimSignalTChar wcntcase;
  RefCsimUnit cnt0;
  RefCsimUnit select0;
  RefCsimVectorWriter vec_stim0;
  RefCsimVectorWriter vec_expect0;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  top() : CsimUnit(RefString(new std::string("top"))) {}
};
}

#endif
