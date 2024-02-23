#ifndef INC_GUARD_rf_h
#define INC_GUARD_rf_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(rf) {
  sc_out<sc_uint<32> > Va2r_tap_slave_in_ifc_read_data;
  sc_out<bool> Va2r_tap_slave_in_ifc_ready;
  sc_out<bool> Va2r_tap_slave_in_ifc_error;
  sc_out<sc_uint<20> > Va2r_tap_slave_in_ifc_address;
  sc_out<sc_uint<32> > Va2r_tap_slave_in_ifc_data;
  sc_out<bool> Va2r_tap_slave_in_ifc_read;
  sc_out<bool> Va2r_tap_slave_in_ifc_write;
  // stimulus vector file 
  sc_trace_file * stimVecFile_rf;  
  // expected vector file 
  sc_trace_file * expVecFile_rf;  

  void createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_rf = sc_create_vec_file(stimInst,2,4);
    ((vec_file*)stimVecFile_rf)->sc_set_vcd_time_unit(-9);
    expVecFile_rf = sc_create_vec_file(expInst,2,4);
    ((vec_file*)expVecFile_rf)->sc_set_vcd_time_unit(-9);
    sc_trace(expVecFile_rf, Va2r_tap_slave_in_ifc_read_data, std::string("Va2r_tap_slave_in_ifc_read_data") );
    sc_trace(expVecFile_rf, Va2r_tap_slave_in_ifc_ready, std::string("Va2r_tap_slave_in_ifc_ready") );
    sc_trace(expVecFile_rf, Va2r_tap_slave_in_ifc_error, std::string("Va2r_tap_slave_in_ifc_error") );
    sc_trace(expVecFile_rf, Va2r_tap_slave_in_ifc_address, std::string("Va2r_tap_slave_in_ifc_address") );
    sc_trace(expVecFile_rf, Va2r_tap_slave_in_ifc_data, std::string("Va2r_tap_slave_in_ifc_data") );
    sc_trace(expVecFile_rf, Va2r_tap_slave_in_ifc_read, std::string("Va2r_tap_slave_in_ifc_read") );
    sc_trace(expVecFile_rf, Va2r_tap_slave_in_ifc_write, std::string("Va2r_tap_slave_in_ifc_write") );

  }

  SC_CTOR(rf) {
    dont_initialize();
  }
};

#endif
