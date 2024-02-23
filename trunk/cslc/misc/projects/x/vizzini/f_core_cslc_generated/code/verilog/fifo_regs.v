`include "defines.v"

module fifo_regs(fifo_reg_bus0_write_en,
                 fifo_reg_bus0_addr,
                 fifo_reg_bus0_write_data,
                 fifo_reg_bus0_read_data,
                 fifo_reg_write_en,
                 fifo_reg_addr,
                 fifo_reg_write_data,
                 fifo_reg_read_data);
// Location of source csl unit: file name = generated/fezzik_core.csl line number = 92
  input [12 - 1:0] fifo_reg_bus0_read_data;
  input fifo_reg_write_en;
  input [5 - 1:0] fifo_reg_addr;
  input [12 - 1:0] fifo_reg_write_data;
  output fifo_reg_bus0_write_en;
  output [5 - 1:0] fifo_reg_bus0_addr;
  output [12 - 1:0] fifo_reg_bus0_write_data;
  output [12 - 1:0] fifo_reg_read_data;
  `include "fifo_regs.logic.v"
endmodule

