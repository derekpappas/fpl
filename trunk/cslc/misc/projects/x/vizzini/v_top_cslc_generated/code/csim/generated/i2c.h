#ifndef I2C_H
#define I2C_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class i2c : public CsimUnit {
public:
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
  i2c() : CsimUnit(RefString(new std::string("i2c"))) {}
};
}

#endif
