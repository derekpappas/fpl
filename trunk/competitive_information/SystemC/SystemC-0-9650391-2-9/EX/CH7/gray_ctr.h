// Copyright 2003 Star Galaxy Publishing
// File: gray_ctr.h

#include "systemc.h"

enum gray_states {s0=0x0, s1=0x1, s2=0x3, s3=0x2, s4=0x6, s5=0x7, s6=0x5, s7=0x4};

SC_MODULE (gray_ctr) {
  sc_in<bool> clk, reset, up_down, hold;

  sc_out<gray_states> gray_count;

  void prc_counter();

  SC_CTOR (gray_ctr) {
    SC_METHOD (prc_counter);
    sensitive_neg << clk << reset;
  }
};
