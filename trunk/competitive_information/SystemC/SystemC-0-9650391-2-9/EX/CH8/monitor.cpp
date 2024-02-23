// Copyright 2003 Star Galaxy Publishing
// File: monitor.cpp

#include "monitor.h"

const int  MAX_APPLY = 20;

void monitor::prc_monitor() {
  int num_applied;

  num_applied = 1;

  while (1) {
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
          cout << "Factorial of " << num_applied << " is " 
               << (int) fac_out.read() << "*(2**" << (int) exp_out.read() << ")\n";
          num_applied = num_applied + 1;

          if (num_applied < MAX_APPLY)
            next_state = apply_data_state;
          else
            sc_stop(); // Stop simulation, done.
    }
  }
}
