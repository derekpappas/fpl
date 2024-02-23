// Test type: initial statement - loop_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon18;
reg [7:0]a,b,c;
initial (*b, c*)forever a=2;
endmodule
