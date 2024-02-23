// Copyright 2003 Star Galaxy Publishing
// File: read_vectors2.h

#include <iostream.h>
#include <fstream.h>
#include "systemc.h"
#include "usr_define.h"

SC_MODULE (read_vectors) {
  sc_in<bool> read_clk;

  sc_out<sc_uint<SEL_WIDTH> > read_sel_op;
  sc_out<bool> read_clear, read_left_in, read_right_in;
  sc_out<sc_uint<WIDTH> > read_data_in, read_usr_out;

  void prc_read_vectors();

  // Member variable:
  ifstream infile;

  SC_CTOR (read_vectors) {
    SC_THREAD(prc_read_vectors);
    sensitive_neg << read_clk;

    infile.open ("usr.in");

    if (!infile) {
      cerr << "**** ERROR: Unable to open input " << "vector file, usr.in" << endl;
      sc_stop();
    }
  }

  // Close the file in the destructor:
  ~ read_vectors() {
    infile.close();
  }
};
