#ifndef OUTPUT_CELL_H
#define OUTPUT_CELL_H

#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimSignal.h"
#include "/opt/fpl_repo2/fpl/cslc/trunk/build_utils/trunk/src/csim/CsimPort.h"
#include "usb_tm_packetizer.h"
#include "usb_tm_dispatcher.h"

using namespace NSCsimLib;

namespace NSCsimGen {

class output_cell : public CsimUnit {
public:
  //functions
  void defaultInitialize();
  void connect();
  virtual void allocate() = 0;
  virtual void initialize() = 0;
  virtual void execute() = 0;
  //constructor
  output_cell() : CsimUnit(RefString(new std::string("output_cell"))) {}
};
}

#endif
