// Copyright 2003 Star Galaxy Publishing
// File: dff.cpp

#include "dff.h"

void dff::prc_dff () {
  if (!reset)
    q = 0;
  else
    q = d;
}
