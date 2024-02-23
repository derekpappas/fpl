#include "uart_mgr.h"

namespace NSCsimGen {

void uart_mgr::defaultInitialize() {
    //port allocations
  fifo_reg_bus0_write_en = CsimPortTBool::build(RefString(new std::string("fifo_reg_bus0_write_en")),1, getThis(), PORT_DIR_OUTPUT);
  fifo_reg_bus0_addr = CsimPortTChar::build(RefString(new std::string("fifo_reg_bus0_addr")),5, getThis(), PORT_DIR_OUTPUT);
  fifo_reg_bus0_write_data = CsimPortTShort::build(RefString(new std::string("fifo_reg_bus0_write_data")),12, getThis(), PORT_DIR_OUTPUT);
  fifo_reg_bus0_read_data = CsimPortTShort::build(RefString(new std::string("fifo_reg_bus0_read_data")),12, getThis(), PORT_DIR_INPUT);
  ram_bus1_valid = CsimPortTBool::build(RefString(new std::string("ram_bus1_valid")),1, getThis(), PORT_DIR_INPUT);
  ram_bus1_write_en = CsimPortTBool::build(RefString(new std::string("ram_bus1_write_en")),1, getThis(), PORT_DIR_INPUT);
  ram_bus1_addr = CsimPortTChar::build(RefString(new std::string("ram_bus1_addr")),5, getThis(), PORT_DIR_INPUT);
  ram_bus1_write_data = CsimPortTShort::build(RefString(new std::string("ram_bus1_write_data")),12, getThis(), PORT_DIR_INPUT);
  ram_bus1_read_data = CsimPortTShort::build(RefString(new std::string("ram_bus1_read_data")),12, getThis(), PORT_DIR_OUTPUT);
  ram_bus1_ready = CsimPortTBool::build(RefString(new std::string("ram_bus1_ready")),1, getThis(), PORT_DIR_OUTPUT);
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
  addConnectable(fifo_reg_bus0_write_en);
  addConnectable(fifo_reg_bus0_addr);
  addConnectable(fifo_reg_bus0_write_data);
  addConnectable(fifo_reg_bus0_read_data);
  addConnectable(ram_bus1_valid);
  addConnectable(ram_bus1_write_en);
  addConnectable(ram_bus1_addr);
  addConnectable(ram_bus1_write_data);
  addConnectable(ram_bus1_read_data);
  addConnectable(ram_bus1_ready);
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

void uart_mgr::connect() {
}
}
