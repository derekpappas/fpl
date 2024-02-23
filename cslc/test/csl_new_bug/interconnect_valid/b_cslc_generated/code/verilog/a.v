`include "defines.v"

module a(ifc10_x,
         ifc10_y);
// Location of source csl unit: file name = port1.csl line number = 10
  input ifc10_x;
  output ifc10_y;
  `include "a.logic.v"
endmodule

