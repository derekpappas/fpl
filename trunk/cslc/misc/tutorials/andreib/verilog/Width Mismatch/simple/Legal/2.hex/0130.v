// Test type: Simple width mismatch - Hex Numbers, unsigned signed, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [7:0]a;
reg signed [6:0]b;
initial begin
a=8'hD9;
b=a;
end
endmodule
