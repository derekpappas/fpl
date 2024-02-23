#ifndef USB_ANALOG_PHY_H
#define USB_ANALOG_PHY_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class usb_analog_phy : public CsimUnit {
public:
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  usb_analog_phy() : CsimUnit(RefString(new std::string("usb_analog_phy"))) {}
};
}

#endif
