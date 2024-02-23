// Copyright 2003 Star Galaxy Publishing
// File: simple_alu.cpp

#include "simple_alu.h"

void simple_alu::prc_simple_alu() {
  if (ctrl)
    z = a.read() & b.read();
  else
    z = a.read() | b.read();
}
