`include "defines.v"

module b(in_b1,
         in_b2,
         out_b1,
         out_b2,
         clk);
// Location of source csl unit: file name = 2.csl line number = 10
  input in_b1;
  input in_b2;
  input clk;
  output out_b1;
  output out_b2;
  wire s1;
  wire s2;
  wire s3;
  assign   s1 = in_b2 & s3;
  assign   out_b1 = s1;
  assign   out_b2 = s2 ^ s3;
  a a0(.clk(clk),
       .in_a(in_b1),
       .out_a(out_b1));
  `include "b.logic.v"
endmodule

