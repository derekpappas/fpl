`include "defines.v"

module u_a(p_a_in,
           p_a_out);
// Location of source csl unit: file name = ar3b.csl line number = 27
  input [2 - 1:0] p_a_in;
  output p_a_out;
  `include "u_a.logic.v"
endmodule

