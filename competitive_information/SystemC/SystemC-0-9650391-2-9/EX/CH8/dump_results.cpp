// Copyright 2003 Star Galaxy Publishing
// File: dump_results.cpp

#include "dump_results.h"

void dump_results::behavior_dump() {
  // Prints values of inputs and outputs at 
  // every falling edge of clock.
  outfile << "At time " << sc_time_stamp() << " clear = " << clear 
          << "left_in = " << left_in << "right_in = " << right_in 
          << "sel_op = " << sel_op << " data_in = " << data_in 
          << " data_out = " << data_out << endl;
}
