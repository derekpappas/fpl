// Copyright 2003 Star Galaxy Publishing
// File: main.cpp

#include "systemc.h"

int sc_main(int argc, char *argv[]) {
  sc_uint<4> write_addr;
  sc_int<5> read_addr;

  read_addr = write_addr + read_addr;

  sc_in<sc_uint<4> > data;
  sc_signal<sc_bv<5> > counter;
  sc_uint<4> temp;
  bool mode, preset;

  mode = data[2]; // Not allowed.
  // Instead, the following two statements can be used:
  temp = data.read();
  mode = temp[2]; 

  // counter[6] = preset; // Not allowed.
  // Instead, the following three statements can be used:
  temp = counter;
  temp[6] = preset;
  counter = temp;

  return 0;
}
