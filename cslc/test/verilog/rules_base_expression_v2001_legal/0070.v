// Test type: Expression - primary - mintypmax
// Vparser rule name:
// Author: andreib
module expressiontest;
reg in;
wire out;
buf #(1:2:3) (out,in);

endmodule
