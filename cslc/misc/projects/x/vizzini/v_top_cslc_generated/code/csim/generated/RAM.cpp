#include "RAM.h"

namespace NSCsimGen {

void RAM::defaultInitialize() {
    //port allocations
  ram_bus0_valid = CsimPortTBool::build(RefString(new std::string("ram_bus0_valid")),1, getThis(), PORT_DIR_OUTPUT);
  ram_bus0_write_en = CsimPortTBool::build(RefString(new std::string("ram_bus0_write_en")),1, getThis(), PORT_DIR_OUTPUT);
  ram_bus0_addr = CsimPortTChar::build(RefString(new std::string("ram_bus0_addr")),5, getThis(), PORT_DIR_OUTPUT);
  ram_bus0_write_data = CsimPortTShort::build(RefString(new std::string("ram_bus0_write_data")),12, getThis(), PORT_DIR_OUTPUT);
  ram_bus0_read_data = CsimPortTShort::build(RefString(new std::string("ram_bus0_read_data")),12, getThis(), PORT_DIR_INPUT);
  ram_bus0_ready = CsimPortTBool::build(RefString(new std::string("ram_bus0_ready")),1, getThis(), PORT_DIR_INPUT);
  ram_bus1_valid = CsimPortTBool::build(RefString(new std::string("ram_bus1_valid")),1, getThis(), PORT_DIR_OUTPUT);
  ram_bus1_write_en = CsimPortTBool::build(RefString(new std::string("ram_bus1_write_en")),1, getThis(), PORT_DIR_OUTPUT);
  ram_bus1_addr = CsimPortTChar::build(RefString(new std::string("ram_bus1_addr")),5, getThis(), PORT_DIR_OUTPUT);
  ram_bus1_write_data = CsimPortTShort::build(RefString(new std::string("ram_bus1_write_data")),12, getThis(), PORT_DIR_OUTPUT);
  ram_bus1_read_data = CsimPortTShort::build(RefString(new std::string("ram_bus1_read_data")),12, getThis(), PORT_DIR_INPUT);
  ram_bus1_ready = CsimPortTBool::build(RefString(new std::string("ram_bus1_ready")),1, getThis(), PORT_DIR_INPUT);
  ram_bus2_valid = CsimPortTBool::build(RefString(new std::string("ram_bus2_valid")),1, getThis(), PORT_DIR_OUTPUT);
  ram_bus2_write_en = CsimPortTBool::build(RefString(new std::string("ram_bus2_write_en")),1, getThis(), PORT_DIR_OUTPUT);
  ram_bus2_addr = CsimPortTChar::build(RefString(new std::string("ram_bus2_addr")),5, getThis(), PORT_DIR_OUTPUT);
  ram_bus2_write_data = CsimPortTShort::build(RefString(new std::string("ram_bus2_write_data")),12, getThis(), PORT_DIR_OUTPUT);
  ram_bus2_read_data = CsimPortTShort::build(RefString(new std::string("ram_bus2_read_data")),12, getThis(), PORT_DIR_INPUT);
  ram_bus2_ready = CsimPortTBool::build(RefString(new std::string("ram_bus2_ready")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
  addConnectable(ram_bus0_valid);
  addConnectable(ram_bus0_write_en);
  addConnectable(ram_bus0_addr);
  addConnectable(ram_bus0_write_data);
  addConnectable(ram_bus0_read_data);
  addConnectable(ram_bus0_ready);
  addConnectable(ram_bus1_valid);
  addConnectable(ram_bus1_write_en);
  addConnectable(ram_bus1_addr);
  addConnectable(ram_bus1_write_data);
  addConnectable(ram_bus1_read_data);
  addConnectable(ram_bus1_ready);
  addConnectable(ram_bus2_valid);
  addConnectable(ram_bus2_write_en);
  addConnectable(ram_bus2_addr);
  addConnectable(ram_bus2_write_data);
  addConnectable(ram_bus2_read_data);
  addConnectable(ram_bus2_ready);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void RAM::connect() {
}
}
