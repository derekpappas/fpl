// Copyright 2003 Star Galaxy Publishing
// File: fac_main.h

#include "fac.cpp"
#include <math.h>

SC_MODULE (monitor) {
  sc_in<bool> clk, done;
  sc_out<bool> reset, start;
  sc_out<sc_uint<DATA_SIZE> > data;
  sc_in<sc_uint<OUT_SIZE> > fac_out, exp_out;

  void process_monitor();
  enum state_type {reset_state, start_state, apply_data_state, wait_result_state};
  sc_signal<state_type> next_state;

  SC_CTOR (monitor) {
    SC_THREAD(process_monitor);
    sensitive_neg << clk;
    sensitive << done;
  }
};

// File: monitor.cpp
// #include "monitor.h"
#define MAX_APPLY 20
void monitor::process_monitor() {
  int num_applied;

  num_applied = 1;

  while (1) {
    // wait (clk == 1);
    wait();
    switch (next_state) {
      case reset_state :
        cout << "In reset state(" << sc_time_stamp() << ") ...\n";
        reset = 1; start = 0;
        next_state = apply_data_state;
        wait();
        break;
      case apply_data_state:
        cout << "In apply_data state(" << sc_time_stamp() << ") ...\n";
        data = num_applied;
        next_state = start_state;
        wait();
        break;
      case start_state:
        cout << "In start state(" << sc_time_stamp() << ") with data:" << num_applied << " ...\n";
        start = 1;
        next_state = wait_result_state;
        wait();
        break;
      case wait_result_state:
        cout << "In wait result state(" << sc_time_stamp() << ") ...\n";
        reset = 0;
        start = 0;

        while (! done)
          wait();

        cout << "Factorial of " << num_applied << " is " << (int) fac_out.read() << "*(2**" << (int) exp_out.read() << ")\n";
/* cannot do all this because of normalization: some bits are lost:
        correct_fac_value = 1;
        for (i=1; i<=num_applied; i++)
          correct_fac_value = correct_fac_value * i;

        if (correct_fac_value != (fac_out.read() * pow(2, exp_out.read()) ))
          cout << "****Error: Incorrect results from factorial model.\n";
*/

        num_applied = num_applied + 1;

        if (num_applied < MAX_APPLY)
          next_state = apply_data_state;
        else
          sc_stop(); // Stop simulation, done.
    }
  }
}

int sc_main (int argc, char *argv[]) {
  sc_signal<bool> reset, start, finished;
  sc_signal<sc_uint<DATA_SIZE> > in_data;
  sc_signal<sc_uint<OUT_SIZE> > fout, eout;
  sc_clock clock ("clock", 10);
  
  // Instantiate DUT:
  fac f1 ("fac_f1");
  f1.reset (reset);
  f1.start (start);
  f1.clk (clock.signal());
  f1.data (in_data);
  f1.done (finished);
  f1.fac_out (fout);
  f1.exp_out (eout);

  // Instantiate reactive monitor:
  monitor m1 ("monitor_m1");
  m1.clk(clock.signal());
  m1.reset (reset);
  m1.start (start);
  m1.done (finished);
  m1.data (in_data);
  m1.fac_out(fout);
  m1.exp_out (eout);

  // Start simulation:
  sc_start (-1);
  return 0;
}
