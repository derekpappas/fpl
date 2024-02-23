// Copyright 2003 Star Galaxy Publishing
// File: half_adder2.cpp

#include "systemc.h"

SC_MODULE (half_adder) {
  sc_in<bool> a, b;

  sc_out<bool> sum, carry;

  void prc_half_adder () {
    sum = a ^ b;
    carry = a & b;
  };

  SC_CTOR (half_adder) {
    SC_METHOD (prc_half_adder);
    sensitive << a << b;
  }
};
