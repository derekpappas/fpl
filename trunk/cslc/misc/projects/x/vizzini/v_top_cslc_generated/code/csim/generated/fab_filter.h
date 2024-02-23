#ifndef FAB_FILTER_H
#define FAB_FILTER_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class fab_filter : public CsimUnit {
public:
  RefCsimPortTBool fabric_out_valid;
  RefCsimPortTBool fabric_out_age;
  RefCsimPortTChar fabric_out_type;
  RefCsimPortTChar fabric_out_src_nid;
  RefCsimPortTChar fabric_out_dst_nid;
  RefCsimPortTShort fabric_out_addr;
  RefCsimPortTShort fabric_out_data;
  RefCsimPortTBool fabric_in_valid;
  RefCsimPortTBool fabric_in_age;
  RefCsimPortTChar fabric_in_type;
  RefCsimPortTChar fabric_in_src_nid;
  RefCsimPortTChar fabric_in_dst_nid;
  RefCsimPortTShort fabric_in_addr;
  RefCsimPortTShort fabric_in_data;
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  fab_filter() : CsimUnit(RefString(new std::string("fab_filter"))) {}
};
}

#endif
