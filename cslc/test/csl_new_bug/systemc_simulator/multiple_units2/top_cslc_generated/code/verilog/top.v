`include "defines.v"

module top(in,
           out1,
           out2,
           clk);
// Location of source csl unit: file name = multiple_units2.csl line number = 34
  input [3 - 1:0] in;
  input clk;
  output [3 - 1:0] out1;
  output [3 - 1:0] out2;
  c c0(.clk(clk),
       .in(in),
       .out(out1));
  c c1(.clk(clk),
       .in(in),
       .out(out2));
  `include "top.logic.vh"
endmodule

