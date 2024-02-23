`include "defines.v"

module c(ar_p1_s_t);
// Location of source csl unit: file name = conn_pattern_ss.csl line number = 15
  input [8 - 1:0] ar_p1_s_t;
  b b0(.ar_p1_s_t(ar_p1_s_t),
       .p1(ar_p1_s_t));
  `include "c.logic.v"
endmodule

