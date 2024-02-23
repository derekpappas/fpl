// Test type: initial statement - wait_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module initcon40;
reg a,clk;
initial wait(clk==1'b1) #1 a=1;
endmodule
