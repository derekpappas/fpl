`include "defines.v"

module x(in1,
         in2,
         out1,
         out2,
         clk);
// Location of source csl unit: file name = tb_multilevel.csl line number = 31
  input [3 - 1:0] in1;
  input [8 - 1:0] in2;
  input clk;
  output [3 - 1:0] out1;
  output [8 - 1:0] out2;
  wire s_clk;
  assign   s_clk = clk;
  y y0(.in1(in1),
       .in2(in2),
       .out1(out1),
       .out2(out2));
  `include "x.logic.vh"
endmodule

