#ifndef INC_GUARD_dummy_unit_synth_removes_h
#define INC_GUARD_dummy_unit_synth_removes_h

#include "systemc.h"
//#include "SystemCVectorWriterTrace.h"

SC_MODULE(dummy_unit_synth_removes) {
  sc_in<bool> dummy1_master_ifc_address;
  sc_in<bool> dummy1_master_ifc_write_data;
  sc_in<bool> dummy1_master_ifc_read;
  sc_in<bool> dummy1_master_ifc_write;
  sc_in<bool> dummy2_master_ifc_address;
  sc_in<bool> dummy2_master_ifc_write_data;
  sc_in<bool> dummy2_master_ifc_read;
  sc_in<bool> dummy2_master_ifc_write;
  sc_in<bool> dummy3_master_ifc_address;
  sc_in<bool> dummy3_master_ifc_write_data;
  sc_in<bool> dummy3_master_ifc_read;
  sc_in<bool> dummy3_master_ifc_write;
  sc_out<bool> dummy1_master_ifc_read_data;
  sc_out<bool> dummy1_master_ifc_ready;
  sc_out<bool> dummy1_master_ifc_error;
  sc_out<bool> dummy2_master_ifc_read_data;
  sc_out<bool> dummy2_master_ifc_ready;
  sc_out<bool> dummy2_master_ifc_error;
  sc_out<bool> dummy3_master_ifc_read_data;
  sc_out<bool> dummy3_master_ifc_ready;
  sc_out<bool> dummy3_master_ifc_error;
//  // stimulus vector file 
//  sc_trace_file * stimVecFile_dummy_unit_synth_removes;  
//  // expected vector file 
//  sc_trace_file * expVecFile_dummy_unit_synth_removes;  

//  void createInstVec(std::string inst) { 
//    char st[] = "stim_vec_"; 
//    char exp[] = "exp_vec_"; 
//    const char* nm = inst.c_str(); 
//    char* stimInst = strcat(st,nm); 
//    char* expInst = strcat(exp,nm); 
//
//    // create the vector files
//    stimVecFile_dummy_unit_synth_removes = sc_create_vec_file(stimInst,2,4);
//    ((vec_file*)stimVecFile_dummy_unit_synth_removes)->sc_set_vcd_time_unit(-9);
//    expVecFile_dummy_unit_synth_removes = sc_create_vec_file(expInst,2,4);
//    ((vec_file*)expVecFile_dummy_unit_synth_removes)->sc_set_vcd_time_unit(-9);
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy1_master_ifc_address, std::string("dummy1_master_ifc_address") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy1_master_ifc_write_data, std::string("dummy1_master_ifc_write_data") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy1_master_ifc_read, std::string("dummy1_master_ifc_read") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy1_master_ifc_write, std::string("dummy1_master_ifc_write") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy2_master_ifc_address, std::string("dummy2_master_ifc_address") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy2_master_ifc_write_data, std::string("dummy2_master_ifc_write_data") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy2_master_ifc_read, std::string("dummy2_master_ifc_read") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy2_master_ifc_write, std::string("dummy2_master_ifc_write") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy3_master_ifc_address, std::string("dummy3_master_ifc_address") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy3_master_ifc_write_data, std::string("dummy3_master_ifc_write_data") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy3_master_ifc_read, std::string("dummy3_master_ifc_read") );
//    sc_trace(stimVecFile_dummy_unit_synth_removes, dummy3_master_ifc_write, std::string("dummy3_master_ifc_write") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy1_master_ifc_read_data, std::string("dummy1_master_ifc_read_data") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy1_master_ifc_ready, std::string("dummy1_master_ifc_ready") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy1_master_ifc_error, std::string("dummy1_master_ifc_error") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy2_master_ifc_read_data, std::string("dummy2_master_ifc_read_data") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy2_master_ifc_ready, std::string("dummy2_master_ifc_ready") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy2_master_ifc_error, std::string("dummy2_master_ifc_error") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy3_master_ifc_read_data, std::string("dummy3_master_ifc_read_data") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy3_master_ifc_ready, std::string("dummy3_master_ifc_ready") );
//    sc_trace(expVecFile_dummy_unit_synth_removes, dummy3_master_ifc_error, std::string("dummy3_master_ifc_error") );
//
//  }

  SC_CTOR(dummy_unit_synth_removes) {
    dont_initialize();
  }
};

#endif
