// Copyright 2003 Star Galaxy Publishing
// File: myclock.h

#include "systemc.h"

const int START_VALUE =0;
const int INITIAL_DELAY= 5;
const int FIRST_DELAY =2;
const int SECOND_DELAY= 3;

SC_MODULE (myclock) {
  sc_out<bool> clk_out;

  void prc_myclock();

  SC_CTOR (myclock) {
    SC_THREAD (prc_myclock);
  }
};
