#ifndef JEFF_UART_H
#define JEFF_UART_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class jeff_uart : public CsimUnit {
public:
  RefCsimPortTBool uart_gpio_0_in;
  RefCsimPortTBool uart_gpio_0_out;
  RefCsimPortTBool uart_gpio_0_en;
  RefCsimPortTBool uart_gpio_1_in;
  RefCsimPortTBool uart_gpio_1_out;
  RefCsimPortTBool uart_gpio_1_en;
  RefCsimPortTBool uart_gpio_2_in;
  RefCsimPortTBool uart_gpio_2_out;
  RefCsimPortTBool uart_gpio_2_en;
  RefCsimPortTBool uart_gpio_3_in;
  RefCsimPortTBool uart_gpio_3_out;
  RefCsimPortTBool uart_gpio_3_en;
  RefCsimPortTBool uart_gpio_4_in;
  RefCsimPortTBool uart_gpio_4_out;
  RefCsimPortTBool uart_gpio_4_en;
  RefCsimPortTBool uart_gpio_5_in;
  RefCsimPortTBool uart_gpio_5_out;
  RefCsimPortTBool uart_gpio_5_en;
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
  jeff_uart() : CsimUnit(RefString(new std::string("jeff_uart"))) {}
};
}

#endif
