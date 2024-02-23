#ifndef INC_GUARD_c_h
#define INC_GUARD_c_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(c) {
  sc_in<bool> p;
  sc_in<bool> clk;

  SC_CTOR(c) {
    dont_initialize();
  }
};

#endif
