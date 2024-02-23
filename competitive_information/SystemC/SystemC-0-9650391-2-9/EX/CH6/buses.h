// Copyright 2003 Star Galaxy Publishing
// File: buses.h

#include "systemc.h"

const int BUS_SIZE= 4;

SC_MODULE (buses) {
  sc_in<bool> a_ready, b_ready;
  sc_in<sc_uint<BUS_SIZE> > a_bus, b_bus;

  sc_out_rv<BUS_SIZE> z_bus; // Resolved port type.

  void prc_a_bus();
  void prc_b_bus();

  SC_CTOR (buses) {
    SC_METHOD (prc_a_bus);
    sensitive << a_ready << a_bus;

    SC_METHOD (prc_b_bus);
    sensitive << b_ready << b_bus;
  }
};
