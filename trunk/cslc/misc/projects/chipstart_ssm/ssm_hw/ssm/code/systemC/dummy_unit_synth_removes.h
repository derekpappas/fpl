#ifndef INC_GUARD_dummy_unit_synth_removes_h
#define INC_GUARD_dummy_unit_synth_removes_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(dummy_unit_synth_removes) {
  sc_in<sc_uint<1> > dummy1_master_ifc_address;
  sc_in<sc_uint<1> > dummy1_master_ifc_write_data;
  sc_in<sc_uint<1> > dummy1_master_ifc_read;
  sc_in<sc_uint<1> > dummy1_master_ifc_write;
  sc_in<sc_uint<1> > dummy2_master_ifc_address;
  sc_in<sc_uint<1> > dummy2_master_ifc_write_data;
  sc_in<sc_uint<1> > dummy2_master_ifc_read;
  sc_in<sc_uint<1> > dummy2_master_ifc_write;
  sc_in<sc_uint<1> > dummy3_master_ifc_address;
  sc_in<sc_uint<1> > dummy3_master_ifc_write_data;
  sc_in<sc_uint<1> > dummy3_master_ifc_read;
  sc_in<sc_uint<1> > dummy3_master_ifc_write;
  sc_out<sc_uint<1> > dummy1_master_ifc_read_data;
  sc_out<sc_uint<1> > dummy1_master_ifc_ready;
  sc_out<sc_uint<1> > dummy1_master_ifc_error;
  sc_out<sc_uint<1> > dummy2_master_ifc_read_data;
  sc_out<sc_uint<1> > dummy2_master_ifc_ready;
  sc_out<sc_uint<1> > dummy2_master_ifc_error;
  sc_out<sc_uint<1> > dummy3_master_ifc_read_data;
  sc_out<sc_uint<1> > dummy3_master_ifc_ready;
  sc_out<sc_uint<1> > dummy3_master_ifc_error;

  SC_CTOR(dummy_unit_synth_removes) {
    dont_initialize();
  }
};

#endif
