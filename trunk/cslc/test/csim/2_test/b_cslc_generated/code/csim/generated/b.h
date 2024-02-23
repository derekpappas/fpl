#ifndef B_H
#define B_H

#include "CsimSignal.h"
#include "CsimPort.h"
#include "a.h"
#include "stim.h"
#include "exp.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class b : public CsimUnit {
public:
  RefCsimPortTBool in_b1;
  RefCsimPortTBool in_b2;
  RefCsimPortTBool out_b1;
  RefCsimPortTBool out_b2;
  RefCsimClock clk;
  RefCsimSignalTBool s1;
  RefCsimSignalTBool s2;
  RefCsimSignalTBool s3;
  RefCsimUnit a0;
  RefCsimVectorWriter stim0;
  RefCsimVectorWriter exp0;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  b() : CsimUnit(RefString(new std::string("b"))) {}
};
}

#endif
