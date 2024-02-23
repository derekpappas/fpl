// Copyright 2003 Star Galaxy Publishing
// File: upc.h

#include "systemc.h"
#include "ff_with_pc.h"

SC_MODULE (upc) {
  sc_in<bool> clk, up_down, pc;

  sc_out<bool> q0, q1, q2;

  void misc_logic();

  // Member variables as pointers to child module:
  ff_with_pc *lq0, *lq1, *lq2;

  // Signals used to connect instances and process:
  sc_signal<bool> qn0, qn1, qn2, bit11, bit21;

  SC_CTOR (upc) {
    // First instance of module ff_with_pc:
    lq0 = new ff_with_pc ("ff_with_pc_lq0");

    // Using named association:
    lq0->clock(clk);
    lq0->din (qn0);
    lq0->preclr (pc);
    lq0->q(q0);
    lq0->notq(qn0);

    // Second instance of module ff_with_pc:
    lq1 = new ff_with_pc ("ff_with_pc_lq1");
    lq1->clock(clk);
    lq1->din (bit11);
    lq1->preclr (pc);
    lq1->q(q1);
    lq1->notq(qn1);

    // Third instance of module ff_with_pc:
    lq2 = new ff_with_pc ("ff_with_pc_lq2");

    // Using positional association:
    (*lq2) (bit21, clk, pc, q2, qn2);

    SC_METHOD (misc_logic);
    sensitive << qn0 << qn1 << qn2;
    sensitive << q0 << up_down << q1;
  }

  ~ upc () {
   delete lq0;
   delete lq1;
   delete lq2;
  }
};
