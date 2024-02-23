#include "usb_phy.h"

namespace NSCsimGen {

void usb_phy::defaultInitialize() {
    //port allocations
  phy_rx_valid = CsimPortTBool::build(RefString(new std::string("phy_rx_valid")),1, getThis(), PORT_DIR_OUTPUT);
  phy_rx_cmd = CsimPortTBool::build(RefString(new std::string("phy_rx_cmd")),1, getThis(), PORT_DIR_OUTPUT);
  phy_rx_data = CsimPortTChar::build(RefString(new std::string("phy_rx_data")),8, getThis(), PORT_DIR_OUTPUT);
  phy_rx_ready = CsimPortTBool::build(RefString(new std::string("phy_rx_ready")),1, getThis(), PORT_DIR_INPUT);
  phy_tx_valid = CsimPortTBool::build(RefString(new std::string("phy_tx_valid")),1, getThis(), PORT_DIR_INPUT);
  phy_tx_cmd = CsimPortTBool::build(RefString(new std::string("phy_tx_cmd")),1, getThis(), PORT_DIR_INPUT);
  phy_tx_data = CsimPortTChar::build(RefString(new std::string("phy_tx_data")),8, getThis(), PORT_DIR_INPUT);
  phy_tx_ready = CsimPortTBool::build(RefString(new std::string("phy_tx_ready")),1, getThis(), PORT_DIR_OUTPUT);
  usb_rpu1_en = CsimPortTBool::build(RefString(new std::string("usb_rpu1_en")),1, getThis(), PORT_DIR_INPUT);
  usb_rpu2_en = CsimPortTBool::build(RefString(new std::string("usb_rpu2_en")),1, getThis(), PORT_DIR_INPUT);
  usb_data_in = CsimPortTBool::build(RefString(new std::string("usb_data_in")),1, getThis(), PORT_DIR_INPUT);
  usb_force_se0 = CsimPortTBool::build(RefString(new std::string("usb_force_se0")),1, getThis(), PORT_DIR_INPUT);
  usb_drv_enable = CsimPortTBool::build(RefString(new std::string("usb_drv_enable")),1, getThis(), PORT_DIR_INPUT);
  usb_suspend = CsimPortTBool::build(RefString(new std::string("usb_suspend")),1, getThis(), PORT_DIR_INPUT);
  usb_se_dp = CsimPortTBool::build(RefString(new std::string("usb_se_dp")),1, getThis(), PORT_DIR_OUTPUT);
  usb_enable_se = CsimPortTBool::build(RefString(new std::string("usb_enable_se")),1, getThis(), PORT_DIR_OUTPUT);
  usb_se_dn = CsimPortTBool::build(RefString(new std::string("usb_se_dn")),1, getThis(), PORT_DIR_OUTPUT);
  usb_data_out = CsimPortTBool::build(RefString(new std::string("usb_data_out")),1, getThis(), PORT_DIR_OUTPUT);
  usb_strobe = CsimPortTBool::build(RefString(new std::string("usb_strobe")),1, getThis(), PORT_DIR_OUTPUT);
  usb_enable_diff = CsimPortTBool::build(RefString(new std::string("usb_enable_diff")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
  addConnectable(phy_rx_valid);
  addConnectable(phy_rx_cmd);
  addConnectable(phy_rx_data);
  addConnectable(phy_rx_ready);
  addConnectable(phy_tx_valid);
  addConnectable(phy_tx_cmd);
  addConnectable(phy_tx_data);
  addConnectable(phy_tx_ready);
  addConnectable(usb_rpu1_en);
  addConnectable(usb_rpu2_en);
  addConnectable(usb_data_in);
  addConnectable(usb_force_se0);
  addConnectable(usb_drv_enable);
  addConnectable(usb_suspend);
  addConnectable(usb_se_dp);
  addConnectable(usb_enable_se);
  addConnectable(usb_se_dn);
  addConnectable(usb_data_out);
  addConnectable(usb_strobe);
  addConnectable(usb_enable_diff);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void usb_phy::connect() {
}
}
