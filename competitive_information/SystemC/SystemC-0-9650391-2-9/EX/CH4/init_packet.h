// Copyright 2003 Star Galaxy Publishing
// File: init_packet.h

#include "systemc.h"

const int XMIT_ID = 3;
const int DONE_ID = 1;
enum states {xmit, rcv, init, done};

struct packet {
  sc_uint<2> packet_id;
  states packet_state;
};

SC_MODULE (init_packet) {
  sc_in<bool> send;

  sc_out<packet> tsq;

  void prc_init_packet();

  SC_CTOR (init_packet) {
    SC_METHOD (prc_init_packet);
    sensitive << send;
  }
};
