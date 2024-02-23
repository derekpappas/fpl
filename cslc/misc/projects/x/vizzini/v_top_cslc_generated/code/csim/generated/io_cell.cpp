#include "io_cell.h"

namespace NSCsimGen {

void io_cell::defaultInitialize() {
    //port allocations
  pad_in = CsimPortTBool::build(RefString(new std::string("pad_in")),1, getThis(), PORT_DIR_OUTPUT);
  pad_out = CsimPortTBool::build(RefString(new std::string("pad_out")),1, getThis(), PORT_DIR_INPUT);
  pad_en = CsimPortTBool::build(RefString(new std::string("pad_en")),1, getThis(), PORT_DIR_INPUT);
  pad_pin = CsimPortTBool::build(RefString(new std::string("pad_pin")),1, getThis(), PORT_DIR_INOUT);
  //port registrations
  addConnectable(pad_in);
  addConnectable(pad_out);
  addConnectable(pad_en);
  addConnectable(pad_pin);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void io_cell::connect() {
}
}
