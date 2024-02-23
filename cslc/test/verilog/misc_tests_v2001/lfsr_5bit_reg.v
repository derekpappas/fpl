module LFSR_5bit(clk,rst,out);
    parameter mask = 5'b10010;
    input clk,rst;
    output [4:0] out;
    reg [4:0] out;
    reg [4:0] lfsr_reg, fdb;
    reg fdb_out;
    always @(posedge clk or negedge rst) begin
        if(!rst) begin lfsr_reg = 8'b00001; end
        else begin
       //     fdb = lfsr_reg & mask;
       //     fdb_out = ^ fdb;
            fdb_out = lfsr_reg [4] ^ lfsr_reg [1];
            lfsr_reg = lfsr_reg << 1;
            lfsr_reg [0]=fdb_out;
        end
        out = lfsr_reg;
    end
endmodule

//tb
module tb();
   reg clk,reset;
   wire [4:0] out; 
   
   LFSR_5bit SHIFT(clk,reset,out);
   
   initial begin
       clk=0;
       reset=1;
       #2;
       reset=0;
       #5;
       reset=1;
   end
   always #5 clk=~clk;
   
endmodule