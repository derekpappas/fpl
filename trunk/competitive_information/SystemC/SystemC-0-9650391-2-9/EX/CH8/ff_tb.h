// Copyright 2003 Star Galaxy Publishing
// File: ff_tb.h

#include "systemc.h"
#include "ff_define.h"

SC_MODULE(ff_tb) {
  sc_in<bool> clk;
  sc_in<sc_uint<SIZE> > data_out;

  sc_out<bool> reset;
  sc_out<sc_uint<SIZE> > data;

  void test();
  void check();

  SC_CTOR(ff_tb) {
    SC_THREAD(test);
    sensitive_pos << clk;

    SC_METHOD(check);
    sensitive << data_out;
  }
};
