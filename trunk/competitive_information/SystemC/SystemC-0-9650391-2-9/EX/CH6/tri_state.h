// Copyright 2003 Star Galaxy Publishing
// File: tri_state.h

#include "systemc.h"

SC_MODULE (tri_state) {
  sc_in<bool> ready, dina, dinb;

  sc_out<sc_logic> selectx;

  void prc_tri_state();

  SC_CTOR (tri_state) {
    SC_METHOD (prc_tri_state);
    sensitive << ready << dina << dinb;
  }
};
