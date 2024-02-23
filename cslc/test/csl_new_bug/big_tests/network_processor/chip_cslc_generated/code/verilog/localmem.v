`include "defines.v"

module localmem(reset,
                clear,
                clock,
                wr_addr,
                rd_addr0,
                rd_addr1,
                data_in,
                data_out0,
                data_out1,
                wr_en,
                rd_en0,
                rd_en1,
                valid);
// Location of source csl unit: file name = IPX2400.csl line number = 14
// The depth of register file module localmem is of illegal type. Depth set to 1.
  input reset;
  input clear;
  input clock;
  input [Error
64) - 1:0] wr_addr;
  input [Error
64) - 1:0] rd_addr0;
  input [Error
64) - 1:0] rd_addr1;
  input [32 - 1:0] data_in;
  input wr_en;
  input rd_en0;
  input rd_en1;
  output [32 - 1:0] data_out0;
  output [32 - 1:0] data_out1;
  output valid;
  localmem_register_file_memory register_file_memory_instance(.clock(clock),
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
  endmodule

