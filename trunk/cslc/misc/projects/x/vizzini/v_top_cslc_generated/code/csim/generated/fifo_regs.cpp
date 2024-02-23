#include "fifo_regs.h"

namespace NSCsimGen {

void fifo_regs::defaultInitialize() {
    //port allocations
  fifo_reg_bus0_write_en = CsimPortTBool::build(RefString(new std::string("fifo_reg_bus0_write_en")),1, getThis(), PORT_DIR_OUTPUT);
  fifo_reg_bus0_addr = CsimPortTChar::build(RefString(new std::string("fifo_reg_bus0_addr")),5, getThis(), PORT_DIR_OUTPUT);
  fifo_reg_bus0_write_data = CsimPortTShort::build(RefString(new std::string("fifo_reg_bus0_write_data")),12, getThis(), PORT_DIR_OUTPUT);
  fifo_reg_bus0_read_data = CsimPortTShort::build(RefString(new std::string("fifo_reg_bus0_read_data")),12, getThis(), PORT_DIR_INPUT);
  fifo_reg_write_en = CsimPortTBool::build(RefString(new std::string("fifo_reg_write_en")),1, getThis(), PORT_DIR_INPUT);
  fifo_reg_addr = CsimPortTChar::build(RefString(new std::string("fifo_reg_addr")),5, getThis(), PORT_DIR_INPUT);
  fifo_reg_write_data = CsimPortTShort::build(RefString(new std::string("fifo_reg_write_data")),12, getThis(), PORT_DIR_INPUT);
  fifo_reg_read_data = CsimPortTShort::build(RefString(new std::string("fifo_reg_read_data")),12, getThis(), PORT_DIR_OUTPUT);
  //port registrations
  addConnectable(fifo_reg_bus0_write_en);
  addConnectable(fifo_reg_bus0_addr);
  addConnectable(fifo_reg_bus0_write_data);
  addConnectable(fifo_reg_bus0_read_data);
  addConnectable(fifo_reg_write_en);
  addConnectable(fifo_reg_addr);
  addConnectable(fifo_reg_write_data);
  addConnectable(fifo_reg_read_data);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void fifo_regs::connect() {
}
}
