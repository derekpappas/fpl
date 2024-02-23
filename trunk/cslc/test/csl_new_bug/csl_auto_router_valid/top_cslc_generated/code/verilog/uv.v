`include "defines.v"

module uv(irc_reset,
          irc_clock,
          iin1_pinx,
          iin1_piny,
          iin2_pinx,
          iin2_piny,
          iout1_pinx,
          iout1_piny,
          iout2_pinx,
          iout2_piny);
// Location of source csl unit: file name = ar10b.csl line number = 69
  input irc_reset;
  input irc_clock;
  input [8 - 1:0] iin1_pinx;
  input [8 - 1:0] iin1_piny;
  input [8 - 1:0] iin2_pinx;
  input [8 - 1:0] iin2_piny;
  output [8 - 1:0] iout1_pinx;
  output [8 - 1:0] iout1_piny;
  output [8 - 1:0] iout2_pinx;
  output [8 - 1:0] iout2_piny;
  `include "uv.logic.v"
endmodule

