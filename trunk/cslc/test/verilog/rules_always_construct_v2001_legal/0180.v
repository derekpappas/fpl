// Test type: always statement - loop_statement - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon18;
reg [7:0]a,b,c;
always (*b, c*)forever a=2;
endmodule
