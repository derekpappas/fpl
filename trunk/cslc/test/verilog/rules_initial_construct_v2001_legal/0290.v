// Test type: initial statement - procedural_timing_control_statement - 1 attribute instance
// Vparser rule name:
// Author: andreib
module initcon29;
reg [7:0]a,b;
initial (*b*) #10 a=2;
endmodule
