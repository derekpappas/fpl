`include "defines.v"

module cmpr(mbc_out_ifc_address,
            mbc_out_ifc_write_data,
            mbc_out_ifc_write,
            mbc_out_ifc_read,
            mbc_out_ifc_read_data,
            mbc_out_ifc_control);
// Location of source csl unit: file name = /opt/new_aurora_fpl_repo/repos/trunk/cslc/misc/projects/ssm/ssm_demo.csl line number = 129
  input [32 - 1:0] mbc_out_ifc_address;
  input [32 - 1:0] mbc_out_ifc_write_data;
  input [1 - 1:0] mbc_out_ifc_write;
  input [1 - 1:0] mbc_out_ifc_read;
  output [32 - 1:0] mbc_out_ifc_read_data;
  output [32 - 1:0] mbc_out_ifc_control;
  me me();
  `include "cmpr.logic.vh"
endmodule
