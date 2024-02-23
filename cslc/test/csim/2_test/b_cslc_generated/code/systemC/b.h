#include "systemc.h"

SC_MODULE(b) {
  sc_in<sc_int<1> > in_b1;
  sc_in<sc_int<1> > in_b2;
  sc_in<sc_int<1> > clk;
  sc_out<sc_int<1> > out_b1;
  sc_out<sc_int<1> > out_b2;
  sc_signal<sc_int<1> > s1;
  sc_signal<sc_int<1> > s2;
  sc_signal<sc_int<1> > s3;

  void cont_assign_1() {
    s1 = in_b2.read() & s3.read();
  }


  void cont_assign_2() {
    out_b1 = s1;
  }


  void cont_assign_3() {
    out_b2 = s2.read() ^ s3.read();
  }

                      a *a0_;
  SC_CTOR(b) {
      SC_METHOD(cont_assign_1);
      SC_METHOD(cont_assign_2);
      SC_METHOD(cont_assign_3);
      a0_ = new a("a0_");
      a0_->clk(clk();
      a0_->in_a(in_b1);
      a0_->out_a(out_b1);
  }
};

