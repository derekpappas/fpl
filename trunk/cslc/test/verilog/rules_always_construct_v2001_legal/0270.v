// Test type: always statement - procedural_continuous_assign - 2 attribute instances
// Vparser rule name:
// Author: andreib
module alwcon27;
reg [7:0]a,b,c;
always (*b, c*) assign a=2;
endmodule
