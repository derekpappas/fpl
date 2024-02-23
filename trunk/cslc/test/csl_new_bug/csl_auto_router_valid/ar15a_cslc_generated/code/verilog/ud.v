`include "defines.v"

module ud(pdin,
          pdout1,
          pdout2,
          ifcin_hw,
          ifcin_w,
          ifcrc_reset,
          ifcrc_clock);
// Location of source csl unit: file name = ar15c.csl line number = 98
  input [8 - 1:0] pdin;
  input [16 - 1:0] ifcin_hw;
  input [8 - 1:0] ifcin_w;
  input ifcrc_reset;
  input ifcrc_clock;
  output [16 - 1:0] pdout1;
  output [3 - 1:0] pdout2;
  `include "ud.logic.v"
endmodule

