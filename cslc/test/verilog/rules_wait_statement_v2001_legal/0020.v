// Test type: wait_statement - null
// Vparser rule name:
// Author: andreib
module wait_statement2;
reg a,clk;
initial wait(~clk);
endmodule
