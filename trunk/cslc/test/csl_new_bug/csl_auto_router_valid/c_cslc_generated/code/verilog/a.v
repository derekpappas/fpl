`include "defines.v"

module a(ifc00_p_m,
         ifc00_p_n,
         ifc00_p_o,
         p_n);
// Location of source csl unit: file name = conn_name22.csl line number = 25
  input [78 - 1:0] ifc00_p_m;
  input [78 - 1:0] ifc00_p_o;
  output [64 - 1:0] ifc00_p_n;
  inout [64 - 1:0] p_n;
  `include "a.logic.vh"
endmodule

