// Copyright 2003 Star Galaxy Publishing
// File: specific_alu.h

#include "generic_alu.h"

class specific_alu: public generic_alu {
public:
  SC_HAS_PROCESS (specific_alu);

  specific_alu (sc_module_name nm, sc_uint<NUM_OPS> mask): generic_alu (nm) {
    enable_mask = mask;
  }
};
