`include "defines.v"

module u_b(ck,
           reset,
           p_b_in,
           p_b_out);
// Location of source csl unit: file name = c_test1.csl line number = 11
  input ck;
  input reset;
  input [8 - 1:0] p_b_in;
  output [8 - 1:0] p_b_out;
  `include "u_b.logic.v"
endmodule

