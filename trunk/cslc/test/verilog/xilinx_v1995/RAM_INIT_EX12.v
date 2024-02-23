// This example shows how to create a 
// 16x4 RAM using Xilinx RAM16X1S component. 
`include "xc4000.v" 
module RAM_INIT_EX1 (DATA_BUS, ADDR, WE, CLK); 
input [3:0] ADDR; 
inout [3:0] DATA_BUS; 
input WE, CLK; 
wire [3:0] DATA_OUT; 
// Only for Simulation -- the defparam will not 
// synthesize 
// Use the defparam for RTL simulation. 
// There is no defparam needed for Post P&R 
//simulation. 
// synthesis translate_off 
defparam RAM0.INIT="0101", RAM1.INIT="AAAA",  
              RAM2.INIT="FFFF", RAM3.INIT="5555"; 
// synthesis translate_on 
assign DATA_BUS = !WE ? DATA_OUT : 4'hz; 
// Instantiation of 4 16X1 Synchronous RAMs 
// Use the xc_props attribute to pass the INIT property 
RAM16X1S RAM3 (.O (DATA_OUT[3]), .D (DATA_BUS[3]), 
      .A3 (ADDR[3]), .A2 (ADDR[2]), .A1 (ADDR[1]), 
      .A0 (ADDR[0]), .WE (WE), .WCLK (CLK)) 
      /* synthesis xc_props="INIT=5555" */; 
RAM16X1S RAM2 (.O (DATA_OUT[2]), .D (DATA_BUS[2]), 
      .A3 (ADDR[3]), .A2 (ADDR[2]), .A1 (ADDR[1]), 
      .A0 (ADDR[0]), .WE (WE), .WCLK (CLK)) 
      /* synthesis xc_props="INIT=FFFF" */; 
RAM16X1S RAM1 (.O (DATA_OUT[1]), .D (DATA_BUS[1]), 
      .A3 (ADDR[3]), .A2 (ADDR[2]), .A1 (ADDR[1]), 
      .A0 (ADDR[0]), .WE (WE), .WCLK (CLK)) 
      /* synthesis xc_props="INIT=AAAA" */; 
RAM16X1S RAM0 (.O (DATA_OUT[0]), .D (DATA_BUS[0]), 
      .A3 (ADDR[3]), .A2 (ADDR[2]), .A1 (ADDR[1]), 
      .A0 (ADDR[0]), .WE (WE), .WCLK (CLK)) 
      /* synthesis xc_props="INIT=0101" */; 
endmodule 
