/******************************************************/   
/* module viterbi_distances                           */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: This module is used to find the hamming distance
//                of received input to all possible branch output.
// --
// File name	: viterbi_distances.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : -
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// Example      : 
//      Received  --> 01
//        in0 = 1         (hamming distance with 00)
//        in1 = 0         (hamming distance with 01)
//        in2 = 2         (hamming distance with 10)
//        in3 = 1         (hamming distance with 11)
// ---------------------------------------------------------------------------

module viterbi_distances  (Y_in_1,Y_in_0,in0,in1,in2,in3);   

   input Y_in_1,Y_in_0; 
   output [1:0] in0,in1,in2,in3;   

   reg [7:0] in;

   always @(Y_in_1 or Y_in_0) 
     begin  
      case (Y_in_1)
        0 : case (Y_in_0)
              0 : in = 'b00010110;
              1 : in = 'b01001001;
            endcase
        1 : case (Y_in_0)
              0 : in = 'b01100001;
              1 : in = 'b10010100;
            endcase
      endcase
   end

   assign in0 = in [7:6];
   assign in1 = in [5:4];
   assign in2 = in [3:2];
   assign in3 = in [1:0];

endmodule    
