// Copyright 2003 Star Galaxy Publishing
// File: xor_gates.h

#include "systemc.h"

const int SIZE = 4;

SC_MODULE (xor_gates) {
  sc_in<sc_uint<SIZE> > bre, sty;

  sc_out<sc_uint<SIZE> > tap;
  sc_out<bool> count_done;

  void prc_xor_gates();

  SC_CTOR (xor_gates) {
    SC_METHOD (prc_xor_gates);
    sensitive << bre << sty;
  }
};

