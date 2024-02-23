// Copyright 2003 Star Galaxy Publishing
// File: init_packet.cpp

#include "init_packet.h"

void init_packet::prc_init_packet() {
  packet temp; // Temporary structure variable.

  if (send) {
    temp.packet_id = XMIT_ID;
    temp.packet_state = xmit;
  }
  else {
    temp.packet_id = DONE_ID;
    temp.packet_state = done;
  }

  tsq = temp;
}
