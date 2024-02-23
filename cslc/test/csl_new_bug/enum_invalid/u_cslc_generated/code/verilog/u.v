`include "defines.v"

module u();
// Location of source csl unit: file name = enum_br.csl line number = 10
  wire [3 - 1:0] s;
  assign   s = e;
  `include "u.logic.v"
endmodule

