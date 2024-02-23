`include "defines.v"

module u1(p1);
// Location of source csl unit: file name = conn_units_multiple_levels.csl line number = 4
  input [2 - 1:0] p1;
  `include "u1.logic.vh"
endmodule

