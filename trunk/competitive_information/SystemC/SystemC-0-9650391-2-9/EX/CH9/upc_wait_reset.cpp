// Copyright 2003 Star Galaxy Publishing

// EXAMPLE TO BE CHANGED LATER ONCE EQUIVALENT OF SC_CTHREAD IS IMPLEMENTED:
// File: upc_wait_reset.h
#include "systemc.h"
#define SIZE 8
#define INCR_SIZE 3
SC_MODULE (upc_wait_reset) {
  sc_in<bool> cp, res, stop, up, ld;
  sc_in<sc_uint<SIZE> > din;
  sc_in<sc_uint<INCR_SIZE> > incr;
  sc_out<sc_uint<SIZE> > dout;
  void process_upc_wait_reset();

  SC_CTOR (upc_wait_reset) {
    SC_CTHREAD (process_upc_wait_reset, cp.pos());
    watching (res.delayed() == true);
  }
};

// File: upc_wait_reset.cpp
// #include "upc_wait_reset.h"
void upc_wait_reset::process_upc_wait_reset() {
  if (res)
    dout = 0;

  while (1) {
    wait();

    if (ld)
      dout = din;

    while (! stop) {
      wait();

      if (up)
        dout = dout + incr;
      else
        dout = dout - incr;
    }
  }
}
