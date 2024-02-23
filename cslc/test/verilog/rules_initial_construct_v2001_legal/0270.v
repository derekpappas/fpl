// Test type: initial statement - procedural_continuous_assign - 2 attribute instances
// Vparser rule name:
// Author: andreib
module initcon27;
reg [7:0]a,b,c;
initial (*b, c*) assign a=2;
endmodule
