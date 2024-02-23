`include "defines.v"

module usu(ifcsu0_iin,
           ifcsu0_iout);
// Location of source csl unit: file name = ar11.csl line number = 75
  input [16 - 1:0] ifcsu0_iin;
  output [16 - 1:0] ifcsu0_iout;
  `include "usu.logic.v"
endmodule

