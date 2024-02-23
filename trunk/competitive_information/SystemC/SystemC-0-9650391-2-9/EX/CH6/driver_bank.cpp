// Copyright 2003 Star Galaxy Publishing
// File: driver_bank.cpp

#include "driver_bank.h"

void driver_bank::prc_driver_bank() {
  sc_lv<BUS_SIZE> temp;

  int i;

  if (read_state) {
    for (i=0; i<BUS_SIZE; i++)
      temp[i] = 'Z';
  }
  else
    temp = cpu_bus.read();

  main_bus = temp;
}
