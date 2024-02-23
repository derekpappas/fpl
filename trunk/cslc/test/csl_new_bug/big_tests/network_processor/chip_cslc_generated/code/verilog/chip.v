`include "defines.v"

module chip();
// Location of source csl unit: file name = IPX2400.csl line number = 264
  wire reset;
  wire clear;
  wire clk;
  wire [7 - 1:0] wr_addr;
  wire [7 - 1:0] rd_addr0;
  wire [7 - 1:0] rd_addr1;
  wire [32 - 1:0] data_in;
  wire [32 - 1:0] data_out0;
  wire [32 - 1:0] data_out1;
  wire wr_en;
  wire rd_en0;
  wire rd_en1;
  wire valid;
  dram dram0(.clear(clear),
             .clock(clk),
             .data_in(data_in),
             .data_out0(data_out0),
             .data_out1(data_out1),
             .rd_addr0(rd_addr0),
             .rd_addr1(rd_addr1),
             .rd_en0(rd_en0),
             .rd_en1(rd_en1),
             .reset(reset),
             .valid(valid),
             .wr_addr(wr_addr),
             .wr_en(wr_en));
  msf msf0();
  sramctrl sramctrl0();
  sramctrl sramctrl1();
  dramctrl dramctrl0();
  hash hash0();
  pcictrl pcictrl0();
  cap cap0();
  mecluster mecluster0(), 
            mecluster1();
  xpi xpi0();
  xscalecore xscalecore0();
  `include "chip.logic.v"
endmodule

