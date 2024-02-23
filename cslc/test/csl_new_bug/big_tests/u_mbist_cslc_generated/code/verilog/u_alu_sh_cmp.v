`include "defines.v"

module u_alu_sh_cmp(ifc_op0_op1,
                    ifc_op0_op2,
                    ifc_out0_o,
                    sel_op_p_sel,
                    sham,
                    compres);
// Location of source csl unit: file name = mbist_datapath.csl line number = 167
  input [15:0] ifc_op0_op1;
  input [15:0] ifc_op0_op2;
  input [3:0] sel_op_p_sel;
  input [16 - 1:0] sham;
  output [15:0] ifc_out0_o;
  output compres;
  wire cin;
  wire cout;
  wire [15:0] p_tomux40;
  wire [15:0] p_tomux41;
  wire [15:0] p_tomux42;
  wire [15:0] p_tomux43;
  wire [15:0] tomux40_p_op1;
  wire [15:0] tomux40_p_op2;
  wire [15:0] tomux41_p_op1;
  wire [15:0] tomux41_p_op2;
  wire [15:0] tomux42_p_o;
  u_arith u_arith0(.cin(cin),
                   .cout(cout),
                   .ifc_op0_op1(ifc_op0_op1),
                   .ifc_op0_op2(ifc_op0_op2));
  u_logic u_logic0(.ifc_op0_op1(ifc_op0_op1),
                   .ifc_op0_op2(ifc_op0_op2));
  u_cmp u_cmp0(.ifc_op_cmp_op1(ifc_op0_op1),
               .ifc_op_cmp_op2(ifc_op0_op2),
               .res(compres));
  u_sh u_sh0(.p_sham(sham));
  u_mux41 u_mux410(.ifc_out0_o(ifc_out0_o),
                   .in0(p_tomux40),
                   .in1(p_tomux41),
                   .in2(p_tomux42),
                   .in3(p_tomux43),
                   .sel(sel_op_p_sel));
  `include "u_alu_sh_cmp.logic.v"
endmodule

