// Copyright 2003 Star Galaxy Publishing
// File: driver_bank_noff.h

#include "systemc.h"

const int BUS_SIZE = 4;

SC_MODULE (driver_bank_noff) {
  sc_in<bool> clock, read_state;
  sc_in<sc_lv<BUS_SIZE> > cpu_bus;

  sc_out<sc_lv<BUS_SIZE> > main_bus;

  void ff_logic();
  void z_logic();

  sc_signal<sc_lv<BUS_SIZE> > saved_value;

  SC_CTOR (driver_bank_noff) {
    // This is a synchronous process:
    SC_METHOD (ff_logic);
    sensitive_pos << clock;

    // This is a combinational process:
    SC_METHOD (z_logic);
    sensitive << saved_value << read_state;
  }
};
