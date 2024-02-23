// Copyright 2003 Star Galaxy Publishing
// File: full_adder_driver.h

#include <iostream.h>
#include <fstream.h>
#include "systemc.h"

SC_MODULE (driver) {
  sc_out<bool> d_a, d_b, d_cin;

  bool t_a, t_b, t_cin;

  ifstream infile;

  void driver_prc ();

  SC_CTOR (driver) {
    SC_THREAD (driver_prc);
    infile.open("full_adder.in");

    if (! infile) {
      cerr << "ERROR: Unable to open vector file," << " fa_with_ha.in!\n";
      sc_stop();
    }
  }

  // Close the file in the destructor:
  ~ driver () {
    infile.close();
  }
};
