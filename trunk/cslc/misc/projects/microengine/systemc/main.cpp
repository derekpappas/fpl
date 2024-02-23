//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "me_config.h"
#include "me.h"
#include <stdio.h>
#include "systemc.h"
#include <iostream>
#include <fstream>
#include <string>

using namespace std;
  
SC_MODULE (me_tb) {
	sc_in<bool> clk;
  
 	sc_signal<bool> reset_;
	sc_signal<bool> stall;
	sc_signal<bool> enable;
	sc_signal<sc_uint<3> > in, out;

	me *me_;
     
	void do_test() {

		//		me_->loadInstructionMemory("test.asm");
		//		me_->loadInstructionMemory("test.asm", false);
		me_->loadInstructionMemory("hw_test.asm", false);
		reset_ = true; 
		enable  = false; 
		wait(20);

		cout << "@" << sc_time_stamp() <<" Starting test"<<endl;
		wait();
		cout << "@" << sc_time_stamp() <<" Asserting reset_"<<endl;
		reset_ = false; 
		wait(4);
		cout << "@" << sc_time_stamp() <<" De-Asserting reset_"<<endl;
		reset_ = true; 
		enable  = true; 
		wait(3);

		me_->init();
		wait(3);
		wait(450);
		cout << "@" << sc_time_stamp() <<" Terminating simulation"<<endl;
		sc_stop();
	}
 
	SC_CTOR(me_tb) {
		// user should add signals corresponding to the ports in the modules

		me_ = new me("me0_");
		me_->clk(clk);
		me_->reset_(reset_);
		me_->enable(enable);

		SC_THREAD (do_test);
		dont_initialize();
		sensitive << clk.pos();
	}
};
 
