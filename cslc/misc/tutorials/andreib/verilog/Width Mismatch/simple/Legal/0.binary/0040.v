// Test type: Simple width mismatch - Binary Numbers, unsigned signed, RH < LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [2:0]a;
reg signed [3:0]b;
initial begin
a=3'b101;
b=a;
end
endmodule
