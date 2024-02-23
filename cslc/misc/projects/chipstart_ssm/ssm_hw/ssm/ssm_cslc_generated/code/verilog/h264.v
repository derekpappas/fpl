`include "defines.v"

module h264(slave_Va2r_tap_h264_read_data,
            slave_Va2r_tap_h264_ready,
            slave_Va2r_tap_h264_error,
            slave_Va2r_tap_h264_address,
            slave_Va2r_tap_h264_data,
            slave_Va2r_tap_h264_read,
            slave_Va2r_tap_h264_write,
            gbl_clk,
            gbl_reset_,
            gbl_enable);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 92
  input [1 - 1:0] gbl_clk;
  input [1 - 1:0] gbl_reset_;
  input [1 - 1:0] gbl_enable;
  output [32 - 1:0] slave_Va2r_tap_h264_read_data;
  output [1 - 1:0] slave_Va2r_tap_h264_ready;
  output [1 - 1:0] slave_Va2r_tap_h264_error;
  output [20 - 1:0] slave_Va2r_tap_h264_address;
  output [32 - 1:0] slave_Va2r_tap_h264_data;
  output [1 - 1:0] slave_Va2r_tap_h264_read;
  output [1 - 1:0] slave_Va2r_tap_h264_write;
  me me(.gbl_clk(gbl_clk),
        .gbl_enable(gbl_enable),
        .gbl_reset_(gbl_reset_),
        .slave_Va2r_tap_arm_address(slave_Va2r_tap_h264_address),
        .slave_Va2r_tap_arm_data(slave_Va2r_tap_h264_data),
        .slave_Va2r_tap_arm_error(slave_Va2r_tap_h264_error),
        .slave_Va2r_tap_arm_read(slave_Va2r_tap_h264_read),
        .slave_Va2r_tap_arm_read_data(slave_Va2r_tap_h264_read_data),
        .slave_Va2r_tap_arm_ready(slave_Va2r_tap_h264_ready),
        .slave_Va2r_tap_arm_write(slave_Va2r_tap_h264_write));
  `include "h264.logic.vh"
endmodule

