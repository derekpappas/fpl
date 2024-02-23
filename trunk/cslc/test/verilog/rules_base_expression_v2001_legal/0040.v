// Test type: Expression - primary - multiple concatenation
// Vparser rule name:
// Author: andreib
module expressiontest(a,y);
input [1:0] a;
output [3:0]y;
wire y;
assign y={3{a}};
endmodule
