//*****************************************************************************
//FILE NAME: receiver.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module is used to model the actual reciever which samples
//           the refclk using the clock generated from the interpolator followed//           by a low to high amplifier    
//*****************************************************************************

                                                                                module receiver(clk1, clk1_b, clk2, clk2_b, analog_in, up_down );

input clk1, clk1_b, clk2, clk2_b;
input analog_in;

output up_down;

reg  temp, up_down;


always @(clk1 or analog_in)
  if(clk1)
    temp = analog_in;

always @(clk2 or temp )
  if(clk2)
    up_down = temp;

endmodule // end receiver module 
