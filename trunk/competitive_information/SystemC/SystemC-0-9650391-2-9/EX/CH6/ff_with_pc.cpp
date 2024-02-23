// Copyright 2003 Star GAlaxy Publishing
// File: ff_with_pc.cpp

#include "ff_with_pc.h"

void ff_with_pc::prc_ff_with_pc() {
  if (preclr)
    q = 0;
  else
    q = din;

  notq = ! q;
}
