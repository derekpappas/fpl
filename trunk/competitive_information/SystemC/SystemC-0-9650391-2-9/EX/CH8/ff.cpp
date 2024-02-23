// Copyright 2003 Star Galaxy Publishing
// File: ff.cpp

#include "ff.h"

void ff::prc_ff() {
  if (reset)
    data_out = 0;
  else
    data_out = data;
}
