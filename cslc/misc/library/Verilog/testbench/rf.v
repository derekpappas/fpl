`timescale 1 ps / 1 ps

module rf(clk,
          reset_,
          wr_data,
          wr_addr,
          wr_en,
          rd0_data,
          rd0_addr,
          rd_en
          );
    
    parameter MEM_WORD_WIDTH  = 1'd0 ; 
    parameter MEM_ADDR_WIDTH  = 1'd0 ;
              
    input                           clk      ;
    input                           reset_   ;
    input [MEM_WORD_WIDTH - 1 : 0 ] wr_data  ;
    input [MEM_ADDR_WIDTH - 1 : 0 ] wr_addr  ;
    input                           wr_en    ;
    input [MEM_ADDR_WIDTH - 1 : 0 ] rd0_addr ;
    input                           rd_en    ;

    output[MEM_WORD_WIDTH - 1 : 0 ] rd0_data ;

    reg   [MEM_WORD_WIDTH - 1 : 0 ] rd0_data;
    
    parameter MEM_DEPTH = (1'b1<<MEM_ADDR_WIDTH)-1;
    reg   [MEM_WORD_WIDTH - 1 : 0 ] rf_memory [ 0 : MEM_DEPTH ];
    
    integer i;
    
    //write data to memory and reset
    always @( posedge clk or negedge reset_ ) begin
        if(~reset_) begin
            $display ("Reset: Initializing the rf memory with 0!");
            for ( i = 0; i < MEM_DEPTH; i = i + 1) begin
                rf_memory [ i ] <= {MEM_WORD_WIDTH {1'b0}};
            end
        end else if( wr_en ) begin
            rf_memory[ wr_addr ] <= wr_data;
            $display ("\n%d was written to rf_mem[%d]\n----------------------------------------------", wr_data, wr_addr);
        end
    end
    
    //read data from memory
    always @( posedge clk ) begin
       if( rd_en ) begin
          rd0_data <= rf_memory [rd0_addr];
          $display ("RF: %d was readed from rf_mem[%d]",rf_memory [rd0_addr], rd0_addr);          
       end
    end
endmodule