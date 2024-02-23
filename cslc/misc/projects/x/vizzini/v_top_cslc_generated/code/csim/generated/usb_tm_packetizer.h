#ifndef USB_TM_PACKETIZER_H
#define USB_TM_PACKETIZER_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class usb_tm_packetizer : public CsimUnit {
public:
  RefCsimPortTBool phy_rx_valid;
  RefCsimPortTBool phy_rx_cmd;
  RefCsimPortTChar phy_rx_data;
  RefCsimPortTBool phy_rx_ready;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  usb_tm_packetizer() : CsimUnit(RefString(new std::string("usb_tm_packetizer"))) {}
};
}

#endif
