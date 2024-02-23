`include "defines.v"

module i2c(fabric_drop_valid,
           fabric_drop_type,
           fabric_drop_src_nid,
           fabric_drop_addr,
           fabric_drop_data,
           fabric_add_valid,
           fabric_add_type,
           fabric_add_dst_nid,
           fabric_add_addr,
           fabric_add_data,
           fabric_add_ready);
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 96
  input fabric_drop_valid;
  input [2 - 1:0] fabric_drop_type;
  input [4 - 1:0] fabric_drop_src_nid;
  input [12 - 1:0] fabric_drop_addr;
  input [12 - 1:0] fabric_drop_data;
  input fabric_add_ready;
  output fabric_add_valid;
  output [2 - 1:0] fabric_add_type;
  output [4 - 1:0] fabric_add_dst_nid;
  output [12 - 1:0] fabric_add_addr;
  output [12 - 1:0] fabric_add_data;
  `include "i2c.logic.v"
endmodule

