// Copyright 2003 Star Galaxy Publishing
// File: sync_mux41.h

#include "systemc.h"

SC_MODULE(sync_mux41) {
  sc_in<bool> clock, reset;
  sc_in<sc_uint<2> > sel;
  sc_in<sc_uint<4> > inp;

  sc_out<bool> out;

  void prc_sync_mux41();

  SC_CTOR(sync_mux41) {
    SC_METHOD(prc_sync_mux41);
    sensitive_pos << clock;
    sensitive_neg << reset;
  }
};
