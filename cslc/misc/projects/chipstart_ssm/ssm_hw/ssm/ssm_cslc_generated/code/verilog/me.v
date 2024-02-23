`include "defines.v"

module me(gbl_clk,
          gbl_reset_,
          gbl_enable,
          slave_Va2r_tap_arm_read_data,
          slave_Va2r_tap_arm_ready,
          slave_Va2r_tap_arm_error,
          slave_Va2r_tap_arm_address,
          slave_Va2r_tap_arm_data,
          slave_Va2r_tap_arm_read,
          slave_Va2r_tap_arm_write);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 94
  input [1 - 1:0] gbl_clk;
  input [1 - 1:0] gbl_reset_;
  input [1 - 1:0] gbl_enable;
  output [32 - 1:0] slave_Va2r_tap_arm_read_data;
  output [1 - 1:0] slave_Va2r_tap_arm_ready;
  output [1 - 1:0] slave_Va2r_tap_arm_error;
  output [20 - 1:0] slave_Va2r_tap_arm_address;
  output [32 - 1:0] slave_Va2r_tap_arm_data;
  output [1 - 1:0] slave_Va2r_tap_arm_read;
  output [1 - 1:0] slave_Va2r_tap_arm_write;
  rf rf(.Va2r_tap_slave_in_ifc_address(slave_Va2r_tap_arm_address),
        .Va2r_tap_slave_in_ifc_data(slave_Va2r_tap_arm_data),
        .Va2r_tap_slave_in_ifc_error(slave_Va2r_tap_arm_error),
        .Va2r_tap_slave_in_ifc_read(slave_Va2r_tap_arm_read),
        .Va2r_tap_slave_in_ifc_read_data(slave_Va2r_tap_arm_read_data),
        .Va2r_tap_slave_in_ifc_ready(slave_Va2r_tap_arm_ready),
        .Va2r_tap_slave_in_ifc_write(slave_Va2r_tap_arm_write));
  pc pc();
  wb wb();
  eu eu();
  im im();
  `include "me.logic.vh"
endmodule

