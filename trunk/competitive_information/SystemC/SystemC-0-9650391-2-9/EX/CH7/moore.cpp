// Copyright 2003 Star Galaxy Publishing
// File: moore.cpp

#include "moore.h"

void moore::prc_moore() {
  if (reset) // Synchronous reset.
    moore_state = s0;
  else
    switch (moore_state) {
      case s0: z = 1; moore_state = a ? s0 : s2; break;
      case s1: z = 0; moore_state = a ? s0 : s2; break;
      case s2: z = 0; moore_state = a ? s2 : s3; break;
      case s3: z = 1; moore_state = a ? s1 : s3; break;
    }
}
