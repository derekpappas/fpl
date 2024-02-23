`include "defines.v"

module a(ck,
         reset);
// Location of source csl unit: file name = conn_by_pattern.csl line number = 6
  input ck;
  input reset;
  `include "a.logic.v"
endmodule

