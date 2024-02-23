// Copyright 2003 Star Galaxy Publishing
// File: seq_det.h

#include "systemc.h"

SC_MODULE (seq_det) {
  sc_in<bool> clk, data;

  sc_out<bool> seq_found;

  // Synchronous logic process:
  void prc_seq_det();

  // Combinational logic process:
  void prc_output();

  // Interprocess communication signals:
  sc_signal<bool> first, second, third;

  SC_CTOR (seq_det) {
    SC_METHOD (prc_seq_det);
    // Edge sensitivity:
    sensitive_pos << clk;

    SC_METHOD (prc_output);
    // Event sensitivity:
    sensitive << first << second << third;
  }
};
