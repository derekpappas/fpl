// Copyright 2003 Star Galaxy Publishing
// File: apply_and_check.h

#include "systemc.h"
#include "usr_define.h"

SC_MODULE (apply_and_check) {
  sc_in<sc_uint<WIDTH> > actual_out;

  sc_out<bool> clear, left_in, right_in;
  sc_out<sc_uint<WIDTH> > data_in;
  sc_out<sc_uint<SEL_WIDTH> > sel_op;

  void behavior();

  SC_CTOR (apply_and_check) {
    SC_THREAD (behavior);
  }
};
