// Copyright 2003 Star Galaxy Publishing
// File: main_31.cpp

// Has 3.1 and 3.3

#include "systemc.h"

SC_MODULE (main_31) {
  sc_out<sc_uint<4> > addi [6];
};

int sc_main(int argc, char *argv[]) {
  int mpy;
  int word, bit;
  int watch_in [4] [8];

  sc_signal<bool> mask [256] [16];

  // Declares a signal of type sc_bit:
  sc_signal<sc_bit> flag; 

  // Declares a variable ready of type bool:
  bool ready = false;

  flag = sc_bit('0'); 

  // Assigns the value '0'.
  ready = ready & flag; // ok to do this: '0' is interpreted

  // as false, '1' is interpreted as true.
  if (ready == flag) ;

  // ok to compare bool with sc_bit.
  for (word = 0; word < 256; word++)
    for (bit = 0; bit < 16; bit++)
     mask[word][bit] = false;
  return 0;
}
