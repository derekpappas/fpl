`include "defines.v"

module u2();
// Location of source csl unit: file name = param_sg.csl line number = 22
  wire [68 - 1:0] sga1_x1;
  wire [68 - 1:0] sga1_x2;
  u1 u1i(.ifca1_x1(sga1_x1),
         .ifca1_x2(sga1_x2));
  `include "u2.logic.v"
endmodule

