// Test type: Expression - primary - concatenation
// Vparser rule name:
// Author: andreib
module expressiontest(a,b,y);
input [1:0] a,b;
output [3:0]y;
wire y;
assign y={a,b};
endmodule
