#ifndef INC_GUARD_a2rtap_h
#define INC_GUARD_a2rtap_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(a2rtap) {
  sc_in<sc_uint<1> > a2rtap_master_ifc_read_data;
  sc_in<sc_uint<1> > a2rtap_master_ifc_ready;
  sc_in<sc_uint<1> > a2rtap_master_ifc_error;
  sc_in<sc_uint<1> > ring_out_ifc_grant;
  sc_in<sc_uint<1> > ring_out_ifc_request;
  sc_in<sc_uint<1> > ring_out_ifc_in;
  sc_in<sc_uint<1> > ring_out_ifc_aphi;
  sc_in<sc_uint<1> > ring_out_ifc_write;
  sc_in<sc_uint<1> > ring_out_ifc_read;
  sc_in<sc_uint<1> > ring_out_ifc_ready;
  sc_in<sc_uint<1> > ring_out_ifc_error;
  sc_in<sc_uint<32> > a2rtap_slave_out_ifc_read_data;
  sc_in<sc_uint<1> > a2rtap_slave_out_ifc_ready;
  sc_in<sc_uint<1> > a2rtap_slave_out_ifc_error;
  sc_in<sc_uint<20> > a2rtap_slave_out_ifc_address;
  sc_in<sc_uint<32> > a2rtap_slave_out_ifc_data;
  sc_in<sc_uint<1> > a2rtap_slave_out_ifc_read;
  sc_in<sc_uint<1> > a2rtap_slave_out_ifc_write;
  sc_out<sc_uint<1> > a2rtap_master_ifc_address;
  sc_out<sc_uint<1> > a2rtap_master_ifc_write_data;
  sc_out<sc_uint<1> > a2rtap_master_ifc_read;
  sc_out<sc_uint<1> > a2rtap_master_ifc_write;
  sc_out<sc_uint<1> > ring_in_ifc_grant;
  sc_out<sc_uint<1> > ring_in_ifc_request;
  sc_out<sc_uint<1> > ring_in_ifc_in;
  sc_out<sc_uint<1> > ring_in_ifc_aphi;
  sc_out<sc_uint<1> > ring_in_ifc_write;
  sc_out<sc_uint<1> > ring_in_ifc_read;
  sc_out<sc_uint<1> > ring_in_ifc_ready;
  sc_out<sc_uint<1> > ring_in_ifc_error;

  SC_CTOR(a2rtap) {
    dont_initialize();
  }
};

#endif
