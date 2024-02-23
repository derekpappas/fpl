// Copyright 2003 Star Galaxy Publishing
// File: memory.cpp

#include "memory.h"

void memory::prc_memory() {
  sc_lv<WORD_SIZE> allzs (sc_logic_Z);
  sc_lv<WORD_SIZE> allxs (sc_logic_X);

  if (en) {
    if (rw) {
      if (addr.read() < MEM_SIZE)
        data = ram [addr.read()];
      else  {
        data = allxs;  // 'X'
#ifndef SYNTHESIS
        cout << "Address " << addr << " is out of range for read operation." << endl;
#endif
      }
    }
    else {
      if (addr.read() < MEM_SIZE)
        ram[addr.read()] = data;

#ifndef SYNTHESIS
      else
        cout << "Address " << addr << " is out of range for write operation." << endl;
#endif
    }
  }
  else 
    data = allzs;
}
