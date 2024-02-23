`include "defines.v"

module dsp(slave_Va2r_tap_dsp_read_data,
           slave_Va2r_tap_dsp_ready,
           slave_Va2r_tap_dsp_error,
           slave_Va2r_tap_dsp_address,
           slave_Va2r_tap_dsp_data,
           slave_Va2r_tap_dsp_read,
           slave_Va2r_tap_dsp_write,
           gbl_clk,
           gbl_reset_,
           gbl_enable);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 89
  input [1 - 1:0] gbl_clk;
  input [1 - 1:0] gbl_reset_;
  input [1 - 1:0] gbl_enable;
  output [32 - 1:0] slave_Va2r_tap_dsp_read_data;
  output [1 - 1:0] slave_Va2r_tap_dsp_ready;
  output [1 - 1:0] slave_Va2r_tap_dsp_error;
  output [20 - 1:0] slave_Va2r_tap_dsp_address;
  output [32 - 1:0] slave_Va2r_tap_dsp_data;
  output [1 - 1:0] slave_Va2r_tap_dsp_read;
  output [1 - 1:0] slave_Va2r_tap_dsp_write;
  me me(.gbl_clk(gbl_clk),
        .gbl_enable(gbl_enable),
        .gbl_reset_(gbl_reset_),
        .slave_Va2r_tap_arm_address(slave_Va2r_tap_dsp_address),
        .slave_Va2r_tap_arm_data(slave_Va2r_tap_dsp_data),
        .slave_Va2r_tap_arm_error(slave_Va2r_tap_dsp_error),
        .slave_Va2r_tap_arm_read(slave_Va2r_tap_dsp_read),
        .slave_Va2r_tap_arm_read_data(slave_Va2r_tap_dsp_read_data),
        .slave_Va2r_tap_arm_ready(slave_Va2r_tap_dsp_ready),
        .slave_Va2r_tap_arm_write(slave_Va2r_tap_dsp_write));
  `include "dsp.logic.vh"
endmodule

