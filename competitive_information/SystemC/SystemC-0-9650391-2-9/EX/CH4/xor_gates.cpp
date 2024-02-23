// Copyright 2003 Star Galaxy Publishing
// File: xor_gates.cpp

#include "xor_gates.h"

void xor_gates::prc_xor_gates() {
  // tap = bre ^ sty;
  tap = bre.read() ^ sty.read();
  count_done.write(0);
}
