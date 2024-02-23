// Copyright 2003 Star Galaxy Publishing
// File: adder_with_carry.cpp

#include "adder_with_carry.h"

void adder_with_carry::prc_adder_with_carry() {
  sc_int<5> temp;

  temp = arb.read() + tbe.read();
  sum = temp.range (3, 0);
  carry_out = temp[4];
}
