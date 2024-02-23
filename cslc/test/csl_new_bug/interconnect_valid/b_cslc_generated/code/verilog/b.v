`include "defines.v"

module b(p);
// Location of source csl unit: file name = port1.csl line number = 15
  input wor p;
  wire s;
  a a0(.ifc10_x(p),
       .ifc10_y(s));
  `include "b.logic.v"
endmodule

