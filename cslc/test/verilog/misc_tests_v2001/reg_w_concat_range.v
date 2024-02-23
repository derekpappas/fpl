module top(en1,en2,clk,in1,in2,q1,q2);
    input en1, en2, clk;
    input [7:0] in1;
    input [3:0] in2;
    output [7:0] q1;
    output [3:0] q2;
    wire [7:0] q1;
    wire [3:0] q2; 
    reg_A reg_A0(en1,clk,in1,q1);
    reg_B reg_B0(en2,clk,in2,q2);
endmodule
module reg_A(en,clk,in,out);
    input en, clk;
    input [7:0] in;
    output [7:0] out;
    reg [7:0] out;
endmodule
module reg_B(en,clk,in,out);
   input en, clk;
   input [3:0] in;
   output [3:0] out;  
   wire [7:0] out;
   wire [7:6] out_b1;
   wire [4:3] out_b2;
   assign out = {out_b1,out_b2};
endmodule