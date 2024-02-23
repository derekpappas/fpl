// Copyright 2003 Star Galaxy Publishing
// File: monitor.h

#include <math.h>
#include "systemc.h"
#include "../CH7/fac.h"

SC_MODULE (monitor) {
  sc_in<bool> clk, done;
  sc_in<sc_uint<OUT_SIZE> > fac_out, exp_out;

  sc_out<bool> reset, start;
  sc_out<sc_uint<DATA_SIZE> > data;

  void prc_monitor();

  enum state_type {reset_state, start_state, apply_data_state, wait_result_state};

  sc_signal<state_type> next_state;

  SC_CTOR (monitor) {
    SC_THREAD(prc_monitor);
    sensitive_neg << clk;
    sensitive << done;
  }
};
