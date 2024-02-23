// Copyright 2003 Star Galaxy Publishing
// File: dump_results.h

#include <iostream.h>
#include <fstream.h>
#include "systemc.h"
#include "usr_define.h"

SC_MODULE (dump_results) {
  sc_in<bool> clock, clear, left_in, right_in;
  sc_in<sc_uint<SEL_WIDTH> > sel_op;
  sc_in<sc_uint<WIDTH> > data_in, data_out;

  // Declare the output stream:
  ofstream outfile;

  void behavior_dump();

  SC_CTOR (dump_results) {
    SC_METHOD (behavior_dump);
    sensitive_neg << clock;

    // Open the output file "mydump.out":
    outfile.open ("mydump.out");
  }
};

