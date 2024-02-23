// Test type: Simple width mismatch - Decimal Numbers, unsigned signed, RH < LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [2:0]a;
reg signed [3:0]b;
initial begin
a=4'd7;
b=a;
end
endmodule
