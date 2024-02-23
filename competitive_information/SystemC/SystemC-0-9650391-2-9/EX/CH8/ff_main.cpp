// Copyright 2003 Star Galaxy Publishing
// File: main.cpp

#include "ff.h"
#include "ff_tb.h"

int sc_main(int argc, char *argv[]) {
  // Sets the time value resolution:
  // sc_set_time_resolution (1, SC_NS);

  sc_clock clk("clk", 2, SC_NS);

  sc_signal<bool> reset;
  sc_signal<sc_uint<SIZE> > data, data_out;

  ff_tb tb("tb");
  tb.clk(clk);
  tb.reset(reset);
  tb.data_out(data_out);
  tb.data(data);

  ff f1 ("ff_f1");
  f1.clk(clk);
  f1.reset(reset);
  f1.data_out(data_out);
  f1.data(data);

  // Start simulation and run forever. Simulation stops
  // due to execution of sc_stop() in module ff_tb.
  sc_start(-1);

  return 0;
}
