`include "defines.v"

module u_top();
// Location of source csl unit: file name = parameter_test3.csl line number = 14
  wire [32 - 1:0] s_data;
  wire [16 - 1:0] s_addr;
  u_mem #(.addr(16),
        .data(32))
        u1(.p_addr(s_addr),
           .p_data_in(s_data),
           .p_data_out(s_data));
  `include "u_top.logic.v"
endmodule

