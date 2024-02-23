#ifndef INC_GUARD_eu_h
#define INC_GUARD_eu_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(eu) {
  sc_in<sc_uint<32> > rf_eu_rfi_rd_data_a;
  sc_in<sc_uint<32> > rf_eu_rfi_rd_data_b;
  sc_in<sc_uint<1> > br_in_qual_br;
  sc_out<sc_uint<32> > eu_im_out_rd_data_a;
  sc_out<sc_uint<32> > eu_im_out_rd_data_b;
  sc_out<sc_uint<32> > eu_rf_out_rd_data_a;
  sc_out<sc_uint<32> > eu_rf_out_rd_data_b;

  SC_CTOR(eu) {
    dont_initialize();
  }
};

#endif
