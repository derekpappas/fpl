// Copyright 2003 Star Galaxy Publishing
// File: non_compute_right.cpp

#include "non_compute_right.h"

void non_compute_right::prc_non_compute_right () {
  sc_uint<DSIZE> dtemp;
  sc_uint<ISIZE> itemp;

  dtemp = data.read();
  itemp = index.read();
  dout = dtemp[itemp];
}
