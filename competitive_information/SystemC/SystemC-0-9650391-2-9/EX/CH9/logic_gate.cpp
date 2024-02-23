// Copyright 2003 Star Galaxy Publishing
// File: logic_gate.cpp

#include "logic_gate.h"

void logic_gate::prc_and_gate() {
  z = a & b & c & d;
}

void logic_gate::prc_or_gate() {
  z = a | b | c | d;
}

void logic_gate::prc_nand_gate() {
  z = !(a & b & c & d);
}

void logic_gate::prc_nor_gate() {
  z = !(a | b | c | d);
}

void logic_gate::prc_xor_gate() {
  z = a ^ b ^ c ^ d;
}
