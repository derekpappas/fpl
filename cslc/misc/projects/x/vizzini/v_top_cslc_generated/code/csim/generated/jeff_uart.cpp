#include "jeff_uart.h"

namespace NSCsimGen {

void jeff_uart::defaultInitialize() {
    //port allocations
  uart_gpio_0_in = CsimPortTBool::build(RefString(new std::string("uart_gpio_0_in")),1, getThis(), PORT_DIR_INPUT);
  uart_gpio_0_out = CsimPortTBool::build(RefString(new std::string("uart_gpio_0_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_0_en = CsimPortTBool::build(RefString(new std::string("uart_gpio_0_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_1_in = CsimPortTBool::build(RefString(new std::string("uart_gpio_1_in")),1, getThis(), PORT_DIR_INPUT);
  uart_gpio_1_out = CsimPortTBool::build(RefString(new std::string("uart_gpio_1_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_1_en = CsimPortTBool::build(RefString(new std::string("uart_gpio_1_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_2_in = CsimPortTBool::build(RefString(new std::string("uart_gpio_2_in")),1, getThis(), PORT_DIR_INPUT);
  uart_gpio_2_out = CsimPortTBool::build(RefString(new std::string("uart_gpio_2_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_2_en = CsimPortTBool::build(RefString(new std::string("uart_gpio_2_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_3_in = CsimPortTBool::build(RefString(new std::string("uart_gpio_3_in")),1, getThis(), PORT_DIR_INPUT);
  uart_gpio_3_out = CsimPortTBool::build(RefString(new std::string("uart_gpio_3_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_3_en = CsimPortTBool::build(RefString(new std::string("uart_gpio_3_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_4_in = CsimPortTBool::build(RefString(new std::string("uart_gpio_4_in")),1, getThis(), PORT_DIR_INPUT);
  uart_gpio_4_out = CsimPortTBool::build(RefString(new std::string("uart_gpio_4_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_4_en = CsimPortTBool::build(RefString(new std::string("uart_gpio_4_en")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_5_in = CsimPortTBool::build(RefString(new std::string("uart_gpio_5_in")),1, getThis(), PORT_DIR_INPUT);
  uart_gpio_5_out = CsimPortTBool::build(RefString(new std::string("uart_gpio_5_out")),1, getThis(), PORT_DIR_OUTPUT);
  uart_gpio_5_en = CsimPortTBool::build(RefString(new std::string("uart_gpio_5_en")),1, getThis(), PORT_DIR_OUTPUT);
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
  addConnectable(uart_gpio_0_in);
  addConnectable(uart_gpio_0_out);
  addConnectable(uart_gpio_0_en);
  addConnectable(uart_gpio_1_in);
  addConnectable(uart_gpio_1_out);
  addConnectable(uart_gpio_1_en);
  addConnectable(uart_gpio_2_in);
  addConnectable(uart_gpio_2_out);
  addConnectable(uart_gpio_2_en);
  addConnectable(uart_gpio_3_in);
  addConnectable(uart_gpio_3_out);
  addConnectable(uart_gpio_3_en);
  addConnectable(uart_gpio_4_in);
  addConnectable(uart_gpio_4_out);
  addConnectable(uart_gpio_4_en);
  addConnectable(uart_gpio_5_in);
  addConnectable(uart_gpio_5_out);
  addConnectable(uart_gpio_5_en);
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

void jeff_uart::connect() {
}
}
