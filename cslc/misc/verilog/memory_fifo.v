//THIS CODE WAS GENERATED USING THE FASTPATHLOGIC HDL COMPILER
//COPYRIGHT (c) 2006, 2007 FastpathLogic Inc
//OUTPUT FILE NAME  : f1_fifo_memory.v
//FILE GENERATED ON : Thu Nov  1 14:49:53 2007

module f1_fifo_memory(clock,
                      reset_,
                      data_in,
                      data_out,
                      valid,
                      wr_addr,
                      rd_addr,
                      wr_en,
                      rd_en);
  parameter ADDR_WIDTH = 3'd4;
  parameter DATA_WIDTH = 6'd32;
  parameter NUM_WORDS = (1 << ADDR_WIDTH);
  input clock;
  input reset_;
  input [DATA_WIDTH-1:0] data_in;
  input [ADDR_WIDTH-1:0] wr_addr;
  input [ADDR_WIDTH-1:0] rd_addr;
  input wr_en;
  input rd_en;
  output reg [DATA_WIDTH-1:0] data_out;
  output reg valid;
  reg [DATA_WIDTH-1:0] internal_memory[0: NUM_WORDS-1] ;

  always @( posedge clock or negedge reset_ )  begin 
    if ( ~reset_ )  begin 
      valid <= 1'd1;
    end
    else  begin 
      valid <= rd_en;
      if ( wr_en )  begin 
        internal_memory[wr_addr] <= data_in;
      end
      if ( rd_en )  begin 
        data_out <= internal_memory[rd_addr];
      end
      
    end
  end
endmodule