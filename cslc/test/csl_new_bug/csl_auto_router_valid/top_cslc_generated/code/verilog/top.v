`include "defines.v"

module top();
// Location of source csl unit: file name = conn_pattern_ss.csl line number = 22
  wire [8 - 1:0] s_t;
  c c0(.ar_p1_s_t(s_t));
  `include "top.logic.v"
endmodule

