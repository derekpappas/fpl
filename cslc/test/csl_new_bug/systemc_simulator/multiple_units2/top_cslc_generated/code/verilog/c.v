`include "defines.v"

module c(in,
         out,
         clk);
// Location of source csl unit: file name = multiple_units2.csl line number = 24
  input [3 - 1:0] in;
  input clk;
  output [3 - 1:0] out;
  b b0(.clk(clk),
       .in(in),
       .out(out));
  `include "c.logic.vh"
endmodule

