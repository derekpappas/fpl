`include "defines.v"

module RAM(ram_bus0_valid,
           ram_bus0_write_en,
           ram_bus0_addr,
           ram_bus0_write_data,
           ram_bus0_read_data,
           ram_bus0_ready,
           ram_bus1_valid,
           ram_bus1_write_en,
           ram_bus1_addr,
           ram_bus1_write_data,
           ram_bus1_read_data,
           ram_bus1_ready,
           ram_bus2_valid,
           ram_bus2_write_en,
           ram_bus2_addr,
           ram_bus2_write_data,
           ram_bus2_read_data,
           ram_bus2_ready);
// Location of source csl unit: file name = generated/vizzini_core.csl line number = 73
  input [12 - 1:0] ram_bus0_read_data;
  input ram_bus0_ready;
  input [12 - 1:0] ram_bus1_read_data;
  input ram_bus1_ready;
  input [12 - 1:0] ram_bus2_read_data;
  input ram_bus2_ready;
  output ram_bus0_valid;
  output ram_bus0_write_en;
  output [5 - 1:0] ram_bus0_addr;
  output [12 - 1:0] ram_bus0_write_data;
  output ram_bus1_valid;
  output ram_bus1_write_en;
  output [5 - 1:0] ram_bus1_addr;
  output [12 - 1:0] ram_bus1_write_data;
  output ram_bus2_valid;
  output ram_bus2_write_en;
  output [5 - 1:0] ram_bus2_addr;
  output [12 - 1:0] ram_bus2_write_data;
  `include "RAM.logic.v"
endmodule

