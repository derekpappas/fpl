// Test type: nonblocking_assignment - repeat (expresion) event control - expression
// Vparser rule name:
// Author: andreib
module nonblocking_assignment4;
reg a,b,clk;
initial a<=repeat(~clk) @b 2;
endmodule
