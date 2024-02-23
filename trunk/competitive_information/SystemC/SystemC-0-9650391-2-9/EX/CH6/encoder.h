// Copyright 2003 Star Galaxy Publishing
// File: encoder.h

#include "systemc.h"

const int IN_SIZE = 8;
const int OUT_SIZE = 3;

SC_MODULE (encoder) {
  sc_in<sc_uint<IN_SIZE> > data;

  sc_out<sc_lv<OUT_SIZE> > yout;

  void prc_encoder();

  SC_CTOR (encoder) {
    SC_METHOD (prc_encoder);
    sensitive << data;
  }
};
