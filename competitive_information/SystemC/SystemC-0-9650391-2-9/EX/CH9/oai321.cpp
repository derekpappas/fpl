// Copyright 2003 Star Galaxy Publishing
// File: oai321.cpp

#include "oai321.h"

void oai321::prc_oai321() {
  bool temp_z;

  while (true) {
    // Wait for an event in the sensitivity list.
    wait();
    temp_z = ~((a1 || a2 || a3) && (b1 || b2) && c);
    wait (GATE_DELAY, SC_NS);
    z = temp_z;
 }
}
