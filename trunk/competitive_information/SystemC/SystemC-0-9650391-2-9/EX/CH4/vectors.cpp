// Copyright 2003 Star Galaxy Publishing
// File: vectors.cpp

#include "vectors.h"

void vectors::prc_vectors () {
  sc_uint<SIZE> atemp, btemp, ctemp, dtemp, r1, r0, ztemp;
  sc_uint<SIZE> reg_bank[TWOD];

  atemp = a.read();
  btemp = b.read();
  ctemp = c.read();
  dtemp = d.read();

  // First set:
  // ztemp = zcat.read();
  ztemp.range(3, 1) = (atemp[2], ctemp.range(3, 2));
  ztemp[0] = btemp[0];
  zcat = ztemp;

  // Second set:
  reg_bank[1] = ctemp & dtemp;
  reg_bank[0] = atemp | btemp;

  // Third set:
  r1 = reg_bank[1];
  r0 = reg_bank[0];
  membit_x = (r1[3] & r0[3]) | (r1[2] & r0[2]);
}
