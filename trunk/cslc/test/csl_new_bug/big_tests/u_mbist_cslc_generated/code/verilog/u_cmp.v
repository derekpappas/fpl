`include "defines.v"

module u_cmp(ifc_op_cmp_op1,
             ifc_op_cmp_op2,
             res);
// Location of source csl unit: file name = mbist_datapath.csl line number = 134
  input [15:0] ifc_op_cmp_op1;
  input [15:0] ifc_op_cmp_op2;
  output res;
  `include "u_cmp.logic.v"
endmodule

