// Copyright 2003 Star Galaxy Publishing
// File: encoder.cpp

#include "encoder.h"

void encoder::prc_encoder() {
  switch (data.read()) {
    case 0x01 : yout = 0;
    case 0x02 : yout = 1;
    case 0x04 : yout = 2;
    case 0x08 : yout = 3;
    // You can assign an integer value or a vector
    // value to output yout.
    case 0x10 : yout = "100";
    case 0x20 : yout = "101";
    case 0x40 : yout = "110";
    case 0x80 : yout = "111";
    default: yout = "XXX"; // Don't-care assignment.
  }
}
