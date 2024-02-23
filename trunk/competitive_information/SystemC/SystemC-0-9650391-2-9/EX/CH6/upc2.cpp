// Copyright 2003 Star Galaxy Publishing
// File: upc2.cpp

#include "upc2.h"

void upc::misc_logic() {
  bool t01, t12, t13;

  t01 = up_down ^ q0;
  bit11 = t01 ^ qn1;
  t12 = up_down ^ q1;
  t13 = t01 | t12;
  bit21 = t13 ^ qn2;
}
