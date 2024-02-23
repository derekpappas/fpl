`include "defines.v"

module u11(ifcrc1_reset,
           ifcrc1_clock,
           ifc11_i0_pin,
           ifc11_i0_pout);
// Location of source csl unit: file name = ar13b.csl line number = 48
  input ifcrc1_reset;
  input ifcrc1_clock;
  input [8 - 1:0] ifc11_i0_pin;
  output [8 - 1:0] ifc11_i0_pout;
  `include "u11.logic.v"
endmodule

