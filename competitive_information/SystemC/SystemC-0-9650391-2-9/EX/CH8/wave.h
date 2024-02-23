// Copyright 2003 Star Galaxy Publishing
// File: wave.h

#include "systemc.h"

SC_MODULE (wave) {
  sc_out<bool> sig_out;

  void prc_wave();

  SC_CTOR (wave) {
    SC_THREAD (prc_wave);
  }
};
