// Copyright 2003 Star Galaxy Publishing
// File: state_update.h

#include "systemc.h"

enum states {s0, s1, s2, s3};
const int Z_SIZE = 2;

SC_MODULE (state_update) {
  sc_in<states> current_state;

  sc_out<sc_uint<Z_SIZE> > z;

  void prc_state_update();

  SC_CTOR (state_update) {
    SC_METHOD (prc_state_update);
    sensitive << current_state;
  }
};
