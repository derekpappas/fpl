// Copyright 2003 Star Galaxy Publishing
// File: upc_wait.cpp

#include "upc_wait.h"

void upc_wait::prc_upc_wait() {
  // Never gets out of the process:
  while (1) {
    wait();

    if (res)
      dout = 0;

    wait();

    if (ld)
      dout = din;

      while (! stop) {
        wait();

        if (up)
          dout = dout.read() + incr.read();
        else
          dout = dout.read() - incr.read();
     }
  }
}
