`include "defines.v"

module c(reset,
         ck_port);
// Location of source csl unit: file name = conn_by_pattern.csl line number = 19
  input reset;
  input [1 - 1:0] ck_port;
  b b0(.ck(ck_port),
       .res_port(reset));
  `include "c.logic.v"
endmodule

