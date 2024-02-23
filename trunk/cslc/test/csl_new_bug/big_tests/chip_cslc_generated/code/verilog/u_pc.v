`include "defines.v"

module u_pc(ifc_pc_p_clk,
            ifc_pc_p_rst,
            ifc_pc_p_stall,
            ifc_unit_pc_r_p_unitOut,
            ifc_unit_pc_r_p_unitIn);
// Location of source csl unit: file name = csl_example_unit.csl line number = 20
  input ifc_pc_p_clk;
  input ifc_pc_p_rst;
  input ifc_pc_p_stall;
  input [32 - 1:0] ifc_unit_pc_r_p_unitIn;
  output [32 - 1:0] ifc_unit_pc_r_p_unitOut;
  `include "u_pc.logic.v"
endmodule

