/******************************************************/   
/*   module path_memory                               */   
/******************************************************/   
// ---------------------------------------------------------------------------
// Purpose 	: This module saves the survival predecessor state. Traceback
//                process also performed on this module.
// --
// File name	: path_memory.v
// Author	: M. Zalfany Urfianto
//		  <zalfany@opencores.org>
// Last Rev.	: 18.4.2000
// 
// Modules used : dff.v
//                back.v
// --
// Simulator	: ModelSim PE/Plus 4.7h
// Error	: None known yet.
// --
// Input  : ACS                 -> survival predecessor state
//          control             -> coming from module reduce, used
//				   to determine where to start traceback.
//                                 
// Output : decode_out	        -> decoded output
// --
// The length of memory is at least 5 * (K-1) = 10
// The decoded_output is simply the MSB of the last state.
// ---------------------------------------------------------------------------

module path_memory (ACS,control,clk,reset,
                    decode_out);   
 
   input [3:0] ACS;   
   input [1:0] control;
   input clk,reset;   
   output decode_out;

   wire [3:0] out1,out2,out3,out4,out5,out6,out7,out8,out9,out10,out11;   
   wire [1:0] state1,state2,state3,state4,state5,state6,state7,state8,state9,state10,state11; 
   wire [1:0] last_state;
   
       path x1 (ACS , out1 ,clk,reset),   
            x2 (out1, out2 ,clk,reset),   
            x3 (out2, out3 ,clk,reset),   
            x4 (out3, out4 ,clk,reset),   
            x5 (out4, out5 ,clk,reset),   
            x6 (out5, out6 ,clk,reset),   
            x7 (out6, out7 ,clk,reset),   
            x8 (out7, out8 ,clk,reset),   
            x9 (out8, out9 ,clk,reset),   
            x10(out9, out10,clk,reset),
            x11(out10,out11,clk,reset);   


       back b11 (control,out1 ,state1),
            b10 (state1 ,out2 ,state2),
            b9  (state2 ,out3 ,state3),
            b8  (state3 ,out4 ,state4),
            b7  (state4 ,out5 ,state5),
            b6  (state5 ,out6 ,state6),
            b5  (state6 ,out7 ,state7),
            b4  (state7 ,out8 ,state8),
            b3  (state8 ,out9 ,state9),
            b2  (state9 ,out10,state10),
            b1  (state10,out11,state11);

    dff #(2) buff (state11,last_state,clk,reset);
    
    assign decode_out = last_state;
    
endmodule
