// Copyright 2003 Star Galaxy Publishing
// File: seq_det.cpp

#include "seq_det.h"

void seq_det::prc_seq_det() {
  first = data;
  second = first;
  third = second;
}

void seq_det::prc_output() {
  seq_found = first & (!second) & third;
}
