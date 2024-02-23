#ifndef UART_H
#define UART_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class uart : public CsimUnit {
public:
  RefCsimPortTBool modem_rx;
  RefCsimPortTBool modem_tx;
  RefCsimPortTBool modem_gp0_in;
  RefCsimPortTBool modem_gp0_out;
  RefCsimPortTBool modem_gp0_en;
  RefCsimPortTBool modem_gp1_in;
  RefCsimPortTBool modem_gp1_out;
  RefCsimPortTBool modem_gp1_en;
  RefCsimPortTBool modem_gp2_in;
  RefCsimPortTBool modem_gp2_out;
  RefCsimPortTBool modem_gp2_en;
  RefCsimPortTBool modem_gp3_in;
  RefCsimPortTBool modem_gp3_out;
  RefCsimPortTBool modem_gp3_en;
  RefCsimPortTBool modem_gp4_in;
  RefCsimPortTBool modem_gp4_out;
  RefCsimPortTBool modem_gp4_en;
  RefCsimPortTBool modem_gp5_in;
  RefCsimPortTBool modem_gp5_out;
  RefCsimPortTBool modem_gp5_en;
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
  uart() : CsimUnit(RefString(new std::string("uart"))) {}
};
}

#endif
