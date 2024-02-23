#ifndef INC_GUARD_aSwitch_h
#define INC_GUARD_aSwitch_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(aSwitch) {
  sc_in<sc_uint<2> > p_a;
  sc_in<sc_uint<4> > p_b;
  sc_in<bool> clk;
  sc_out<bool> p_c;
  sc_out<sc_uint<3> > p_d;

  SC_CTOR(aSwitch) {
    dont_initialize();
  }
};

#endif
