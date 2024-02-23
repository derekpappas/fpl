// Test type: Simple width mismatch - Decimal Numbers, unsigned signed, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [3:0]a;
reg signed [2:0]b;
initial begin
a=4'd12;
b=a;
end
endmodule
