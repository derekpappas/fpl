// Test type: Expression - primary - system function call
// Vparser rule name:
// Author: andreib
module expressiontest;
reg [1:0]a;
initial begin
  a=$random;
end
endmodule
