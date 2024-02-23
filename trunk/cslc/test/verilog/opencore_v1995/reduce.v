/******************************************************/   
/*   module reduce                                    */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: This module is used to limit the size of error metric.
// --
// File name	: reduce.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : -
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// Input  : input{0..3}        -> previous error metric
//                                 
// Output : m_in{0..3}         -> result of accumulation
//                                  x : the 'source' state
//				    y : the 'target' state
//          control	       -> look below
// --
// This module uses a simple algorithm to limit error metric
// size. After finding the smallest error metric, all
// error metric is substracted by those number.
//
// <control> indicates which state has the smallest error metric
// and used to determine where to start traceback.
// ---------------------------------------------------------------------------

module reduce   
      (input0,input1,input2,input3,   
      m_in0,m_in1,m_in2,m_in3,   
      control);   

   input [2:0] input0,input1,input2,input3;   
   output [2:0] m_in0,m_in1,m_in2,m_in3;   
   output [1:0] control; 
  
   wire [2:0] smallest;
   reg [1:0] control;

   function [2:0] find_smallest;   
      input [2:0] input0,input1,input2,input3;
      reg [2:0] a,b;   
         begin   
            if(input0<=input1) a=input0; else a=input1;   
            if(input2<=input3) b=input2; else b=input3;   
            if(a<=b) find_smallest = a;   
            else find_smallest = b;   
         end   
   endfunction    

   always @(smallest)
     begin
       case (smallest)
         input0 : control = 0;
         input1 : control = 1;
         input2 : control = 2;
         input3 : control = 3;
       endcase
     end
     
   assign smallest = find_smallest(input0,input1,input2,input3);
   
   assign m_in0 = input0 - smallest;   
   assign m_in1 = input1 - smallest;   
   assign m_in2 = input2 - smallest;   
   assign m_in3 = input3 - smallest;   

endmodule
