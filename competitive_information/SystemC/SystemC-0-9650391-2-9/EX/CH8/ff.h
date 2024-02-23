// Copyright 2003 Star Galaxy Publishing
// File: ff.h

#include "systemc.h"
#include "ff_define.h"

SC_MODULE(ff) {
  sc_in< bool > clk;
  sc_in< bool > reset;
  sc_in< sc_uint<SIZE> > data;

  sc_out< sc_uint<SIZE> > data_out;

  void prc_ff();

  SC_CTOR (ff) {
    SC_METHOD (prc_ff);
    sensitive_pos << clk << reset;
  }
};
