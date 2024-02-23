// Test type: Simple width mismatch - Octal Numbers, unsigned unsigned, RH < LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [1:0]a;
reg [2:0]b;
initial begin
a=2'o3;
b=a;
end
endmodule
