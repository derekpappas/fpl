// Copyright 2003 Star Galaxy Publishing
// File: incr.h

#include "systemc.h"

const int COUNTER_SIZE = 2;

SC_MODULE (incr) {
  sc_in<bool> phy;
  sc_in<sc_uint<COUNTER_SIZE> > one_count;

  sc_out<sc_uint<COUNTER_SIZE> > z;

  // sc_signal<sc_uint<COUNTER_SIZE> > ones;

  void prc_incr();

  SC_CTOR (incr) {
    SC_METHOD (prc_incr);
    sensitive << phy << one_count;
  }
};
