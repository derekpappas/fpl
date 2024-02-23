// Copyright 2003 Star Galaxy Publishing
// File: latched_alu.h

#include "systemc.h"

SC_MODULE (latched_alu) {
  sc_in<bool> clk, a, b;

  sc_out<bool> z;

  void prc_alu();

  SC_CTOR (latched_alu) {
    SC_METHOD (prc_alu);
    sensitive << clk << a << b;
  }
};
