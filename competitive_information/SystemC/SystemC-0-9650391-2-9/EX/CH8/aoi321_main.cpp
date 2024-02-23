// Copyright 2003 Star Galaxy Publishing
// File: aoi321_main.cpp

#include "aoi321.h"

int sc_main (int argc, char *argv[]) {
  sc_signal<bool> aone, atwo, athree, bone, btwo, cee, zee;

  // Instantiate DUV before applying stimulus:
  aoi321 t1 ("aoi321");
  t1.a1 (aone);
  t1.a2 (atwo);
  t1.a3 (athree);
  t1.b1 (bone);
  t1.b2 (btwo);
  t1.c (cee);
  t1.z (zee);

  // Tracing:
  sc_trace_file *tf = sc_create_vcd_trace_file ("aoi321out");
  sc_trace (tf, aone, "a1");
  sc_trace (tf, atwo, "a2");
  sc_trace (tf, athree, "a3");
  sc_trace (tf, bone, "b1");
  sc_trace (tf, btwo, "b2");
  sc_trace (tf, cee, "c");
  sc_trace (tf, zee, "z");

  // Generate waveform:
  sc_uint<6> ctr = 0;
  sc_initialize();

  for (int i=0; i<=100; i++) {
    ctr++;
    aone = ctr[0];
    atwo = ctr[1];
    athree = ctr[2];
    bone = ctr[3];
    btwo = ctr[4];
    cee = ctr[5];
    sc_cycle (2);
    cout << "At time " << sc_time_stamp() << ":: ";
    cout << "(a1, a2, a3, b1, b2, c): ";
    cout << aone << atwo << athree << bone << btwo << cee;
    cout << "    z: " << zee << '\n';
    sc_cycle(1);
  }

  sc_close_vcd_trace_file (tf);
  return (0);
}
