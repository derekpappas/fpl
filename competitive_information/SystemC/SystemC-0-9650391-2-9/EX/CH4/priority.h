// Copyright 2003 Star Galaxy Publishing
// File: priority.h

#include "systemc.h"

const int INPUT_SIZE = 4;
const int OUTPUT_SIZE = 3;

SC_MODULE (priority) {
  sc_in<sc_uint<INPUT_SIZE> > sel;

  sc_out<sc_uint<OUTPUT_SIZE> > z;

  void prc_priority();

  SC_CTOR (priority) {
    SC_METHOD (prc_priority);
    sensitive << sel;
  }
};
