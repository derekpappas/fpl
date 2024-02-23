// Copyright 2003 Star Galaxy Publishing
// File: incr.cpp

#include "incr.h"

void incr::prc_incr() {
  if (phy)
    z = one_count.read() + 1;
    // z = ones;
}
