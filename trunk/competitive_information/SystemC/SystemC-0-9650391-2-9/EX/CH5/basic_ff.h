// Copyright 2003 Star Galaxy Publishing
// File: basic_ff.h

#include "systemc.h"

SC_MODULE (basic_ff) {
  sc_in<bool> d, clk;

  sc_out<bool> q;

  void prc_basic_ff();

  SC_CTOR (basic_ff) {
    SC_METHOD (prc_basic_ff);
    sensitive_pos << clk;
    // Edge sensitivity.
  }
};
