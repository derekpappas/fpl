`include "defines.v"

module b(ck,
         res_port);
// Location of source csl unit: file name = conn_by_pattern.csl line number = 11
  input ck;
  input [1 - 1:0] res_port;
  a a0(.ck(ck),
       .reset(res_port));
  a a1(.ck(ck),
       .reset(res_port));
  `include "b.logic.v"
endmodule

