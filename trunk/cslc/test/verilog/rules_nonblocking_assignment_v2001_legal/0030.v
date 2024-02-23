// Test type: nonblocking_assignment - event control - expression
// Vparser rule name:
// Author: andreib
module nonblocking_assignment3;
reg a,clk;
initial a<=@clk 1;
endmodule
