// Copyright 2003 Star Galaxy Publishing
// File: not_equals.h

#include "systemc.h"

const int WIDTH = 4;

SC_MODULE (not_equals) {
  sc_in<sc_int<WIDTH> > a, b;
  sc_out<bool> z;

  void prc_not_equals();

  SC_CTOR (not_equals) {
    SC_METHOD (prc_not_equals);
    sensitive << a << b;
  }
};
