// Test type: Simple width mismatch - Octal Numbers, unsigned signed, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [2:0]a;
reg signed [1:0]b;
initial begin
a=3'o7;
b=a;
end
endmodule