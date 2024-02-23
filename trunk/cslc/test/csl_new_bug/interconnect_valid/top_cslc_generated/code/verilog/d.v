`include "defines.v"

module d(d_in,
         d_out);
// Location of source csl unit: file name = concat_s_sg.csl line number = 23
  input [32 - 1:0] d_in;
  output d_out;
  `include "d.logic.v"
endmodule

