// Copyright 2003 Star Galaxy Publishing
// File: compute3.cpp

#include "compute.h"

void compute::prc_compute() {
  grade = excellent; // Initialize value.

  if (marks.read() < 5)
    grade = fail;
  else if (marks.read() < 7)
    grade = pass;
}
