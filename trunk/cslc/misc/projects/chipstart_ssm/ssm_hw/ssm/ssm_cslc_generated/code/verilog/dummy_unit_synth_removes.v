`include "defines.v"

module dummy_unit_synth_removes(dummy1_master_ifc_address,
                                dummy1_master_ifc_write_data,
                                dummy1_master_ifc_read,
                                dummy1_master_ifc_write,
                                dummy1_master_ifc_read_data,
                                dummy1_master_ifc_ready,
                                dummy1_master_ifc_error,
                                dummy2_master_ifc_address,
                                dummy2_master_ifc_write_data,
                                dummy2_master_ifc_read,
                                dummy2_master_ifc_write,
                                dummy2_master_ifc_read_data,
                                dummy2_master_ifc_ready,
                                dummy2_master_ifc_error,
                                dummy3_master_ifc_address,
                                dummy3_master_ifc_write_data,
                                dummy3_master_ifc_read,
                                dummy3_master_ifc_write,
                                dummy3_master_ifc_read_data,
                                dummy3_master_ifc_ready,
                                dummy3_master_ifc_error);
// Location of source csl unit: file name = /Volumes/s2/unfuddle_ssm_repo/ssm_ssmrepo/ssm/hw/ssm/ssm_demo.csl line number = 90
  input [1 - 1:0] dummy1_master_ifc_address;
  input [1 - 1:0] dummy1_master_ifc_write_data;
  input [1 - 1:0] dummy1_master_ifc_read;
  input [1 - 1:0] dummy1_master_ifc_write;
  input [1 - 1:0] dummy2_master_ifc_address;
  input [1 - 1:0] dummy2_master_ifc_write_data;
  input [1 - 1:0] dummy2_master_ifc_read;
  input [1 - 1:0] dummy2_master_ifc_write;
  input [1 - 1:0] dummy3_master_ifc_address;
  input [1 - 1:0] dummy3_master_ifc_write_data;
  input [1 - 1:0] dummy3_master_ifc_read;
  input [1 - 1:0] dummy3_master_ifc_write;
  output [1 - 1:0] dummy1_master_ifc_read_data;
  output [1 - 1:0] dummy1_master_ifc_ready;
  output [1 - 1:0] dummy1_master_ifc_error;
  output [1 - 1:0] dummy2_master_ifc_read_data;
  output [1 - 1:0] dummy2_master_ifc_ready;
  output [1 - 1:0] dummy2_master_ifc_error;
  output [1 - 1:0] dummy3_master_ifc_read_data;
  output [1 - 1:0] dummy3_master_ifc_ready;
  output [1 - 1:0] dummy3_master_ifc_error;
  `include "dummy_unit_synth_removes.logic.vh"
endmodule

