module alws(w1,r1);
 parameter b=10;
 parameter c=5 + b;
 parameter d=1 + c % 2;
 parameter a=d?b:c;
 input [a:b] w1;
 output reg [d:c] r1;
 reg r0;
 wire f, g;
assign f = w1;
assign g = w1?w1:w1 + a;
always @( w1 )
begin
   r0 = w1 + 1;
   r1 <= w1 + c;
   end
endmodule