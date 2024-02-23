// Copyright 2003 Star Galaxy Publishing
// File: generic_alu.cpp

#include "generic_alu.h"

void generic_alu::prc_alu() {
  sc_lv<DATA_SIZE> allxs (sc_logic_X);

  switch (select) {
    case add_op: 
      z = (enable_mask & 0x1) ? a.read() + b.read(): allxs; break;
    case sub_op: 
      z = (enable_mask & 0x2) ? a.read() - b.read(): allxs; break;
    case mul_op: 
      z = (enable_mask & 0x4) ? a.read() * b.read(): allxs; break;
    case div_op: 
      z = (enable_mask & 0x8) ? a.read() / b.read(): allxs; break;
  }
}
