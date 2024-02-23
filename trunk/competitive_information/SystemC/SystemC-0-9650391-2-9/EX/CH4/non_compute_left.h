// Copyright 2003 Star Galaxy Publishing
// File: non_compute_left.h

#include "systemc.h"

const int DSIZE = 4;
const int ISIZE = 2;

SC_MODULE (non_compute_left) {
  sc_in<bool> store;
  sc_in<sc_uint<ISIZE> > addr;

  sc_out<sc_uint<DSIZE> > mem;

  void prc_non_compute_left();

  SC_CTOR (non_compute_left) {
    SC_METHOD (prc_non_compute_left);
    sensitive << store << addr;
  }
};
