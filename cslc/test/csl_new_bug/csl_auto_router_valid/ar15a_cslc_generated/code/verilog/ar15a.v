`include "defines.v"

module ar15a(ifcrc0_reset,
             ifcrc0_clock,
             ifcin0_p0,
             ifcin0_p1,
             ifcin0_p2,
             ifcout0_p0,
             ifcout0_p1,
             ifcout0_p2,
             ifcin1_hw,
             ifcin1_w,
             ifcin1_c,
             ifcin2_hw,
             ifcin2_w,
             ifcin2_c,
             ifcin3_hw,
             ifcin3_w,
             ifcin3_c,
             pt_out,
             p_w,
             pt1_out);
// Location of source csl unit: file name = ar15c.csl line number = 141
  input ifcrc0_reset;
  input ifcrc0_clock;
  input [8 - 1:0] ifcin0_p0;
  input [8 - 1:0] ifcin0_p1;
  input [8 - 1:0] ifcin0_p2;
  input [16 - 1:0] ifcin1_hw;
  input [8 - 1:0] ifcin1_w;
  input [3 - 1:0] ifcin1_c;
  input [16 - 1:0] ifcin2_hw;
  input [8 - 1:0] ifcin2_w;
  input [3 - 1:0] ifcin2_c;
  input [16 - 1:0] ifcin3_hw;
  input [8 - 1:0] ifcin3_w;
  input [3 - 1:0] ifcin3_c;
  input [16 - 1:0] pt_out;
  input [8 - 1:0] p_w;
  output [8 - 1:0] ifcout0_p0;
  output [8 - 1:0] ifcout0_p1;
  output [8 - 1:0] ifcout0_p2;
  output [16 - 1:0] pt1_out;
  wire [8 - 1:0] s_out;
  ua ua0(.ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pain(ifcin0_p0),
         .paout(s_out));
  ub ub0(.ifcout_hw(pt_out),
         .ifcout_w(p_w),
         .ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pbin(ifcin0_p1));
  uc uc0(.ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pcin(ifcin0_p2),
         .pcout(pt1_out));
  ude ude0(.ifcrc0_clock(ifcrc0_clock),
           .ifcrc0_reset(ifcrc0_reset));
  uf uf0(.ifcfin_c(ifcin1_c),
         .ifcfin_hw(ifcin1_hw),
         .ifcfin_w(ifcin1_w),
         .ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pfout(ifcout0_p0));
  uf uf1(.ifcfin_c(ifcin2_c),
         .ifcfin_hw(ifcin2_hw),
         .ifcfin_w(ifcin2_w),
         .ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pfout(ifcout0_p1));
  uf uf2(.ifcfin_c(ifcin3_c),
         .ifcfin_hw(ifcin3_hw),
         .ifcfin_w(ifcin3_w),
         .ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pfout(ifcout0_p2));
  `include "ar15a.logic.v"
endmodule

