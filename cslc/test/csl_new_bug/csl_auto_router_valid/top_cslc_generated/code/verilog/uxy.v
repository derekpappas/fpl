`include "defines.v"

module uxy(irc_reset,
           irc_clock,
           ifcxin_pinx,
           ifcxin_piny,
           iin1_pinx,
           iin1_piny,
           iin2_pinx,
           iin2_piny,
           ar_tsel1_sel,
           ar_tsel2_sel);
// Location of source csl unit: file name = ar10b.csl line number = 82
  input irc_reset;
  input irc_clock;
  input [8 - 1:0] ifcxin_pinx;
  input [8 - 1:0] ifcxin_piny;
  input [2 - 1:0] ar_tsel1_sel;
  input [2 - 1:0] ar_tsel2_sel;
  output [8 - 1:0] iin1_pinx;
  output [8 - 1:0] iin1_piny;
  output [8 - 1:0] iin2_pinx;
  output [8 - 1:0] iin2_piny;
  uu ux(.iin_pinx(ifcxin_pinx),
        .iin_piny(ifcxin_piny),
        .iout_pinx(iin1_pinx),
        .iout_piny(iin1_piny),
        .irc_clock(irc_clock),
        .irc_reset(irc_reset),
        .sel(ar_tsel1_sel));
  uu uy(.iin_pinx(ifcxin_pinx),
        .iin_piny(ifcxin_piny),
        .iout_pinx(iin2_pinx),
        .iout_piny(iin2_piny),
        .irc_clock(irc_clock),
        .irc_reset(irc_reset),
        .sel(ar_tsel2_sel));
  `include "uxy.logic.v"
endmodule

