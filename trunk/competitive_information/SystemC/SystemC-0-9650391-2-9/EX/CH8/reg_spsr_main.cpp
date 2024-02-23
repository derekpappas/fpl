// Copyright 2003 Star Galaxy Publishing
// File: reh_spsr_main.cpp

#include "reg_spsr.h"

int sc_main(int argc, char *argv[]) {
  // Sets the time value resolution:
  sc_set_time_resolution (1, SC_NS);

  sc_clock clk("clk", 2, SC_NS);

  sc_signal<bool> reg_in[REG_SIZE];
  sc_signal<bool> reg_out[REG_SIZE];
  sc_signal<bool> clear;

  reg_spsr ureg_spsr("ureg_spsr");
  ureg_spsr.clk(clk);
  ureg_spsr.reset(clear);

  for (int j=0; j<REG_SIZE; j++) {
    ureg_spsr.d_in[j](reg_in[j]);
    ureg_spsr.d_out[j] (reg_out[j]);
  }

  // clear reg:
  clear = 1;
  sc_start(10, SC_NS);
  clear = 0;
  sc_start(10, SC_NS);

  // check output:
  for (int j=0; j<REG_SIZE; j++)
    if (reg_out[j] != 0)
      cerr << "Reg bit " << j << " not cleared." << endl;

  clear = 1;

  // Load value (all 1's):
  for (int j=0; j<REG_SIZE; j++)
    reg_in[j] = 1;
  
  // Continue simlation for few clock cycles:
  sc_start(10, SC_NS);

  // check output:
  for (int j=0; j<REG_SIZE; j++)
    if (reg_out[j] != 1)
      cerr << "Reg bit " << j << " not set to 1 (it is " << reg_out[j] << ") at time " << sc_time_stamp() << endl;

  return 0;
}
