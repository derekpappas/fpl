`include "defines.v"

module a(a_in,
         a_out);
// Location of source csl unit: file name = concat_s_sg.csl line number = 5
  input a_in;
  output [8 - 1:0] a_out;
  `include "a.logic.v"
endmodule

