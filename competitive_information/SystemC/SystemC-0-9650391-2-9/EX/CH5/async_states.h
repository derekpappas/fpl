// Copyright 2003 Star Galaxy Publishing
// File: async_states.h

#include "systemc.h"

const int STATE_BITS =4;

SC_MODULE (async_states) {
  sc_in<bool> clk, reset, set;
  sc_in<sc_uint<STATE_BITS> > current_state;

  sc_out<sc_uint<STATE_BITS> > next_state;

  void prc_async_states ();

  SC_CTOR (async_states) {
    SC_METHOD (prc_async_states);
    // Negative edge clock and active low reset:
    sensitive_neg << clk << reset;
    sensitive_pos << set;
    // Active high set.
  }
};
