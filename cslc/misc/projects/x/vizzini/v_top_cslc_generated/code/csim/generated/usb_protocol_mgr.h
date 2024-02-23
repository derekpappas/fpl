#ifndef USB_PROTOCOL_MGR_H
#define USB_PROTOCOL_MGR_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class usb_protocol_mgr : public CsimUnit {
public:
  RefCsimPortTBool tp_bus_t2p_valid;
  RefCsimPortTChar tp_bus_t2p_length;
  RefCsimPortTChar tp_bus_t2p_endpoint;
  RefCsimPortTBool tp_bus_t2p_ready;
  RefCsimPortTBool tp_bus_p2t_valid;
  RefCsimPortTChar tp_bus_p2t_length;
  RefCsimPortTChar tp_bus_p2t_endpoint;
  RefCsimPortTBool tp_bus_p2t_ready;
  RefCsimPortTBool ram_bus1_valid;
  RefCsimPortTBool ram_bus1_write_en;
  RefCsimPortTChar ram_bus1_addr;
  RefCsimPortTShort ram_bus1_write_data;
  RefCsimPortTShort ram_bus1_read_data;
  RefCsimPortTBool ram_bus1_ready;
  RefCsimPortTBool fabric_drop_valid;
  RefCsimPortTChar fabric_drop_type;
  RefCsimPortTChar fabric_drop_src_nid;
  RefCsimPortTShort fabric_drop_addr;
  RefCsimPortTShort fabric_drop_data;
  RefCsimPortTBool fabric_add_valid;
  RefCsimPortTChar fabric_add_type;
  RefCsimPortTChar fabric_add_dst_nid;
  RefCsimPortTShort fabric_add_addr;
  RefCsimPortTShort fabric_add_data;
  RefCsimPortTBool fabric_add_ready;
  RefCsimPortTBool fifo_reg_write_en;
  RefCsimPortTChar fifo_reg_addr;
  RefCsimPortTShort fifo_reg_write_data;
  RefCsimPortTShort fifo_reg_read_data;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  usb_protocol_mgr() : CsimUnit(RefString(new std::string("usb_protocol_mgr"))) {}
};
}

#endif
