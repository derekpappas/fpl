`include "defines.v"

module uabc(ifc11_i2_pin,
            ifc11_i2_pout,
            ifc12_i2_pin,
            ifc12_i2_pout1,
            ifc12_i2_pout2,
            ar_rst_reset,
            ar_clk_clock);
// Location of source csl unit: file name = ar13b.csl line number = 76
  input [8 - 1:0] ifc11_i2_pin;
  input [8 - 1:0] ifc12_i2_pin;
  input [1 - 1:0] ar_rst_reset;
  input [1 - 1:0] ar_clk_clock;
  output [8 - 1:0] ifc11_i2_pout;
  output [8 - 1:0] ifc12_i2_pout1;
  output [8 - 1:0] ifc12_i2_pout2;
  ubc ubc0(.ar_clk_clock(ar_clk_clock),
           .ar_rst_reset(ar_rst_reset),
           .ifc11_i1_pin(ifc11_i2_pin),
           .ifc11_i1_pout(ifc11_i2_pout),
           .ifc12_i1_pin(ifc12_i2_pin),
           .ifc12_i1_pout1(ifc12_i2_pout1),
           .ifc12_i1_pout2(ifc12_i2_pout2));
  `include "uabc.logic.v"
endmodule

