#ifndef USB_TM_DISPATCHER_H
#define USB_TM_DISPATCHER_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class usb_tm_dispatcher : public CsimUnit {
public:
  RefCsimPortTBool phy_tx_valid;
  RefCsimPortTBool phy_tx_cmd;
  RefCsimPortTChar phy_tx_data;
  RefCsimPortTBool phy_tx_ready;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  usb_tm_dispatcher() : CsimUnit(RefString(new std::string("usb_tm_dispatcher"))) {}
};
}

#endif
