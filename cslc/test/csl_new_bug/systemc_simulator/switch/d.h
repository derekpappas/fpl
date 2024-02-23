#ifndef INC_GUARD_d_h
#define INC_GUARD_d_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(d) {
  sc_in<sc_uint<3> > p;
  sc_in<bool> clk;

  SC_CTOR(d) {
    dont_initialize();
  }
};

#endif
