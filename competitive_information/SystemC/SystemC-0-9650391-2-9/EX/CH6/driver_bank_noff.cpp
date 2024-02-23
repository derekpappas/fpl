// Copyright 2003 Star Galaxy Publishing
// File: driver_bank_noff.cpp

#include "driver_bank_noff.h"

void driver_bank_noff::z_logic() {
  sc_lv<BUS_SIZE> temp (sc_logic_Z);

  if (read_state)
    main_bus = temp;
  else
    main_bus = saved_value.read();
}

void driver_bank_noff::ff_logic() {
  saved_value = cpu_bus.read();
}
