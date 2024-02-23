`include "defines.v"

module top();
// Location of source csl unit: file name = multipl_units.csl line number = 14
  wire [2 - 1:0] s1;
  wire [4 - 1:0] s2;
  u1 u1_2(.x(s2),
          .y(s2));
  u1 u1_3(.x(s2),
          .y(s2));
  u2 u2_1(.a(s1),
          .b(s1),
          .c(s2));
  u2 u2_2(.a(s2[3:2]),
          .b(s1),
          .c(s2));
  `include "top.logic.v"
endmodule

