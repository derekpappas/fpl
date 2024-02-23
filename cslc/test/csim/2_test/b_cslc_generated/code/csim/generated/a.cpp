#include "a.h"

namespace NSCsimGen {

void a::defaultInitialize() {
    //port allocations
  in_a = CsimPortTBool::build(RefString(new std::string("in_a")),1, getThis(), PORT_DIR_INPUT);
  out_a = CsimPortTBool::build(RefString(new std::string("out_a")),1, getThis(), PORT_DIR_OUTPUT);
  //port registrations
  addConnectable(in_a);
  addConnectable(out_a);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void a::connect() {
}
}
