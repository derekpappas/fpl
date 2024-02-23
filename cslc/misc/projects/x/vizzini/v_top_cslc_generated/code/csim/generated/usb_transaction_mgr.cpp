#include "usb_transaction_mgr.h"

namespace NSCsimGen {

void usb_transaction_mgr::defaultInitialize() {
    //port allocations
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
  tp_bus_t2p_valid = CsimPortTBool::build(RefString(new std::string("tp_bus_t2p_valid")),1, getThis(), PORT_DIR_INPUT);
  tp_bus_t2p_length = CsimPortTChar::build(RefString(new std::string("tp_bus_t2p_length")),6, getThis(), PORT_DIR_INPUT);
  tp_bus_t2p_endpoint = CsimPortTChar::build(RefString(new std::string("tp_bus_t2p_endpoint")),4, getThis(), PORT_DIR_INPUT);
  tp_bus_t2p_ready = CsimPortTBool::build(RefString(new std::string("tp_bus_t2p_ready")),1, getThis(), PORT_DIR_OUTPUT);
  tp_bus_p2t_valid = CsimPortTBool::build(RefString(new std::string("tp_bus_p2t_valid")),1, getThis(), PORT_DIR_OUTPUT);
  tp_bus_p2t_length = CsimPortTChar::build(RefString(new std::string("tp_bus_p2t_length")),6, getThis(), PORT_DIR_OUTPUT);
  tp_bus_p2t_endpoint = CsimPortTChar::build(RefString(new std::string("tp_bus_p2t_endpoint")),4, getThis(), PORT_DIR_OUTPUT);
  tp_bus_p2t_ready = CsimPortTBool::build(RefString(new std::string("tp_bus_p2t_ready")),1, getThis(), PORT_DIR_INPUT);
  phy_rx_valid = CsimPortTBool::build(RefString(new std::string("phy_rx_valid")),1, getThis(), PORT_DIR_INPUT);
  phy_rx_cmd = CsimPortTBool::build(RefString(new std::string("phy_rx_cmd")),1, getThis(), PORT_DIR_INPUT);
  phy_rx_data = CsimPortTChar::build(RefString(new std::string("phy_rx_data")),8, getThis(), PORT_DIR_INPUT);
  phy_rx_ready = CsimPortTBool::build(RefString(new std::string("phy_rx_ready")),1, getThis(), PORT_DIR_OUTPUT);
  phy_tx_valid = CsimPortTBool::build(RefString(new std::string("phy_tx_valid")),1, getThis(), PORT_DIR_OUTPUT);
  phy_tx_cmd = CsimPortTBool::build(RefString(new std::string("phy_tx_cmd")),1, getThis(), PORT_DIR_OUTPUT);
  phy_tx_data = CsimPortTChar::build(RefString(new std::string("phy_tx_data")),8, getThis(), PORT_DIR_OUTPUT);
  phy_tx_ready = CsimPortTBool::build(RefString(new std::string("phy_tx_ready")),1, getThis(), PORT_DIR_INPUT);
  //port registrations
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
  addConnectable(tp_bus_t2p_valid);
  addConnectable(tp_bus_t2p_length);
  addConnectable(tp_bus_t2p_endpoint);
  addConnectable(tp_bus_t2p_ready);
  addConnectable(tp_bus_p2t_valid);
  addConnectable(tp_bus_p2t_length);
  addConnectable(tp_bus_p2t_endpoint);
  addConnectable(tp_bus_p2t_ready);
  addConnectable(phy_rx_valid);
  addConnectable(phy_rx_cmd);
  addConnectable(phy_rx_data);
  addConnectable(phy_rx_ready);
  addConnectable(phy_tx_valid);
  addConnectable(phy_tx_cmd);
  addConnectable(phy_tx_data);
  addConnectable(phy_tx_ready);
  //building vector writers
  //initializers
  allocate();
  //instance registration
  usb_tm_packetizer_->setParent(getThis());
  usb_tm_packetizer_->setInstanceName(RefString(new std::string("usb_tm_packetizer_")));
  usb_tm_dispatcher_->setParent(getThis());
  usb_tm_dispatcher_->setInstanceName(RefString(new std::string("usb_tm_dispatcher_")));
  //clock connections
                                  //default initis
  usb_tm_packetizer_->defaultInitialize();
  usb_tm_dispatcher_->defaultInitialize();
  connect();
  initialize();
}

void usb_transaction_mgr::connect() {
    cmd->connect(boost::static_pointer_cast<CsimPortTBool>(usb_tm_packetizer_->getSignalByName(RefString(new std::string("cmd")))));
    data->connect(boost::static_pointer_cast<CsimPortTChar>(usb_tm_packetizer_->getSignalByName(RefString(new std::string("data")))));
    ready->connect(boost::static_pointer_cast<CsimPortTBool>(usb_tm_packetizer_->getSignalByName(RefString(new std::string("ready")))));
    valid->connect(boost::static_pointer_cast<CsimPortTBool>(usb_tm_packetizer_->getSignalByName(RefString(new std::string("valid")))));
    cmd->connect(boost::static_pointer_cast<CsimPortTBool>(usb_tm_dispatcher_->getSignalByName(RefString(new std::string("cmd")))));
    data->connect(boost::static_pointer_cast<CsimPortTChar>(usb_tm_dispatcher_->getSignalByName(RefString(new std::string("data")))));
    ready->connect(boost::static_pointer_cast<CsimPortTBool>(usb_tm_dispatcher_->getSignalByName(RefString(new std::string("ready")))));
    valid->connect(boost::static_pointer_cast<CsimPortTBool>(usb_tm_dispatcher_->getSignalByName(RefString(new std::string("valid")))));
}
}
