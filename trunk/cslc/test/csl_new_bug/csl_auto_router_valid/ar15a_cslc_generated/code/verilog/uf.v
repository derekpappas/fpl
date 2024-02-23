`include "defines.v"

module uf(pfout,
          ifcfin_hw,
          ifcfin_w,
          ifcfin_c,
          ifcrc_reset,
          ifcrc_clock);
// Location of source csl unit: file name = ar15c.csl line number = 131
  input [16 - 1:0] ifcfin_hw;
  input [8 - 1:0] ifcfin_w;
  input [3 - 1:0] ifcfin_c;
  input ifcrc_reset;
  input ifcrc_clock;
  output [8 - 1:0] pfout;
  `include "uf.logic.v"
endmodule

