#ifndef INC_GUARD_cmpr_h
#define INC_GUARD_cmpr_h

#include "systemc.h"
#include "me.h"

SC_MODULE(cmpr) {
  sc_in<sc_uint<32> > mbc_out_ifc_address;
  sc_in<sc_uint<32> > mbc_out_ifc_write_data;
  sc_in<sc_uint<1> > mbc_out_ifc_write;
  sc_in<sc_uint<1> > mbc_out_ifc_read;
  sc_out<sc_uint<32> > mbc_out_ifc_read_data;
  sc_out<sc_uint<32> > mbc_out_ifc_control;
    me *me_;

  SC_CTOR(cmpr) {
      me_ = new me("me_");

    dont_initialize();
  }
};

#endif
