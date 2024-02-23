#ifndef INC_GUARD_a2p_h
#define INC_GUARD_a2p_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(a2p) {
  sc_in<sc_uint<1> > a2rtap_master_ifc_address;
  sc_in<sc_uint<1> > a2rtap_master_ifc_write_data;
  sc_in<sc_uint<1> > a2rtap_master_ifc_read;
  sc_in<sc_uint<1> > a2rtap_master_ifc_write;
  sc_in<sc_uint<1> > gbl_clock;
  sc_in<sc_uint<1> > gbl_reset;
  sc_in<sc_uint<1> > gbl_a2rtap_pipe_en;
  sc_out<sc_uint<1> > a2rtap_master_ifc_read_data;
  sc_out<sc_uint<1> > a2rtap_master_ifc_ready;
  sc_out<sc_uint<1> > a2rtap_master_ifc_error;

  SC_CTOR(a2p) {
    dont_initialize();
  }
};

#endif
