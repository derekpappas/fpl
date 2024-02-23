`include "defines.v"

module uart_mgr(fifo_reg_bus0_write_en,
                fifo_reg_bus0_addr,
                fifo_reg_bus0_write_data,
                fifo_reg_bus0_read_data,
                ram_bus1_valid,
                ram_bus1_write_en,
                ram_bus1_addr,
                ram_bus1_write_data,
                ram_bus1_read_data,
                ram_bus1_ready,
                fabric_drop_valid,
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
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 62
  input [12 - 1:0] fifo_reg_bus0_read_data;
  input ram_bus1_valid;
  input ram_bus1_write_en;
  input [5 - 1:0] ram_bus1_addr;
  input [12 - 1:0] ram_bus1_write_data;
  input fabric_drop_valid;
  input [2 - 1:0] fabric_drop_type;
  input [4 - 1:0] fabric_drop_src_nid;
  input [12 - 1:0] fabric_drop_addr;
  input [12 - 1:0] fabric_drop_data;
  input fabric_add_ready;
  output fifo_reg_bus0_write_en;
  output [5 - 1:0] fifo_reg_bus0_addr;
  output [12 - 1:0] fifo_reg_bus0_write_data;
  output [12 - 1:0] ram_bus1_read_data;
  output ram_bus1_ready;
  output fabric_add_valid;
  output [2 - 1:0] fabric_add_type;
  output [4 - 1:0] fabric_add_dst_nid;
  output [12 - 1:0] fabric_add_addr;
  output [12 - 1:0] fabric_add_data;
  `include "uart_mgr.logic.v"
endmodule

