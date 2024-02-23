// Copyright 2003 Star Galaxy Publishing
// File: count4.cpp

#include "count4.h"

void count4::sync_block() {
  if (! clear)
    // Asynchronous condition.
    data_out = 0;
  else 
    // Else rising clock edge.
    if (updown)
      data_out = data_out.read() + 1;
    else
      data_out = data_out.read() - 1;
}
