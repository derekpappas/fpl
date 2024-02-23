`include "defines.v"

module u2(a,
          b,
          c);
// Location of source csl unit: file name = multipl_units.csl line number = 8
  input [2 - 1:0] a;
  input [2 - 1:0] b;
  output [4 - 1:0] c;
  wire [4 - 1:0] s;
  u1 u1_1(.x(s),
          .y(s));
  `include "u2.logic.v"
endmodule

