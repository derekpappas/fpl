// Copyright 2003 Star Galaxy Publishing
// File: myclock.cpp

#include "myclock.h"

void myclock::prc_myclock() {
  clk_out = START_VALUE;
  wait (INITIAL_DELAY, SC_NS);

  while (1) {
    clk_out = ! clk_out;
    wait (FIRST_DELAY, SC_NS);
    clk_out = ! clk_out;
    wait (SECOND_DELAY, SC_NS);
  }
}
