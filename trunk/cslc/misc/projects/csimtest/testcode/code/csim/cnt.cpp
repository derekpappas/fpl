#include "cnt.h"

namespace NSCsimGen {

void cnt::defaultInitialize() {
  //port allocations
  out = CsimPortTChar::build(RefString(new std::string("out")),2, getThis(), PORT_DIR_OUTPUT);
  reset_ = CsimPortTBool::build(RefString(new std::string("reset_")),1, getThis(), PORT_DIR_INPUT);
  en = CsimPortTBool::build(RefString(new std::string("en")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
  addConnectable(out);
  addConnectable(reset_);
  addConnectable(en);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void cnt::connect() {
}
}
