`include "defines.v"

module a(in1,
         in2,
         in3,
         out,
         clk);
// Location of source csl unit: file name = multiple_units3.csl line number = 5
  input [3 - 1:0] in1;
  input in2;
  input [6 - 1:0] in3;
  input clk;
  output [3 - 1:0] out;
  `include "a.logic.vh"
endmodule

