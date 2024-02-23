`include "defines.v"

module a(in,
         out,
         clk);
// Location of source csl unit: file name = multiple_units1.csl line number = 5
  input [5 - 1:0] in;
  input clk;
  output [5 - 1:0] out;
  `include "a.logic.vh"
endmodule

