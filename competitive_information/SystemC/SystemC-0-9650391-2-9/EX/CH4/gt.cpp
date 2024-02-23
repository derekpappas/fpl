// Copyright 2003 Star Galaxy Publishing
// File: gt.cpp

#include "gt.h"

void gt::prc_gt() {
  sc_uint<WIDTH> atemp, btemp;

  atemp = a.read();
  btemp = b.read();

  z = sc_uint<WIDTH>(atemp.range(WIDTH/2-1, 0)) > sc_uint<WIDTH>(btemp.range(WIDTH-1, WIDTH/2));
  // z = atemp.range(WIDTH/2-1, 0) > btemp.range(WIDTH-1, WIDTH/2);
}
