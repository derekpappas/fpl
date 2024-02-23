`include "defines.v"

module a(in,
         out,
         clk);
// Location of source csl unit: file name = multiple_units2.csl line number = 5
  input [3 - 1:0] in;
  input clk;
  output [3 - 1:0] out;
  `include "a.logic.vh"
endmodule

