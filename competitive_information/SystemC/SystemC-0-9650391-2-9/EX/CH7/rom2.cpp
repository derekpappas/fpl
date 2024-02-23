// Copyright 2003 Star Galaxy Publishing
// File: rom.cpp

#include "rom2.h"

const sc_uint<DATA_WIDTH> rom::rom_data [WORD_DEPTH] = {0x11, 0x22, 0x33, 0x44, 0x55};

void rom::prc_rom() {
  if (cen) 
    que = rom_data[addr.read()];
  else
    que = 0;
}
