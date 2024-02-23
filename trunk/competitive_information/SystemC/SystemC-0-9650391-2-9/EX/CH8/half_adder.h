// Copyright 2003 Star Galaxy Publishing
// File: half_adder.h

#include "systemc.h"

SC_MODULE (half_adder) {
  sc_in<bool> a, b;

  sc_out<bool> sum, carry;

  void half_adder_process ();

  SC_CTOR (half_adder) {
    SC_METHOD (half_adder_process);
    sensitive << a << b;
  }
};
