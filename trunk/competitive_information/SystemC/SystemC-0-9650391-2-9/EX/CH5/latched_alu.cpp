// Copyright 2003 Star Galaxy Publishing
// File: latched_alu.cpp

#include "latched_alu.h"

void latched_alu::prc_alu() {
  if (clk)
    z = !(a | b);
}
