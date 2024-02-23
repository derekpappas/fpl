// Copyright 2003 Star Galaxy Publishing
// File: unsigned_adder.cpp

#include "unsigned_adder.h"

void unsigned_adder::prc_unsigned_adder() {
  sum = arb.read() + tbe.read();
}
