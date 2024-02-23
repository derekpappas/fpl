#ifndef INC_GUARD_pc_h
#define INC_GUARD_pc_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(pc) {
  sc_out<sc_uint<1> > me_cntl_out_v;
  sc_out<sc_uint<8> > me_cntl_out_pc;
  sc_out<sc_uint<8> > me_cntl_out_npc;
  sc_out<sc_uint<32> > me_cntl_out_ir;
  sc_out<sc_uint<8> > me_cntl_out_br_offset;

  SC_CTOR(pc) {
    dont_initialize();
  }
};

#endif
