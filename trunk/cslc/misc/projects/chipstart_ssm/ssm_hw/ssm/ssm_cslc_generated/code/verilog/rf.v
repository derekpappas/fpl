`include "defines.v"

module rf(Va2r_tap_slave_in_ifc_read_data,
          Va2r_tap_slave_in_ifc_ready,
          Va2r_tap_slave_in_ifc_error,
          Va2r_tap_slave_in_ifc_address,
          Va2r_tap_slave_in_ifc_data,
          Va2r_tap_slave_in_ifc_read,
          Va2r_tap_slave_in_ifc_write);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 96
  output [32 - 1:0] Va2r_tap_slave_in_ifc_read_data;
  output [1 - 1:0] Va2r_tap_slave_in_ifc_ready;
  output [1 - 1:0] Va2r_tap_slave_in_ifc_error;
  output [20 - 1:0] Va2r_tap_slave_in_ifc_address;
  output [32 - 1:0] Va2r_tap_slave_in_ifc_data;
  output [1 - 1:0] Va2r_tap_slave_in_ifc_read;
  output [1 - 1:0] Va2r_tap_slave_in_ifc_write;
  `include "rf.logic.vh"
endmodule

