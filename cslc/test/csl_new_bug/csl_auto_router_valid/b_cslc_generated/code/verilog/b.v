`include "defines.v"

module b(ar_expr_s1_s2);
// Location of source csl unit: file name = bug2380.csl line number = 8
  input [4 - 1:0] ar_expr_s1_s2;
  wire s1;
  wire [4 - 1:0] s2;
  assign   ar_expr_s1_s2 = s1 + s2;
  a a0(.p1(ar_expr_s1_s2));
  `include "b.logic.v"
endmodule

