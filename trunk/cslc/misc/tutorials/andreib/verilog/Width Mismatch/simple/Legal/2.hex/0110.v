// Test type: Simple width mismatch - Hex Numbers, unsigned unsigned, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [7:0]a;
reg [6:0]b;
initial begin
a=8'hA3;
b=a;
end
endmodule
