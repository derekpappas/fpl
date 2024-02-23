// Copyright 2003 Star Galaxy Publishing
// File: full_adder_main.cpp

#include "full_adder_driver.h"
#include "full_adder_monitor.h"
#include "full_adder.h"

int sc_main(int argc, char* argv[]) {
  sc_signal<bool> t_a, t_b, t_cin, t_sum, t_cout;

  full_adder f1 ("FullAdderWithHalfAdder");
  // Positional association:
  f1 << t_a << t_b << t_cin << t_sum << t_cout;

  driver d1 ("GenerateWaveforms");
  d1 << t_a << t_b << t_cin;

  monitor mo1 ("MonitorWaveforms");
  mo1 << t_a << t_b << t_cin << t_sum << t_cout;

  if (! mo1.outfile) {
    cerr << "ERROR: Unable to open output file," << " fa_with_ha.out!\n";
    return (-2);
  }

  sc_trace_file *tf = sc_create_vcd_trace_file ("full_adder");
  sc_trace(tf, t_a,"A");
  sc_trace(tf, t_b, "B");
  sc_trace(tf, t_cin, "CarryIn");
  sc_trace(tf, t_sum, "Sum");
  sc_trace(tf, t_cout, "CarryOut");

  sc_start(100, SC_NS);

  // mo1.outfile.close();

  // d1.infile.close();
  sc_close_vcd_trace_file (tf);

  return(0);
}
