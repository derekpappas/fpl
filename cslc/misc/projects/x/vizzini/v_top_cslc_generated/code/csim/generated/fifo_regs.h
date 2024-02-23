#ifndef FIFO_REGS_H
#define FIFO_REGS_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class fifo_regs : public CsimUnit {
public:
  RefCsimPortTBool fifo_reg_bus0_write_en;
  RefCsimPortTChar fifo_reg_bus0_addr;
  RefCsimPortTShort fifo_reg_bus0_write_data;
  RefCsimPortTShort fifo_reg_bus0_read_data;
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
  fifo_regs() : CsimUnit(RefString(new std::string("fifo_regs"))) {}
};
}

#endif
