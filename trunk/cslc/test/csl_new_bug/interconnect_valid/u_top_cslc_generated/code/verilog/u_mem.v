`include "defines.v"

module u_mem(p_data_in,
             p_addr,
             p_data_out);
// Location of source csl unit: file name = parameter_test3.csl line number = 3
  parameter addr = 1;
  parameter data = 1;
  input [data - 1:0] p_data_in;
  input [addr - 1:0] p_addr;
  output [data - 1:0] p_data_out;
  `include "u_mem.logic.v"
endmodule

