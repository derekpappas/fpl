`include "defines.v"

module u();
// Location of source csl unit: file name = enum_br.csl line number = 9
  wire [4 - 1:0] s;
  assign   s = a;
  `include "u.logic.v"
endmodule

