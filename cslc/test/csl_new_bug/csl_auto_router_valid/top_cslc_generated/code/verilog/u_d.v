`include "defines.v"

module u_d(ck,
           reset,
           p_d_in,
           p_d_out);
// Location of source csl unit: file name = c_test1.csl line number = 23
  input ck;
  input reset;
  input [8 - 1:0] p_d_in;
  output [8 - 1:0] p_d_out;
  `include "u_d.logic.v"
endmodule

