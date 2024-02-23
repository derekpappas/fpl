`include "defines.v"

module d(clk,
         res);
// Location of source csl unit: file name = conn_by_pattern.csl line number = 25
  input clk;
  input res;
  c c0(.ck_port(clk),
       .reset(res));
  `include "d.logic.v"
endmodule

