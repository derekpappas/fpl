// Copyright 2003 Star Galaxy Publishing
// File: full_adder_driver.cpp

#include "full_adder_driver.h"

void driver::driver_prc() {
  sc_time apply_delay (5, SC_NS);

  // Open file and read from first line:
  while (infile >> t_a >> t_b >> t_cin) {
    d_a.write(t_a);
    d_b.write(t_b);
    d_cin.write(t_cin);

    wait (apply_delay);
  }
}
