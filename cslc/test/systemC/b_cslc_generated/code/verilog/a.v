`include "defines.v"

module a(in,
         out,
         clk);
// Location of source csl unit: file name = 2.csl line number = 2
  input in;
  input clk;
  output out;
  `include "a.logic.vh"
endmodule

