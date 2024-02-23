`include "defines.v"

module ude(ifcrc0_reset,
           ifcrc0_clock);
// Location of source csl unit: file name = ar15c.csl line number = 119
  input [1 - 1:0] ifcrc0_reset;
  input [1 - 1:0] ifcrc0_clock;
  wire [8 - 1:0] s_in;
  wire [16 - 1:0] se_in;
  wire [16 - 1:0] sg01_hw;
  wire [8 - 1:0] sg01_w;
  wire [16 - 1:0] sg02_hw;
  wire [8 - 1:0] sg02_w;
  wire [16 - 1:0] sg1_hw;
  wire [8 - 1:0] sg1_w;
  wire [3 - 1:0] sg1_c;
  ud ud0(.ifcin_hw(sg01_hw),
         .ifcin_w(sg01_w),
         .ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pdin(s_in),
         .pdout1(sg1_hw),
         .pdout2(sg1_c));
  ue ue0(.ifcin_hw(sg02_hw),
         .ifcin_w(sg02_w),
         .ifcrc_clock(ifcrc0_clock),
         .ifcrc_reset(ifcrc0_reset),
         .pein(se_in),
         .peout(sg1_w));
  `include "ude.logic.v"
endmodule

