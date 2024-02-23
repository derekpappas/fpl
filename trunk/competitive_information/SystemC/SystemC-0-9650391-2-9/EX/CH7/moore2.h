// Copyright 2003 Star Galaxy Publishing
// File: moore2.h

#include "systemc.h"

SC_MODULE (moore2) {
  sc_in<bool> a, clk, reset;

  sc_out<bool> z;

  enum state_type {s0, s1, s2, s3};

  sc_signal<state_type> moore_state;

  void prc_states();
  void prc_outputs();

  SC_CTOR (moore2) {
    SC_METHOD (prc_states); // Synchronous.
    sensitive_pos << clk;

    SC_METHOD (prc_outputs); // Combinational.
    sensitive << moore_state;
  }
};
