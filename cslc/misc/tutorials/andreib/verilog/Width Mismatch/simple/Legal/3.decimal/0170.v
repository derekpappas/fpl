// Test type: Simple width mismatch - Decimal Numbers, unsigned unsigned, RH < LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [2:0]a;
reg [3:0]b;
initial begin
a=4'd5;
b=a;
end
endmodule
