`include "defines.v"

module top(in1,
           in2,
           in3,
           out1,
           out2,
           clk);
// Location of source csl unit: file name = multiple_units3.csl line number = 40
  input [3 - 1:0] in1;
  input in2;
  input [6 - 1:0] in3;
  input clk;
  output [3 - 1:0] out1;
  output [3 - 1:0] out2;
  c c0(.clk(clk),
       .in1(in1),
       .in2(in2),
       .in3(in3),
       .out(out1));
  c c1(.clk(clk),
       .in1(in1),
       .in2(in2),
       .in3(in3),
       .out(out2));
  `include "top.logic.vh"
endmodule

