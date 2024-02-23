// Test type: Simple width mismatch - Hex Numbers, signed signed, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg signed [7:0]a;
reg signed [6:0]b;
initial begin
a=8'shEC;
b=a;
end
endmodule
