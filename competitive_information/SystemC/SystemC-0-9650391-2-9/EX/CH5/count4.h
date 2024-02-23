// Copyright 2003 Star Galaxy Publishing
// File: count4.h

#include "systemc.h"

const int COUNT_SIZE = 4;

SC_MODULE (count4) {
  sc_in<bool> mclk, clear, updown;

  sc_out<sc_uint<COUNT_SIZE> > data_out;

  void sync_block();

  SC_CTOR (count4) {
    SC_METHOD(sync_block);
    sensitive_pos << mclk;
    // Positive clock edge.
    sensitive_neg << clear;
    // Negative active clear.
  }
};
