#ifndef INC_GUARD_me_h
#define INC_GUARD_me_h

#include "systemc.h"
#include "SystemCVectorWriterTrace.h"

SC_MODULE(me) {
  sc_signal<sc_uint<4> > im_rf_wr_addr;
  sc_signal<sc_uint<1> > im_rf_wr_en;
  sc_signal<sc_uint<32> > im_rf_wr_data;
  sc_signal<sc_uint<4> > im_rf_rd_addr_a;
  sc_signal<sc_uint<1> > im_rf_rd_en_a;
  sc_signal<sc_uint<4> > im_rf_rd_addr_b;
  sc_signal<sc_uint<1> > im_rf_rd_en_b;
  sc_signal<sc_uint<1> > pc_im_me_cntl_v;
  sc_signal<sc_uint<8> > pc_im_me_cntl_pc;
  sc_signal<sc_uint<8> > pc_im_me_cntl_npc;
  sc_signal<sc_uint<32> > pc_im_me_cntl_ir;
  sc_signal<sc_uint<8> > pc_im_me_cntl_br_offset;
  sc_signal<sc_uint<1> > im_rf_me_cntl_v;
  sc_signal<sc_uint<8> > im_rf_me_cntl_pc;
  sc_signal<sc_uint<8> > im_rf_me_cntl_npc;
  sc_signal<sc_uint<32> > im_rf_me_cntl_ir;
  sc_signal<sc_uint<8> > im_rf_me_cntl_br_offset;
  sc_signal<sc_uint<32> > rf_eu_rfi_rd_data_a;
  sc_signal<sc_uint<32> > rf_eu_rfi_rd_data_b;
  sc_signal<sc_uint<32> > eu_wb_rfi_rd_data_a;
  sc_signal<sc_uint<32> > eu_wb_rfi_rd_data_b;
  sc_signal<sc_uint<32> > eu_rf_rfi_rd_data_a;
  sc_signal<sc_uint<32> > eu_rf_rfi_rd_data_b;
  sc_signal<sc_uint<1> > me_br_qual_br;
            rf *rf_;
  im *im_;
  eu *eu_;
  pc *pc_;
  wb *wb_;

  SC_CTOR(me) {
      rf_ = new rf("rf_");
      im_ = new im("im_");
      eu_ = new eu("eu_");
      pc_ = new pc("pc_");
      wb_ = new wb("wb_");
      rf_->br_in_qual_br(me_br_qual_br);
      rf_->eu_rf_in_rd_data_a();
      rf_->eu_rf_in_rd_data_b();
      rf_->im_rf_in_rfi_rd_addr_a();
      rf_->im_rf_in_rfi_rd_addr_b();
      rf_->im_rf_in_rfi_rd_en_a();
      rf_->im_rf_in_rfi_rd_en_b();
      rf_->im_rf_in_rfi_wr_addr();
      rf_->im_rf_in_rfi_wr_data();
      rf_->im_rf_in_rfi_wr_en();
      rf_->rf_eu_rfi_rd_data_a(rf_eu_rfi_rd_data_a);
      rf_->rf_eu_rfi_rd_data_b(rf_eu_rfi_rd_data_b);
      // stimulus vector file 
      sc_trace_file * stimVecFile_rf_;  
      // expected vector file 
      sc_trace_file * expVecFile_rf_;  
      // create the vector files
      stimVecFile_rf_ = sc_create_vec_file("stim_vec_rf_",2,4);
      ((vec_file*)stimVecFile_rf_)->sc_set_vcd_time_unit(-9);
      expVecFile_rf_ = sc_create_vec_file("exp_vec_rf_",2,4);
      ((vec_file*)expVecFile_rf_)->sc_set_vcd_time_unit(-9);

      im_->br_in_qual_br(me_br_qual_br);
      im_->im_rf_out_rfi_rd_addr_a(im_rf_rd_addr_a);
      im_->im_rf_out_rfi_rd_addr_b(im_rf_rd_addr_b);
      im_->im_rf_out_rfi_rd_en_a(im_rf_rd_en_a);
      im_->im_rf_out_rfi_rd_en_b(im_rf_rd_en_b);
      im_->im_rf_out_rfi_wr_addr(im_rf_wr_addr);
      im_->im_rf_out_rfi_wr_data(im_rf_wr_data);
      im_->im_rf_out_rfi_wr_en(im_rf_wr_en);
      im_->me_cntl_in_br_offset(pc_im_me_cntl_br_offset);
      im_->me_cntl_in_ir(pc_im_me_cntl_ir);
      im_->me_cntl_in_npc(pc_im_me_cntl_npc);
      im_->me_cntl_in_pc(pc_im_me_cntl_pc);
      im_->me_cntl_in_v(pc_im_me_cntl_v);
      im_->me_cntl_out_br_offset(im_rf_me_cntl_br_offset);
      im_->me_cntl_out_ir(im_rf_me_cntl_ir);
      im_->me_cntl_out_npc(im_rf_me_cntl_npc);
      im_->me_cntl_out_pc(im_rf_me_cntl_pc);
      im_->me_cntl_out_v(im_rf_me_cntl_v);
      // stimulus vector file 
      sc_trace_file * stimVecFile_im_;  
      // expected vector file 
      sc_trace_file * expVecFile_im_;  
      // create the vector files
      stimVecFile_im_ = sc_create_vec_file("stim_vec_im_",2,4);
      ((vec_file*)stimVecFile_im_)->sc_set_vcd_time_unit(-9);
      expVecFile_im_ = sc_create_vec_file("exp_vec_im_",2,4);
      ((vec_file*)expVecFile_im_)->sc_set_vcd_time_unit(-9);
      sc_trace(stimVecFile_im_, im_->me_cntl_in_v, std::string("me_cntl_in_v") );
      sc_trace(stimVecFile_im_, im_->me_cntl_in_pc, std::string("me_cntl_in_pc") );
      sc_trace(stimVecFile_im_, im_->me_cntl_in_npc, std::string("me_cntl_in_npc") );
      sc_trace(stimVecFile_im_, im_->me_cntl_in_ir, std::string("me_cntl_in_ir") );
      sc_trace(stimVecFile_im_, im_->me_cntl_in_br_offset, std::string("me_cntl_in_br_offset") );
      sc_trace(stimVecFile_im_, im_->br_in_qual_br, std::string("br_in_qual_br") );
      sc_trace(expVecFile_im_, im_->im_rf_out_rfi_wr_addr, std::string("im_rf_out_rfi_wr_addr") );
      sc_trace(expVecFile_im_, im_->im_rf_out_rfi_wr_en, std::string("im_rf_out_rfi_wr_en") );
      sc_trace(expVecFile_im_, im_->im_rf_out_rfi_wr_data, std::string("im_rf_out_rfi_wr_data") );
      sc_trace(expVecFile_im_, im_->im_rf_out_rfi_rd_addr_a, std::string("im_rf_out_rfi_rd_addr_a") );
      sc_trace(expVecFile_im_, im_->im_rf_out_rfi_rd_en_a, std::string("im_rf_out_rfi_rd_en_a") );
      sc_trace(expVecFile_im_, im_->im_rf_out_rfi_rd_addr_b, std::string("im_rf_out_rfi_rd_addr_b") );
      sc_trace(expVecFile_im_, im_->im_rf_out_rfi_rd_en_b, std::string("im_rf_out_rfi_rd_en_b") );
      sc_trace(expVecFile_im_, im_->me_cntl_out_v, std::string("me_cntl_out_v") );
      sc_trace(expVecFile_im_, im_->me_cntl_out_pc, std::string("me_cntl_out_pc") );
      sc_trace(expVecFile_im_, im_->me_cntl_out_npc, std::string("me_cntl_out_npc") );
      sc_trace(expVecFile_im_, im_->me_cntl_out_ir, std::string("me_cntl_out_ir") );
      sc_trace(expVecFile_im_, im_->me_cntl_out_br_offset, std::string("me_cntl_out_br_offset") );

      eu_->br_in_qual_br(me_br_qual_br);
      eu_->eu_im_out_rd_data_a(eu_wb_rfi_rd_data_a);
      eu_->eu_im_out_rd_data_b(eu_wb_rfi_rd_data_b);
      eu_->eu_rf_out_rd_data_a(eu_rf_rfi_rd_data_a);
      eu_->eu_rf_out_rd_data_b(eu_rf_rfi_rd_data_b);
      eu_->rf_eu_rfi_rd_data_a(rf_eu_rfi_rd_data_a);
      eu_->rf_eu_rfi_rd_data_b(rf_eu_rfi_rd_data_b);
      // stimulus vector file 
      sc_trace_file * stimVecFile_eu_;  
      // expected vector file 
      sc_trace_file * expVecFile_eu_;  
      // create the vector files
      stimVecFile_eu_ = sc_create_vec_file("stim_vec_eu_",2,4);
      ((vec_file*)stimVecFile_eu_)->sc_set_vcd_time_unit(-9);
      expVecFile_eu_ = sc_create_vec_file("exp_vec_eu_",2,4);
      ((vec_file*)expVecFile_eu_)->sc_set_vcd_time_unit(-9);
      sc_trace(stimVecFile_eu_, eu_->rf_eu_rfi_rd_data_a, std::string("rf_eu_rfi_rd_data_a") );
      sc_trace(stimVecFile_eu_, eu_->rf_eu_rfi_rd_data_b, std::string("rf_eu_rfi_rd_data_b") );
      sc_trace(stimVecFile_eu_, eu_->br_in_qual_br, std::string("br_in_qual_br") );
      sc_trace(expVecFile_eu_, eu_->eu_im_out_rd_data_a, std::string("eu_im_out_rd_data_a") );
      sc_trace(expVecFile_eu_, eu_->eu_im_out_rd_data_b, std::string("eu_im_out_rd_data_b") );
      sc_trace(expVecFile_eu_, eu_->eu_rf_out_rd_data_a, std::string("eu_rf_out_rd_data_a") );
      sc_trace(expVecFile_eu_, eu_->eu_rf_out_rd_data_b, std::string("eu_rf_out_rd_data_b") );

      pc_->me_cntl_out_br_offset(pc_im_me_cntl_br_offset);
      pc_->me_cntl_out_ir(pc_im_me_cntl_ir);
      pc_->me_cntl_out_npc(pc_im_me_cntl_npc);
      pc_->me_cntl_out_pc(pc_im_me_cntl_pc);
      pc_->me_cntl_out_v(pc_im_me_cntl_v);
      // stimulus vector file 
      sc_trace_file * stimVecFile_pc_;  
      // expected vector file 
      sc_trace_file * expVecFile_pc_;  
      // create the vector files
      stimVecFile_pc_ = sc_create_vec_file("stim_vec_pc_",2,4);
      ((vec_file*)stimVecFile_pc_)->sc_set_vcd_time_unit(-9);
      expVecFile_pc_ = sc_create_vec_file("exp_vec_pc_",2,4);
      ((vec_file*)expVecFile_pc_)->sc_set_vcd_time_unit(-9);

      wb_->br_out_qual_br();
      wb_->eu_wb_in_rd_data_a();
      wb_->eu_wb_in_rd_data_b();
      wb_->me_cntl_in_br_offset(im_rf_me_cntl_br_offset);
      wb_->me_cntl_in_ir(im_rf_me_cntl_ir);
      wb_->me_cntl_in_npc(im_rf_me_cntl_npc);
      wb_->me_cntl_in_pc(im_rf_me_cntl_pc);
      wb_->me_cntl_in_v(im_rf_me_cntl_v);
      // stimulus vector file 
      sc_trace_file * stimVecFile_wb_;  
      // expected vector file 
      sc_trace_file * expVecFile_wb_;  
      // create the vector files
      stimVecFile_wb_ = sc_create_vec_file("stim_vec_wb_",2,4);
      ((vec_file*)stimVecFile_wb_)->sc_set_vcd_time_unit(-9);
      expVecFile_wb_ = sc_create_vec_file("exp_vec_wb_",2,4);
      ((vec_file*)expVecFile_wb_)->sc_set_vcd_time_unit(-9);

    dont_initialize();
  }
};

#endif
