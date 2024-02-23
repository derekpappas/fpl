// Test type: Simple width mismatch - Decimal Numbers, signed signed, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg signed [3:0]a;
reg signed [2:0]b;
initial begin
a=4'sd11;
b=a;
end
endmodule
