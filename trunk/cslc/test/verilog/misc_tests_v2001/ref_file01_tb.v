module Test_reg_file;
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 8;
    reg clk,rst,rd_en,wr_en;
    reg [ADDR_WIDTH - 1 : 0] wr_a;
    reg [ADDR_WIDTH - 1 : 0] rd_a;
    reg [DATA_WIDTH - 1 : 0] wr_d;
    wire [DATA_WIDTH - 1 : 0] rd_d;
    
    reg_file rf_DUT(clk, rst, wr_en, rd_en, wr_a, rd_a, wr_d, rd_d);
    initial begin
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        #3
        rst = 0;
        #5
        rst = 1;
        #10
        rd_en = 1;
        rd_a = 3'b000;
              
        #7
        rd_en = 0;
        wr_en = 1;
        wr_a = 100;
        #15
        wr_d = 32'h10100010;
        #7
        rd_en = 1;      
        wr_a = 3'b011;
        wr_d = 32'hA102FFFF;
        #2
        wr_a = 3'b000;
        rd_a = 32'h10100010;
        rd_a = 100;
        #8
        rd_en = 0;
        wr_en = 0;
        #5
        wr_a = 3'b110;
        wr_d = 32'hA945FCBF;
        #5
        rd_en = 1;
        wr_en = 1;
        wr_a = 111;
        rd_a = 111;
        wr_d = 32'h5555FFFF;
        #10
        rst = 0;
    end
        always #1   clk = ~clk;
   endmodule