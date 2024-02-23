// Test type: always statement - nonblocking_assignment - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon21;
reg [7:0]a,b,c;
always (*b, c*) a<=2;
endmodule
