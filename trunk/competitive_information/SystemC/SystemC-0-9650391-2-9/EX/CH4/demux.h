// Copyright 2003 Star Galaxy Publishing
// File: demux.h

#include "systemc.h"

const int IN_WIDTH = 2;
const int OUT_WIDTH = 4;

SC_MODULE (demux) {
  sc_in<sc_uint<IN_WIDTH> > a;

  sc_out<sc_uint<OUT_WIDTH> > z;

  void prc_demux();

  SC_CTOR (demux) {
    SC_METHOD (prc_demux);
    sensitive << a;
  }
};
