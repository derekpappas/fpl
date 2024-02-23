      //////////////////////////////////////////
     // RAM_PRIMITIVE.V Version 1.0          //
    // Example of instantiating 4           //
   // 16x1 Synchronous RAMs                //
  // HDL Synthesis Design Guide for FPGAs //
 // August 1997                          //
//////////////////////////////////////////
 

module ram_primitive(DATA_IN, ADDR, WE, CLOCK, DATA_OUT);

input  [3:0] DATA_IN, ADDR;
input        WE, CLOCK;
output [3:0] DATA_OUT;

RAM16X1S RAM0 (.O(DATA_OUT[0]), .D(DATA_IN[0]), .A3(ADDR[3]),
               .A2(ADDR[2]), .A1(ADDR[1]), .A0(ADDR[0]),
               .WE(WE), .WCLK(CLOCK));

RAM16X1S RAM1 (.O(DATA_OUT[1]), .D(DATA_IN[1]), .A3(ADDR[3]),
               .A2(ADDR[2]), .A1(ADDR[1]), .A0(ADDR[0]),
               .WE(WE), .WCLK(CLOCK));

RAM16X1S RAM2 (.O(DATA_OUT[2]), .D(DATA_IN[2]), .A3(ADDR[3]),
               .A2(ADDR[2]), .A1(ADDR[1]), .A0(ADDR[0]),
               .WE(WE), .WCLK(CLOCK));

RAM16X1S RAM3 (.O(DATA_OUT[3]), .D(DATA_IN[3]), .A3(ADDR[3]),
               .A2(ADDR[2]), .A1(ADDR[1]), .A0(ADDR[0]),
               .WE(WE), .WCLK(CLOCK));

endmodule

