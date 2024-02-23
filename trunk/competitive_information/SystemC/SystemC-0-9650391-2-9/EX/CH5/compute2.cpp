// Copyright 2003 Star Galaxy Publishing
// File: compute2.cpp

#include "compute.h"

void compute::prc_compute() {
  if (marks.read() < 5)
    grade = fail;
  else if (marks.read() < 7)
    grade = pass;
  else
    // A catchall else branch.
    grade = excellent;
}
