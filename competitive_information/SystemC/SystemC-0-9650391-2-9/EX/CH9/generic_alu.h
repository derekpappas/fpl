// Copyright 2003 Star Galaxy Publishing
// File: generic_alu.h

#include "systemc.h"

const int DATA_SIZE = 8;
const int NUM_OPS= 4;
enum op_type {add_op, sub_op, mul_op, div_op};

SC_MODULE (generic_alu) {
  sc_in<sc_uint<DATA_SIZE> > a, b;
  sc_in<op_type> select;

  // Output has to be of the logic vector type since it 
  // can have the value 'X'.

  sc_out<sc_lv<DATA_SIZE> > z;

  // Member variable controls the kind of ALU:
  sc_uint<NUM_OPS> enable_mask;

  void prc_alu();

  SC_CTOR (generic_alu) {
    SC_METHOD (prc_alu);
    sensitive << a << b;
    enable_mask = 0xF;
  }
};
