#include "b.h"

namespace NSCsimGen {

void b::defaultInitialize() {
  setInstanceName(RefString(new std::string("b")));
  //port allocations
  in_b1 = CsimPortTBool::build(RefString(new std::string("in_b1")),1, getThis(), PORT_DIR_INPUT);
  in_b2 = CsimPortTBool::build(RefString(new std::string("in_b2")),1, getThis(), PORT_DIR_INPUT);
  out_b1 = CsimPortTBool::build(RefString(new std::string("out_b1")),1, getThis(), PORT_DIR_OUTPUT);
  out_b2 = CsimPortTBool::build(RefString(new std::string("out_b2")),1, getThis(), PORT_DIR_OUTPUT);
  //port registrations
  addConnectable(in_b1);
  addConnectable(in_b2);
  addConnectable(out_b1);
  addConnectable(out_b2);
  //signal allocations
  clk = CsimClock::build(2, (RefString(new std::string("clk"))), getThis());
  s1 = CsimSignalTBool::build(RefString(new std::string("s1")),1, getThis());
  s2 = CsimSignalTBool::build(RefString(new std::string("s2")),1, getThis());
  s3 = CsimSignalTBool::build(RefString(new std::string("s3")),1, getThis());
  //signal registrations
  addConnectable(s1);
  addConnectable(s2);
  addConnectable(s3);
  //building vector writers
  stim0 = buildVW(new stim(), getThis());
  exp0 = buildVW(new exp(), getThis());
  //initializers
  allocate();
  //instance registration
  a0->setParent(getThis());
  a0->setInstanceName(RefString(new std::string("a0")));
  //clock connections
    clk->connectToClock(a0, (boost::static_pointer_cast<a>(a0))->clk, RefString(new std::string("clk")));
          //default initis
  a0->defaultInitialize();
  connect();
  initialize();
}

void b::connect() {
        in_b1->connect(boost::static_pointer_cast<CsimPortTBool>(a0->getSignalByName(RefString(new std::string("in_a")))));
    out_b1->connect(boost::static_pointer_cast<CsimPortTBool>(a0->getSignalByName(RefString(new std::string("out_a")))));
}
}
