// Copyright 2003 Star Galaxy Publishing
// File: sctime.cpp

#include "systemc.h"

int sc_main (int argc, char *argv[]) {
  sc_clock mclk ("mclk", 10, 0.2, 5, false);

  sc_start (89, SC_NS);

  sc_time curr_time = sc_time_stamp();

  cout << "As double:" << curr_time.to_double() << endl;

  cout << "In seconds:" << curr_time.to_seconds() << endl;
 
  cout << "In default time units:" << curr_time.to_default_time_units() << endl;
 
  cout << "As string:" << curr_time.to_string() << endl;

  cout << "sc_simulation_time():" << sc_simulation_time() << endl;

  cout << "sc_time_stamp():" << sc_time_stamp() << endl;

  // sc_cycle (20, SC_NS);

  printf ("Simulation time is %5.12f\n", (float) sc_time_stamp().to_seconds());
  // printf ("Simulation time is %5.12f\n", (float) curr_time.to_seconds());

  return 0;
}
