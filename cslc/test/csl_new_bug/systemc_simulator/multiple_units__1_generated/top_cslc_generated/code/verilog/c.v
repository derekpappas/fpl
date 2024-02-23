`include "defines.v"

module c(in,
         out,
         clk);
// Location of source csl unit: file name = multiple_units1.csl line number = 24
  input [5 - 1:0] in;
  input clk;
  output [5 - 1:0] out;
  b b0(.clk(clk),
       .in(in),
       .out(out));
  `include "c.logic.vh"
endmodule

