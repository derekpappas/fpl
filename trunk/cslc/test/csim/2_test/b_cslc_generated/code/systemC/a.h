#include "systemc.h"

SC_MODULE(a) {
  sc_in<sc_int<1> > in_a;
  sc_in<sc_int<1> > clk;
  sc_out<sc_int<1> > out_a;
  SC_CTOR(a) {
  }
};

