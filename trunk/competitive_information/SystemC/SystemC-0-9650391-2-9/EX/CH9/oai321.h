// Copyright 2003 Star Galaxy Publishing
// File: oai321.h

#include "systemc.h"

#define GATE_DELAY 5

SC_MODULE (oai321) {
  sc_in<bool> a1, a2, a3, b1, b2, c;
  sc_out<bool> z;

  void prc_oai321();

  SC_CTOR (oai321) {
    SC_THREAD(prc_oai321);
    sensitive << a1 << a2 << a3 << b1 << b2 << c;
  }
};

