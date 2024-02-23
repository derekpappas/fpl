// Copyright 2003 Star Galaxy Publishing
// File: signed_adder.h

#include "systemc.h"

SC_MODULE (signed_adder) {
  sc_in<sc_int<4> > arb, tbe;

  sc_out<sc_int<5> > sum;

  void prc_signed_adder();

  SC_CTOR (signed_adder) {
    SC_METHOD (prc_signed_adder);
    sensitive << arb << tbe;
  }
};
