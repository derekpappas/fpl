// Test type: blocking_assignment - event control - expression
// Vparser rule name:
// Author: andreib
module blocking_assignment3;
reg a,clk;
initial a=@clk 1;
endmodule
