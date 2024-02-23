#ifndef UART_MGR_H
#define UART_MGR_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class uart_mgr : public CsimUnit {
public:
  RefCsimPortTBool fifo_reg_bus0_write_en;
  RefCsimPortTChar fifo_reg_bus0_addr;
  RefCsimPortTShort fifo_reg_bus0_write_data;
  RefCsimPortTShort fifo_reg_bus0_read_data;
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
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  uart_mgr() : CsimUnit(RefString(new std::string("uart_mgr"))) {}
};
}

#endif
