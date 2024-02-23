// Test type: initial statement - blocking_assignment - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon2;
reg [7:0]a,b;
initial (*b*)a=2;
endmodule
