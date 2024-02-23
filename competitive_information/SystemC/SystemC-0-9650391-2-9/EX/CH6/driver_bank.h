// Copyright 2003 Star Galaxy Publishing
// File: driver_bank.h

#include "systemc.h"

const int BUS_SIZE =4;

SC_MODULE (driver_bank) {
  sc_in<bool> myclk, read_state;
  sc_in<sc_lv<BUS_SIZE> > cpu_bus;

  sc_out<sc_lv<BUS_SIZE> > main_bus;

  void prc_driver_bank();

  SC_CTOR (driver_bank) {
    SC_METHOD (prc_driver_bank);
    sensitive_pos << myclk;
  }
};
