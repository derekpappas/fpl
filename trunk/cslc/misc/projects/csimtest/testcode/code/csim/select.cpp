#include "select.h"

namespace NSCsimGen {

void select::defaultInitialize() {
  //port allocations
  out0 = CsimPortTBool::build(RefString(new std::string("out0")),1, getThis(), PORT_DIR_OUTPUT);
  out1 = CsimPortTBool::build(RefString(new std::string("out1")),1, getThis(), PORT_DIR_OUTPUT);
  out2 = CsimPortTBool::build(RefString(new std::string("out2")),1, getThis(), PORT_DIR_OUTPUT);
  out3 = CsimPortTBool::build(RefString(new std::string("out3")),1, getThis(), PORT_DIR_OUTPUT);
  in = CsimPortTChar::build(RefString(new std::string("in")),2, getThis(), PORT_DIR_INPUT);
  reset_ = CsimPortTBool::build(RefString(new std::string("reset_")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
  addConnectable(out0);
  addConnectable(out1);
  addConnectable(out2);
  addConnectable(out3);
  addConnectable(in);
  addConnectable(reset_);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void select::connect() {
}
}
