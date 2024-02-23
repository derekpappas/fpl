// Test type: always statement - wait_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon42;
reg a,b,c,clk;
always (*b, c*) wait(clk==1'b1) #1 a=1;
endmodule
