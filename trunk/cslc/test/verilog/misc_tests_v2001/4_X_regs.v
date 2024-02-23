module top(clr,en1,en2,clk,in,out1,out2);
    input clr, en1, en2, clk;
    input [7:0] in;
    output [7:0] out1, out2;
    wire [7:0] out1, out2;
    wire [7:0] sgn1, sgn2;
    reg_8 reg1(clr,en1,clk,in,sgn1);
    reg_8 reg2(clr,en2,clk,sgn1,out1);
    reg_8 reg3(clr,en1,clk,in,sgn2);
    reg_8 reg4(clr,en2,clk,sgn2,out2);
endmodule
module reg_8(clr,en,clk,d,q);
    parameter clr_val = 8'b0;
    input clr,en,clk;
    input [7:0] d;
    output [7:0] q;
    reg [7:0] q;
    always @(posedge clk) begin
        if(clr)
        q <= clr_val;
        else if(en)
        q <= d;
    end
endmodule