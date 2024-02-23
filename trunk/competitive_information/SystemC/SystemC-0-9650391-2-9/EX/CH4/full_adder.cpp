// Copyright 2003 Star Galaxy Publishing
// File: full_adder.cpp

#include "full_adder.h"

void full_adder::prc_full_adder () {
  sum = (a ^ b) ^ cin;
  cout = (a & b) | (a & cin) | (b & cin);
}
