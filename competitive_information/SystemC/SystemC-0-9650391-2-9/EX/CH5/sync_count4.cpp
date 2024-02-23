// Copyright 2003 Star Galaxy Publishing
// File: sync_count4.cpp

#include "sync_count4.h"

void sync_count4::prc_counter() {
  if (! preset)
    data_out = data_in;
  else
    if (updown)
      data_out = data_out.read() + 1;
    else
      data_out = data_out.read() - 1;
}
