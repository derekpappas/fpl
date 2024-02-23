// Copyright 2003 Star Galaxy Publishing
// File: state_update2.cpp

#include "state_update.h"

void state_update::prc_state_update() {
  z = 1; // Initialize z to a value.

  switch (current_state) {
    case s0:
    case s3: z = 0; break;
    case s1: z = 3; break;
  }
}
