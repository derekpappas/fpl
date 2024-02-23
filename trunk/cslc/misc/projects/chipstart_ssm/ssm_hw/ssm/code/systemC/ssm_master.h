#ifndef INC_GUARD_ssm_master_h
#define INC_GUARD_ssm_master_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(ssm_master) {
  sc_in<sc_uint<1> > a2rtap_master_ifc_address;
  sc_in<sc_uint<1> > a2rtap_master_ifc_write_data;
  sc_in<sc_uint<1> > a2rtap_master_ifc_read;
  sc_in<sc_uint<1> > a2rtap_master_ifc_write;
  sc_out<sc_uint<1> > a2rtap_master_ifc_read_data;
  sc_out<sc_uint<1> > a2rtap_master_ifc_ready;
  sc_out<sc_uint<1> > a2rtap_master_ifc_error;

  SC_CTOR(ssm_master) {
    dont_initialize();
  }
};

#endif
