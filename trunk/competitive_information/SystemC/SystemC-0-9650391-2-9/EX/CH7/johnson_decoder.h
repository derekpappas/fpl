// Copyright 2003 Star Galaxy Publishing
// File: johnson_decoder.h

#include "systemc.h"

const int NBITS =3;
const int TWICENBITS = 2*NBITS;

SC_MODULE (johnson_decoder) {
  sc_in<sc_uint<NBITS> > sel;
  sc_in<bool> enable;

  sc_out<sc_uint<TWICENBITS> > y;

  void prc_decoder();

  SC_CTOR (johnson_decoder) {
    SC_METHOD (prc_decoder);
    sensitive << sel << enable;
  }
};
