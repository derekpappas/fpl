// Copyright 2003 Star Galaxy Publishing
// File: sync_mux41.cpp

#include "sync_mux41.h"

void sync_mux41::prc_sync_mux41() {
  sc_uint<4> temp_inp;

  // Need to do this to access individual bits:
  temp_inp = inp.read(); 

  if (reset == 0)
    out = 0;
  else {
    if (sel.read() == 0)
      out = temp_inp[0];
    else if (sel.read() == 1)
      out = temp_inp[1];
    else if (sel.read() == 2)
      out = temp_inp[2];
    else
      out = temp_inp[3];
  }
}
