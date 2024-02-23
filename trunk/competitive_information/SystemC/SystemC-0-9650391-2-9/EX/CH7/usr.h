// Copyright 2003 Star Galaxy Publishing
// File: usr.h

#include "systemc.h"
#include "usr_define.h"

SC_MODULE (usr) {
  sc_in<bool> clk, clr, lin, rin;
  sc_in<sc_uint<SEL_WIDTH> > select;
  sc_in<sc_uint<WIDTH> > par_in;

  sc_out<sc_uint<WIDTH> > q;

  void prc_usr();

  SC_CTOR (usr) {
    SC_METHOD (prc_usr);
    sensitive_pos << clk;
    sensitive_neg << clr;
  }
};
