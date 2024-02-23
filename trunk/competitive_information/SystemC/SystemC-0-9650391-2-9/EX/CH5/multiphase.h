// Copyright 2003 Star Galaxy Publishing
// File: multiphase.h

#include "systemc.h"

SC_MODULE (multiphase) {
  sc_in<bool> zclk, a, b, c;

  sc_out<bool> e;

  void prc_rising();
  void prc_falling();

  sc_signal<bool> d;

  SC_CTOR (multiphase) {
    SC_METHOD (prc_rising);
    sensitive_pos << zclk;

    SC_METHOD (prc_falling);
    sensitive_neg << zclk;
  }
};
