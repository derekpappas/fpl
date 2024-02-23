//*****************************************************************************
//FILE NAME: synchronizer.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module is used to model the actual synchronizer used after the
//           receiver in order to minimize the metastability problem.
//*****************************************************************************

                                                                                module synchronizer(clk1, clk1_b, clk2, clk2_b, synch_in, synch_out_s1 );

input clk1, clk1_b, clk2, clk2_b;
input synch_in;

output synch_out_s1;

reg temp1_s2, temp2_s2, temp3_s1, synch_out_s1;

always @(clk1 or synch_in)
  if(clk1)
    temp1_s2 = synch_in;

always @(clk2 or temp1_s2)
  if(clk2)
    temp3_s1 = temp1_s2;

always @(clk1 or temp3_s1)
  if(clk1)
    temp2_s2 = temp3_s1;

always @(clk2 or temp2_s2)
  if(clk2)
    synch_out_s1 = temp2_s2;



endmodule // end synchronizer module
