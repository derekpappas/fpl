// Copyright 2003 Star Galaxy Publishing
// File: alu.h

#include "systemc.h"

const int WORD = 2;
enum op_type {add, subtract, multiply, divide};

SC_MODULE (alu) {
  sc_in<sc_uint<WORD> > a, b;
  sc_in<op_type> op;

  sc_out<sc_uint<WORD> > z;

  void prc_alu();

  SC_CTOR (alu) {
    SC_METHOD(prc_alu);
    sensitive << a << b << op;
  }
};
