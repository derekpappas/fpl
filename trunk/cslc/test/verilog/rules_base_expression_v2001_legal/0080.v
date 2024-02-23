// Test type: Expression - conditional expression
// Vparser rule name:
// Author: andreib
module expressiontest;
reg enable,in;
wire out;
assign out = (enable) ? in:1'bz;

endmodule
