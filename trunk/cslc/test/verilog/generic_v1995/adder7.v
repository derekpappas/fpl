//*****************************************************************************
//FILE NAME: adder7.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module adds the output from the FSM and the output from the   
//           7-bit latch(which is actually the adder output in the previous 
//           cycle) and feeds it to the mux decoder and therm_decoder
//*****************************************************************************

                                                                                module adder7(latch_s1, fsm_s1, sum_s1);

input [6:0] latch_s1;
input [6:0] fsm_s1;

output [6:0] sum_s1;

wire [6:0] sum_s1;

assign  sum_s1= latch_s1 + fsm_s1;

endmodule // end adder7 module
