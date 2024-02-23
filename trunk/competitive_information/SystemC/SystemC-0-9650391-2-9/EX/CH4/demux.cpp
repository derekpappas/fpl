// Copyright 2003 Star Galaxy Publishing
// File: demux.cpp

#include "demux.h"

void demux::prc_demux() {
  sc_uint<3> j;
  sc_uint<OUT_WIDTH> temp;

  /*
  for (j=0; j<OUT_WIDTH; j++)
    if (a == j)
      temp[j] = 1;
    else
      temp[j] = 0;
  */

  j=0;
  if (a == j) temp[j] = 1; else temp[j] = 0;

  j=1;
  if (a == j) temp[j] = 1; else temp[j] = 0;

  j=2;
  if (a == j) temp[j] = 1; else temp[j] = 0;

  j=3;
  if (a == j) temp[j] = 1; else temp[j] = 0;

  z = temp;
}
