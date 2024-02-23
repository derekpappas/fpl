// Copyright 2003 Star Galaxy Publishing
// File: vectors.h

#include "systemc.h"

const int SIZE = 4;
const int TWOD = 2;

SC_MODULE (vectors) {
  sc_in<sc_uint<SIZE> > a, b, c, d;

  sc_out<sc_uint<SIZE> > zcat;
  sc_out<bool> membit_x;

  // sc_signal<sc_uint<SIZE> > reg_bank[TWOD];

  void prc_vectors();

  SC_CTOR (vectors) {
    SC_METHOD (prc_vectors);
    sensitive << a << b << c << d;
  }
};
