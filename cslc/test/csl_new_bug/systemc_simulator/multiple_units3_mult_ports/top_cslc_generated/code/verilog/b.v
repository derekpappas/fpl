`include "defines.v"

module b(in1,
         in2,
         in3,
         out,
         clk);
// Location of source csl unit: file name = multiple_units3.csl line number = 16
  input [3 - 1:0] in1;
  input in2;
  input [6 - 1:0] in3;
  input clk;
  output [3 - 1:0] out;
  a a0(.clk(clk),
       .in1(in1),
       .in2(in2),
       .in3(in3),
       .out(out));
  `include "b.logic.vh"
endmodule

