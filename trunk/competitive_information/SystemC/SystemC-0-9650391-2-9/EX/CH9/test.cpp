// Copyright 2003 Star Galaxy Publishing
// File: test.cpp

#include "systemc.h"

int sc_main (int argc, char *argv[]) {
  sc_signal<bool> clk, reset, clear;

  wait();
  wait (clk.posedge_event());
  wait (reset.negedge_event());

  // negedge_event() and posedge_event() methods can
  // be applied to a signal or a port to identify the
  // specific event.
  wait (clk.posedge_event() | reset.negedge_event() | clear.value_changed_event());

  // A value_changed_event() method is true when any
  // value change occu
  sc_signal<sc_uint<4> > ready;
  sc_signal<bool> data;

  wait (clk.value_changed_event() & data.posedge_event() & ready.value_changed_event());

  // The events can span over multiple simulation 
  // cycles. For example, if clk changes at 5ns, 
  // a positive edge on data occurs at 8ns and ready
  // changes at 10ns, then the wait is triggered at
  // time 10ns.

  wait (20, SC_NS); 

  // does NOT work with sc_bit or sc_logic:
  sc_signal<bool> speed_ctrl;

  wait (10, SC_NS, speed_ctrl.posedge_event());

  // Waits for positive edge to occur on speed_ctrl
  // for 10ns and then times out.
  wait (SC_ZERO_TIME);
  wait (0, SC_NS);

  sc_signal<sc_logic> sac;
  // sc_in<sc_logic> sync_reset;
  sc_signal<sc_logic> sync_reset;

  wait (sac.posedge_event());
  wait (sync_reset.negedge_event());

  sc_event write_back;

  // sensitive << write_back;
  wait (write_back);

  write_back.notify();
  write_back.notify (20, SC_NS);
  write_back.notify(SC_ZERO_TIME);

  // Trigger event in next delta cycle.
  write_back.cancel(); // Cancels a delayed notification.

  sc_out<bool> out_port;

  out_port.initialize(0);

  sc_time t_res;

  t_res = sc_get_time_resolution();
  cout << "The time resolution is " << sc_get_time_resolution() << endl;

  double time_in_dbl;
  sc_time time_res = sc_get_time_resolution();
  sc_time curr_time = sc_time_stamp();

  time_in_dbl = curr_time / time_res;
  cout << "Time as a double value is " << time_in_dbl << endl;

  time_in_dbl = sc_simulation_time();
  cout << "Time is " << time_in_dbl;

  sc_set_default_time_unit (100, SC_PS);
  sc_time t_unit (10, SC_NS);

  // NOT WORKING:
  // sc_set_default_time_unit (t_unit);
  sc_set_default_time_unit (100, SC_PS);

  sc_time tf_unit;

  tf_unit = sc_get_default_time_unit();

  // Wake up SC_METHOD process after 10ns:
  next_trigger (10, SC_NS);

  // Wake up SC_METHOD process on a rising edge 
  // of reset:
  next_trigger (reset.posedge_event());

  return 0;
}
