/******************************************************/   
/*   module compare_select                            */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: This module is used to find the smaller 
//                accumulated error metric that are entering a state
// --
// File name	: compare_select.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : -
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// Output :  out{0..3}        -> the next error metric
//
//           ACS [3:0]        -> the survival branch
// 	     			  note : 0 -> from the 'lower' branch
//                  			 1 -> from the 'upper' branch
// ---------------------------------------------------------------------------

module compare_select   
         (p0_0,p1_0,p2_1,p3_1,p0_2,p1_2,p2_3,p3_3,rst_3,
          out0,out1,out2,out3,   
          ACS);   

   input [3:0] p0_0,p1_0,p2_1,p3_1,p0_2,p1_2,p2_3,p3_3;
   input rst_3;
   output [2:0] out0,out1,out2,out3;   
   output [3:0] ACS;

   function [2:0] find_min_metric; 
     input [3:0] a,b;
     input enabled;
      begin   
         if (enabled == 0) find_min_metric=a;
         else if (a<=b) find_min_metric=a; 
              else find_min_metric=b;   
      end   
   endfunction   

   function set_control; 
      input [2:0] a,b;
      input enabled;
      begin   
         if (enabled == 0) set_control=0;
         else if (a<=b) set_control=0; 
              else set_control=1;   
      end   
   endfunction   

   assign out0=find_min_metric(p0_0,p1_0,rst_3);
   assign out1=find_min_metric(p2_1,p3_1,rst_3);
   assign out2=find_min_metric(p0_2,p1_2,rst_3);
   assign out3=find_min_metric(p2_3,p3_3,rst_3);
   
   assign ACS[0] = set_control (p0_0,p1_0,rst_3);
   assign ACS[1] = set_control (p2_1,p3_1,rst_3);
   assign ACS[2] = set_control (p0_2,p1_2,rst_3);
   assign ACS[3] = set_control (p2_3,p3_3,rst_3);
   
endmodule    