#include "uart.h"

namespace NSCsimGen {

void uart::defaultInitialize() {
    //port allocations
  modem_rx = CsimPortTBool::build(RefString(new std::string("modem_rx")),1, getThis(), PORT_DIR_INPUT);
  modem_tx = CsimPortTBool::build(RefString(new std::string("modem_tx")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp0_in = CsimPortTBool::build(RefString(new std::string("modem_gp0_in")),1, getThis(), PORT_DIR_INPUT);
  modem_gp0_out = CsimPortTBool::build(RefString(new std::string("modem_gp0_out")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp0_en = CsimPortTBool::build(RefString(new std::string("modem_gp0_en")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp1_in = CsimPortTBool::build(RefString(new std::string("modem_gp1_in")),1, getThis(), PORT_DIR_INPUT);
  modem_gp1_out = CsimPortTBool::build(RefString(new std::string("modem_gp1_out")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp1_en = CsimPortTBool::build(RefString(new std::string("modem_gp1_en")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp2_in = CsimPortTBool::build(RefString(new std::string("modem_gp2_in")),1, getThis(), PORT_DIR_INPUT);
  modem_gp2_out = CsimPortTBool::build(RefString(new std::string("modem_gp2_out")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp2_en = CsimPortTBool::build(RefString(new std::string("modem_gp2_en")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp3_in = CsimPortTBool::build(RefString(new std::string("modem_gp3_in")),1, getThis(), PORT_DIR_INPUT);
  modem_gp3_out = CsimPortTBool::build(RefString(new std::string("modem_gp3_out")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp3_en = CsimPortTBool::build(RefString(new std::string("modem_gp3_en")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp4_in = CsimPortTBool::build(RefString(new std::string("modem_gp4_in")),1, getThis(), PORT_DIR_INPUT);
  modem_gp4_out = CsimPortTBool::build(RefString(new std::string("modem_gp4_out")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp4_en = CsimPortTBool::build(RefString(new std::string("modem_gp4_en")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp5_in = CsimPortTBool::build(RefString(new std::string("modem_gp5_in")),1, getThis(), PORT_DIR_INPUT);
  modem_gp5_out = CsimPortTBool::build(RefString(new std::string("modem_gp5_out")),1, getThis(), PORT_DIR_OUTPUT);
  modem_gp5_en = CsimPortTBool::build(RefString(new std::string("modem_gp5_en")),1, getThis(), PORT_DIR_OUTPUT);
  fabric_drop_valid = CsimPortTBool::build(RefString(new std::string("fabric_drop_valid")),1, getThis(), PORT_DIR_INPUT);
  fabric_drop_type = CsimPortTChar::build(RefString(new std::string("fabric_drop_type")),2, getThis(), PORT_DIR_INPUT);
  fabric_drop_src_nid = CsimPortTChar::build(RefString(new std::string("fabric_drop_src_nid")),4, getThis(), PORT_DIR_INPUT);
  fabric_drop_addr = CsimPortTShort::build(RefString(new std::string("fabric_drop_addr")),12, getThis(), PORT_DIR_INPUT);
  fabric_drop_data = CsimPortTShort::build(RefString(new std::string("fabric_drop_data")),12, getThis(), PORT_DIR_INPUT);
  fabric_add_valid = CsimPortTBool::build(RefString(new std::string("fabric_add_valid")),1, getThis(), PORT_DIR_OUTPUT);
  fabric_add_type = CsimPortTChar::build(RefString(new std::string("fabric_add_type")),2, getThis(), PORT_DIR_OUTPUT);
  fabric_add_dst_nid = CsimPortTChar::build(RefString(new std::string("fabric_add_dst_nid")),4, getThis(), PORT_DIR_OUTPUT);
  fabric_add_addr = CsimPortTShort::build(RefString(new std::string("fabric_add_addr")),12, getThis(), PORT_DIR_OUTPUT);
  fabric_add_data = CsimPortTShort::build(RefString(new std::string("fabric_add_data")),12, getThis(), PORT_DIR_OUTPUT);
  fabric_add_ready = CsimPortTBool::build(RefString(new std::string("fabric_add_ready")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
  addConnectable(modem_rx);
  addConnectable(modem_tx);
  addConnectable(modem_gp0_in);
  addConnectable(modem_gp0_out);
  addConnectable(modem_gp0_en);
  addConnectable(modem_gp1_in);
  addConnectable(modem_gp1_out);
  addConnectable(modem_gp1_en);
  addConnectable(modem_gp2_in);
  addConnectable(modem_gp2_out);
  addConnectable(modem_gp2_en);
  addConnectable(modem_gp3_in);
  addConnectable(modem_gp3_out);
  addConnectable(modem_gp3_en);
  addConnectable(modem_gp4_in);
  addConnectable(modem_gp4_out);
  addConnectable(modem_gp4_en);
  addConnectable(modem_gp5_in);
  addConnectable(modem_gp5_out);
  addConnectable(modem_gp5_en);
  addConnectable(fabric_drop_valid);
  addConnectable(fabric_drop_type);
  addConnectable(fabric_drop_src_nid);
  addConnectable(fabric_drop_addr);
  addConnectable(fabric_drop_data);
  addConnectable(fabric_add_valid);
  addConnectable(fabric_add_type);
  addConnectable(fabric_add_dst_nid);
  addConnectable(fabric_add_addr);
  addConnectable(fabric_add_data);
  addConnectable(fabric_add_ready);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void uart::connect() {
}
}
