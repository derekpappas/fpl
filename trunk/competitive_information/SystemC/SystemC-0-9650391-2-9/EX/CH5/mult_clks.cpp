// Copyright 2003 Star Galaxy Publishing
// File: mult_clks.cpp

#include "mult_clks.h"

void mult_clks::prc_vt15ck () {
  add_state = !(addclk | (adn | resetn));
  sub_state = subclr ^ (subn & resetn);
}

void mult_clks::prc_ds1ck() {
  ds1_add = add_state;
  ds1_sub = sub_state;
}
