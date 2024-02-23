// Test type: initial statement - nonblocking_assignment - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon20;
reg [7:0]a,b;
initial (*b*) a<=2;
endmodule
