// Copyright 2003 Star Galaxy Publishing
// File: pulse.cpp

#include "pulse.h"

void pulse::prc_pulse() {
  pulse_out = 0; 

  while (true) {
    wait(); 

    // Wait for positive edge of clock;
    wait (DELAY);
    pulse_out = 1;
    wait (ON_DURATION);
    pulse_out = 0;
  }
}
