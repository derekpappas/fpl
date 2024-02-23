//*****************************************************************************
//FILE NAME: latch7.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : It latches the output of the 7-bit adder and feeds it back  to the
//           adder in the next cycle.It also consists of the reset mux which is
//           used to reset the latch when the reset signal goes high.  
//*****************************************************************************

                                                                                module latch7(clk1, clk1_b, clk2, clk2_b, reset_s1, latchin_s1, latchout_s1);

input clk1, clk1_b, clk2, clk2_b, reset_s1;
input [6:0] latchin_s1;

output [6:0] latchout_s1;

reg [6:0] temp_s2,latchout_s1;

wire [6:0] tempin_s1;

// If reset_s1 is high then it initializes the latches to 7'b0000000
assign tempin_s1 = (reset_s1) ? 7'b0000000 : latchin_s1 ;


always @(clk1 or reset_s1 or tempin_s1 )
 if(reset_s1 && clk1)
   begin
    latchout_s1 = 7'b0000000;
    temp_s2 = tempin_s1;
   end
  else if(clk1)
       temp_s2 = tempin_s1;

always @(clk2 or temp_s2 )
  if(clk2)
    latchout_s1 = temp_s2;

endmodule // end latch7 module

