`include "defines.v"

module cluster(out);
// Location of source csl unit: file name = connect_output_to_input_u_to_u.csl line number = 6
  input [32 - 1:0] out;
  proc p0(.in(out));
  proc p1(.in(out));
  `include "cluster.logic.v"
endmodule

