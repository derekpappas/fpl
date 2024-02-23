// Copyright 2003 Star Galaxy Publishing
// File: full_adder_monitor.h

#include <fstream.h>
#include "systemc.h"

SC_MODULE (monitor) {
  sc_in<bool> m_a, m_b, m_cin, m_sum, m_cout;

  ofstream outfile;

  void monitor_prc ();

  SC_CTOR (monitor) {
    SC_METHOD (monitor_prc);
    sensitive << m_a << m_b << m_cin << m_sum << m_cout;

    outfile.open ("full_adder.out");
  }

  // Close the file in the destructor:
  ~ monitor () {
    outfile.close();
  }
};
