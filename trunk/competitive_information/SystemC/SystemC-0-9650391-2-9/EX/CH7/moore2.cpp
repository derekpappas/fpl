// Copyright 2003 Star Galaxy Publishing
// File: moore2.cpp

#include "moore2.h"

void moore2::prc_states() {
  if (reset) 
    moore_state = s0;
  else
    switch (moore_state) {
      case s0: moore_state = a ? s0 : s2; break;
      case s1: moore_state = a ? s0 : s2; break;
      case s2: moore_state = a ? s2 : s3; break;
      case s3: moore_state = a ? s1 : s3; break;
    }
}

void moore2::prc_outputs() {
  switch (moore_state) {
    case s3:
    case s0: z = 1; break; 
    case s1: 
    case s2: z = 0; break;
  }
}
