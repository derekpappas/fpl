// Copyright 2003 Star Galaxy Publishing
// File: usr.cpp

#include "usr.h"

void usr::prc_usr() {
  sc_uint<WIDTH> q_temp;
  sc_uint<SEL_WIDTH> sel_temp;

  if (!clr)
    q = 0;
  else {
    q_temp = q.read(); // Ok to read output port.
    sel_temp = select.read();

    switch (sel_temp) {
      case HOLD: break; // hold value
      case SHIFT_LEFT: 
        q = (q_temp.range(WIDTH-2, 0), rin.read());
        break;
      case SHIFT_RIGHT: 
        q = (lin.read(), q_temp.range(WIDTH-1, 1));
        break;
      case LOAD: 
        q = par_in; 
        break;
    }
  }
} 
