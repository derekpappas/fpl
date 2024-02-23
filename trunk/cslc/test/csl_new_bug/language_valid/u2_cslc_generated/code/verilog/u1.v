`include "defines.v"

module u1(ifca1_x1,
          ifca1_x2);
// Location of source csl unit: file name = param_sg.csl line number = 16
  input [68 - 1:0] ifca1_x1;
  input [68 - 1:0] ifca1_x2;
  `include "u1.logic.v"
endmodule

