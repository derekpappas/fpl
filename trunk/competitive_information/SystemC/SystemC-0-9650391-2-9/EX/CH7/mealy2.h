// Copyright 2003 Star Galaxy Publishing
// File: mealy2.h

#include "systemc.h"

SC_MODULE (mealy2) {
  sc_in<bool> clock, resetn, a, b, c, d;

  sc_out<bool> out1, out2;

  enum states {state0=0x0, state1=0x2, state2=0x3, state3=0x7, state4=0x5};

  sc_signal<states> curr_state, nxt_state;

  void prc_comb_logic();
  void prc_state();

  SC_CTOR (mealy2) {
    SC_METHOD (prc_state);
    sensitive_pos << clock;
    sensitive_neg << resetn; // Asynchronous reset.

    SC_METHOD (prc_comb_logic);
    sensitive << nxt_state << a << b << c << d;
  }
};
