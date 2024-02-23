// Copyright 2003 Star Galaxy Publishing
// File: buses2.cpp

#include "buses2.h"

void buses2::prc_a_bus() {
  if (a_ready)
    driver_bus = a_bus.read();
  else
    driver_bus = "ZZZZ";
}

void buses2::prc_b_bus() {
  if (b_ready)
    driver_bus = b_bus.read();
  else
    driver_bus = "ZZZZ";
}

void buses2::prc_ab_bus() {
  z_bus = driver_bus;
}
