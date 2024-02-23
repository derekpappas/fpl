// Copyright 2003 Star Galaxy Publishing
// File: johnson_ctr.h

#include "systemc.h"

const int NBITS =3;

SC_MODULE (johnson_ctr) {
  sc_in<bool> clk, clear;

  sc_out<sc_uint<NBITS> > q;

  void prc_counter();

  SC_CTOR (johnson_ctr) {
    SC_METHOD (prc_counter); // Synchronous.
    sensitive_pos << clk;
    sensitive_neg << clear;
  }
};
