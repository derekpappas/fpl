#include "systemc.h"

SC_MODULE(stim) {
  // input and output ports declared by the user
  void stimGen() {

  // ouput ports that will be connected to the DUT are written with values
  }

  SC_CTOR(stim) {
    SC_THREAD(stimGen);
    dont_initialize();
    // sensitvity list, usually is clock: sensitive << clk.pos();
  }
};
