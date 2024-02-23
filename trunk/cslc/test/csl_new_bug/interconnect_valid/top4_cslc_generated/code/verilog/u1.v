`include "defines.v"

module u1(ifc10_p1,
          ifc10_p2);
// Location of source csl unit: file name = parameter_test4.csl line number = 12
  input [16 - 1:0] ifc10_p1;
  input [84 - 1:0] ifc10_p2;
  `include "u1.logic.v"
endmodule

