// Copyright 2003 Star Galaxy Publishing
// File: wave.cpp

#include "wave.h"

void wave::prc_wave() {
  sig_out = 0;
  wait (5, SC_NS);
  sig_out = 1;
  wait (2, SC_NS);
  sig_out = 0;
  wait (5, SC_NS);
  sig_out = 1;
  wait (8, SC_NS);
  sig_out = 0;
}
