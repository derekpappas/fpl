`include "defines.v"

module uc(pcin,
          pcout,
          ifcrc_reset,
          ifcrc_clock);
// Location of source csl unit: file name = ar15c.csl line number = 88
  input [8 - 1:0] pcin;
  input ifcrc_reset;
  input ifcrc_clock;
  output [16 - 1:0] pcout;
  `include "uc.logic.v"
endmodule

