// Copyright 2003 Star Galaxy Publishing
// File: ff_with_pc.h

#include "systemc.h"

SC_MODULE (ff_with_pc) {
  sc_in<bool> din, clock, preclr;

  sc_out<bool> q, notq;

  void prc_ff_with_pc();

  SC_CTOR (ff_with_pc) {
    SC_METHOD (prc_ff_with_pc);
    sensitive_neg << clock;
    sensitive_pos << preclr;
  }
};
