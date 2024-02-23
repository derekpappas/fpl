// Copyright 2003 Star Galaxy Publishing
// File: gang_ffs.h

#include "systemc.h"

const int WIDTH = 4;

SC_MODULE (gang_ffs) {
  sc_in<sc_uint<WIDTH> > current_state;
  sc_in<bool> clock;

  sc_out<sc_uint<WIDTH> > next_state;

  void prc_gang_ffs();

  SC_CTOR (gang_ffs) {
    SC_METHOD (prc_gang_ffs);
    sensitive_neg << clock;
  }
};
