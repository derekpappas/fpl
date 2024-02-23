// Copyright 2003 Star Galaxy Publishing
// File: mult_procs.cpp

#include "mult_procs.h"

void mult_procs:: mult_procs_1 () {
  connect1 = ! source;
}

void mult_procs::mult_procs_2() {
  connect2 = ! connect1;
}

void mult_procs::mult_procs_3() {
  drain = ! connect2;
}
