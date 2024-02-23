// Copyright 2003 Star Galaxy Publishing
// File: generic_instantiate.h

#include "generic_and.h"
// File "systemc.h" included with above include.

const int WIDTH = 6;

SC_MODULE (generic_instantiate) {
  sc_in<sc_uint<WIDTH> > tsq;

  sc_out<bool> rsq;

  void prc_xor();
  void prc_splitter();

  generic_and<2> *and2;
  generic_and<4> *and4;

  sc_signal<bool> and2out, and4out;
  sc_signal<sc_uint<2> > t2;
  sc_signal<sc_uint<4> > t4;

  SC_CTOR (generic_instantiate) {
    SC_METHOD (prc_xor);
    sensitive << and2out << and4out;

    SC_METHOD (prc_splitter);
    sensitive << tsq;

    and2 = new generic_and<2> ("and2");
    and2->a(t2);
    and2->z(and2out);

    and4 = new generic_and<4> ("and4");
    and4->a(t4);
    and4->z(and4out);

  }

  ~ generic_instantiate () {
    delete and2;
    delete and4;
  }
};
