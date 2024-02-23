// Copyright 2003 Star Galaxy Publishing
// File: main.cpp

#include "specific_alu.h"

int sc_main (int argc, char *argv[]) {   
  // An ALU with all four operations:
  generic_alu g1 ("alu_g1");

  // An ALU with only addition and subtraction:
  specific_alu s1 ("alu_s1", 0x3);

  // An ALU with just multiplication:
  specific_alu s2 ("alu_s2", 0x8);

  return 0;
} 
