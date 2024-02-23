// Copyright 2003 Star Galaxy Publishing
// File: var_sig.h

// Example highlights differences between variable 
// and signal assignments:

#include "systemc.h"

SC_MODULE (var_sig) {
  sc_in<bool> clk_a, tmq;

  sc_out<bool> bds_1, bds_2, bds_3;

  sc_signal<bool> qst_2;

  void var_sig_1();
  void var_sig_2();
  void var_sig_3();

  SC_CTOR (var_sig) {
    SC_METHOD (var_sig_1);
    sensitive_pos << clk_a;

    SC_METHOD (var_sig_2);
    sensitive_pos << clk_a;

    SC_METHOD (var_sig_3);
    sensitive << qst_2;
  }
};
