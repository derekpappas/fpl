// Copyright 2003 Star Galaxy Publishing
// File: main.cpp

#include "read_vectors2.h"
#include "check_results.h"
#include "usr.h"

// Include for design under test.

int sc_main (int argc, char *argv[]) {
  sc_signal<bool> clear, left_in, right_in;
  sc_signal<sc_uint<SEL_WIDTH> > sel_op;
  sc_signal<sc_uint<WIDTH> > data_in, usr_out, expected_usr_out;

  // Generate clock:
  sc_clock clock ("usr_clock", 2);

  // Instantiate design under test before applying stimulus:
  usr u1 ("usr_u1");
  u1.clk (clock);
  u1.clr (clear);
  u1.lin (left_in);
  u1.rin (right_in);
  u1.select (sel_op);
  u1.par_in (data_in);
  u1.q(usr_out);

  // Instantiate read vectors:
  read_vectors rv ("read_vectors_rv");
  rv.read_clk (clock);
  rv.read_clear(clear);
  rv.read_left_in (left_in);
  rv.read_right_in (right_in);
  rv.read_sel_op (sel_op);
  rv.read_data_in (data_in);
  rv.read_usr_out (expected_usr_out);

  // Instantiate checking module:
  check_results cr1 ("check_results_cr1");
  cr1.check_clk (clock);
  cr1.expected_out (expected_usr_out);
  cr1.actual_out (usr_out);

  // Tracing:
  sc_trace_file *tf = sc_create_wif_trace_file ("usrout");
  sc_trace (tf, clock, "clock");
  sc_trace (tf, clear, "clear");
  sc_trace (tf, left_in, "left_in");
  sc_trace (tf, right_in, "right_in");
  sc_trace (tf, sel_op, "sel_op");
  sc_trace (tf, data_in, "data_in");
  sc_trace (tf, usr_out, "usr_out");

  sc_start (-1); // Run forever. However simulation 
  // stops because of sc_stop() method in module read_vectors.

  sc_close_wif_trace_file (tf);

  return (0);
}
