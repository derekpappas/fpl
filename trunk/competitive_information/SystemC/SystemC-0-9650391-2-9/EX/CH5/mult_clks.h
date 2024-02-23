// Copyright 2003 Star Galaxy Publishing
// File: mult_clks.h

#include "systemc.h"

SC_MODULE (mult_clks) {
  sc_in<bool> vt15ck, addclk, adn, resetn, subclr, subn, ds1ck;

  sc_out<bool> ds1_add, ds1_sub;

  void prc_vt15ck();
  void prc_ds1ck();

  sc_signal<bool> add_state, sub_state;

  SC_CTOR (mult_clks) {
    SC_METHOD (prc_vt15ck);
    sensitive_neg << vt15ck;

    SC_METHOD (prc_ds1ck);
    sensitive_pos << ds1ck;
  }
};
