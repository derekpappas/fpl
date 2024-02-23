// Copyright 2003 Star Galaxy Publishing
// File: buses.cpp

#include "buses.h"

void buses::prc_a_bus() {
  if (a_ready)
    z_bus = a_bus.read();
  else
    z_bus = "ZZZZ"; 
}

void buses::prc_b_bus() {
  if (b_ready)
    z_bus = b_bus.read();
  else
    z_bus = "ZZZZ";
}
