`include "defines.v"

module chip(p_clock,
            p_reset,
            p_enable,
            p_data_in,
            p_data_out,
            p_stall_chip,
            ifc_pclm_p_unitOut,
            ifc_pclm_p_unitIn,
            ifc_lmid_p_unitOut,
            ifc_lmid_p_unitIn,
            ifc_idrf_p_unitOut,
            ifc_idrf_p_unitIn,
            ifc_rfalu_p_unitOut,
            ifc_rfalu_p_unitIn);
// Location of source csl unit: file name = csl_example_unit.csl line number = 529
  input p_clock;
  input p_reset;
  input p_enable;
  input [32 - 1:0] p_data_in;
  input p_stall_chip;
  input [32 - 1:0] ifc_pclm_p_unitIn;
  input [32 - 1:0] ifc_lmid_p_unitIn;
  input [32 - 1:0] ifc_idrf_p_unitIn;
  input [32 - 1:0] ifc_rfalu_p_unitIn;
  output [32 - 1:0] p_data_out;
  output [32 - 1:0] ifc_pclm_p_unitOut;
  output [32 - 1:0] ifc_lmid_p_unitOut;
  output [32 - 1:0] ifc_idrf_p_unitOut;
  output [32 - 1:0] ifc_rfalu_p_unitOut;
  wire sgn_clk;
  wire sgn_reset;
  wire sgn_stall;
  assign   sgn_stall = p_stall_chip;
  u_pc pc(.ifc_pc_p_clk(sgn_clk),
          .ifc_pc_p_rst(sgn_reset),
          .ifc_pc_p_stall(sgn_stall),
          .ifc_unit_pc_r_p_unitIn(ifc_pclm_p_unitIn),
          .ifc_unit_pc_r_p_unitOut(ifc_pclm_p_unitOut));
  u_im im(.ifc_im_p_clk(sgn_clk),
          .ifc_im_p_rst(sgn_reset),
          .ifc_im_p_stall(sgn_stall),
          .ifc_unit_im_l_p_unitIn(p_data_in),
          .ifc_unit_im_l_p_unitOut(p_data_out),
          .ifc_unit_im_r_p_unitIn(ifc_lmid_p_unitIn),
          .ifc_unit_im_r_p_unitOut(ifc_lmid_p_unitOut));
  u_id id(.ifc_id_p_clk(sgn_clk),
          .ifc_id_p_rst(sgn_reset),
          .ifc_id_p_stall(sgn_stall),
          .ifc_unit_id_l_p_unitIn(p_data_in),
          .ifc_unit_id_l_p_unitOut(p_data_out),
          .ifc_unit_id_r_p_unitIn(ifc_idrf_p_unitIn),
          .ifc_unit_id_r_p_unitOut(ifc_idrf_p_unitOut));
  u_rf rf(.ifc_rf_p_clk(sgn_clk),
          .ifc_rf_p_rst(sgn_reset),
          .ifc_rf_p_stall(sgn_stall),
          .ifc_unit_rf_l_p_unitIn(p_data_in),
          .ifc_unit_rf_l_p_unitOut(p_data_out),
          .ifc_unit_rf_r_p_unitIn(ifc_rfalu_p_unitIn),
          .ifc_unit_rf_r_p_unitOut(ifc_rfalu_p_unitOut));
  u_alu alu(.ifc_alu_p_clk(sgn_clk),
            .ifc_alu_p_rst(sgn_reset),
            .ifc_alu_p_stall(sgn_stall),
            .ifc_unit_alu_l_p_unitIn(p_data_in),
            .ifc_unit_alu_l_p_unitOut(p_data_out),
            .ifc_unit_alu_r_p_unitIn(p_data_in),
            .ifc_unit_alu_r_p_unitOut(p_data_out));
  pc_reg pc_reg(.clock(p_clock),
                .enable(p_enable),
                .reg_in(p_data_in),
                .reg_out(p_data_out),
                .reset_(p_reset));
  rf_reg rf_reg(.clock(p_clock),
                .enable(p_enable),
                .reg_in(p_data_in),
                .reg_out(p_data_out),
                .reset_(p_reset));
  alu_reg alu_reg(.clock(p_clock),
                  .enable(p_enable),
                  .reg_in(p_data_in),
                  .reg_out(p_data_out),
                  .reset_(p_reset));
  r_shr r_shr(.clock(p_clock),
              .enable(p_enable),
              .reg_in(p_data_in),
              .reg_out(p_data_out),
              .reset_(p_reset));
  `include "chip.logic.v"
endmodule

