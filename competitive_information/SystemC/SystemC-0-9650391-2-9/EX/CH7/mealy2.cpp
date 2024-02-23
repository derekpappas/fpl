// Copyright 2003 Star Galaxy Publishing
// File: mealy2.cpp

#include "mealy2.h"

void mealy2::prc_state() {
  if (! resetn)
    curr_state = state0;
  else
    curr_state = nxt_state;
}

void mealy2::prc_comb_logic() {
  out1 = 0;
  out2 = 0;
  nxt_state = state0;

  switch (curr_state) {
    case state0:
      if ((a & b) | c)
        nxt_state = state2;
      else
        nxt_state = state1;

      break;
    case state1:
      if (b & d) 
        out1 = 1;

      nxt_state = state4;
      break;
    case state2:
      out2 = 1;
      nxt_state = state3;
      break;
    case state3:
      out2 = 1;

      if ((a | b) & (c | d))
        nxt_state = state4;
      else
        nxt_state = state3;

      break;
    case state4:
      nxt_state = state0;
      break;
    default:
      nxt_state = state0;
      break;
  }
} 
