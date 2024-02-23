// Copyright 2003 Star Galaxy Publishing
// File: half_adder.cpp

#include "half_adder.h"

void half_adder::half_adder_process () {
  sum = a ^ b;
  carry = a & b;
};
