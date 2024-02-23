// Copyright 2003 Star Galaxy Publishing
// File: reg_spsr.h

#include <string>
#include "systemc.h"
#include "dff.h"

#define REG_SIZE 8

SC_MODULE(reg_spsr) {
  sc_in< bool > clk;
  sc_in< bool > reset;
  sc_in< bool > d_in [REG_SIZE];
  sc_out< bool > d_out [REG_SIZE];

  dff *udff[REG_SIZE];
  int i;
  string ff_name;

  SC_CTOR (reg_spsr) {
    for (i=0; i<REG_SIZE; i++) {
      ff_name = "udff" + i;
      udff[i] = new dff (ff_name.c_str());
      (*udff[i]) (clk, reset, d_in[i], d_out[i]);
    }
  }
};
