`include "defines.v"

module ssm_master(Va2r_tap_master_ifc_address,
                  Va2r_tap_master_ifc_write_data,
                  Va2r_tap_master_ifc_read,
                  Va2r_tap_master_ifc_write,
                  Va2r_tap_master_ifc_read_data,
                  Va2r_tap_master_ifc_ready,
                  Va2r_tap_master_ifc_error,
                  gbl_clk,
                  gbl_reset_,
                  gbl_enable);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 98
  input [1 - 1:0] Va2r_tap_master_ifc_address;
  input [1 - 1:0] Va2r_tap_master_ifc_write_data;
  input [1 - 1:0] Va2r_tap_master_ifc_read;
  input [1 - 1:0] Va2r_tap_master_ifc_write;
  input [1 - 1:0] gbl_clk;
  input [1 - 1:0] gbl_reset_;
  input [1 - 1:0] gbl_enable;
  output [1 - 1:0] Va2r_tap_master_ifc_read_data;
  output [1 - 1:0] Va2r_tap_master_ifc_ready;
  output [1 - 1:0] Va2r_tap_master_ifc_error;
  `include "ssm_master.logic.vh"
endmodule

