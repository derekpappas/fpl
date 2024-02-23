// Copyright 2003 Star Galaxy Publishing
// File: sync_count4.h

#include "systemc.h"

const int COUNT_BITS = 4;

SC_MODULE (sync_count4) {
  sc_in<bool> mclk, preset, updown;
  sc_in<sc_uint<COUNT_BITS> > data_in;

  sc_out<sc_uint<COUNT_BITS> > data_out;

  void prc_counter();

  SC_CTOR (sync_count4) {
    SC_METHOD(prc_counter);
    sensitive_pos << mclk; // Only clock edge specified.
  }
};
