#ifndef INC_GUARD_ssm_master_h
#define INC_GUARD_ssm_master_h

#include "systemc.h"
//#include "SystemCVectorWriterTrace.h"

SC_MODULE(ssm_master) {
  sc_in<bool> Va2r_tap_master_ifc_address;
  sc_in<bool> Va2r_tap_master_ifc_write_data;
  sc_in<bool> Va2r_tap_master_ifc_read;
  sc_in<bool> Va2r_tap_master_ifc_write;
  sc_in<bool> gbl_clk;
  sc_in<bool> gbl_reset_;
  sc_in<bool> gbl_enable;
  sc_out<bool> Va2r_tap_master_ifc_read_data;
  sc_out<bool> Va2r_tap_master_ifc_ready;
  sc_out<bool> Va2r_tap_master_ifc_error;
//  //  // stimulus vector file 
//  sc_trace_file * stimVecFile_ssm_master;  
//  // expected vector file 
//  sc_trace_file * expVecFile_ssm_master;  

//  void createInstVec(std::string inst) { 
//    char st[] = "stim_vec_"; 
//    char exp[] = "exp_vec_"; 
//    const char* nm = inst.c_str(); 
//    char* stimInst = strcat(st,nm); 
//    char* expInst = strcat(exp,nm); 
//
//    // create the vector files
//    stimVecFile_ssm_master = sc_create_vec_file(stimInst,2,4);
//    ((vec_file*)stimVecFile_ssm_master)->sc_set_vcd_time_unit(-9);
//    expVecFile_ssm_master = sc_create_vec_file(expInst,2,4);
//    ((vec_file*)expVecFile_ssm_master)->sc_set_vcd_time_unit(-9);
//    sc_trace(stimVecFile_ssm_master, Va2r_tap_master_ifc_address, std::string("Va2r_tap_master_ifc_address") );
//    sc_trace(stimVecFile_ssm_master, Va2r_tap_master_ifc_write_data, std::string("Va2r_tap_master_ifc_write_data") );
//    sc_trace(stimVecFile_ssm_master, Va2r_tap_master_ifc_read, std::string("Va2r_tap_master_ifc_read") );
//    sc_trace(stimVecFile_ssm_master, Va2r_tap_master_ifc_write, std::string("Va2r_tap_master_ifc_write") );
//    sc_trace(stimVecFile_ssm_master, gbl_clk, std::string("gbl_clk") );
//    sc_trace(stimVecFile_ssm_master, gbl_reset_, std::string("gbl_reset_") );
//    sc_trace(stimVecFile_ssm_master, gbl_enable, std::string("gbl_enable") );
//    sc_trace(expVecFile_ssm_master, Va2r_tap_master_ifc_read_data, std::string("Va2r_tap_master_ifc_read_data") );
//    sc_trace(expVecFile_ssm_master, Va2r_tap_master_ifc_ready, std::string("Va2r_tap_master_ifc_ready") );
//    sc_trace(expVecFile_ssm_master, Va2r_tap_master_ifc_error, std::string("Va2r_tap_master_ifc_error") );
//
//  }

  SC_CTOR(ssm_master) {
    dont_initialize();
  }
};

#endif
