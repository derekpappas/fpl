`include "defines.v"

module Va2r_tap(Va2r_tap_master_ifc_address,
                Va2r_tap_master_ifc_write_data,
                Va2r_tap_master_ifc_read,
                Va2r_tap_master_ifc_write,
                Va2r_tap_master_ifc_read_data,
                Va2r_tap_master_ifc_ready,
                Va2r_tap_master_ifc_error,
                ring_out_ifc_grant,
                ring_out_ifc_request,
                ring_out_ifc_in,
                ring_out_ifc_aphi,
                ring_out_ifc_write,
                ring_out_ifc_read,
                ring_out_ifc_ready,
                ring_out_ifc_error,
                ring_in_ifc_grant,
                ring_in_ifc_request,
                ring_in_ifc_in,
                ring_in_ifc_aphi,
                ring_in_ifc_write,
                ring_in_ifc_read,
                ring_in_ifc_ready,
                ring_in_ifc_error,
                Va2r_tap_slave_out_ifc_read_data,
                Va2r_tap_slave_out_ifc_ready,
                Va2r_tap_slave_out_ifc_error,
                Va2r_tap_slave_out_ifc_address,
                Va2r_tap_slave_out_ifc_data,
                Va2r_tap_slave_out_ifc_read,
                Va2r_tap_slave_out_ifc_write,
                gbl_clk,
                gbl_reset_,
                gbl_enable);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 86
  input [1 - 1:0] Va2r_tap_master_ifc_read_data;
  input [1 - 1:0] Va2r_tap_master_ifc_ready;
  input [1 - 1:0] Va2r_tap_master_ifc_error;
  input [1 - 1:0] ring_out_ifc_grant;
  input [1 - 1:0] ring_out_ifc_request;
  input [1 - 1:0] ring_out_ifc_in;
  input [1 - 1:0] ring_out_ifc_aphi;
  input [1 - 1:0] ring_out_ifc_write;
  input [1 - 1:0] ring_out_ifc_read;
  input [1 - 1:0] ring_out_ifc_ready;
  input [1 - 1:0] ring_out_ifc_error;
  input [32 - 1:0] Va2r_tap_slave_out_ifc_read_data;
  input [1 - 1:0] Va2r_tap_slave_out_ifc_ready;
  input [1 - 1:0] Va2r_tap_slave_out_ifc_error;
  input [20 - 1:0] Va2r_tap_slave_out_ifc_address;
  input [32 - 1:0] Va2r_tap_slave_out_ifc_data;
  input [1 - 1:0] Va2r_tap_slave_out_ifc_read;
  input [1 - 1:0] Va2r_tap_slave_out_ifc_write;
  input [1 - 1:0] gbl_clk;
  input [1 - 1:0] gbl_reset_;
  input [1 - 1:0] gbl_enable;
  output [1 - 1:0] Va2r_tap_master_ifc_address;
  output [1 - 1:0] Va2r_tap_master_ifc_write_data;
  output [1 - 1:0] Va2r_tap_master_ifc_read;
  output [1 - 1:0] Va2r_tap_master_ifc_write;
  output [1 - 1:0] ring_in_ifc_grant;
  output [1 - 1:0] ring_in_ifc_request;
  output [1 - 1:0] ring_in_ifc_in;
  output [1 - 1:0] ring_in_ifc_aphi;
  output [1 - 1:0] ring_in_ifc_write;
  output [1 - 1:0] ring_in_ifc_read;
  output [1 - 1:0] ring_in_ifc_ready;
  output [1 - 1:0] ring_in_ifc_error;
  `include "Va2r_tap.logic.vh"
endmodule

