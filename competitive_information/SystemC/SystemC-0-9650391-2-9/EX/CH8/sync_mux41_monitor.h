// Copyright 2003 Star Galaxy Publishing
// File: sync_mux41_monitor.h

#include "systemc.h"

SC_MODULE (monitor) {
  sc_in<bool> m_clock, m_reset;
  sc_in<sc_uint<2> > m_sel;
  sc_in<sc_uint<4> > m_inp;
  sc_in<bool> m_out;

  void prc_monitor ();

  SC_CTOR (monitor) {
    SC_METHOD (prc_monitor);
    sensitive << m_clock << m_reset << m_sel << m_inp << m_out;
  }
};
