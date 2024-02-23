// Copyright 2003 Star Galaxy Publishing
// File: odd_ones.cpp

#include "odd_ones.h"

/*
void odd_ones::prc_odd_ones() {
  is_odd = compute_if_odd(data_in);
}
*/

// #include "odd_ones.h"
void odd_ones::prc_odd_ones() {
  sc_bv<SIZE> temp;

  temp = data_in.read();
  is_odd = temp.xor_reduce();
}

bool odd_ones::compute_if_odd (sc_uint<SIZE> abus) {
  bool result;
  int i;

  result = false;

  for (i=0; i<SIZE; i++)
    result = result ^ abus[i];

  return (result);
}
