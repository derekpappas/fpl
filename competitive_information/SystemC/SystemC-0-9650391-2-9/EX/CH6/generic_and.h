// Copyright 2003 Star Galaxy Publishing
// File: generic_and.h

#include "systemc.h"

template <int size>
SC_MODULE (generic_and) {
  sc_in<sc_uint<size> > a;

  sc_out<bool> z;

  void prc_generic_and();

  SC_CTOR (generic_and) {
    SC_METHOD (prc_generic_and);
    sensitive << a;
  }
};

template <int size>
void generic_and<size>::prc_generic_and() {
  sc_bv<size> bv_temp; 

  bv_temp = a.read();
  z = bv_temp.and_reduce();
}
