`include "defines.v"

module ub(pbin,
          ifcout_hw,
          ifcout_w,
          ifcrc_reset,
          ifcrc_clock);
// Location of source csl unit: file name = ar15c.csl line number = 78
  input [8 - 1:0] pbin;
  input [16 - 1:0] ifcout_hw;
  input [8 - 1:0] ifcout_w;
  input ifcrc_reset;
  input ifcrc_clock;
  `include "ub.logic.v"
endmodule

