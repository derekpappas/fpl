// Test type: always statement - blocking_assignment - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon2;
reg [7:0]a,b;
always (*b*)a=2;
endmodule
