// Copyright 2003 Star Galaxy Publishing
//File: unsigned_adder.h

#include "systemc.h"

SC_MODULE (unsigned_adder) {
  sc_in<sc_uint<4> > arb, tbe;

  sc_out<sc_uint<5> > sum;

  void prc_unsigned_adder();

  SC_CTOR (unsigned_adder) {
    SC_METHOD (prc_unsigned_adder);
    sensitive << arb << tbe;
  }
};
