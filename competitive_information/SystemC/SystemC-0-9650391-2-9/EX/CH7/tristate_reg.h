// Copyright 2003 Star Galaxy Publishing
// File: tristate_reg.h

// Parameterizable register with three-state output
// built using parameterizable blocks:

#include "systemc.h"

template<int width>
SC_MODULE (tristate) {
  sc_in<sc_uint<width> > in_bus;
  sc_in<bool> output_enable;

  sc_out<sc_lv<width> > out_bus;

  // The definition can appear inside the template:
  void prc_tristate() {
    sc_lv<width> all_zs (sc_logic_Z);

    if (output_enable)
      out_bus = in_bus.read();
    else
      out_bus = all_zs;
  }

  SC_CTOR (tristate) {
    SC_METHOD (prc_tristate);
    sensitive << in_bus << output_enable;
  }
};

template<int width>
SC_MODULE (reg) {
  sc_in<sc_uint<width> > d;
  sc_in<bool> enable, clock, reset;

  sc_out<sc_uint<width> > q;

  void prc_reg () {
    if (reset)
      q = 0;
    else { /* clock behavior */
      if (enable)
        q = d;
    }
  }

  SC_CTOR(reg) {
    SC_METHOD (prc_reg);
    sensitive_pos << reset;
    sensitive_neg << clock; // enable is not in list as it is synchronous.
  }
};

// #include "tristate_reg.h"
// Even this block can be parameterized if necessary.

const int SIZE =2;

SC_MODULE (tristate_reg) {
  sc_in<bool> clock, reset, reg_enable, output_enable;
  sc_in<sc_uint<SIZE> > data_in;

  sc_out<sc_lv<SIZE> > data_out;

  reg<SIZE> *inst1;
  tristate<SIZE> *inst2;
  sc_signal<sc_uint<SIZE> > reg_out;

  SC_CTOR (tristate_reg) {
    inst1 = new reg<SIZE> ("regSIZE");
    inst1->d (data_in);
    inst1->enable (reg_enable);
    inst1->clock (clock);
    inst1->reset (reset);
    inst1->q (reg_out);

    inst2 = new tristate<SIZE> ("tristateSIZE");
    inst2->in_bus (reg_out);
    inst2->output_enable (output_enable);
    inst2->out_bus (data_out);
  }

  ~ tristate_reg() {
    delete inst1;
    delete inst2;
  }
};
