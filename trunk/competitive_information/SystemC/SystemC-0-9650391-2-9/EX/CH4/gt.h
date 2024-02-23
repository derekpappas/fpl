// Copyright 2003 Star Galaxy Publishing
// File: gt.h

#include "systemc.h"

const int WIDTH = 8;

SC_MODULE (gt) {
  sc_in<sc_uint<WIDTH> > a, b;

  sc_out<bool> z;

  void prc_gt();

  SC_CTOR (gt) {
    SC_METHOD (prc_gt);
    sensitive << a << b;
  }
};
