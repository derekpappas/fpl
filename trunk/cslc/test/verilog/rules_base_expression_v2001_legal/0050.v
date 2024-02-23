// Test type: Expression - primary - function call
// Vparser rule name:
// Author: andreib
module expressiontest;
 function testfunction;
 input a,b;
  testfunction = a+b;
 endfunction

initial begin
  $display("%h=sumfunction(%h,%h)", testfunction(8,9), 5'd8, 5'd9);
end

endmodule
