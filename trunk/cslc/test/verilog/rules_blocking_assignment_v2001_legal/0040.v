// Test type: blocking_assignment - repeat (expresion) event control - expression
// Vparser rule name:
// Author: andreib
module blocking_assignment4;
reg a,b,clk;
initial a=repeat(~clk) @b 2;
endmodule
