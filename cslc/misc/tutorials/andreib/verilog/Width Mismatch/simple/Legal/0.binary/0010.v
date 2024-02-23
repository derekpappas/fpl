// Test type: Simple width mismatch - Binary Numbers, unsigned unsigned, RH > LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [3:0]a;
reg [2:0]b;
initial begin
a=4'b1001;
b=a;
end
endmodule
