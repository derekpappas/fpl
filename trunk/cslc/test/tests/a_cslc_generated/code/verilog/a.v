`include "defines.v"

module a(in,
         out,
         out2,
         clk);
// Location of source csl unit: file name = tb_test.csl line number = 1
  input [3 - 1:0] in;
  input clk;
  output [2 - 1:0] out;
  output [4 - 1:0] out2;
  wire [3 - 1:0] s_in;
  wire [2 - 1:0] s_out;
  wire [4 - 1:0] s_out2;
  wire s_clk;
  assign   s_out = 2'b11;
  assign   s_out2 = 4'b0111;
  assign   s_in = in;
  assign   out = s_out;
  assign   out2 = s_out2;
  assign   s_clk = clk;
  `include "a.logic.vh"
endmodule

