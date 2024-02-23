module reg_4(en,clk,in,out);
input en, clk;
input [3:0] in;
output [3:0] out;
reg [3:0] out;
always @(posedge clk) begin
if (en) begin 
out = in; 
end
end
endmodule

module testb_reg;
    reg en, clk;
    reg [3:0] in;
    wire [3:0] out;
    
    reg_4 dut(en,clk,in,out);
    
    initial begin
        clk = 0;
        en = 0;
        in = 4'b0000;
        #4
        en = 1;
        #4
        en = 0;
        in = 4'b1000;
        #1
        en = 1;
        in = 4'b0110;
    end

    always #1 clk = ~clk;
endmodule