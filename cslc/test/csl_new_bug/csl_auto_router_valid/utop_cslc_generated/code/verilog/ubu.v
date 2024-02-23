`include "defines.v"

module ubu(ifcbu0_ifcup_iin,
           ifcbu0_ifcup_iout,
           ifcbu0_ifcdw_iin,
           ifcbu0_ifcdw_iout);
// Location of source csl unit: file name = ar11.csl line number = 85
  input [16 - 1:0] ifcbu0_ifcup_iin;
  input [16 - 1:0] ifcbu0_ifcdw_iin;
  output [16 - 1:0] ifcbu0_ifcup_iout;
  output [16 - 1:0] ifcbu0_ifcdw_iout;
  `include "ubu.logic.v"
endmodule

