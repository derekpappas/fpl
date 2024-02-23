// Copyright 2003 Star Galaxy Publishing
// File: large_static.h

#include "systemc.h"

SC_MODULE (large_static) {
  sc_in<bool> stat, bus1, ucint, adr_match, spi_clk, usb_rdy;
  // . . .

  void event_process();
  void another_process();

  sc_event static_list_event;

  SC_CTOR (large_static) {
    SC_METHOD (event_process);
    sensitive << stat << bus1 << ucint << adr_match;

    SC_THREAD (another_process);
    sensitive << spi_clk << usb_rdy;
  }
};
