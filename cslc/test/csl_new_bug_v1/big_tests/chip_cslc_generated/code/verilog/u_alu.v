`include "defines.v"

module u_alu(ifc_alu_p_clk,
             ifc_alu_p_rst,
             ifc_alu_p_stall,
             ifc_unit_alu_l_p_unitOut,
             ifc_unit_alu_l_p_unitIn,
             ifc_unit_alu_r_p_unitOut,
             ifc_unit_alu_r_p_unitIn);
// Location of source csl unit: file name = csl_example_unit.csl line number = 44
  input ifc_alu_p_clk;
  input ifc_alu_p_rst;
  input ifc_alu_p_stall;
  input [32 - 1:0] ifc_unit_alu_l_p_unitIn;
  input [32 - 1:0] ifc_unit_alu_r_p_unitIn;
  output [32 - 1:0] ifc_unit_alu_l_p_unitOut;
  output [32 - 1:0] ifc_unit_alu_r_p_unitOut;
  `include "u_alu.logic.v"
endmodule

