#ifndef USB_PHY_H
#define USB_PHY_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class usb_phy : public CsimUnit {
public:
  RefCsimPortTBool phy_rx_valid;
  RefCsimPortTBool phy_rx_cmd;
  RefCsimPortTChar phy_rx_data;
  RefCsimPortTBool phy_rx_ready;
  RefCsimPortTBool phy_tx_valid;
  RefCsimPortTBool phy_tx_cmd;
  RefCsimPortTChar phy_tx_data;
  RefCsimPortTBool phy_tx_ready;
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
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  usb_phy() : CsimUnit(RefString(new std::string("usb_phy"))) {}
};
}

#endif
