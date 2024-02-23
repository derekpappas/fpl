#ifndef INC_GUARD_mcb_h
#define INC_GUARD_mcb_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(mcb) {
  sc_in<sc_uint<32> > mbc_in_ifc_read_data;
  sc_in<sc_uint<32> > mbc_in_ifc_control;
  sc_out<sc_uint<32> > a2rtap_slave_in_ifc_read_data;
  sc_out<sc_uint<1> > a2rtap_slave_in_ifc_ready;
  sc_out<sc_uint<1> > a2rtap_slave_in_ifc_error;
  sc_out<sc_uint<20> > a2rtap_slave_in_ifc_address;
  sc_out<sc_uint<32> > a2rtap_slave_in_ifc_data;
  sc_out<sc_uint<1> > a2rtap_slave_in_ifc_read;
  sc_out<sc_uint<1> > a2rtap_slave_in_ifc_write;
  sc_out<sc_uint<32> > mbc_in_ifc_address;
  sc_out<sc_uint<32> > mbc_in_ifc_write_data;
  sc_out<sc_uint<1> > mbc_in_ifc_write;
  sc_out<sc_uint<1> > mbc_in_ifc_read;

  SC_CTOR(mcb) {
    dont_initialize();
  }
};

#endif
