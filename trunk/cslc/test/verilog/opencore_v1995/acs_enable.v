/******************************************************/
/* module acs_enable                                  */
/******************************************************/
// ---------------------------------------------------------------------------
// Purpose 	: This module is used to delay the reset for 2 clocks 
//                as there is no compare and select on 
//                clock 0 to K - 1 (look at the trellis diagram)
// --
// File name	: acs_enable.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : dff.v
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// ---------------------------------------------------------------------------

module acs_enable (clk,res,res_3);

   input clk,res; 
   output res_3;

   wire res_1,res_2;   
   
   dff dff_0(res,res_1,clk,res); 
   dff dff_1(res_1,res_2,clk,res);
   dff dff_2(res_2,res_3,clk,res);
   
endmodule