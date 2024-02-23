`include "defines.v"

module me();
// Location of source csl unit: file name = IPX2400.csl line number = 118
  wire reset;
  wire clear;
  wire clk;
  wire [5 - 1:0] wr_addr1;
  wire [5 - 1:0] rd_addr01;
  wire [5 - 1:0] rd_addr11;
  wire [32 - 1:0] data_in1;
  wire [32 - 1:0] data_out01;
  wire [32 - 1:0] data_out11;
  wire wr_en1;
  wire rd_en01;
  wire rd_en11;
  wire valid1;
  wire [5 - 1:0] wr_addr2;
  wire [5 - 1:0] rd_addr02;
  wire [5 - 1:0] rd_addr12;
  wire [32 - 1:0] data_in2;
  wire [32 - 1:0] data_out02;
  wire [32 - 1:0] data_out12;
  wire wr_en2;
  wire rd_en02;
  wire rd_en12;
  wire valid2;
  wire [5 - 1:0] wr_addr3;
  wire [5 - 1:0] rd_addr03;
  wire [5 - 1:0] rd_addr13;
  wire [32 - 1:0] data_in3;
  wire [32 - 1:0] data_out03;
  wire [32 - 1:0] data_out13;
  wire wr_en3;
  wire rd_en03;
  wire rd_en13;
  wire valid3;
  wire [5 - 1:0] wr_addr4;
  wire [5 - 1:0] rd_addr04;
  wire [5 - 1:0] rd_addr14;
  wire [32 - 1:0] data_in4;
  wire [32 - 1:0] data_out04;
  wire [32 - 1:0] data_out14;
  wire wr_en4;
  wire rd_en04;
  wire rd_en14;
  wire valid4;
  wire [6 - 1:0] wr_addr5;
  wire [6 - 1:0] rd_addr05;
  wire [6 - 1:0] rd_addr15;
  wire [32 - 1:0] data_in5;
  wire [32 - 1:0] data_out05;
  wire [32 - 1:0] data_out15;
  wire wr_en5;
  wire rd_en05;
  wire rd_en15;
  wire valid5;
  rf128 gpra(.clear(clear),
             .clock(clk),
             .data_in(data_in1),
             .data_out0(data_out01),
             .data_out1(data_out11),
             .rd_addr0(rd_addr01),
             .rd_addr1(rd_addr11),
             .rd_en0(rd_en01),
             .rd_en1(rd_en11),
             .reset(reset),
             .valid(valid1),
             .wr_addr(wr_addr1),
             .wr_en(wr_en1));
  rf128 gprb(.clear(clear),
             .clock(clk),
             .data_in(data_in2),
             .data_out0(data_out02),
             .data_out1(data_out12),
             .rd_addr0(rd_addr02),
             .rd_addr1(rd_addr12),
             .rd_en0(rd_en02),
             .rd_en1(rd_en12),
             .reset(reset),
             .valid(valid2),
             .wr_addr(wr_addr2),
             .wr_en(wr_en2));
  rf128 nn(.clear(clear),
           .clock(clk),
           .data_in(data_in3),
           .data_out0(data_out03),
           .data_out1(data_out13),
           .rd_addr0(rd_addr03),
           .rd_addr1(rd_addr13),
           .rd_en0(rd_en03),
           .rd_en1(rd_en13),
           .reset(reset),
           .valid(valid3),
           .wr_addr(wr_addr3),
           .wr_en(wr_en3));
  rf128 xferind(.clear(clear),
                .clock(clk),
                .data_in(data_in4),
                .data_out0(data_out04),
                .data_out1(data_out14),
                .rd_addr0(rd_addr04),
                .rd_addr1(rd_addr14),
                .rd_en0(rd_en04),
                .rd_en1(rd_en14),
                .reset(reset),
                .valid(valid4),
                .wr_addr(wr_addr4),
                .wr_en(wr_en4));
  localmem lm(.clear(clear),
              .clock(clk),
              .data_in(data_in5),
              .data_out0(data_out05),
              .data_out1(data_out15),
              .rd_addr0(rd_addr05),
              .rd_addr1(rd_addr15),
              .rd_en0(rd_en05),
              .rd_en1(rd_en15),
              .reset(reset),
              .valid(valid5),
              .wr_addr(wr_addr5),
              .wr_en(wr_en5));
  execu eu0();
  ctrlstore cs0();
  opmux opmuxa(), 
        opmuxb();
  crc crc0();
  crcr crcr0();
  rfmux rfmux0();
  `include "me.logic.v"
endmodule

