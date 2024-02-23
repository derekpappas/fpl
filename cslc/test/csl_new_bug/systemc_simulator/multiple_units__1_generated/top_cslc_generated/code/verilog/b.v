`include "defines.v"

module b(in,
         out,
         clk);
// Location of source csl unit: file name = multiple_units1.csl line number = 14
  input [5 - 1:0] in;
  input clk;
  output [5 - 1:0] out;
  a a0(.clk(clk),
       .in(in),
       .out(out));
  `include "b.logic.vh"
endmodule

