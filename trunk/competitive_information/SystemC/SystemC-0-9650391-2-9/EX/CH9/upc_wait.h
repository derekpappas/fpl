// Copyright 2003 Star Galaxy Publishing
// File: upc_wait.h

#include "systemc.h"

const int SIZE = 8;
const int INCR_SIZE = 3;

SC_MODULE (upc_wait) {
  sc_in<bool> cp, res, stop, up, ld;
  sc_in<sc_uint<SIZE> > din;
  sc_in<sc_uint<INCR_SIZE> > incr;

  sc_out<sc_uint<SIZE> > dout;

  void prc_upc_wait();

  SC_CTOR (upc_wait) {
    SC_THREAD (prc_upc_wait);
    sensitive_pos << cp;
  }
};
