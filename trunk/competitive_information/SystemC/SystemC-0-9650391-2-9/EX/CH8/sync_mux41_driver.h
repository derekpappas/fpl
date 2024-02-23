// Copyright 2003 Star Galaxy Publishing
// File: driver.h

#include "systemc.h"

SC_MODULE (driver) {
  sc_out<bool> d_reset;
  sc_out<sc_uint<2> > d_sel;
  sc_out<sc_uint<4> > d_inp;

  void prc_driver ();

  SC_CTOR (driver) {
    SC_THREAD (prc_driver);
  }
};
