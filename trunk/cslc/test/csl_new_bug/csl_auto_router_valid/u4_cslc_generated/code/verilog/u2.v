`include "defines.v"

module u2(p1,
          p2);
// Location of source csl unit: file name = conn_units_multiple_levels.csl line number = 9
  input [2 - 1:0] p1;
  input [2 - 1:0] p2;
  u1 u11(.p1(p1));
  u1 u12(.p1(p2));
  `include "u2.logic.vh"
endmodule

