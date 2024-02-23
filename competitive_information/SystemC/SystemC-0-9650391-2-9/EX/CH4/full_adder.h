// Copyright 2003 Star Galaxy Publishing
// File: full_adder.h

#include "systemc.h"

SC_MODULE (full_adder) {
  sc_in<bool> a, b, cin;

  sc_out<bool> sum, cout;

  void prc_full_adder();

  SC_CTOR (full_adder) {
    SC_METHOD (prc_full_adder);
    sensitive << a << b << cin;
  }
};
