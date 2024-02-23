// Copyright 2003 Star Galaxy Publishing
// File: johnson.decoder.cpp

#include "johnson_decoder.h"

void johnson_decoder::prc_decoder() {
  sc_uint<TWICENBITS> address, y_temp;

  int i;

  if (!enable)
    y = 0;
  else {
    address = 0;
    y_temp = 0;

    for (i=0; i<NBITS; i++)
      if (sel[i])
        address++;

    if (sel[NBITS-1])
      address = TWICENBITS - address;

    y_temp[address] = 1; 
    y = y_temp;
  }
}