int sc_main (int argc, char* argv[]) {
	//   sc_clock clock ("my_clock",1,0.5);
 
	// default clock
	sc_clock clk("clk", 10, SC_NS, 0.5);

	me_tb  tb("ME_TB");
	tb.clk (clk.signal());
	sc_trace_file *wf = sc_create_vcd_trace_file("tb_me");
	sc_trace(wf, tb.clk, "clk");
	sc_trace(wf, tb.reset_, "reset_");
	sc_trace(wf, tb.me_->reset_, "reset_");
	sc_trace(wf, tb.me_->enable, "enable");
	sc_trace(wf, tb.me_->pc_im_v, "pc_im_v");
	sc_trace(wf, tb.me_->im_rf_v, "im_rf_v");
	sc_trace(wf, tb.me_->rf_eu_v, "rf_eu_v");
	sc_trace(wf, tb.me_->eu_branch, "eu_branch");
	sc_trace(wf, tb.me_->im_RnW, "im_RnW");
	sc_trace(wf, tb.me_->pc_im_address, "pc_im_address");
	sc_trace(wf, tb.me_->pc_0, "pc_0");
	sc_trace(wf, tb.me_->im_data, "im_data");


	sc_trace(wf, tb.me_-> pc_0, " pc_0");
	sc_trace(wf, tb.me_->npc_2, "npc_2");
	sc_trace(wf, tb.me_->npc_3, "npc_3");
	sc_trace(wf, tb.me_->npc_4, "npc_4");
	sc_trace(wf, tb.me_->eu_rf_wr_data , "eu_rf_wr_data");
	sc_trace(wf, tb.me_->pc_im_v       , "pc_im_v");
	sc_trace(wf, tb.me_->im_rf_v       , "im_rf_v");
	sc_trace(wf, tb.me_->rf_eu_v       , "rf_eu_v");
	sc_trace(wf, tb.me_->eu_rf_wren    , "eu_rf_wren");
	sc_trace(wf, tb.me_->ir_rf_3, "ir_rf_3");
	sc_trace(wf, tb.me_->ir_eu_4, "ir_eu_4");
	sc_trace(wf, tb.me_->im_clock     , "im_clock");
	sc_trace(wf, tb.me_->im_RnW       , "im_RnW");
	sc_trace(wf, tb.me_->pc_im_address, "pc_im_address");
	sc_trace(wf, tb.me_->im_data      , "im_data");
	sc_trace(wf, tb.me_->rf_wr_data , "rf_wr_data");
	sc_trace(wf, tb.me_->rf_wren    , "rf_wren");
	sc_trace(wf, tb.me_->rf_rd_data_a, "rf_rd_data_a");
	sc_trace(wf, tb.me_->rf_rd_data_b, "rf_rd_data_b");
	sc_trace(wf, tb.me_->eu_->eu_rf_wr_data_las, "eu_rf_wr_data_las");
	sc_trace(wf, tb.me_->eu_->eu_rf_wr_data_bit, "eu_rf_wr_data_bit");
	sc_trace(wf, tb.me_->eu_->rf_eu_ir     , "rf_eu_ir     ");
	sc_trace(wf, tb.me_->eu_->src_a        , "src_a        ");
	sc_trace(wf, tb.me_->eu_->src_b        , "src_b        ");
	sc_trace(wf, tb.me_->eu_->eu_rf_wr_data, "eu_rf_wr_data");
	sc_trace(wf, tb.me_->eu_->eu_rf_wr_addr, "eu_rf_wr_addr");
	sc_trace(wf, tb.me_->eu_->eu_rf_wren   , "eu_rf_wren   ");
	sc_trace(wf, tb.me_->eu_->eu_branch    , "eu_branch    ");
	sc_trace(wf, tb.me_->eu_->rf_eu_v, "rf_eu_v");

	sc_trace(wf, tb.me_->rf_->bypass_a, "bypass_a");
	sc_trace(wf, tb.me_->rf_->bypass_b, "bypass_b");

	sc_trace(wf, tb.me_->rf_->im_rf_ir           , "im_rf_ir");
	sc_trace(wf, tb.me_->rf_->rd_data_a           , "rd_data_a           ");
	sc_trace(wf, tb.me_->rf_->rd_data_b           , "rd_data_b           ");
	sc_trace(wf, tb.me_->rf_->im_rf_v             , "im_rf_v             ");
	sc_trace(wf, tb.me_->rf_->rf_eu_v             , "rf_eu_v             ");
	sc_trace(wf, tb.me_->rf_->rd_data_dest        , "rd_data_dest        ");
	sc_trace(wf, tb.me_->rf_->rden_a              , "rden_a              ");
	sc_trace(wf, tb.me_->rf_->rd_addr_a           , "rd_addr_a           ");
	sc_trace(wf, tb.me_->rf_->rd_addr_a_d1        , "rd_addr_a_d1        ");
	sc_trace(wf, tb.me_->rf_->rden_b              , "rden_b              ");
	sc_trace(wf, tb.me_->rf_->rd_addr_b           , "rd_addr_b           ");
	sc_trace(wf, tb.me_->rf_->rd_addr_b_d1        , "rd_addr_b_d1        ");
	sc_trace(wf, tb.me_->rf_->rd_data_imm_a       , "rd_data_imm_a       ");
	sc_trace(wf, tb.me_->rf_->rd_data_rf_a        , "rd_data_rf_a        ");
	sc_trace(wf, tb.me_->rf_->swap_wren           , "swap_wren           ");
	sc_trace(wf, tb.me_->rf_->swap_wr_addr_a      , "swap_wr_addr_a      ");
	sc_trace(wf, tb.me_->rf_->swap_wr_data_a      , "swap_wr_data_a      ");
	sc_trace(wf, tb.me_->rf_->swap_wr_addr_b      , "swap_wr_addr_b      ");
	sc_trace(wf, tb.me_->rf_->swap_wr_data_b      , "swap_wr_data_b      ");
	sc_trace(wf, tb.me_->rf_->swapbit_wren        , "swapbit_wren        ");
	sc_trace(wf, tb.me_->rf_->swapbit_wr_addr_a   , "swapbit_wr_addr_a   ");
	sc_trace(wf, tb.me_->rf_->swapbit_wr_data_a   , "swapbit_wr_data_a   ");
	sc_trace(wf, tb.me_->rf_->swapbit_wr_addr_b   , "swapbit_wr_addr_b   ");
	sc_trace(wf, tb.me_->rf_->swapbit_wr_data_b   , "swapbit_wr_data_b   ");
	sc_trace(wf, tb.me_->rf_->testbit_wren        , "testbit_wren        ");
	sc_trace(wf, tb.me_->rf_->testbit_wr_addr     , "testbit_wr_addr     ");
	sc_trace(wf, tb.me_->rf_->testbit_wr_data     , "testbit_wr_data     ");
	sc_trace(wf, tb.me_->rf_->setbit_wren         , "setbit_wren         ");
	sc_trace(wf, tb.me_->rf_->setbit_wr_addr      , "setbit_wr_addr      ");
	sc_trace(wf, tb.me_->rf_->setbit_wr_data      , "setbit_wr_data      ");
	sc_trace(wf, tb.me_->rf_->ldimm_ab_16_wren    , "ldimm_ab_16_wren    ");
	sc_trace(wf, tb.me_->rf_->ldimm_ab_16_wr_addr , "ldimm_ab_16_wr_addr ");
	sc_trace(wf, tb.me_->rf_->ldimm_ab_16_wr_data , "ldimm_ab_16_wr_data ");
	sc_trace(wf, tb.me_->rf_->rf_mux_in_wren_a    , "rf_mux_in_wren_a    ");
	sc_trace(wf, tb.me_->rf_->rf_mux_in_wr_addr_a , "rf_mux_in_wr_addr_a ");
	sc_trace(wf, tb.me_->rf_->rf_mux_in_wr_data_a , "rf_mux_in_wr_data_a ");
	sc_trace(wf, tb.me_->rf_->rf_mux_in_wren_b    , "rf_mux_in_wren_b    ");
	sc_trace(wf, tb.me_->rf_->rf_mux_in_wr_addr_b , "rf_mux_in_wr_addr_b ");
	sc_trace(wf, tb.me_->rf_->rf_mux_in_wr_data_b , "rf_mux_in_wr_data_b ");
	sc_trace(wf, tb.me_->rf_->bypass_a            , "bypass_a            ");
	sc_trace(wf, tb.me_->rf_->bypass_b            , "bypass_b            ");
	sc_trace(wf, tb.me_->rf_->rd_data_imm_mux_a   , "rd_data_imm_mux_a   ");
	sc_trace(wf, tb.me_->rf_->rd_data_bypass_mux_a, "rd_data_bypass_mux_a");
	sc_trace(wf, tb.me_->rf_->rd_data_imm_mux_b   , "rd_data_imm_mux_b   ");
	sc_trace(wf, tb.me_->rf_->rd_data_bypass_mux_b, "rd_data_bypass_mux_b");
	sc_trace(wf, tb.me_->rf_->rf_dest_data        , "rf_dest_data        ");

	sc_trace(wf, tb.me_->rf_->rfa_wire_0 , "rfa_0 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_1 , "rfa_1 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_2 , "rfa_2 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_3 , "rfa_3 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_4 , "rfa_4 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_5 , "rfa_5 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_6 , "rfa_6 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_7 , "rfa_7 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_8 , "rfa_8 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_9 , "rfa_9 ");
	sc_trace(wf, tb.me_->rf_->rfa_wire_10, "rfa_10");
	sc_trace(wf, tb.me_->rf_->rfa_wire_11, "rfa_11");
	sc_trace(wf, tb.me_->rf_->rfa_wire_12, "rfa_12");
	sc_trace(wf, tb.me_->rf_->rfa_wire_13, "rfa_13");
	sc_trace(wf, tb.me_->rf_->rfa_wire_14, "rfa_14");
	sc_trace(wf, tb.me_->rf_->rfa_wire_15, "rfa_15");
	sc_trace(wf, tb.me_->rf_->rfa_wire_16, "rfa_16");
	sc_trace(wf, tb.me_->rf_->rfa_wire_17, "rfa_17");
	sc_trace(wf, tb.me_->rf_->rfa_wire_18, "rfa_18");
	sc_trace(wf, tb.me_->rf_->rfa_wire_19, "rfa_19");
	sc_trace(wf, tb.me_->rf_->rfa_wire_20, "rfa_20");
	sc_trace(wf, tb.me_->rf_->rfa_wire_21, "rfa_21");
	sc_trace(wf, tb.me_->rf_->rfa_wire_22, "rfa_22");
	sc_trace(wf, tb.me_->rf_->rfa_wire_23, "rfa_23");
	sc_trace(wf, tb.me_->rf_->rfa_wire_24, "rfa_24");
	sc_trace(wf, tb.me_->rf_->rfa_wire_25, "rfa_25");
	sc_trace(wf, tb.me_->rf_->rfa_wire_26, "rfa_26");
	sc_trace(wf, tb.me_->rf_->rfa_wire_27, "rfa_27");
	sc_trace(wf, tb.me_->rf_->rfa_wire_28, "rfa_28");
	sc_trace(wf, tb.me_->rf_->rfa_wire_29, "rfa_29");
	sc_trace(wf, tb.me_->rf_->rfa_wire_30, "rfa_30");
	sc_trace(wf, tb.me_->rf_->rfa_wire_31, "rfa_31");

	sc_start();
	//sc_close_vcd_trace_file(wf);


	return 0;
}
