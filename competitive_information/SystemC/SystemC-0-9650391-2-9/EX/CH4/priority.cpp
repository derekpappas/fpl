// Copyright 2003 Star Galaxy Publishing
// File: priority.cpp

#include "priority.h"

void priority::prc_priority() {
  sc_uint<INPUT_SIZE> tsel;

  tsel = sel.read();

  if (tsel[0])
    z = 0;
  else if (tsel[1])
    z = 1;
  else if (tsel[2])
    z = 2;
  else if (tsel[3])
    z = 3;
  else
    z = 7;
} 
