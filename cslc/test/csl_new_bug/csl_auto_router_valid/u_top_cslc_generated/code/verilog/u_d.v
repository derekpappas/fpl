`include "defines.v"

module u_d(p_d_in1,
           p_d_out);
// Location of source csl unit: file name = ar3b.csl line number = 47
  input [2 - 1:0] p_d_in1;
  output p_d_out;
  `include "u_d.logic.v"
endmodule

