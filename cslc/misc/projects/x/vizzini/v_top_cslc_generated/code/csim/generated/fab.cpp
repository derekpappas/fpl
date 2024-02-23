#include "fab.h"

namespace NSCsimGen {

void fab::defaultInitialize() {
    //port allocations
  fabric_drop_valid = CsimPortTBool::build(RefString(new std::string("fabric_drop_valid")),1, getThis(), PORT_DIR_OUTPUT);
  fabric_drop_type = CsimPortTChar::build(RefString(new std::string("fabric_drop_type")),2, getThis(), PORT_DIR_OUTPUT);
  fabric_drop_src_nid = CsimPortTChar::build(RefString(new std::string("fabric_drop_src_nid")),4, getThis(), PORT_DIR_OUTPUT);
  fabric_drop_addr = CsimPortTShort::build(RefString(new std::string("fabric_drop_addr")),12, getThis(), PORT_DIR_OUTPUT);
  fabric_drop_data = CsimPortTShort::build(RefString(new std::string("fabric_drop_data")),12, getThis(), PORT_DIR_OUTPUT);
  fabric_add_valid = CsimPortTBool::build(RefString(new std::string("fabric_add_valid")),1, getThis(), PORT_DIR_INPUT);
  fabric_add_type = CsimPortTChar::build(RefString(new std::string("fabric_add_type")),2, getThis(), PORT_DIR_INPUT);
  fabric_add_dst_nid = CsimPortTChar::build(RefString(new std::string("fabric_add_dst_nid")),4, getThis(), PORT_DIR_INPUT);
  fabric_add_addr = CsimPortTShort::build(RefString(new std::string("fabric_add_addr")),12, getThis(), PORT_DIR_INPUT);
  fabric_add_data = CsimPortTShort::build(RefString(new std::string("fabric_add_data")),12, getThis(), PORT_DIR_INPUT);
  fabric_add_ready = CsimPortTBool::build(RefString(new std::string("fabric_add_ready")),1, getThis(), PORT_DIR_OUTPUT);
  fabric_out_valid = CsimPortTBool::build(RefString(new std::string("fabric_out_valid")),1, getThis(), PORT_DIR_OUTPUT);
  fabric_out_age = CsimPortTBool::build(RefString(new std::string("fabric_out_age")),1, getThis(), PORT_DIR_OUTPUT);
  fabric_out_type = CsimPortTChar::build(RefString(new std::string("fabric_out_type")),2, getThis(), PORT_DIR_OUTPUT);
  fabric_out_src_nid = CsimPortTChar::build(RefString(new std::string("fabric_out_src_nid")),4, getThis(), PORT_DIR_OUTPUT);
  fabric_out_dst_nid = CsimPortTChar::build(RefString(new std::string("fabric_out_dst_nid")),4, getThis(), PORT_DIR_OUTPUT);
  fabric_out_addr = CsimPortTShort::build(RefString(new std::string("fabric_out_addr")),12, getThis(), PORT_DIR_OUTPUT);
  fabric_out_data = CsimPortTShort::build(RefString(new std::string("fabric_out_data")),12, getThis(), PORT_DIR_OUTPUT);
  fabric_in_valid = CsimPortTBool::build(RefString(new std::string("fabric_in_valid")),1, getThis(), PORT_DIR_INPUT);
  fabric_in_age = CsimPortTBool::build(RefString(new std::string("fabric_in_age")),1, getThis(), PORT_DIR_INPUT);
  fabric_in_type = CsimPortTChar::build(RefString(new std::string("fabric_in_type")),2, getThis(), PORT_DIR_INPUT);
  fabric_in_src_nid = CsimPortTChar::build(RefString(new std::string("fabric_in_src_nid")),4, getThis(), PORT_DIR_INPUT);
  fabric_in_dst_nid = CsimPortTChar::build(RefString(new std::string("fabric_in_dst_nid")),4, getThis(), PORT_DIR_INPUT);
  fabric_in_addr = CsimPortTShort::build(RefString(new std::string("fabric_in_addr")),12, getThis(), PORT_DIR_INPUT);
  fabric_in_data = CsimPortTShort::build(RefString(new std::string("fabric_in_data")),12, getThis(), PORT_DIR_INPUT);
  //port registrations
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
  addConnectable(fabric_out_valid);
  addConnectable(fabric_out_age);
  addConnectable(fabric_out_type);
  addConnectable(fabric_out_src_nid);
  addConnectable(fabric_out_dst_nid);
  addConnectable(fabric_out_addr);
  addConnectable(fabric_out_data);
  addConnectable(fabric_in_valid);
  addConnectable(fabric_in_age);
  addConnectable(fabric_in_type);
  addConnectable(fabric_in_src_nid);
  addConnectable(fabric_in_dst_nid);
  addConnectable(fabric_in_addr);
  addConnectable(fabric_in_data);
  //building vector writers
  //initializers
  allocate();
  connect();
  initialize();
}

void fab::connect() {
}
}
