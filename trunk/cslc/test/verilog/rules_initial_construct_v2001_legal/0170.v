// Test type: initial statement - loop_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon17;
reg [7:0]a,b;
initial (*b*)forever a=2;
endmodule
