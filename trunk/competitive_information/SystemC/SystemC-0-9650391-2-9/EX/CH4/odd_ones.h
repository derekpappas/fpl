// Copyright 2003 Star Galaxy Publishing
// File: odd_ones.h

#include "systemc.h"

const int SIZE = 6;

SC_MODULE (odd_ones) {
  sc_in<sc_uint<SIZE> > data_in;

  sc_out<bool> is_odd;

  bool compute_if_odd (sc_uint<SIZE> abus);

  void prc_odd_ones();

  SC_CTOR (odd_ones) {
    SC_METHOD (prc_odd_ones);
    sensitive << data_in;
  }
};
