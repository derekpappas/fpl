`include "defines.v"

module top(in,
           out,
           clk);
// Location of source csl unit: file name = multiple_units1.csl line number = 34
  input [5 - 1:0] in;
  input clk;
  output [5 - 1:0] out;
  c c0(.clk(clk),
       .in(in),
       .out(out));
  `include "top.logic.vh"
endmodule

