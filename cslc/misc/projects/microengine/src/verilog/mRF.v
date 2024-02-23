//####################################
//# Circuit: mRF                     #
//# Author: Catalin Gabriel Lipsa    #
//# Date: Apr 3, 2007                #
//####################################

module mrf(src_a, rd_data_a, src_b, rd_data_b, dest, wr_data, we, clear);
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 5;
    
    input [ADDR_WIDTH-1:0] src_a, src_b, dest;
    input [DATA_WIDTH-1:0] wr_data;
    input we, clear;
    output [DATA_WIDTH-1:0] rd_data_a, rd_data_b;
    
    reg [DATA_WIDTH-1:0]RF[0:(1<<ADDR_WIDTH)-1];
    integer i;
    
    assign rd_data_a=((src_a==dest) && we) ? wr_data : RF[src_a];
    assign rd_data_b=((src_a==dest) && we) ? wr_data : RF[src_b];      
    
    always@(posedge we or negedge clear) begin
        if (!clear) begin
            for(i=0;i<(1<<ADDR_WIDTH); i=i+1) begin
                RF[i] = 0;
            end
        end
        else begin
            RF[dest] = wr_data;
        end
    end
endmodule

//testnemch mRF
module tb_mrf();
   parameter DATA_WIDTH = 32;
   parameter ADDR_WIDTH = 5;
    
   reg [ADDR_WIDTH-1:0] src_a, src_b, dest;
   reg [DATA_WIDTH-1:0] wr_data;
   reg we, clear;
   wire [DATA_WIDTH-1:0] rd_data_a, rd_data_b; 
   
   mrf mRF(src_a, rd_data_a, src_b, rd_data_b, dest, wr_data, we, clear);
   
   initial begin
       clear = 1;
       src_a = 5'b00000;
       src_b = 5'b00000;
       dest = 5'b00001;
       we = 0;
       wr_data = 32'hABCDEF01;
       #3 clear = 0;
       #5 clear = 1;
       we =1;
       #5;
       we = 0;
       dest = 5'b00010;
       wr_data = 32'hFFFFFFFF;
       #5;
       we = 1;
       #5;
       we = 0;
       dest = 5'b10000;
       wr_data = 32'hFFFFFFF0;
       #5;
       we = 1;
       #5;
       we = 0;
   end
endmodule