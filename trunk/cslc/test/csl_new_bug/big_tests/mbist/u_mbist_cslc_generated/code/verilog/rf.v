`include "defines.v"

module rf(clock,
          reset,
          data_in,
          data_out1,
          data_out2,
          wr_addr,
          rd_addr1,
          rd_addr2,
          wr_en,
          rd_en1,
          rd_en2);
// Location of source csl unit: file name = mbist_datapath.csl line number = 90
  input clock;
  input reset;
  input [15:0] data_in;
  input [3:0] wr_addr;
  input [3:0] rd_addr1;
  input [3:0] rd_addr2;
  input wr_en;
  input rd_en1;
  input rd_en2;
  output [15:0] data_out1;
  output [15:0] data_out2;
  `include "mbist_datapath.csl" 
  endmodule

