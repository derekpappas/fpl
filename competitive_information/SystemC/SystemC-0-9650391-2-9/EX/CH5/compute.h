// Copyright 2003 Star Galaxy Publishing
// File: compute.h

#include "systemc.h"

const int BITS = 4;
enum grade_type {fail, pass, excellent};

SC_MODULE (compute) {
  sc_in<sc_uint<BITS> > marks;

  sc_out<grade_type> grade;

  void prc_compute();

  SC_CTOR (compute) {
    SC_METHOD (prc_compute);
    sensitive << marks;
  }
};
