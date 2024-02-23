// Copyright 2003 Star Galaxy Publishing
// File: sync_mux41_main.cpp

#include "sync_mux41_driver.h"
#include "sync_mux41_monitor.h"
#include "sync_mux41.h"

const int CLOCK_PERIOD = 2;

int sc_main(int argc, char* argv[]) {
  sc_signal<bool> t_reset;
  sc_signal<sc_uint<4> > t_inp;
  sc_signal<sc_uint<2> > t_sel;
  sc_signal<bool> t_out;

  // sc_set_default_time_unit (1, SC_NS);
  sc_clock t_clock("clock", CLOCK_PERIOD);

  // Instantiate the design under test:
  sync_mux41 m1 ("SyncMuxer4x1");
  m1.clock(t_clock);
  m1.reset(t_reset);
  m1.sel(t_sel);
  m1.inp(t_inp);
  m1.out(t_out);

  // Instantiate the driver:
  driver d1 ("GenerateWaveforms");
  d1.d_reset (t_reset);
  d1.d_sel (t_sel);
  d1.d_inp (t_inp);

  // Instantiate the monitor:
  monitor mo1 ("MonitorWaveforms");
  mo1.m_clock (t_clock);
  mo1.m_reset (t_reset);
  mo1.m_sel (t_sel);
  mo1.m_inp (t_inp);
  mo1.m_out (t_out);

  sc_trace_file *tf = sc_create_vcd_trace_file ("sync_mux41");
  sc_trace(tf, t_clock, "clock");
  sc_trace(tf, t_reset,"reset");
  sc_trace(tf, t_inp, "input");
  sc_trace(tf, t_sel, "select");
  sc_trace(tf, t_out, "output");

  sc_start(100, SC_NS);

  sc_close_vcd_trace_file (tf);

  return(0);
}
