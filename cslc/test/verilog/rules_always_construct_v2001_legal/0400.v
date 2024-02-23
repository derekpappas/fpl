// Test type: always statement - wait_statement - no attribute instance
// Vparser rule name:
// Author: andreib
module alwcon40;
reg a,clk;
always wait(clk==1'b1) #1 a=1;
endmodule
