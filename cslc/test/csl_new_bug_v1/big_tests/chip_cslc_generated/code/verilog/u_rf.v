`include "defines.v"

module u_rf(ifc_rf_p_clk,
            ifc_rf_p_rst,
            ifc_rf_p_stall,
            ifc_unit_rf_l_p_unitOut,
            ifc_unit_rf_l_p_unitIn,
            ifc_unit_rf_r_p_unitOut,
            ifc_unit_rf_r_p_unitIn);
// Location of source csl unit: file name = csl_example_unit.csl line number = 38
  input ifc_rf_p_clk;
  input ifc_rf_p_rst;
  input ifc_rf_p_stall;
  input [32 - 1:0] ifc_unit_rf_l_p_unitIn;
  input [32 - 1:0] ifc_unit_rf_r_p_unitIn;
  output [32 - 1:0] ifc_unit_rf_l_p_unitOut;
  output [32 - 1:0] ifc_unit_rf_r_p_unitOut;
  `include "u_rf.logic.v"
endmodule

