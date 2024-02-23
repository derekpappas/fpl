#ifndef INC_GUARD_im_h
#define INC_GUARD_im_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(im) {
  sc_in<sc_uint<1> > me_cntl_in_v;
  sc_in<sc_uint<8> > me_cntl_in_pc;
  sc_in<sc_uint<8> > me_cntl_in_npc;
  sc_in<sc_uint<32> > me_cntl_in_ir;
  sc_in<sc_uint<8> > me_cntl_in_br_offset;
  sc_in<sc_uint<1> > br_in_qual_br;
  sc_out<sc_uint<4> > im_rf_out_rfi_wr_addr;
  sc_out<sc_uint<1> > im_rf_out_rfi_wr_en;
  sc_out<sc_uint<32> > im_rf_out_rfi_wr_data;
  sc_out<sc_uint<4> > im_rf_out_rfi_rd_addr_a;
  sc_out<sc_uint<1> > im_rf_out_rfi_rd_en_a;
  sc_out<sc_uint<4> > im_rf_out_rfi_rd_addr_b;
  sc_out<sc_uint<1> > im_rf_out_rfi_rd_en_b;
  sc_out<sc_uint<1> > me_cntl_out_v;
  sc_out<sc_uint<8> > me_cntl_out_pc;
  sc_out<sc_uint<8> > me_cntl_out_npc;
  sc_out<sc_uint<32> > me_cntl_out_ir;
  sc_out<sc_uint<8> > me_cntl_out_br_offset;

  SC_CTOR(im) {
    dont_initialize();
  }
};

#endif
