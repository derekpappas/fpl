// Test type: Simple width mismatch - Binary Numbers, unsigned unsigned, RH < LH
// Vparser rule name: Width mismatch ?
// Author: andreib
module test;
reg [2:0]a;
reg [3:0]b;
initial begin
a=3'b110;
b=a;
end
endmodule
