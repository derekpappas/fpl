`include "defines.v"

module ue(pein,
          peout,
          ifcin_hw,
          ifcin_w,
          ifcrc_reset,
          ifcrc_clock);
// Location of source csl unit: file name = ar15c.csl line number = 109
  input [16 - 1:0] pein;
  input [16 - 1:0] ifcin_hw;
  input [8 - 1:0] ifcin_w;
  input ifcrc_reset;
  input ifcrc_clock;
  output [8 - 1:0] peout;
  `include "ue.logic.v"
endmodule

