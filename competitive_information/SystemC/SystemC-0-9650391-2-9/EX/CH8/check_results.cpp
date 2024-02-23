// Copyright 2003 Star Galaxy Publishing
// File: check_results.cpp

#include "check_results.h"

void check_results::prc_check_results() {
  if (expected_out != actual_out)
    cout << "**** Mismatch results at time " << sc_time_stamp() 
         << " Expected:" << expected_out.read() << " Actual:" 
         << actual_out.read() << endl;
  else
    cout << "Results match at time " << sc_time_stamp() 
         << "Expected:" << expected_out.read() << " Actual:" 
         << actual_out.read() << endl;
}
