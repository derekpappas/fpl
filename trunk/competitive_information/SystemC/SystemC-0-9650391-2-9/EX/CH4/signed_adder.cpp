// Copyright 2003 Star Galaxy Publishing
// File: signed_adder.cpp

#include "signed_adder.h"

void signed_adder::prc_signed_adder() {
  sum = arb.read() + tbe.read();
}
