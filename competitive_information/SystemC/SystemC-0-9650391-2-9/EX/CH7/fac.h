// Copyright 2003 Star Galaxy Publishing
// File: fac.h

#include "systemc.h"

const int DATA_SIZE = 5;
const int OUT_SIZE = 8;

SC_MODULE (fac) {
  sc_in<bool> reset, start, clk;
  sc_in<sc_uint<DATA_SIZE> > data;

  sc_out<bool> done;
  sc_out<sc_uint<OUT_SIZE> > fac_out, exp_out;

  sc_signal<sc_uint<DATA_SIZE> > inlatch;

  void prc_fac();

  SC_CTOR (fac) {
    SC_METHOD (prc_fac);
    sensitive_pos << clk;
  }
};
