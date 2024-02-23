#ifndef A_H
#define A_H

#include "CsimSignal.h"
#include "CsimPort.h"
#include "stim.h"
#include "exp.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class a : public CsimUnit {
public:
  RefCsimPortTBool in;
  RefCsimPortTBool out;
  RefCsimClock clk;
  RefCsimSignalTBool s_in;
  RefCsimSignalTBool s_out;
  RefCsimSignalTBool s_clk;
  RefCsimVectorWriter stim0;
  RefCsimVectorWriter exp0;
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
