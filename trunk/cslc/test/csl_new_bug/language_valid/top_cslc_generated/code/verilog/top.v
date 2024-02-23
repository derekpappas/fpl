`include "defines.v"

module top(ifc0_ixx_p_ifc1,
           ifc0_ixx_p_ifc2);
// Location of source csl unit: file name = suffix_set_suffix.csl line number = 18
  input [8 - 1:0] ifc0_ixx_p_ifc1;
  output [8 - 1:0] ifc0_ixx_p_ifc2;
  wire [8 - 1:0] sg0_s_sg1;
  wire [8 - 1:0] sg0_s_sg2;
  assign   ifc0_ixx_p_ifc1 = sg0_s_sg1;
  assign   ifc0_ixx_p_ifc2 = sg0_s_sg2;
  `include "top.logic.v"
endmodule

