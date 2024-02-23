#ifndef INC_GUARD_rf_h
#define INC_GUARD_rf_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(rf) {
  sc_in<sc_uint<4> > im_rf_in_rfi_wr_addr;
  sc_in<sc_uint<1> > im_rf_in_rfi_wr_en;
  sc_in<sc_uint<32> > im_rf_in_rfi_wr_data;
  sc_in<sc_uint<4> > im_rf_in_rfi_rd_addr_a;
  sc_in<sc_uint<1> > im_rf_in_rfi_rd_en_a;
  sc_in<sc_uint<4> > im_rf_in_rfi_rd_addr_b;
  sc_in<sc_uint<1> > im_rf_in_rfi_rd_en_b;
  sc_in<sc_uint<32> > eu_rf_in_rd_data_a;
  sc_in<sc_uint<32> > eu_rf_in_rd_data_b;
  sc_in<sc_uint<1> > br_in_qual_br;
  sc_out<sc_uint<32> > rf_eu_rfi_rd_data_a;
  sc_out<sc_uint<32> > rf_eu_rfi_rd_data_b;

  SC_CTOR(rf) {
    dont_initialize();
  }
};

#endif
