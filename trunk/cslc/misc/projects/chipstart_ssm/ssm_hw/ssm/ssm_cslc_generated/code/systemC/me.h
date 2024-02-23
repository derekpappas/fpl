#ifndef INC_GUARD_me_h
#define INC_GUARD_me_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "rf.h"
#include "pc.h"
#include "wb.h"
#include "eu.h"
#include "im.h"

SC_MODULE(me) {
  sc_in<bool> gbl_clk;
  sc_in<bool> gbl_reset_;
  sc_in<bool> gbl_enable;
  sc_out<sc_uint<32> > slave_Va2r_tap_arm_read_data;
  sc_out<bool> slave_Va2r_tap_arm_ready;
  sc_out<bool> slave_Va2r_tap_arm_error;
  sc_out<sc_uint<20> > slave_Va2r_tap_arm_address;
  sc_out<sc_uint<32> > slave_Va2r_tap_arm_data;
  sc_out<bool> slave_Va2r_tap_arm_read;
  sc_out<bool> slave_Va2r_tap_arm_write;
          
  rf *rf_;
  pc *pc_;
  wb *wb_;
  eu *eu_;
  im *im_;
  // stimulus vector file 
  sc_trace_file * stimVecFile_me;  
  // expected vector file 
  sc_trace_file * expVecFile_me;  

  void createInstVec(std::string inst) { 
    char st[] = "stim_vec_"; 
    char exp[] = "exp_vec_"; 
    const char* nm = inst.c_str(); 
    char* stimInst = strcat(st,nm); 
    char* expInst = strcat(exp,nm); 

    // create the vector files
    stimVecFile_me = sc_create_vec_file(stimInst,2,4);
    ((vec_file*)stimVecFile_me)->sc_set_vcd_time_unit(-9);
    expVecFile_me = sc_create_vec_file(expInst,2,4);
    ((vec_file*)expVecFile_me)->sc_set_vcd_time_unit(-9);
    sc_trace(stimVecFile_me, gbl_clk, std::string("gbl_clk") );
    sc_trace(stimVecFile_me, gbl_reset_, std::string("gbl_reset_") );
    sc_trace(stimVecFile_me, gbl_enable, std::string("gbl_enable") );
    sc_trace(expVecFile_me, slave_Va2r_tap_arm_read_data, std::string("slave_Va2r_tap_arm_read_data") );
    sc_trace(expVecFile_me, slave_Va2r_tap_arm_ready, std::string("slave_Va2r_tap_arm_ready") );
    sc_trace(expVecFile_me, slave_Va2r_tap_arm_error, std::string("slave_Va2r_tap_arm_error") );
    sc_trace(expVecFile_me, slave_Va2r_tap_arm_address, std::string("slave_Va2r_tap_arm_address") );
    sc_trace(expVecFile_me, slave_Va2r_tap_arm_data, std::string("slave_Va2r_tap_arm_data") );
    sc_trace(expVecFile_me, slave_Va2r_tap_arm_read, std::string("slave_Va2r_tap_arm_read") );
    sc_trace(expVecFile_me, slave_Va2r_tap_arm_write, std::string("slave_Va2r_tap_arm_write") );

  }

  SC_CTOR(me) {
      rf_ = new rf("rf_");
      rf_->createInstVec("rf_");
      pc_ = new pc("pc_");
      pc_->createInstVec("pc_");
      wb_ = new wb("wb_");
      wb_->createInstVec("wb_");
      eu_ = new eu("eu_");
      eu_->createInstVec("eu_");
      im_ = new im("im_");
      im_->createInstVec("im_");
      rf_->Va2r_tap_slave_in_ifc_address();
      rf_->Va2r_tap_slave_in_ifc_data();
      rf_->Va2r_tap_slave_in_ifc_error();
      rf_->Va2r_tap_slave_in_ifc_read();
      rf_->Va2r_tap_slave_in_ifc_read_data();
      rf_->Va2r_tap_slave_in_ifc_ready();
      rf_->Va2r_tap_slave_in_ifc_write();
    dont_initialize();
  }
};

#endif
