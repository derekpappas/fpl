#ifndef INC_GUARD_top_h
#define INC_GUARD_top_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"
#include "stim_sw.h"

SC_MODULE(top) {
  sc_in<bool> clk;
  sc_signal<sc_uint<2> > ar_p_p_a;
  sc_signal<sc_uint<2> > ar_p_p_a_tmp; // added by user
  sc_signal<sc_uint<4> > ar_p_p_b;
  sc_signal<sc_uint<4> > ar_p_p_b_tmp; // added by user
  sc_signal<bool> ar_p_c_p;
  sc_signal<sc_uint<3> > ar_p_d_p;
            a *a_in_;
  b *b_in_;
  c *c_out_;
  d *d_out_;
  aSwitch *aSwitch_;

  SC_CTOR(top) {
      a_in_ = new a("a_in_");
      b_in_ = new b("b_in_");
      c_out_ = new c("c_out_");
      d_out_ = new d("d_out_");
      aSwitch_ = new aSwitch("aSwitch_");
      ar_p_p_a.write(ar_p_p_a_tmp.read());
      a_in_->clk(clk);
      a_in_->p(ar_p_p_a);
      // stimulus vector file 
      sc_trace_file * stimVecFile_a_in_;  
      // expected vector file 
      sc_trace_file * expVecFile_a_in_;  
      // create the vector files
      stimVecFile_a_in_ = sc_create_vec_file("stim_vec_a_in_",2,4);
      ((vec_file*)stimVecFile_a_in_)->sc_set_vcd_time_unit(-9);
      expVecFile_a_in_ = sc_create_vec_file("exp_vec_a_in_",2,4);
      ((vec_file*)expVecFile_a_in_)->sc_set_vcd_time_unit(-9);
      sc_trace(expVecFile_a_in_, a_in_->p, std::string("p") );

      ar_p_p_b.write(ar_p_p_b_tmp.read());
      b_in_->clk(clk);
      b_in_->p(ar_p_p_b);
      // stimulus vector file 
      sc_trace_file * stimVecFile_b_in_;  
      // expected vector file 
      sc_trace_file * expVecFile_b_in_;  
      // create the vector files
      stimVecFile_b_in_ = sc_create_vec_file("stim_vec_b_in_",2,4);
      ((vec_file*)stimVecFile_b_in_)->sc_set_vcd_time_unit(-9);
      expVecFile_b_in_ = sc_create_vec_file("exp_vec_b_in_",2,4);
      ((vec_file*)expVecFile_b_in_)->sc_set_vcd_time_unit(-9);
      sc_trace(expVecFile_b_in_, b_in_->p, std::string("p") );

      c_out_->clk(clk);
      c_out_->p(ar_p_c_p);
      // stimulus vector file 
      sc_trace_file * stimVecFile_c_out_;  
      // expected vector file 
      sc_trace_file * expVecFile_c_out_;  
      // create the vector files
      stimVecFile_c_out_ = sc_create_vec_file("stim_vec_c_out_",2,4);
      ((vec_file*)stimVecFile_c_out_)->sc_set_vcd_time_unit(-9);
      expVecFile_c_out_ = sc_create_vec_file("exp_vec_c_out_",2,4);
      ((vec_file*)expVecFile_c_out_)->sc_set_vcd_time_unit(-9);
      sc_trace(stimVecFile_c_out_, c_out_->p, std::string("p") );

      d_out_->clk(clk);
      d_out_->p(ar_p_d_p);
      // stimulus vector file 
      sc_trace_file * stimVecFile_d_out_;  
      // expected vector file 
      sc_trace_file * expVecFile_d_out_;  
      // create the vector files
      stimVecFile_d_out_ = sc_create_vec_file("stim_vec_d_out_",2,4);
      ((vec_file*)stimVecFile_d_out_)->sc_set_vcd_time_unit(-9);
      expVecFile_d_out_ = sc_create_vec_file("exp_vec_d_out_",2,4);
      ((vec_file*)expVecFile_d_out_)->sc_set_vcd_time_unit(-9);
      sc_trace(stimVecFile_d_out_, d_out_->p, std::string("p") );

      stim_sw *stim_sw_;
      stim_sw_ = new stim_sw("stim_sw_");
      stim_sw_->A(ar_p_p_a_tmp);
      stim_sw_->B(ar_p_p_b_tmp);
      stim_sw_->clk(clk);
      aSwitch_->clk(clk);
      aSwitch_->p_a(ar_p_p_a_tmp);
      aSwitch_->p_b(ar_p_p_b_tmp);
      aSwitch_->p_c(ar_p_c_p);
      aSwitch_->p_d(ar_p_d_p);
      // stimulus vector file 
      sc_trace_file * stimVecFile_aSwitch_;  
      // expected vector file 
      sc_trace_file * expVecFile_aSwitch_;  
      // create the vector files
      stimVecFile_aSwitch_ = sc_create_vec_file("stim_vec_aSwitch_",2,4);
      ((vec_file*)stimVecFile_aSwitch_)->sc_set_vcd_time_unit(-9);
      expVecFile_aSwitch_ = sc_create_vec_file("exp_vec_aSwitch_",2,4);
      ((vec_file*)expVecFile_aSwitch_)->sc_set_vcd_time_unit(-9);
      sc_trace(stimVecFile_aSwitch_, aSwitch_->p_a, std::string("p_a") );
      sc_trace(stimVecFile_aSwitch_, aSwitch_->p_b, std::string("p_b") );
      sc_trace(expVecFile_aSwitch_, aSwitch_->p_c, std::string("p_c") );
      sc_trace(expVecFile_aSwitch_, aSwitch_->p_d, std::string("p_d") );

    dont_initialize();
  }
};

#endif
