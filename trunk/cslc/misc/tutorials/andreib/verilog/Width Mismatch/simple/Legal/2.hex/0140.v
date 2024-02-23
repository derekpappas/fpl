// Test type: Simple width mismatch - Hex Numbers, unsigned signed, RH < LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [6:0]a;
reg signed [7:0]b;
initial begin
a=8'h7C;
b=a;
end
endmodule
