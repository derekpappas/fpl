// Copyright 2003 Star Galaxy Publishing
// File: gcd.cpp

#include "gcd.h"

void gcd::prc_gcd() {
  sc_uint<WIDTH> fopd, sopd;

  fopd = first.read();
  sopd = second.read();

  if ((fopd == 0) | (sopd == 0) | reset)
    result = 0;
  else {
    while (fopd != sopd)
      if (fopd > sopd)
        fopd = fopd - sopd;
      else
        sopd = sopd - fopd;

    result = fopd;
  }
}
