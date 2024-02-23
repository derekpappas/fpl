// Test type: initial statement - procedural_continuous_assign - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon26;
reg [7:0]a,b;
initial (*b*) assign a=2;
endmodule
