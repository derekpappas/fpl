// Test type: always statement - procedural_continuous_assign - 1 attribute instance
// Vparser rule name:
// Author: andreib
module alwcon26;
reg [7:0]a,b;
always (*b*) assign a=2;
endmodule
