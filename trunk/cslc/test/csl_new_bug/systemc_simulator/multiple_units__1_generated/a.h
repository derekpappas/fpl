#ifndef INC_GUARD_a_h
#define INC_GUARD_a_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(a) {
  sc_in<sc_uint<5> > in;
  sc_in<bool> clk;
  sc_out<sc_uint<5> > out;

  SC_CTOR(a) {

    dont_initialize();
    sensitive << clk.pos();
  }
};

#endif
