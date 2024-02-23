`include "defines.v"

module ubc(ifc11_i1_pin,
           ifc11_i1_pout,
           ifc12_i1_pin,
           ifc12_i1_pout1,
           ifc12_i1_pout2,
           ar_rst_reset,
           ar_clk_clock);
// Location of source csl unit: file name = ar13b.csl line number = 65
  input [8 - 1:0] ifc11_i1_pin;
  input [8 - 1:0] ifc12_i1_pin;
  input [1 - 1:0] ar_rst_reset;
  input [1 - 1:0] ar_clk_clock;
  output [8 - 1:0] ifc11_i1_pout;
  output [8 - 1:0] ifc12_i1_pout1;
  output [8 - 1:0] ifc12_i1_pout2;
  u11 ub(.ifc11_i0_pin(ifc11_i1_pin),
         .ifc11_i0_pout(ifc11_i1_pout),
         .ifcrc1_clock(ar_clk_clock),
         .ifcrc1_reset(ar_rst_reset));
  u12 uc(.ifc12_i0_pin(ifc12_i1_pin),
         .ifc12_i0_pout1(ifc12_i1_pout1),
         .ifc12_i0_pout2(ifc12_i1_pout2),
         .ifcrc0_clock(ar_clk_clock),
         .ifcrc0_reset(ar_rst_reset));
  `include "ubc.logic.v"
endmodule

