// Test type: Simple width mismatch - Hex Numbers, unsigned unsigned, RH < LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [6:0]a;
reg [7:0]b;
initial begin
a=8'h7F;
b=a;
end
endmodule
