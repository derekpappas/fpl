// Copyright 2003 Star Galaxy Publishing
// File: filter.h

#include "systemc.h"

const int PRECISION =16;

SC_MODULE (filter) {
  sc_in<sc_uint<PRECISION> > xin, xd1, xd2, xd3;
  sc_in<bool> clk;

  sc_out<sc_uint<PRECISION> > yout;

  void prc_filter();

  SC_CTOR (filter) {
    SC_THREAD (prc_filter);
    sensitive_pos << clk;
  }
};
