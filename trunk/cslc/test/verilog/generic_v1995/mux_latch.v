//*****************************************************************************
//FILE NAME: mux_latch.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module latches the values generated by the mux_decoder so
//           that the mux select inputs are stable during the clock selection 
//*****************************************************************************

                                                                                module mux_latch(clk1, clk1_b, clk2, clk2_b, e_latchin_s1,o_latchin_s1,e_latchout_s1, o_latchout_s1 );
input clk1, clk1_b, clk2, clk2_b;
input [2:0] e_latchin_s1, o_latchin_s1;
output [2:0] e_latchout_s1,  o_latchout_s1;
reg [2:0] e_temp_s2, o_temp_s2, e_latchout_s1,  o_latchout_s1;

always @(clk1 or e_latchin_s1   )
  if(clk1)
    e_temp_s2 = e_latchin_s1;

always @(clk2 or e_temp_s2 )
  if(clk2)
    e_latchout_s1 = e_temp_s2;

always @(clk1 or o_latchin_s1 )
  if(clk1)
    o_temp_s2 = o_latchin_s1;

always @(clk2 or o_temp_s2 )
  if(clk2)
    o_latchout_s1 = o_temp_s2;


endmodule
