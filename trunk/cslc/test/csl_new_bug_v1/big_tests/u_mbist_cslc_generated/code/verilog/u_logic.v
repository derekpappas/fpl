`include "defines.v"

module u_logic(ifc_op0_op1,
               ifc_op0_op2,
               ifc_sel0_sel,
               ifc_out0_o);
// Location of source csl unit: file name = mbist_datapath.csl line number = 85
  input [15:0] ifc_op0_op1;
  input [15:0] ifc_op0_op2;
  input [3:0] ifc_sel0_sel;
  output [15:0] ifc_out0_o;
  `include "u_logic.logic.v"
endmodule

