`include "defines.v"

module uu(sel,
          irc_reset,
          irc_clock,
          iin_pinx,
          iin_piny,
          iout_pinx,
          iout_piny);
// Location of source csl unit: file name = ar10b.csl line number = 57
  input [2 - 1:0] sel;
  input irc_reset;
  input irc_clock;
  input [8 - 1:0] iin_pinx;
  input [8 - 1:0] iin_piny;
  output [8 - 1:0] iout_pinx;
  output [8 - 1:0] iout_piny;
  `include "uu.logic.v"
endmodule

