// Test type: always statement - wait_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon41;
reg a,b,clk;
always (*b*) wait(clk==1'b1) #1 a=1;
endmodule
