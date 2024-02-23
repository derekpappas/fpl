// Test type: wait_statement - statement
// Vparser rule name:
// Author: andreib
module wait_statement1;
reg a,clk;
initial wait(~clk) a=~a;
endmodule
