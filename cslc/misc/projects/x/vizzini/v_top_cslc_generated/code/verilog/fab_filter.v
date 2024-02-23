`include "defines.v"

module fab_filter(fabric_out_valid,
                  fabric_out_age,
                  fabric_out_type,
                  fabric_out_src_nid,
                  fabric_out_dst_nid,
                  fabric_out_addr,
                  fabric_out_data,
                  fabric_in_valid,
                  fabric_in_age,
                  fabric_in_type,
                  fabric_in_src_nid,
                  fabric_in_dst_nid,
                  fabric_in_addr,
                  fabric_in_data);
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 132
  input fabric_in_valid;
  input fabric_in_age;
  input [2 - 1:0] fabric_in_type;
  input [4 - 1:0] fabric_in_src_nid;
  input [4 - 1:0] fabric_in_dst_nid;
  input [12 - 1:0] fabric_in_addr;
  input [12 - 1:0] fabric_in_data;
  output fabric_out_valid;
  output fabric_out_age;
  output [2 - 1:0] fabric_out_type;
  output [4 - 1:0] fabric_out_src_nid;
  output [4 - 1:0] fabric_out_dst_nid;
  output [12 - 1:0] fabric_out_addr;
  output [12 - 1:0] fabric_out_data;
  `include "fab_filter.logic.v"
endmodule

