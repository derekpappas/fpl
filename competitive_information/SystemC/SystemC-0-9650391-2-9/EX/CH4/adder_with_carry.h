// Copyright 2003 Star Galaxy Publishing
// File: adder_with_carry.h

#include "systemc.h"

SC_MODULE (adder_with_carry) {
  sc_in<sc_int<4> > arb, tbe;

  sc_out<sc_int<4> > sum;
  sc_out<bool> carry_out;

  void prc_adder_with_carry();

  SC_CTOR (adder_with_carry) {
    SC_METHOD (prc_adder_with_carry);
    sensitive << arb << tbe;
  }
};
