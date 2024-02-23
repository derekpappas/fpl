`include "defines.v"

module u12(ifcrc0_reset,
           ifcrc0_clock,
           ifc12_i0_pin,
           ifc12_i0_pout1,
           ifc12_i0_pout2);
// Location of source csl unit: file name = ar13b.csl line number = 41
  input ifcrc0_reset;
  input ifcrc0_clock;
  input [8 - 1:0] ifc12_i0_pin;
  output [8 - 1:0] ifc12_i0_pout1;
  output [8 - 1:0] ifc12_i0_pout2;
  `include "u12.logic.v"
endmodule

