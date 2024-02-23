`include "defines.v"

module a(in_a,
         out_a,
         clk);
// Location of source csl unit: file name = 2.csl line number = 1
  input in_a;
  input clk;
  output out_a;
  `include "a.logic.v"
endmodule

