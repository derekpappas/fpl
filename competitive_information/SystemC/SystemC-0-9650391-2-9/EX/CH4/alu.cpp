// Copyright 2003 Star Galaxy Publishing
// File: alu.cpp

#include "alu.h"

void alu::prc_alu() {
  sc_uint<WORD> ta, tb;

  ta = a.read();
  tb = b.read();

  /*
  switch (op) {
    case add : z = ta + tb; break;
    case subtract: z = ta - tb; break;
    case multiply: z = ta * tb; break;
    case divide: z = ta / tb; break;
  }
  */

  if (op == add)
    z = ta + tb;
  else if (op == subtract)
    z = ta - tb;
  else if (op == multiply)
    z = ta * tb;
  else if (op == divide)
    z = ta / tb;
}
