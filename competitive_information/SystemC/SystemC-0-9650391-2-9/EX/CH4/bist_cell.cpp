// Copyright 2003 Star Galaxy Publishing
// File: bist_cell.cpp

#include "bist_cell.h"

/* 
void bist_cell::prc_bist_cell () {
  bool s1, s2, s3;

  s1 = ! (b0 & d1);
  s2 = ! (d0 & b1);
  s3 = ! (s2 | s1);
  s2 = s2 & s1;

  z = !(s2 | s3);
}
*/

void bist_cell:: prc_bist_cell () {
  z = ! ( (!(d0 & b1) & !(b0 & d1)) | !(!(d0 & b1) | !(b0 & d1)));
  // Though it is harder to read and understand.
}
