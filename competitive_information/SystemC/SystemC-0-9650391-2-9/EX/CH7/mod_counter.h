// Copyright 2003 Star Galaxy Publishing
// File: mod_counter.h

#include "systemc.h"

const int NBITS =4;
const int UPTO =11;

SC_MODULE (mod_counter) {
  sc_in<bool> clk, clear;

  sc_out<sc_uint<NBITS> > q, qbar;

  sc_signal<sc_uint<NBITS> > counter;

  void prc_counter();
  void prc_outputs();

  SC_CTOR (mod_counter) {
    SC_METHOD (prc_counter); // Synchronous.
    sensitive_pos << clk << clear;

    SC_METHOD (prc_outputs); // Combinational.
    sensitive << counter;
  }
};
