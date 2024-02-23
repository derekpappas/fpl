module box;
    wire [3:0] in;
    wire [3:0] out;
    wire en, clk, rst;
    reg_4 reg123(rst,en,clk,in,out);
endmodule
module reg_4(rst, en, clk, in, out);
    input en, clk, rst;
    input [3:0] in;
    output [3:0] out;
    reg [3:0] out;
initial 
out <= in;
always @(rst) begin
if (rst == 0)
out = 4'b0;
end
always @(posedge clk) begin
if (en == 1)
out <= in;
end
endmodule