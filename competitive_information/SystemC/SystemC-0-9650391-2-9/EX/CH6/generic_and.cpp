// Copyright 2003 Star Galaxy Publishing
// File: generic_and.cpp

// File: generic_and.h
#include "systemc.h"

template <int size>
SC_MODULE (generic_and) {
  sc_in<sc_uint<size> > a;
  sc_out<bool> z;
  void process_generic_and();

  SC_CTOR (generic_and) {
    SC_METHOD (process_generic_and);
    sensitive << a;
  }
};

template <int size>
void generic_and<size>::process_generic_and() {
  sc_bv<size> bv_temp; // and_reduce is only for bit vectors.
  bv_temp = a.read();
  z.write(bv_temp.and_reduce());
}

// File: generic_instantiate.h
// #include "generic_and.h"
#define WIDTH 6
SC_MODULE (generic_instantiate) {
  sc_in<sc_uint<WIDTH> > tsq;
  sc_out<bool> rsq;
  void process_xor();
  void process_splitter();

  generic_and<2> *and2;
  generic_and<4> *and4;

  sc_signal<bool> and2out, and4out;
  sc_signal<sc_uint<2> > t2;
  sc_signal<sc_uint<4> > t4;

  SC_CTOR (generic_instantiate) {
    SC_METHOD (process_xor);
    sensitive << and2out << and4out;
    SC_METHOD (process_splitter);
    // needed since bit select and range not allow to connect to ports.
    sensitive << tsq;

    and2 = new generic_and<2> ("and2");
    and2->a(t2);
    and2->z(and2out);

    and4 = new generic_and<4> ("and4");
    and4->a(t4);
    and4->z(and4out);
  }
};

// File: generic_instantiate.cpp
// #include "generic_instantiate.h"
void generic_instantiate::process_xor() {
  rsq.write (and2out ^ and4out);
}

void generic_instantiate::process_splitter() {
  sc_uint<WIDTH> temp;

  temp = tsq.read();
  t2 = temp.range(0, 1);
  t4 = temp.range(2, 5);
}
