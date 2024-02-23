`include "defines.v"

module a2p(a2rtap_master_ifc_address,
           a2rtap_master_ifc_write_data,
           a2rtap_master_ifc_read,
           a2rtap_master_ifc_write,
           a2rtap_master_ifc_read_data,
           a2rtap_master_ifc_ready,
           a2rtap_master_ifc_error,
           gbl_clock,
           gbl_reset,
           gbl_a2rtap_pipe_en);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 89
  input [1 - 1:0] a2rtap_master_ifc_address;
  input [1 - 1:0] a2rtap_master_ifc_write_data;
  input [1 - 1:0] a2rtap_master_ifc_read;
  input [1 - 1:0] a2rtap_master_ifc_write;
  input [1 - 1:0] gbl_clock;
  input [1 - 1:0] gbl_reset;
  input [1 - 1:0] gbl_a2rtap_pipe_en;
  output [1 - 1:0] a2rtap_master_ifc_read_data;
  output [1 - 1:0] a2rtap_master_ifc_ready;
  output [1 - 1:0] a2rtap_master_ifc_error;
  `include "a2p.logic.vh"
endmodule

