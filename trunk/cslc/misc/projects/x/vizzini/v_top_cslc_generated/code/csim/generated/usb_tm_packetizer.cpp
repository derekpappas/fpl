#include "usb_tm_packetizer.h"

namespace NSCsimGen {

void usb_tm_packetizer::defaultInitialize() {
    //port allocations
  phy_rx_valid = CsimPortTBool::build(RefString(new std::string("phy_rx_valid")),1, getThis(), PORT_DIR_INPUT);
  phy_rx_cmd = CsimPortTBool::build(RefString(new std::string("phy_rx_cmd")),1, getThis(), PORT_DIR_INPUT);
  phy_rx_data = CsimPortTChar::build(RefString(new std::string("phy_rx_data")),8, getThis(), PORT_DIR_INPUT);
  phy_rx_ready = CsimPortTBool::build(RefString(new std::string("phy_rx_ready")),1, getThis(), PORT_DIR_OUTPUT);
  //port registrations
  addConnectable(phy_rx_valid);
  addConnectable(phy_rx_cmd);
  addConnectable(phy_rx_data);
  addConnectable(phy_rx_ready);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void usb_tm_packetizer::connect() {
}
}
