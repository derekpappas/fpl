`include "defines.v"

module b(b_in,
         b_out);
// Location of source csl unit: file name = concat_s_sg.csl line number = 11
  input b_in;
  output [8 - 1:0] b_out;
  `include "b.logic.v"
endmodule

