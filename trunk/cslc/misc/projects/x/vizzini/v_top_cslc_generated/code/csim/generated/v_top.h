#ifndef V_TOP_H
#define V_TOP_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"
#include "RAM.h"
#include "fab.h"
#include "uart_mgr.h"
#include "fab.h"
#include "jeff_uart.h"
#include "fab.h"
#include "uart.h"
#include "fab.h"
#include "uart.h"
#include "fab.h"
#include "uart.h"
#include "fab.h"
#include "i2c.h"
#include "fab.h"
#include "usb_protocol_mgr.h"
#include "fab_filter.h"
#include "fab.h"
#include "usb_transaction_mgr.h"
#include "fifo_regs.h"
#include "usb_phy.h"
#include "v_core.h"
#include "input_cell.h"
#include "output_cell.h"
#include "io_cell.h"
#include "io_cell.h"
#include "io_cell.h"
#include "io_cell.h"
#include "io_cell.h"
#include "io_cell.h"
#include "usb_analog_phy.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class v_top : public CsimUnit {
public:
  RefCsimPortTBool uart1_rx;
  RefCsimPortTBool uart1_tx;
  RefCsimPortTBool uart1_gp0_in;
  RefCsimPortTBool uart1_gp0_out;
  RefCsimPortTBool uart1_gp0_en;
  RefCsimPortTBool uart1_gp1_in;
  RefCsimPortTBool uart1_gp1_out;
  RefCsimPortTBool uart1_gp1_en;
  RefCsimPortTBool uart1_gp2_in;
  RefCsimPortTBool uart1_gp2_out;
  RefCsimPortTBool uart1_gp2_en;
  RefCsimPortTBool uart1_gp3_in;
  RefCsimPortTBool uart1_gp3_out;
  RefCsimPortTBool uart1_gp3_en;
  RefCsimPortTBool uart1_gp4_in;
  RefCsimPortTBool uart1_gp4_out;
  RefCsimPortTBool uart1_gp4_en;
  RefCsimPortTBool uart1_gp5_in;
  RefCsimPortTBool uart1_gp5_out;
  RefCsimPortTBool uart1_gp5_en;
  RefCsimPortTBool uart2_rx;
  RefCsimPortTBool uart2_tx;
  RefCsimPortTBool uart2_gp0_in;
  RefCsimPortTBool uart2_gp0_out;
  RefCsimPortTBool uart2_gp0_en;
  RefCsimPortTBool uart2_gp1_in;
  RefCsimPortTBool uart2_gp1_out;
  RefCsimPortTBool uart2_gp1_en;
  RefCsimPortTBool uart2_gp2_in;
  RefCsimPortTBool uart2_gp2_out;
  RefCsimPortTBool uart2_gp2_en;
  RefCsimPortTBool uart2_gp3_in;
  RefCsimPortTBool uart2_gp3_out;
  RefCsimPortTBool uart2_gp3_en;
  RefCsimPortTBool uart2_gp4_in;
  RefCsimPortTBool uart2_gp4_out;
  RefCsimPortTBool uart2_gp4_en;
  RefCsimPortTBool uart2_gp5_in;
  RefCsimPortTBool uart2_gp5_out;
  RefCsimPortTBool uart2_gp5_en;
  RefCsimPortTBool uart3_rx;
  RefCsimPortTBool uart3_tx;
  RefCsimPortTBool uart3_gp0_in;
  RefCsimPortTBool uart3_gp0_out;
  RefCsimPortTBool uart3_gp0_en;
  RefCsimPortTBool uart3_gp1_in;
  RefCsimPortTBool uart3_gp1_out;
  RefCsimPortTBool uart3_gp1_en;
  RefCsimPortTBool uart3_gp2_in;
  RefCsimPortTBool uart3_gp2_out;
  RefCsimPortTBool uart3_gp2_en;
  RefCsimPortTBool uart3_gp3_in;
  RefCsimPortTBool uart3_gp3_out;
  RefCsimPortTBool uart3_gp3_en;
  RefCsimPortTBool uart3_gp4_in;
  RefCsimPortTBool uart3_gp4_out;
  RefCsimPortTBool uart3_gp4_en;
  RefCsimPortTBool uart3_gp5_in;
  RefCsimPortTBool uart3_gp5_out;
  RefCsimPortTBool uart3_gp5_en;
  RefCsimPortTBool usb_rpu1_en;
  RefCsimPortTBool usb_rpu2_en;
  RefCsimPortTBool usb_data_in;
  RefCsimPortTBool usb_force_se0;
  RefCsimPortTBool usb_drv_enable;
  RefCsimPortTBool usb_suspend;
  RefCsimPortTBool usb_se_dp;
  RefCsimPortTBool usb_enable_se;
  RefCsimPortTBool usb_se_dn;
  RefCsimPortTBool usb_data_out;
  RefCsimPortTBool usb_strobe;
  RefCsimPortTBool usb_enable_diff;
  RefCsimPortTBool gpio_a0;
  RefCsimPortTBool gpio_a1;
  RefCsimPortTBool gpio_a2;
  RefCsimPortTBool gpio_a3;
  RefCsimPortTBool gpio_a4;
  RefCsimPortTBool gpio_a5;
  RefCsimSignalTBool gpio_connect_a0_in;
  RefCsimSignalTBool gpio_connect_a0_out;
  RefCsimSignalTBool gpio_connect_a0_en;
  RefCsimSignalTBool gpio_connect_a1_in;
  RefCsimSignalTBool gpio_connect_a1_out;
  RefCsimSignalTBool gpio_connect_a1_en;
  RefCsimSignalTBool gpio_connect_a2_in;
  RefCsimSignalTBool gpio_connect_a2_out;
  RefCsimSignalTBool gpio_connect_a2_en;
  RefCsimSignalTBool gpio_connect_a3_in;
  RefCsimSignalTBool gpio_connect_a3_out;
  RefCsimSignalTBool gpio_connect_a3_en;
  RefCsimSignalTBool gpio_connect_a4_in;
  RefCsimSignalTBool gpio_connect_a4_out;
  RefCsimSignalTBool gpio_connect_a4_en;
  RefCsimSignalTBool gpio_connect_a5_in;
  RefCsimSignalTBool gpio_connect_a5_out;
  RefCsimSignalTBool gpio_connect_a5_en;
  RefCsimUnit v_core;
  RefCsimUnit rx_mod_0;
  RefCsimUnit tx_mod_0;
  RefCsimUnit gpio_mod_a0;
  RefCsimUnit gpio_mod_a1;
  RefCsimUnit gpio_mod_a2;
  RefCsimUnit gpio_mod_a3;
  RefCsimUnit gpio_mod_a4;
  RefCsimUnit gpio_mod_a5;
  RefCsimUnit usb_analog_phy_;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  v_top() : CsimUnit(RefString(new std::string("v_top"))) {}
};
}

#endif
