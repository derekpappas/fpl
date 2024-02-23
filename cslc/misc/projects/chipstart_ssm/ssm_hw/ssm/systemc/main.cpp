//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006 - 2009 FastpathLogic Inc
#include "SystemCVectorWriterTrace.h" 
#include "ssm.h"
#include "Va2r_tap.h"
#include "arm.h"
#include "cmpr.h"
#include "dsp.h"
#include "dummy_unit_synth_removes.h"
#include "eu.h"
#include "h264.h"
#include "im.h"
#include "me.h"
#include "rf.h"
#include "ssm_master.h"

SC_MODULE (ssm_tb) {
	sc_in<bool> gbl_clk;
  
 	sc_signal<bool> gbl_reset_;
	sc_signal<bool> stall;
	sc_signal<bool> gbl_enable;
	sc_signal<sc_uint<3> > in, out;

	ssm *ssm_;
     
	void do_test() {

		gbl_reset_ = true; 
		gbl_enable  = false; 
		wait(20);

		cout << "@" << sc_time_stamp() <<" Starting test"<<endl;
		wait();
		cout << "@" << sc_time_stamp() <<" Asserting gbl_reset_"<<endl;
		gbl_reset_ = false; 
		wait(4);
		cout << "@" << sc_time_stamp() <<" De-Asserting gbl_reset_"<<endl;
		gbl_reset_ = true; 
		gbl_enable  = true; 
		wait(3);

		//		ssm_->init();
		wait(3);
		wait(450);
		cout << "@" << sc_time_stamp() <<" Terminating simulation"<<endl;
		sc_stop();
	}
 
	SC_CTOR(ssm_tb) {
		// user should add signals corresponding to the ports in the modules

		ssm_ = new ssm("ssm0");
		ssm_->gbl_clk(gbl_clk);
		ssm_->gbl_reset_(gbl_reset_);
		ssm_->gbl_enable(gbl_enable);

		SC_THREAD (do_test);
		dont_initialize();
		sensitive << gbl_clk.pos();
	}
};
 
int sc_main (int argc, char* argv[]) {
	//   sc_clock clock ("my_clock",1,0.5);
 
	// default clock
	sc_clock gbl_clk("gbl_clk", 10, SC_NS, 0.5);

	ssm_tb  tb("SSM_TB");
	tb.gbl_clk (gbl_clk.signal());
	//	sc_trace_file *wf = sc_create_vcd_trace_file("tb_ssm");
//	sc_trace(wf, tb.gbl_clk, "gbl_clk");
//	sc_trace(wf, tb.gbl_reset_, "gbl_reset_");

	sc_start();
	//sc_close_vcd_trace_file(wf);


	return 0;
}
