`include "defines.v"

module b(in,
         out,
         clk);
// Location of source csl unit: file name = multiple_units2.csl line number = 14
  input [3 - 1:0] in;
  input clk;
  output [3 - 1:0] out;
  a a0(.clk(clk),
       .in(in),
       .out(out));
  `include "b.logic.vh"
endmodule

