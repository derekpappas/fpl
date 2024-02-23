// Copyright 2003 Star Galaxy Publishing
// File: aoi321.h

// And-Or-Invert 321 combinational logic gate.

#include "systemc.h"

SC_MODULE (aoi321) {
  sc_in<bool> a1, a2, a3, b1, b2, c;

  sc_out<bool> z;

  void aoi321_prc();

  SC_CTOR (aoi321) {
    SC_METHOD (aoi321_prc);
    sensitive << a1 << a2 << a3 << b1 << b2 << c;
  }
};
