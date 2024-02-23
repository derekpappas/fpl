#include "usb_tm_dispatcher.h"

namespace NSCsimGen {

void usb_tm_dispatcher::defaultInitialize() {
    //port allocations
  phy_tx_valid = CsimPortTBool::build(RefString(new std::string("phy_tx_valid")),1, getThis(), PORT_DIR_OUTPUT);
  phy_tx_cmd = CsimPortTBool::build(RefString(new std::string("phy_tx_cmd")),1, getThis(), PORT_DIR_OUTPUT);
  phy_tx_data = CsimPortTChar::build(RefString(new std::string("phy_tx_data")),8, getThis(), PORT_DIR_OUTPUT);
  phy_tx_ready = CsimPortTBool::build(RefString(new std::string("phy_tx_ready")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
  addConnectable(phy_tx_valid);
  addConnectable(phy_tx_cmd);
  addConnectable(phy_tx_data);
  addConnectable(phy_tx_ready);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void usb_tm_dispatcher::connect() {
}
}
