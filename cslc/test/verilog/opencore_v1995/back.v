/******************************************************/   
/*   module back	                              */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: This module is used to perform one traceback process.
// --
// File name	: back.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : -
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// Input  : state              -> the state we want to find what
//                                is its predecessor state
//          survival_data      -> ACS saved on path_memory
//                                 
// Output : out [1:0]	       -> the predecessor state
// --
// Process example :
//    state      	   =   10  (2)
//    survival_data [2]    =   1
//    out                  =   01  (1)
//  
//         <out> is coming from <state> left shifted by 1 and the LSB
//         is <survival_data [state]>
// ---------------------------------------------------------------------------

module back(state,survival_data,out);   

   input [1:0] state; 
   input [3:0] survival_data;

   output [1:0] out;

   assign out [0] = survival_data [state];
   assign out [1] = state [0];

endmodule
