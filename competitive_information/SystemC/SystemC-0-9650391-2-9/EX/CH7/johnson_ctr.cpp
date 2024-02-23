// Copyright 2003 Star Galaxy Publishing
// File: johnson_ctr.cpp

#include "johnson_ctr.h"

void johnson_ctr::prc_counter() {
  sc_uint<NBITS> t_cnt;

  if (!clear)
    q = 0;
  else {
    t_cnt = q.read();
    q = (t_cnt.range(NBITS-2, 0), !t_cnt[NBITS-1]);
  }
}
