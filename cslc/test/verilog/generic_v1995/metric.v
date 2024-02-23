/******************************************************/   
/*   module metric                                    */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: This module is used to save the accumulated error metric.
// --
// File name	: metric.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : dff.v
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// Input  : m_in{0..3}        -> previous error metric
//                                 
// Output : m_out{0..3}       -> the error metric.
// ---------------------------------------------------------------------------

module metric (m_in0,m_in1,m_in2,m_in3,   
               m_out0,m_out1,m_out2,m_out3,   
               clk,reset);   

   input [2:0] m_in0,m_in1,m_in2,m_in3;   
   output [2:0] m_out0,m_out1,m_out2,m_out3;   

   input clk,reset;   

      dff #(3) metric3(m_in3, m_out3, clk, reset);   
      dff #(3) metric2(m_in2, m_out2, clk, reset);   
      dff #(3) metric1(m_in1, m_out1, clk, reset);   
      dff #(3) metric0(m_in0, m_out0, clk, reset);   

endmodule