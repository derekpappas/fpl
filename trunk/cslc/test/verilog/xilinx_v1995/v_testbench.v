//20 August 2007
//
module x(in,out,clk);
  input [1:0] in;
  input clk;
  output [1:0] out;
  reg [1:0] out;
  reg [1:0] q;
  always@(posedge clk) begin
     q<=in;
     out<=q;
  end
endmodule

module counter(clk, r_, cnt);
  input clk;
  input r_;
  output [1:0] cnt;
  reg [1:0] cnt;
  always@(posedge clk or negedge r_) begin
    if(~r_)
      cnt<=2'b0;
    if (clk)
      cnt<=cnt+2'b1;
  end
endmodule

module tb;
  reg clk;
  reg r_;
  wire [1:0] cnt;
//  reg [1:0] in;
  wire [1:0] out;
  wire [1:0] out1;
  initial begin
     clk=0;
     r_=01;
     #20 r_=00;
     #20 r_=10;
     
  end
  always #5 clk=~clk;
  counter c0(.clk(clk),.r_(r_),.cnt(cnt));
  x x0(.clk(clk),.in(cnt),.out(out));
  x x1(.clk(clk),.in(out),.out(out1));
endmodule