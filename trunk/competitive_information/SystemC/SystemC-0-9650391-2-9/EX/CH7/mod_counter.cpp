// Copyright 2003 Star Galaxy Publishing
// File: mod_counter.cpp

#include "mod_counter.h"

void mod_counter::prc_counter() {
  if (clear)
    counter = 0;
  else
    counter = (counter.read() + 1) % UPTO;
}

void mod_counter::prc_outputs() {
  q = counter;
  qbar = ~ counter.read();
}
