`include "defines.v"

module mcb(a2rtap_slave_in_ifc_read_data,
           a2rtap_slave_in_ifc_ready,
           a2rtap_slave_in_ifc_error,
           a2rtap_slave_in_ifc_address,
           a2rtap_slave_in_ifc_data,
           a2rtap_slave_in_ifc_read,
           a2rtap_slave_in_ifc_write,
           mbc_in_ifc_address,
           mbc_in_ifc_write_data,
           mbc_in_ifc_write,
           mbc_in_ifc_read,
           mbc_in_ifc_read_data,
           mbc_in_ifc_control);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 136
  input [32 - 1:0] mbc_in_ifc_read_data;
  input [32 - 1:0] mbc_in_ifc_control;
  output [32 - 1:0] a2rtap_slave_in_ifc_read_data;
  output [1 - 1:0] a2rtap_slave_in_ifc_ready;
  output [1 - 1:0] a2rtap_slave_in_ifc_error;
  output [20 - 1:0] a2rtap_slave_in_ifc_address;
  output [32 - 1:0] a2rtap_slave_in_ifc_data;
  output [1 - 1:0] a2rtap_slave_in_ifc_read;
  output [1 - 1:0] a2rtap_slave_in_ifc_write;
  output [32 - 1:0] mbc_in_ifc_address;
  output [32 - 1:0] mbc_in_ifc_write_data;
  output [1 - 1:0] mbc_in_ifc_write;
  output [1 - 1:0] mbc_in_ifc_read;
  `include "mcb.logic.vh"
endmodule

