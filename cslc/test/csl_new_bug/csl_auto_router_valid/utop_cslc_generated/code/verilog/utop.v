`include "defines.v"

module utop(rst,
            clk,
            tin1,
            tin2,
            tout1,
            ifc11_i3_pin,
            ifc11_i3_pout,
            ifc12_i3_pin,
            ifc12_i3_pout1,
            ifc12_i3_pout2);
// Location of source csl unit: file name = ar13b.csl line number = 88
  input rst;
  input clk;
  input [8 - 1:0] tin1;
  input [8 - 1:0] tin2;
  input [8 - 1:0] ifc11_i3_pin;
  input [8 - 1:0] ifc12_i3_pin;
  output [36 - 1:0] tout1;
  output [8 - 1:0] ifc11_i3_pout;
  output [8 - 1:0] ifc12_i3_pout1;
  output [8 - 1:0] ifc12_i3_pout2;
  uabc u0(.ar_clk_clock(clk),
          .ar_rst_reset(rst),
          .ifc11_i2_pin(ifc11_i3_pin),
          .ifc11_i2_pout(ifc11_i3_pout),
          .ifc12_i2_pin(ifc12_i3_pin),
          .ifc12_i2_pout1(ifc12_i3_pout1),
          .ifc12_i2_pout2(ifc12_i3_pout2));
  u21 u21_i(.ifcrc2_clock(clk),
            .ifcrc2_reset(rst),
            .pin1(tin1),
            .pin2(tin2),
            .pout(tout1));
  `include "utop.logic.v"
endmodule

