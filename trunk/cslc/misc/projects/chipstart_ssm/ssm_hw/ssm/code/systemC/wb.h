#ifndef INC_GUARD_wb_h
#define INC_GUARD_wb_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(wb) {
  sc_in<sc_uint<1> > me_cntl_in_v;
  sc_in<sc_uint<8> > me_cntl_in_pc;
  sc_in<sc_uint<8> > me_cntl_in_npc;
  sc_in<sc_uint<32> > me_cntl_in_ir;
  sc_in<sc_uint<8> > me_cntl_in_br_offset;
  sc_in<sc_uint<32> > eu_wb_in_rd_data_a;
  sc_in<sc_uint<32> > eu_wb_in_rd_data_b;
  sc_out<sc_uint<1> > br_out_qual_br;

  SC_CTOR(wb) {
    dont_initialize();
  }
};

#endif
