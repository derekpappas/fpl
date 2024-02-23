`include "defines.v"

module u_a(ck,
           reset,
           p_a_in,
           p_a_out);
// Location of source csl unit: file name = c_test1.csl line number = 4
  input ck;
  input reset;
  input [8 - 1:0] p_a_in;
  output [8 - 1:0] p_a_out;
  `include "u_a.logic.v"
endmodule

