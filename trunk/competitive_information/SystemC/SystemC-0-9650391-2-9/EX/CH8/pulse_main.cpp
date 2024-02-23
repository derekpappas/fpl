// Copyright 2003 Star Galaxy Publishing
// File: main.cpp

#include "pulse.h"

int sc_main (int argc, char *argv[]) {
  sc_signal<bool> pout;
  sc_trace_file *tf;
  sc_clock clock ("master_clk", 5, SC_NS);

  // Instantiate the pulse module:
  pulse p1 ("pulse_p1");
  p1.clk (clock);
  p1.pulse_out (pout);

  // Specify trace file pulse.vcd and trace signals:
  tf = sc_create_vcd_trace_file ("pulse"); 
  sc_trace (tf, clock, "clock");
  sc_trace (tf, pout, "pulse_out");

  sc_start (100);
  sc_close_vcd_trace_file (tf);
  cout << "Finished at time " << sc_time_stamp() << endl;

  return 0;
}
