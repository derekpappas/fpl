`include "defines.v"

module c(c_in,
         c_out);
// Location of source csl unit: file name = concat_s_sg.csl line number = 17
  input c_in;
  output [16 - 1:0] c_out;
  `include "c.logic.v"
endmodule

