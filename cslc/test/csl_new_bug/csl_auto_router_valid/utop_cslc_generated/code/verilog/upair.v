`include "defines.v"

module upair(ifcbu1_ifcup_iin,
             ifcbu1_ifcup_iout,
             ifcbu1_ifcdw_iin,
             ifcbu1_ifcdw_iout,
             ifcsu1_iin,
             ifcsu1_iout);
// Location of source csl unit: file name = ar11.csl line number = 96
  input [16 - 1:0] ifcbu1_ifcup_iin;
  input [16 - 1:0] ifcbu1_ifcdw_iin;
  input [16 - 1:0] ifcsu1_iin;
  output [16 - 1:0] ifcbu1_ifcup_iout;
  output [16 - 1:0] ifcbu1_ifcdw_iout;
  output [16 - 1:0] ifcsu1_iout;
  usu su(.ifcsu0_iin(ifcsu1_iin),
         .ifcsu0_iout(ifcsu1_iout));
  ubu bu(.ifcbu0_ifcdw_iin(ifcbu1_ifcdw_iin),
         .ifcbu0_ifcdw_iout(ifcbu1_ifcdw_iout),
         .ifcbu0_ifcup_iin(ifcbu1_ifcup_iin),
         .ifcbu0_ifcup_iout(ifcbu1_ifcup_iout));
  `include "upair.logic.v"
endmodule

