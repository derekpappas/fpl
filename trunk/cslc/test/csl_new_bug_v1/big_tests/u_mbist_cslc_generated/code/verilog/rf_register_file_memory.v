`include "defines.v"

module rf_register_file_memory(clock,
                               reset,
                               data_in,
                               data_out0,
                               data_out1,
                               wr_addr,
                               rd_addr0,
                               rd_addr1,
                               wr_en,
                               rd_en0,
                               rd_en1,
                               valid);
// The depth of register file module rf_register_file_memory is of illegal type. Depth set to 1.
// The width of register file module rf_register_file_memory is of illegal type. Width set to 1.
  parameter ADDR_WIDTH = 0;
  parameter DATA_WIDTH = 1;
  parameter NUM_WORDS = (1 << DATA_WIDTH);
  input clock;
  input reset;
  input [DATA_WIDTH - 1:0] data_in;
  input [ADDR_WIDTH - 1:0] wr_addr;
  input [ADDR_WIDTH - 1:0] rd_addr0;
  input [ADDR_WIDTH - 1:0] rd_addr1;
  input wr_en;
  input rd_en0;
  input rd_en1;
  output reg [DATA_WIDTH - 1:0] data_out0;
  output reg [DATA_WIDTH - 1:0] data_out1;
  output reg valid;
  reg [DATA_WIDTH - 1:0] internal_memory[0:NUM_WORDS - 1] ;

  always @( posedge clock or negedge reset )  begin 
    if ( ~(reset) )  begin 
      valid <= 1;
    end
    else  begin 
      valid <= rd_en0 | rd_en1;
      if ( rd_en0 )  begin 
        data_out0 <= internal_memory[rd_addr0];
      end
      if ( rd_en1 )  begin 
        data_out1 <= internal_memory[rd_addr1];
      end
      if ( wr_en )  begin 
        internal_memory[wr_addr] <= data_in;
      end
    end
  end
  endmodule

