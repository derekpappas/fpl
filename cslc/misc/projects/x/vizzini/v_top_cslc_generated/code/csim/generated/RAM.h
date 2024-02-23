#ifndef RAM_H
#define RAM_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class RAM : public CsimUnit {
public:
  RefCsimPortTBool ram_bus0_valid;
  RefCsimPortTBool ram_bus0_write_en;
  RefCsimPortTChar ram_bus0_addr;
  RefCsimPortTShort ram_bus0_write_data;
  RefCsimPortTShort ram_bus0_read_data;
  RefCsimPortTBool ram_bus0_ready;
  RefCsimPortTBool ram_bus1_valid;
  RefCsimPortTBool ram_bus1_write_en;
  RefCsimPortTChar ram_bus1_addr;
  RefCsimPortTShort ram_bus1_write_data;
  RefCsimPortTShort ram_bus1_read_data;
  RefCsimPortTBool ram_bus1_ready;
  RefCsimPortTBool ram_bus2_valid;
  RefCsimPortTBool ram_bus2_write_en;
  RefCsimPortTChar ram_bus2_addr;
  RefCsimPortTShort ram_bus2_write_data;
  RefCsimPortTShort ram_bus2_read_data;
  RefCsimPortTBool ram_bus2_ready;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  RAM() : CsimUnit(RefString(new std::string("RAM"))) {}
};
}

#endif
