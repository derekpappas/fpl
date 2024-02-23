`include "defines.v"

module u_arith(ifc_op0_op1,
               ifc_op0_op2,
               ifc_sel0_sel,
               ifc_out0_o,
               cin,
               cout);
// Location of source csl unit: file name = mbist_datapath.csl line number = 66
  input [15:0] ifc_op0_op1;
  input [15:0] ifc_op0_op2;
  input [3:0] ifc_sel0_sel;
  input cin;
  output [15:0] ifc_out0_o;
  output cout;
  `include "u_arith.logic.v"
endmodule

