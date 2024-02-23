// Copyright 2003 Star Galaxy Publishing
// File: non_compute_left.cpp

#include "non_compute_left.h"

void non_compute_left::prc_non_compute_left () {
  sc_uint<DSIZE> mem_temp;
  sc_uint<ISIZE> addr_temp;

  addr_temp = addr.read();
  mem_temp [addr_temp] = store;
  mem = mem_temp;
} 
