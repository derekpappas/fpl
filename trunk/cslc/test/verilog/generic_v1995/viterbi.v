/******************************************************/   
/* module viterbi                                     */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: TOP LEVEL MODULE OF DECODER PART
// --
// File name	: viterbi.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : compute_metric.v
//                compare_select.v
//                reduce.v
//                metric.v
//                path_memory.v
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// input : in0 ... in3    -> the distance of received
//                           data 
// output : decode_out    -> the decoded data
// --
//  The Decoder [K=3 and rate 1/2 (111,101)] shown here is intended as learning material only.
//  Written using very simple algorithm that may give you better understanding on how
//  the decoding process operate.
// --
// The block diagram of Viterbi Decoder used here is :
//
//    <m_out{0..3}>+---------+  <m_in{0..3}> +---------+ <control>
//              +--| metric  |<--------------| reduce  |-----------+
//              |  |         |               |         |           |
//              |  +---------+               +---------+           |
//              |                                 ^                |
//              |                                 |<out{0..3}>     #
//              |         +---------+        +---------+       +---------+ 
//              +-------->| compute |------->| compare |------>| path    |---------------> 
// <in{0..3}> ----------->| metric  | <px_y> | select  | <ACS> | memory  | <decode_out>
//                        +---------+        +---------+       +---------+
//        
// --
//  Use freely :)
// ---------------------------------------------------------------------------


module viterbi (in0,in1,in2,in3,decode_out,clk,reset);   

   input [1:0] in0,in1,in2,in3;   
   output decode_out; 
   input clk,reset; 
   
   wire [2:0] m_in0,m_in1,m_in2,m_in3;   
   wire [2:0] m_out0,m_out1,m_out2,m_out3;   
   wire [3:0] p0_0,p1_0,p2_1,p3_1,p0_2,p1_2,p2_3,p3_3;   
   wire [3:0] ACS;   
   wire [2:0] out0,out1,out2,out3;   
   wire [1:0] control;   
      
   wire res_3;
   
      compute_metric u1(m_out0,m_out1,m_out2,m_out3,in0,in1,in2,in3,
         	        p0_0,p1_0,p2_1,p3_1,p0_2,p1_2,p2_3,p3_3);                             

      metric u2(m_in0,m_in1,m_in2,m_in3,m_out0,m_out1,m_out2,m_out3,clk,reset);   
   
      acs_enable u3 (clk, reset, res_3);
   
      compare_select u4(p0_0,p1_0,p2_1,p3_1,p0_2,p1_2,p2_3,p3_3,res_3,
                        out0,out1,out2,out3,ACS);   

      reduce u5(out0,out1,out2,out3,m_in0,m_in1,m_in2,m_in3,control);   

      path_memory u6(ACS,control,clk,reset,
                     decode_out);

endmodule