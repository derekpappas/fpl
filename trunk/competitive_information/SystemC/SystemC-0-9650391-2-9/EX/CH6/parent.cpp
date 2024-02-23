// Copyright 2003 Star Galaxy Publishing
// File: parent.cpp

#include "parent.h"

void parent::split_x () {
  sc_uint<3> tmp_bus;

  tmp_bus = bus_m.read();
  bus_m0 = tmp_bus[0];
  bus_m1 = tmp_bus[1];
  bus_m2 = tmp_bus[2];
}

void parent::merge_z () {
  sc_uint<4> tmp_arith;

  // tmp_arith = arith_bus.read();
  tmp_arith[0] = arith0;
  tmp_arith[1] = arith1;
  tmp_arith[2] = arith2;
  tmp_arith[3] = arith3;

  arith_bus = tmp_arith;
}
