`include "defines.v"

module u_c(ck,
           reset,
           p_c_in,
           p_c_out);
// Location of source csl unit: file name = c_test1.csl line number = 17
  input ck;
  input reset;
  input [8 - 1:0] p_c_in;
  output [8 - 1:0] p_c_out;
  `include "u_c.logic.v"
endmodule

