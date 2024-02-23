// Copyright 2003 Star Galaxy Publishing
// File: parent.h

#include "systemc.h"
 
SC_MODULE (child) {
  sc_in <bool> term_a;

  sc_out<bool> term_b;

  SC_CTOR (child) {
    cout << "hi" << endl;
  }
};

SC_MODULE (parent) {
  sc_out<sc_uint<4> > arith_bus;

  // . . .

  sc_signal<sc_uint<3> > bus_m;
  sc_signal<bool> bus_m0, bus_m1, bus_m2;
  sc_signal<bool> arith0, arith1, arith2, arith3;

  void split_x();
  void merge_z();

  child *ptr1, *ptr2;

  SC_CTOR (parent) {
    // Process splits bus bus_m into its individual elements:
    SC_METHOD (split_x);
    sensitive << bus_m;

    // Process merge individual elements of bus:
    SC_METHOD (merge_z);
    sensitive << arith0 << arith1 << arith2 << arith3;

    ptr1 = new child ("child_instance_name1");
    ptr1->term_a (bus_m1); // bus_m[1] is not allowed.
    ptr1->term_b (arith0);

    // . . .

    ptr2 = new child ("child_instance_name2");
    ptr2->term_a (arith1); // arith_bus[1] not allowed.
  }

  ~ parent() {
   delete ptr1;
   delete ptr2;
  }
};
