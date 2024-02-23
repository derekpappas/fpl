// Copyright 2003 Star Galaxy Publishing
// File: main.cpp

#include "monitor.h"

int sc_main (int argc, char *argv[]) {
  sc_signal<bool> reset, start, finished;
  sc_signal<sc_uint<DATA_SIZE> > in_data;
  sc_signal<sc_uint<OUT_SIZE> > fout, eout;

  sc_clock clock ("clock", 10, SC_NS);

  // Instantiate the factorial model:
  fac f1 ("fac_f1");
  f1.reset (reset);
  f1.start (start);
  f1.clk (clock);
  f1.data (in_data);
  f1.done (finished);
  f1.fac_out (fout);
  f1.exp_out (eout);

  // Instantiate the reactive monitor:
  monitor m1 ("monitor_m1");
  m1.clk(clock);
  m1.reset (reset);
  m1.start (start);
  m1.done (finished);
  m1.data (in_data);
  m1.fac_out(fout);
  m1.exp_out (eout);

  // Start simulation and run forever:
  sc_start (-1);

  return 0;
}
