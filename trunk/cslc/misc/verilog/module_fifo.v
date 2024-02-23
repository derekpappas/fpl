//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : f1.v
//FILE GENERATED ON : Thu Nov  1 14:49:53 2007

module f1(push,
          pop,
          full,
          empty,
          data_out,
          data_in,
          reset_,
          clock,
          valid);
// Location of source csl unit: file name =  line number = 1
  parameter ADDR_WIDTH = 3'd4;
  parameter DATA_WIDTH = 6'd32;
  input push;
  input pop;
  input [DATA_WIDTH-1:0] data_in;
  input reset_;
  input clock;
  output  full;
  output  empty;
  output  [DATA_WIDTH-1:0] data_out;
  output  valid;
  reg [ADDR_WIDTH-1:0] wr_addr;
  reg [ADDR_WIDTH-1:0] rd_addr;
  wire wr_en;
  wire rd_en;
  assign   full = wr_addr + 1 == rd_addr;
  assign   empty = wr_addr == rd_addr;
  assign   wr_en = !full && push;
  assign   rd_en = !empty && pop;
  f1_fifo_memory fifo_memory_instance(.clock(clock),
                                      .data_in(data_in),
                                      .data_out(data_out),
                                      .rd_addr(rd_addr),
                                      .rd_en(rd_en),
                                      .reset_(reset_),
                                      .valid(valid),
                                      .wr_addr(wr_addr),
                                      .wr_en(wr_en));

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      rd_addr <= {ADDR_WIDTH {1'b0}};
    end
    else       if ( rd_en)  begin 
        rd_addr <= rd_addr + 1'b1;
      end
  end

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      wr_addr <= {ADDR_WIDTH {1'b0}};
    end
    else       if ( wr_en )  begin 
        wr_addr <= wr_addr + 1'b1;
      end
  end
endmodule
