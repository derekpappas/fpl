// Copyright 2003 Star Galaxy Publishing
// File: multiphase.cpp

#include "multiphase.h"

void multiphase::prc_rising() {
  e = d & c;
}

void multiphase::prc_falling() {
  d = a & b;
}
