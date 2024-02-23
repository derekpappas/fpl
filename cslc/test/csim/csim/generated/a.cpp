#include "a.h"

namespace NSCsimGen {

void a::defaultInitialize() {
  setInstanceName(RefString(new std::string("a")));
  //port allocations
  in = CsimPortTBool::build(RefString(new std::string("in")),1, getThis(), PORT_DIR_INPUT);
  out = CsimPortTBool::build(RefString(new std::string("out")),1, getThis(), PORT_DIR_OUTPUT);
  //port registrations
  addConnectable(in);
  addConnectable(out);
  //signal allocations
  clk = CsimClock::build(2, (RefString(new std::string("clk"))), getThis());
  s_in = CsimSignalTBool::build(RefString(new std::string("s_in")),1, getThis());
  s_out = CsimSignalTBool::build(RefString(new std::string("s_out")),1, getThis());
  s_clk = CsimSignalTBool::build(RefString(new std::string("s_clk")),1, getThis());
  //signal registrations
  addConnectable(s_in);
  addConnectable(s_out);
  addConnectable(s_clk);
  //building vector writers
  stim0 = buildVW(new stim(), getThis());
  exp0 = buildVW(new exp(), getThis());
  stim0->setClock(clk); // added
  exp0->setClock(clk);  // added
  //initializers
  allocate();
  connect();
  initialize();
}

void a::connect() {
}
}
