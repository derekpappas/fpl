// Copyright 2003 Star Galaxy Publishing
// File: check_results.h

#include <iostream.h>
#include "systemc.h"
#include "usr_define.h"

SC_MODULE (check_results) {
  sc_in<bool> check_clk;
  sc_in<sc_uint<WIDTH> > expected_out, actual_out;

  void prc_check_results();

  SC_CTOR (check_results) {
    SC_METHOD (prc_check_results);
    sensitive_neg << check_clk;
  }
};
