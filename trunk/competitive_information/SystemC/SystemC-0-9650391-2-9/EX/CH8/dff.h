// Copyright 2003 Star Galaxy Publishing
// File: dff.h

#include "systemc.h"

SC_MODULE (dff) {
  sc_in<bool> d, clk, reset;

  sc_out<bool> q;

  void prc_dff();

  SC_CTOR (dff) {
    SC_METHOD (prc_dff);
    sensitive_pos << clk;
    // Edge sensitivity.
    sensitive_neg << reset;
  }
};
