//*****************************************************************************
//FILE NAME: mux_decoder.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module takes the upper four bits of the adder output as inputs
//           and generates the corresponding  bits which will be used as inputs
//           to the mux which shall select the corresponding even and odd clocks
//*****************************************************************************

                                                                                module mux_decoder(x_s1[3:0], y_s1[2:0], z_s1[2:0]);

input [3:0] x_s1;

output [2:0] y_s1;
output [2:0] z_s1;

wire [2:0] y_s1,z_s1;

assign y_s1[2] = ( x_s1[3] ^ (x_s1[2] & x_s1[1] & x_s1[0]));
assign y_s1[1] = ( x_s1[2] ^ (x_s1[1] & x_s1[0]));   
assign y_s1[0] = ( x_s1[1] ^  x_s1[0] );
assign z_s1[2] = x_s1[3];
assign z_s1[1] = x_s1[2];
assign z_s1[0] = x_s1[1];

endmodule //end mux_decoder module
