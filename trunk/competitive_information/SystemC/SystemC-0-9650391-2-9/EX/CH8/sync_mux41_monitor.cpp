// Copyright 2003 Star Galaxy Publishing
// File: sync_mux41_monitor.cpp

#include "sync_mux41_monitor.h"

void monitor::prc_monitor() {
  cout << "At time " << sc_simulation_time() << "::";
  cout << "(clock, reset, sel, inp): ";
  cout << m_clock.read() << m_reset.read() << m_sel.read() << m_inp.read();
  cout << "  out: " << m_out.read() << '\n';
}
