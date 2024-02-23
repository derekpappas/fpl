`include "defines.v"

module b(in,
         out,
         clk);
// Location of source csl unit: file name = 2.csl line number = 11
  input in;
  input clk;
  output out;
  a a0(.clk(clk),
       .in(in),
       .out(out));
  `include "b.logic.vh"
endmodule

