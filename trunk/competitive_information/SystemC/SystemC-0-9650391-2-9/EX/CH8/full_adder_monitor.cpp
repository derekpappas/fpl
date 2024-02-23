// Copyright 2003 Star Galaxy Publishing
// File: full_adder_monitor.cpp

#include "full_adder_monitor.h"

void monitor::monitor_prc() {
  outfile << "At time " << sc_time_stamp() << "::";
  outfile << "(a, b, carry_in): ";
  outfile << m_a << m_b << m_cin;
  outfile << "  (sum, carry_out): " << m_sum << m_cout << '\n';
}
