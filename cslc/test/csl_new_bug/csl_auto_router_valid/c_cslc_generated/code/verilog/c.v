`include "defines.v"

module c(ifc10_p_x,
         ifc10_ifc00_p_m,
         ifc10_ifc00_p_n,
         ifc10_ifc00_p_o,
         ifc10_ifc01_p_m,
         ifc10_ifc01_p_n,
         ifc10_ifc01_p_o);
// Location of source csl unit: file name = conn_name22.csl line number = 42
  input [88 - 1:0] ifc10_p_x;
  input [78 - 1:0] ifc10_ifc00_p_m;
  input [78 - 1:0] ifc10_ifc00_p_o;
  input [78 - 1:0] ifc10_ifc01_p_m;
  input [78 - 1:0] ifc10_ifc01_p_o;
  output [64 - 1:0] ifc10_ifc00_p_n;
  output [64 - 1:0] ifc10_ifc01_p_n;
  wire [78 - 1:0] s_m;
  wire [152 - 1:0] s_c;
  b b0(.ifc10_ifc00_p_n(ifc10_ifc00_p_n),
       .ifc11_ifc00_p_m(ifc10_ifc00_p_m),
       .ifc11_ifc00_p_n(ifc10_ifc00_p_n),
       .ifc11_ifc00_p_o(ifc10_ifc00_p_o),
       .ifc11_ifc01_p_m(ifc10_ifc01_p_m),
       .ifc11_ifc01_p_n(ifc10_ifc01_p_n),
       .ifc11_ifc01_p_o(ifc10_ifc01_p_o),
       .ifc11_p_x(ifc10_p_x),
       .p_c(s_c[151:88]),
       .p_m(s_m));
  `include "c.logic.vh"
endmodule

