// Copyright 2003 Star Galaxy Publishing
// File: rom.h

#include "systemc.h"

#define DATA_WIDTH 8
#define WORD_DEPTH 5
#define ADDR_WIDTH 10

SC_MODULE (rom) {
  sc_in<bool> clk;
  sc_in<bool> cen;
  sc_in<sc_uint<ADDR_WIDTH> > addr;

  sc_out<sc_uint<DATA_WIDTH> > que;

  void prc_rom();

  SC_CTOR (rom) {
    SC_METHOD(prc_rom);
    sensitive_pos << clk;
  }
};
