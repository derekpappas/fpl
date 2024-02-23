// Copyright 2003 Star Galaxy Publishing
// File: simple_alu.h

#include "systemc.h"

const int WORD_SIZE = 4;

SC_MODULE (simple_alu) {
  sc_in<sc_uint<WORD_SIZE> > a, b;
  sc_in<bool> ctrl;

  sc_out<sc_uint<WORD_SIZE> > z;

  void prc_simple_alu();

  SC_CTOR (simple_alu) {
    SC_METHOD (prc_simple_alu);
    sensitive << a << b << ctrl;
  }
};
