`include "defines.v"

module b(p1,
         ar_p1_s_t);
// Location of source csl unit: file name = conn_pattern_ss.csl line number = 9
  input [8 - 1:0] p1;
  input [8 - 1:0] ar_p1_s_t;
  a a0(.p1(ar_p1_s_t));
  `include "b.logic.v"
endmodule

