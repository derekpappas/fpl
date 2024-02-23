// Copyright 2003 Star Galaxy Publishing
// File: aoi321.cpp

#include <iostream.h>
#include "aoi321.h"

void aoi321::aoi321_prc() {

#ifdef DEBUG
  cout << "Debug: In aoi321_prc: \n";
  cout << a1 << a2 << a3 << '\n';
#endif

  z.write (!((a1 & a2 & a3) | (b1 & b2) | (c)));
}
