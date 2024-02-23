// Copyright 2003 Star Galaxy Publishing
// File: mult_procs.h

#include "systemc.h"

SC_MODULE (mult_procs) {
  sc_in<bool> source;

  sc_out<bool> drain;

  sc_signal<bool> connect1, connect2;

  void mult_procs_1();
  void mult_procs_2();
  void mult_procs_3();

  SC_CTOR (mult_procs) {
    SC_METHOD (mult_procs_1);
    sensitive << source;

    SC_METHOD (mult_procs_2);
    sensitive << connect1;

    SC_METHOD (mult_procs_3);
    sensitive << connect2;
  }
};
