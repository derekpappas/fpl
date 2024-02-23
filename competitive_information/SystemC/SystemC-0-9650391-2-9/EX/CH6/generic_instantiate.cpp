// Copyright 2003 Star Galaxy Publishing
// File: generic_instantiate.cpp

#include "generic_instantiate.h"

void generic_instantiate::prc_xor() {
  rsq = and2out ^ and4out;
}

void generic_instantiate::prc_splitter() {
  sc_uint<WIDTH> temp;

  temp = tsq.read();
  t2 = temp.range(0, 1);
  t4 = temp.range(2, 5);
}
