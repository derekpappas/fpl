`include "defines.v"

module u21(ifcrc2_reset,
           ifcrc2_clock,
           pin1,
           pin2,
           pout);
// Location of source csl unit: file name = ar13b.csl line number = 56
  input ifcrc2_reset;
  input ifcrc2_clock;
  input [8 - 1:0] pin1;
  input [8 - 1:0] pin2;
  output [36 - 1:0] pout;
  `include "u21.logic.v"
endmodule

