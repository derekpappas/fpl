#ifndef INC_GUARD_Va2r_tap_h
#define INC_GUARD_Va2r_tap_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(Va2r_tap) {
  sc_in<bool> Va2r_tap_master_ifc_read_data;
  sc_in<bool> Va2r_tap_master_ifc_ready;
  sc_in<bool> Va2r_tap_master_ifc_error;
  sc_in<bool> ring_out_ifc_grant;
  sc_in<bool> ring_out_ifc_request;
  sc_in<bool> ring_out_ifc_in;
  sc_in<bool> ring_out_ifc_aphi;
  sc_in<bool> ring_out_ifc_write;
  sc_in<bool> ring_out_ifc_read;
  sc_in<bool> ring_out_ifc_ready;
  sc_in<bool> ring_out_ifc_error;
  sc_in<sc_uint<32> > Va2r_tap_slave_out_ifc_read_data;
  sc_in<bool> Va2r_tap_slave_out_ifc_ready;
  sc_in<bool> Va2r_tap_slave_out_ifc_error;
  sc_in<sc_uint<20> > Va2r_tap_slave_out_ifc_address;
  sc_in<sc_uint<32> > Va2r_tap_slave_out_ifc_data;
  sc_in<bool> Va2r_tap_slave_out_ifc_read;
  sc_in<bool> Va2r_tap_slave_out_ifc_write;
  sc_in<bool> gbl_clk;
  sc_in<bool> gbl_reset_;
  sc_in<bool> gbl_enable;
  sc_out<bool> Va2r_tap_master_ifc_address;
  sc_out<bool> Va2r_tap_master_ifc_write_data;
  sc_out<bool> Va2r_tap_master_ifc_read;
  sc_out<bool> Va2r_tap_master_ifc_write;
  sc_out<bool> ring_in_ifc_grant;
  sc_out<bool> ring_in_ifc_request;
  sc_out<bool> ring_in_ifc_in;
  sc_out<bool> ring_in_ifc_aphi;
  sc_out<bool> ring_in_ifc_write;
  sc_out<bool> ring_in_ifc_read;
  sc_out<bool> ring_in_ifc_ready;
  sc_out<bool> ring_in_ifc_error;
  // stimulus vector file 
  sc_trace_file * stimVecFile_Va2r_tap;  
  // expected vector file 
  sc_trace_file * expVecFile_Va2r_tap;  

  void createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_Va2r_tap = sc_create_vec_file(stimInst,2,4);
    ((vec_file*)stimVecFile_Va2r_tap)->sc_set_vcd_time_unit(-9);
    expVecFile_Va2r_tap = sc_create_vec_file(expInst,2,4);
    ((vec_file*)expVecFile_Va2r_tap)->sc_set_vcd_time_unit(-9);
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_master_ifc_read_data, std::string("Va2r_tap_master_ifc_read_data") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_master_ifc_ready, std::string("Va2r_tap_master_ifc_ready") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_master_ifc_error, std::string("Va2r_tap_master_ifc_error") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_grant, std::string("ring_out_ifc_grant") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_request, std::string("ring_out_ifc_request") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_in, std::string("ring_out_ifc_in") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_aphi, std::string("ring_out_ifc_aphi") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_write, std::string("ring_out_ifc_write") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_read, std::string("ring_out_ifc_read") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_ready, std::string("ring_out_ifc_ready") );
    sc_trace(stimVecFile_Va2r_tap, ring_out_ifc_error, std::string("ring_out_ifc_error") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_slave_out_ifc_read_data, std::string("Va2r_tap_slave_out_ifc_read_data") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_slave_out_ifc_ready, std::string("Va2r_tap_slave_out_ifc_ready") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_slave_out_ifc_error, std::string("Va2r_tap_slave_out_ifc_error") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_slave_out_ifc_address, std::string("Va2r_tap_slave_out_ifc_address") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_slave_out_ifc_data, std::string("Va2r_tap_slave_out_ifc_data") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_slave_out_ifc_read, std::string("Va2r_tap_slave_out_ifc_read") );
    sc_trace(stimVecFile_Va2r_tap, Va2r_tap_slave_out_ifc_write, std::string("Va2r_tap_slave_out_ifc_write") );
    sc_trace(stimVecFile_Va2r_tap, gbl_clk, std::string("gbl_clk") );
    sc_trace(stimVecFile_Va2r_tap, gbl_reset_, std::string("gbl_reset_") );
    sc_trace(stimVecFile_Va2r_tap, gbl_enable, std::string("gbl_enable") );
    sc_trace(expVecFile_Va2r_tap, Va2r_tap_master_ifc_address, std::string("Va2r_tap_master_ifc_address") );
    sc_trace(expVecFile_Va2r_tap, Va2r_tap_master_ifc_write_data, std::string("Va2r_tap_master_ifc_write_data") );
    sc_trace(expVecFile_Va2r_tap, Va2r_tap_master_ifc_read, std::string("Va2r_tap_master_ifc_read") );
    sc_trace(expVecFile_Va2r_tap, Va2r_tap_master_ifc_write, std::string("Va2r_tap_master_ifc_write") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_grant, std::string("ring_in_ifc_grant") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_request, std::string("ring_in_ifc_request") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_in, std::string("ring_in_ifc_in") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_aphi, std::string("ring_in_ifc_aphi") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_write, std::string("ring_in_ifc_write") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_read, std::string("ring_in_ifc_read") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_ready, std::string("ring_in_ifc_ready") );
    sc_trace(expVecFile_Va2r_tap, ring_in_ifc_error, std::string("ring_in_ifc_error") );

  }

  SC_CTOR(Va2r_tap) {
    dont_initialize();
  }
};

#endif
