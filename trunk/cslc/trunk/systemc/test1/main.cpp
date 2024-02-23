///#include "SystemCVectorWriter.h"
#include "SystemCVectorWriterTrace.h"
#include "stim.h"
#include "exor2.h"
#include "mon.h" 

int sc_main(int argc, char* argv[])
{
  sc_signal<sc_uint<4> > ASig, HSig;
  sc_signal<sc_uint<4> > BSig, ISig;
  sc_signal<sc_uint<4> > FSig, GSig;
  sc_clock TestClk("TestClock1", 10, SC_NS,0.5);

  stim Stim1("Stimulus1");
  Stim1.A(ASig);
  Stim1.B(BSig);
  Stim1.Clk(TestClk);

  stim Stim2("Stimulus2");
  Stim2.A(HSig);
  Stim2.B(ISig);
  Stim2.Clk(TestClk);

  exor2 DUT0("exor20");
  DUT0.setInstanceName("DUT0");
  DUT0.A(ASig);
  DUT0.B(BSig);
  DUT0.F(FSig);
  DUT0.clk(TestClk);
  

// to be generated
/*
  sc_trace_file * stimVecFile1;
  sc_trace_file * expVecFile1;
    stimVecFile1 = sc_create_vec_file("stim_vec_dut0", 2, 4);   
    ((vec_file*)stimVecFile1)->sc_set_vcd_time_unit(-9);
    expVecFile1 = sc_create_vec_file("exp_vec_dut0", 2, 4);   
    ((vec_file*)expVecFile1)->sc_set_vcd_time_unit(-9);
  sc_trace(stimVecFile1, DUT0.A , std::string("A") );
  sc_trace(stimVecFile1,DUT0.B , std::string("B") );
  sc_trace(expVecFile1, DUT0.F , std::string("F") );
*/
//

  exor2 DUT1("exor21");
  DUT1.setInstanceName("DUT1");
  DUT1.A(ISig);
  DUT1.B(HSig);
  DUT1.F(GSig);
  DUT1.clk(TestClk);


// to be generated
/*
  sc_trace_file * stimVecFile2;
  sc_trace_file * expVecFile2;
    stimVecFile2 = sc_create_vec_file("stim_vec_dut1", 2, 4);   
    ((vec_file*)stimVecFile2)->sc_set_vcd_time_unit(-9);
    expVecFile2 = sc_create_vec_file("exp_vec_dut1", 2, 4);   
    ((vec_file*)expVecFile2)->sc_set_vcd_time_unit(-9);
  sc_trace(stimVecFile2, DUT1.A , std::string("A") );
  sc_trace(stimVecFile2, DUT1.B , std::string("B") );
  sc_trace(expVecFile2, GSig , std::string("F") );
*/
//

  mon Monitor1("Monitor");
  Monitor1.A(ASig);
  Monitor1.B(BSig);
  Monitor1.F(FSig);
  Monitor1.Clk(TestClk);

 
  sc_start();  // run forever

// to be adapted in VWTrace and generated
  /*sc_close_vcd_trace_file(stimVecFile1);
  sc_close_vcd_trace_file(expVecFile1);
  sc_close_vcd_trace_file(stimVecFile2);
  sc_close_vcd_trace_file(expVecFile2); */


  return 0;

}
