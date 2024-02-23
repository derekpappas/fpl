`include "defines.v"

module ua(pain,
          paout,
          ifcrc_reset,
          ifcrc_clock);
// Location of source csl unit: file name = ar15c.csl line number = 68
  input [8 - 1:0] pain;
  input ifcrc_reset;
  input ifcrc_clock;
  output [8 - 1:0] paout;
  `include "ua.logic.v"
endmodule

