// Test type: always statement - nonblocking_assignment - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon20;
reg [7:0]a,b;
always (*b*) a<=2;
endmodule
