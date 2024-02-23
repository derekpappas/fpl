// Copyright 2003 Star Galaxy Publishing
// File: ripple.cpp



// File: toggle.h
#include "systemc.h"
SC_MODULE (toggle_ff) {
  sc_in<bool> pc, clk;
  sc_out<bool> z;
  void process_toggle_ff();

  SC_CTOR (toggle_ff) {
    SC_METHOD (process_toggle_ff);
    sensitive_pos << clk;
    sensitive_neg << pc;
  }
};

// File: toggle.cpp
// #include "toggle.h"
void toggle_ff::process_toggle_ff(0 {
  if (!pc)
    z = 0;
  else
    z = !z;
}

// File: ripple.h
#define SIZE 4
SC_MODULE (ripple) {
  sc_in<bool> clear, count;
  sc_out<sc_uint<SIZE> > q;

  SC_CTOR (ripple) {
    for (i=0; i<SIZE; i++) {
      if (i == 0) {
        toggle_ff t1 ("toggle_ff_t1");
        t1.pc (clear);
        t1.pc (count);
        t1.z (ct[i]);
      else {
        toggle_ff t2 ("toggle_ff_t1");
        t2.pc (clear);
        t2.pc (count);
        t2.z (ct[i]);
      }
    }
  }
};
