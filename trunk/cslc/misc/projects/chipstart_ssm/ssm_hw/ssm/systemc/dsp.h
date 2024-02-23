#ifndef INC_GUARD_dsp_h
#define INC_GUARD_dsp_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "me.h"

SC_MODULE(dsp) {
  sc_in<bool> gbl_clk;
  sc_in<bool> gbl_reset_;
  sc_in<bool> gbl_enable;
  sc_out<sc_uint<32> > slave_Va2r_tap_dsp_read_data;
  sc_out<bool> slave_Va2r_tap_dsp_ready;
  sc_out<bool> slave_Va2r_tap_dsp_error;
  sc_out<sc_uint<20> > slave_Va2r_tap_dsp_address;
  sc_out<sc_uint<32> > slave_Va2r_tap_dsp_data;
  sc_out<bool> slave_Va2r_tap_dsp_read;
  sc_out<bool> slave_Va2r_tap_dsp_write;
  
  me *me_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_dsp;  
  // expected vector file 
  sc_trace_file * expVecFile_dsp;  

//  void createInstVec(std::string inst) { 
//    char st[] = "stim_vec_"; 
//    char exp[] = "exp_vec_"; 
//    const char* nm = inst.c_str(); 
//    char* stimInst = strcat(st,nm); 
//    char* expInst = strcat(exp,nm); 
//
//    // create the vector files
//    stimVecFile_dsp = sc_create_vec_file(stimInst,2,4);
//    ((vec_file*)stimVecFile_dsp)->sc_set_vcd_time_unit(-9);
//    expVecFile_dsp = sc_create_vec_file(expInst,2,4);
//    ((vec_file*)expVecFile_dsp)->sc_set_vcd_time_unit(-9);
//    sc_trace(expVecFile_dsp, slave_Va2r_tap_dsp_read_data, std::string("slave_Va2r_tap_dsp_read_data") );
//    sc_trace(expVecFile_dsp, slave_Va2r_tap_dsp_ready, std::string("slave_Va2r_tap_dsp_ready") );
//    sc_trace(expVecFile_dsp, slave_Va2r_tap_dsp_error, std::string("slave_Va2r_tap_dsp_error") );
//    sc_trace(expVecFile_dsp, slave_Va2r_tap_dsp_address, std::string("slave_Va2r_tap_dsp_address") );
//    sc_trace(expVecFile_dsp, slave_Va2r_tap_dsp_data, std::string("slave_Va2r_tap_dsp_data") );
//    sc_trace(expVecFile_dsp, slave_Va2r_tap_dsp_read, std::string("slave_Va2r_tap_dsp_read") );
//    sc_trace(expVecFile_dsp, slave_Va2r_tap_dsp_write, std::string("slave_Va2r_tap_dsp_write") );
//
//  }

  SC_CTOR(dsp) {
      me_ = new me("me_");
	  //      me_->createInstVec("me_");

	  me_->gbl_clk  (gbl_clk  );
	  me_->gbl_reset_(gbl_reset_);
	  me_->gbl_enable(gbl_enable);

      me_->slave_Va2r_tap_arm_address(slave_Va2r_tap_dsp_address);
      me_->slave_Va2r_tap_arm_data(slave_Va2r_tap_dsp_data);
      me_->slave_Va2r_tap_arm_error(slave_Va2r_tap_dsp_error);
      me_->slave_Va2r_tap_arm_read(slave_Va2r_tap_dsp_read);
      me_->slave_Va2r_tap_arm_read_data(slave_Va2r_tap_dsp_read_data);
      me_->slave_Va2r_tap_arm_ready(slave_Va2r_tap_dsp_ready);
      me_->slave_Va2r_tap_arm_write(slave_Va2r_tap_dsp_write);
    dont_initialize();
  }
};

#endif
