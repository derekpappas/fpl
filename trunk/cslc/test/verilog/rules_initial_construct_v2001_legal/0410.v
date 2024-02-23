// Test type: initial statement - wait_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon41;
reg a,b,clk;
initial (*b*) wait(clk==1'b1) #1 a=1;
endmodule
