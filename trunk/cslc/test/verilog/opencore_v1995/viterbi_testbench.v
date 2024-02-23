/*****************************************************/
/* module viterbi_testbench                          */
/*****************************************************/
// ---------------------------------------------------------------------------
// Design 	: Test Bench for viterbi decoder.
// --
// File name	: viterbi_testbench.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : viterbi_distances.v
//                viterbi.v
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// ---------------------------------------------------------------------------

module viterbi_testbench;   

   wire decode_out;               // decoder out    
   reg [1:0] Y;                   // received signal

   reg Clk, Res;

   wire [1:0] in0,in1,in2,in3;   
   
   initial 
     begin
        #4000 $finish;    
     end
   
   initial 
     begin 
       Clk=0;    
       #70 Res=0;
       #10 Res=1;
     end                          // hit reset after inputs are stable   

   always #50 Clk=~Clk; 
   
// 1. What is inputted to the test bench come from the Viterbi Encoder for 
//    K = 3, rate = 1/2 (111,101)
// 2. For the example below, the original data is : 010111001010001 + 00 (2 tail bits)
//    The encoder output is : 00 11 10 00 01 10 01 11 11 10 00 10 11 00 11 + 10 11
// 3. We may manually introduce error(s) into decoder input by altering the data(s) below.

   initial                        
     begin                        

//          input      |     input
//      with error (s) | without error(s)     
//   ------------------|------------------         

       #51 Y = 0;             // 0 
       #100 Y = 2;            // 3 e 
       #100 Y = 2;            // 2 
       #100 Y = 0;            // 0
       #100 Y = 3;            // 1 e 
       #100 Y = 2;            // 2 
       #100 Y = 1;            // 1 
       #100 Y = 3;            // 3 
       #100 Y = 1;            // 3 e
       #100 Y = 2;            // 2
       #100 Y = 0;            // 0 
       #100 Y = 3;            // 2 e
       #100 Y = 3;            // 3
       #100 Y = 0;            // 0 
       #100 Y = 1;            // 3 e
       #100 Y = 2;            // 2
       #100 Y = 3;            // 3 
       #100 Y = 0;            
     end
   
   
   viterbi_distances v_1 (Y[1],Y[0],in0,in1,in2,in3);   
   viterbi v_2 (in0,in1,in2,in3,decode_out,Clk,Res);   
   
endmodule