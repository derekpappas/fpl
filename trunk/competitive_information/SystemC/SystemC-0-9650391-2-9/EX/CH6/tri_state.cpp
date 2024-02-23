// Copyright 2003 Star Galaxy Publishing
// File: tri_state.cpp

#include "tri_state.h"

void tri_state::prc_tri_state() {
  if (ready)
    selectx = sc_logic('Z');
    // selectx = sc_logic_Z;
  else
    // selectx = static_cast <sc_logic> (dina.read() & dinb.read());
    selectx = sc_logic (dina.read() & dinb.read());
}
