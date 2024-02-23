// Copyright 2003 Star Galaxy Publishing
// File: filter.cpp

#include "filter.h"

const int k0 =0x39;
const int k1 =0x50;
const int k2 =0x30;
const int k3 =0x41;

void filter::prc_filter() {
  sc_uint<PRECISION> y1, y2, y3, y4;

  // Keep computing the output:
  while (1) {
    wait();
    y1 = k0 * xin.read();
    wait();
    y2 = k1 * xd1.read();
    wait();
    y3 = y1 + y2;
    wait ();
    y1 = k2 * xd2.read();
    wait();
    y2 = k3 * xd3.read();
    wait();
    y4 = y1 + y2;
    wait();
    yout = y3 + y4;
  }
}
