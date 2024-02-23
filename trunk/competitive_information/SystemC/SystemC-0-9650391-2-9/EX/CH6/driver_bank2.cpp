// Copyright 2003 Star Galaxy Publishing
#include "driver_bank.h"

void driver_bank::prc_driver_bank() {
  sc_lv<BUS_SIZE> temp (sc_logic_Z);

  if (read_state)
    main_bus = temp;
  else
    main_bus = cpu_bus.read();
}
