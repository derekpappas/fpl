module ff(out, in, clk, reset);
    input [1:0] in;
    output reg [1:0] out;
    input clk, reset;
    
    always @ (posedge clk or negedge reset) begin
        if (reset == 1'b0) begin
            out <= 2'b00;
        end
        else begin
            out <= in;
        end
    end
endmodule

module top(out,in,clk,reset);
        input [1:0] in;
        output [1:0] out;
        input clk, reset;
        
        wire [1:0] wff;
        
        ff ff0(wff,in,clk,reset);
        ff ff1(out,wff,clk,reset);
        
endmodule

module tb_prop();
    reg clk, reset;
    reg [1:0] in;
    wire [1:0] out;
    
    top top(out,in,clk,reset);
    
    initial begin
       clk = 1'b1;
       reset = 1'b0;
       in = 2'b01;
       #2 reset = 1'b1;
       #4 in = 2'b10;
       #4 in = 2'b11;
    end
    
    always clk = #1 ~clk; 
endmodule