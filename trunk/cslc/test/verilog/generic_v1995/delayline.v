//*****************************************************************************
//FILE NAME: delayline.v
//OWNER    : NIKHIL KUMAR SRIVASTAVA
//COMMENTS : This module generates 16 equally spaced phases from the input clk. 
//*****************************************************************************

module delayline(inclk,even_clk,odd_clk);

input inclk;

output [7:0] even_clk;
output [7:0] odd_clk;

`define NumPhases 16
`define DelayLCLK 128

assign #(0*`DelayLCLK/`NumPhases)	even_clk[0] = inclk;
assign #(1*`DelayLCLK/`NumPhases)	odd_clk[0]  = inclk;
assign #(2*`DelayLCLK/`NumPhases)	even_clk[1] = inclk;
assign #(3*`DelayLCLK/`NumPhases)	odd_clk[1]  = inclk;
assign #(4*`DelayLCLK/`NumPhases)	even_clk[2] = inclk;
assign #(5*`DelayLCLK/`NumPhases)	odd_clk[2]  = inclk;
assign #(6*`DelayLCLK/`NumPhases)	even_clk[3] = inclk;
assign #(7*`DelayLCLK/`NumPhases)	odd_clk[3]  = inclk;

assign #(0*`DelayLCLK/`NumPhases)	even_clk[4] = ~inclk;
assign #(1*`DelayLCLK/`NumPhases)	odd_clk[4]  = ~inclk;
assign #(2*`DelayLCLK/`NumPhases)	even_clk[5] = ~inclk;
assign #(3*`DelayLCLK/`NumPhases)	odd_clk[5]  = ~inclk;
assign #(4*`DelayLCLK/`NumPhases)	even_clk[6] = ~inclk;
assign #(5*`DelayLCLK/`NumPhases)	odd_clk[6]  = ~inclk;
assign #(6*`DelayLCLK/`NumPhases)	even_clk[7] = ~inclk;
assign #(7*`DelayLCLK/`NumPhases)	odd_clk[7]  = ~inclk;

endmodule // end delayline module
