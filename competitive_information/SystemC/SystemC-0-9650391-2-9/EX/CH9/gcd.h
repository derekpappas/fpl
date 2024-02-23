// Copyright 2003 Star Galaxy Publishing
// File: gcd.h

#include "systemc.h"

const int WIDTH = 16;

SC_MODULE (gcd) {
  sc_in<sc_uint<WIDTH> > first, second;
  sc_in<bool> reset;

  sc_out<sc_uint<WIDTH> > result;

  void prc_gcd();

  SC_CTOR (gcd) {
    SC_METHOD(prc_gcd);
    sensitive << first << second << reset;
  }
};

