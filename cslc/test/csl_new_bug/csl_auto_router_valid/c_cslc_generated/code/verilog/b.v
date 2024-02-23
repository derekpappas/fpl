`include "defines.v"

module b(p_m,
         p_c,
         ifc11_p_x,
         ifc11_ifc00_p_m,
         ifc11_ifc00_p_n,
         ifc11_ifc00_p_o,
         ifc11_ifc01_p_m,
         ifc11_ifc01_p_n,
         ifc11_ifc01_p_o,
         ifc10_ifc00_p_n);
// Location of source csl unit: file name = conn_name22.csl line number = 32
  input [78 - 1:0] p_m;
  input [88 - 1:0] ifc11_p_x;
  input [78 - 1:0] ifc11_ifc00_p_m;
  input [78 - 1:0] ifc11_ifc00_p_o;
  input [78 - 1:0] ifc11_ifc01_p_m;
  input [78 - 1:0] ifc11_ifc01_p_o;
  output [64 - 1:0] p_c;
  output [64 - 1:0] ifc11_ifc00_p_n;
  output [64 - 1:0] ifc11_ifc01_p_n;
  output [64 - 1:0] ifc10_ifc00_p_n;
  a a0(.ifc00_p_m(p_m),
       .ifc00_p_n(p_c),
       .ifc00_p_o(p_m),
       .p_n(ifc10_ifc00_p_n));
  `include "b.logic.vh"
endmodule

