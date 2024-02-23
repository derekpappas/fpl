// Copyright 2003 Star Galaxy Publishing
// File: sync_mux41_driver.cpp

#include "sync_mux41_driver.h"

void driver::prc_driver() {
  d_reset = 1;
  wait (7, SC_NS);
  d_reset = 0;

  for (int i=0; i<=20; i++) {
    d_inp = i;

    for (int j=0; j<=3; j++) {
      d_sel = j;
      wait (5, SC_NS);
    }
  }
}
