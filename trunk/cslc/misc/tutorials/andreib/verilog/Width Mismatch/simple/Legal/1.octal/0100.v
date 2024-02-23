// Test type: Simple width mismatch - Octal Numbers, signed signed, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg signed [2:0]a;
reg signed [1:0]b;
initial begin
a=3'so5;
b=a;
end
endmodule
