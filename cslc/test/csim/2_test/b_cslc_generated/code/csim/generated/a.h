#ifndef A_H
#define A_H

#include "CsimSignal.h"
#include "CsimPort.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class a : public CsimUnit {
public:
  RefCsimPortTBool in_a;
  RefCsimPortTBool out_a;
  RefCsimClock clk;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  a() : CsimUnit(RefString(new std::string("a"))) {}
};
}

#endif
