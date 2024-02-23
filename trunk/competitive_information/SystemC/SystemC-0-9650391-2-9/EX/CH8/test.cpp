// Copyright 2003 Star Galaxy Publishing
// File: test.cpp

#include "systemc.h"

#include "../CH7/tristate_reg.cpp"
#include "../CH7/johnson_ctr.cpp"

#define MAXLEN 8

void sc_trace (sc_trace_file *tfile, bool *v, const sc_string& name, int arg_length) {
  char mybuf[MAXLEN];

  for (int j = 0; j < arg_length; j++) {
    sprintf (mybuf, "[%d]", j);
    sc_trace (tfile, v[j], name+mybuf);
  }
}

// The structure:
struct packet {
  sc_uint<2> packet_id;
  bool packet_state;
};

// The overloaded sc_trace() method for type packet:
void sc_trace (sc_trace_file *tfile, const packet& v, const sc_string& name) {
  sc_trace (tfile, v.packet_id, name + ".packet_id");
  sc_trace (tfile, v.packet_state, name + ".packet_state");
}

template <class T>
void sc_trace (sc_trace_file *tfile, const T array_var[], const sc_string &name, int arg_length) {
  for (int j=0; j <arg_length; j++)
    sc_trace (tfile, array_var[j], name + "." + sc_string::to_string("%d", j));
}

enum fsm_state {IDLE, RESET, COUNT0, COUNT1, COUNT2, COUNT3};
// const char **enum_strings = {"IDLE", "RESET", "COUNT0", "COUNT1", "COUNT2", "COUNT3", 0};
const char *fsm_state_strings[] = {"IDLE", "RESET", "COUNT0", "COUNT1", "COUNT2", "COUNT3"};

void sc_trace (sc_trace_file *tfile, fsm_state curr_state, const sc_string& name, const char *fsm_state_strings[]) {
  sc_trace (tfile, fsm_state_strings[(unsigned int) curr_state], name);
}

#define NUM_BITS 8

// File: main.cpp
// Include files here.

int sc_main (int argc, char *argv[]) {
  sc_set_time_resolution (100, SC_PS);

  // sc_signal declarations here: used to connect the
  // various modules that are instantiated.

  sc_signal<bool> clk, resetn, renable, oenable;
  sc_signal<sc_uint<2> > din;
  sc_signal<sc_uint<3> > qout;
  sc_signal<sc_lv<2> > dout;

  // Design under test, stimulus module and 
  // monitor module instantiations.
  tristate_reg tr1 ("tristate_reg_tr1");
  // Named association:
  tr1.clock (clk);
  tr1.reset (resetn);
  tr1.reg_enable (renable);
  tr1.output_enable (oenable);
  tr1.data_in (din);
  tr1.data_out (dout);

  johnson_ctr jc1 ("johnson_ctr_jc1");
  // Positional association:
  jc1 << clk << resetn << qout;
  // The ports for the Johnson counter are: clk, clear and q.

  sc_time t1 (100, SC_NS); // Specifies the value 100ns.
  sc_time t2 (20, SC_PS); // Specifies the value 20ps.

  // Following two forms are equivalent:
  sc_start (t1); // Run simulation for 100ns.
  sc_start (100, SC_NS);

  sc_cycle (t2);
  sc_clock c1 ("c1", 20.26, SC_NS);

  bool reg_file [NUM_BITS];

  // The aggregate variable:
  // Signal does not work since it needs it other overloaded guys:
  // sc_signal<packet> saved;
  packet saved;

  // sc_clock clock declarations.
  sc_clock rclk ("rclk", 10, SC_NS);

  // NOT WORKING:
  // sc_clock mclk ("mclk", 10, SC_NS, 0.2, 5, false);
  sc_clock mclkA ("mclk", 10, SC_NS, 0.2, 5, SC_NS, false);
  // Does not take TIME as an argument:
  sc_clock mclk ("mclk", 10, 0.2, 5, false);
  sc_clock clka ("clka");

  sc_time period (10, SC_NS);
  sc_time start_time (2, SC_NS);
  sc_clock fclk ("fclk", period, 0.2, start_time, true);

  sc_time mtime (10, SC_NS);
  sc_time m2time (5, SC_NS);
  sc_clock mclk1 ("mclk", mtime, 0.2, m2time, false);

  // Trace file creation and monitoring.
  sc_trace_file *tfile = sc_create_vcd_trace_file ("myvcddump");
  sc_trace_file *pointer_to_trace_file_v = sc_create_vcd_trace_file ("myvcddump");

  // NOT WORKING:
  // sc_trace_file *pointer_to_trace_file_i = sc_create_isdb_trace_file ("myvcddump");
  sc_trace_file *pointer_to_trace_file_w = sc_create_wif_trace_file ("myvcddump");
  sc_trace_file *trfile = sc_create_vcd_trace_file ("ahb_trans.vcd");
  ((vcd_trace_file *) trfile)->sc_set_vcd_time_unit(-6);

  trfile->delta_cycles (true);
  trfile->delta_cycles (false);
  trfile->delta_cycles (true);

  sc_signal<bool> signal_name;
  sc_trace (tfile, signal_name, "signal_name");
  sc_trace (tfile, reg_file, "reg_file", NUM_BITS);
  sc_trace (tfile, saved, "saved");

  sc_signal<float> qms[4];
  int mlef[8];

  sc_trace (tfile, qms, "qms", 4);
  sc_trace (tfile, mlef, "mlef", 8);

  fsm_state c_state;
  c_state = COUNT0;

  sc_trace (tfile, c_state, "c_state", fsm_state_strings);

  // Simulation start and control.
  sc_start (100, SC_MS);
  sc_start(-1);

  cout << "Current time is " << sc_time_stamp() << endl;
  double curr_time = sc_simulation_time();
  sc_cycle(10, SC_US); // 10 microseconds.
  cout << "Time now is %f" << curr_time << endl;

  sc_stop();
  sc_close_vcd_trace_file (pointer_to_trace_file_v);

  // NOT WORKING:
  // sc_close_isdb_trace_file (pointer_to_trace_file_i);
  sc_close_wif_trace_file (pointer_to_trace_file_w);
  return 0;
}
