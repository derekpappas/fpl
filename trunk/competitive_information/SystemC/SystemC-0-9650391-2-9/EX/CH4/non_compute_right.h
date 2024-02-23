// Copyright 2003 Star Galaxy Publishing
// File: non_compute_right.h

#include "systemc.h"

const int DSIZE =4;
const int ISIZE =2;

SC_MODULE (non_compute_right) {
  sc_in<sc_uint<DSIZE> > data;
  sc_in<sc_uint<ISIZE> > index;

  sc_out<bool> dout;

  void prc_non_compute_right();

  SC_CTOR (non_compute_right) {
    SC_METHOD (prc_non_compute_right);
    sensitive << data << index;
  }
};
