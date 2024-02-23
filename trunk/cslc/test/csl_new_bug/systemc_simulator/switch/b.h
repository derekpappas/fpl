#ifndef INC_GUARD_b_h
#define INC_GUARD_b_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(b) {
  sc_in<bool> clk;
  sc_out<sc_uint<4> > p;

  SC_CTOR(b) {
    dont_initialize();
  }
};

#endif
